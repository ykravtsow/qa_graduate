*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  RequestsLibrary
Library  AdvancedLogging
Library  Collections
Library  Base64
Resource  ${RESOURCES}/Variables.robot
Resource  ${RESOURCES}/Common.robot
Resource  ${RESOURCES}/MainPage.robot
Resource  ${RESOURCES}/AuthPage.robot
Resource  ${RESOURCES}/StatusCodesPage.robot
Resource  ${RESOURCES}/RequestInspectionPage.robot
Resource  ${RESOURCES}/ResponseInspectionPage.robot
Resource  ${RESOURCES}/DynamicDataPage.robot
Resource  ${RESOURCES}/ImagePage.robot
Resource  ${RESOURCES}/RedirectPage.robot

Suite Setup  Open Selenoid Browser  NONE  ${BROWSER}
Suite Teardown  Close Browser

*** Test Cases ***

Scenario 1: I want to test httpbin main page
    Given that i open browser on httpbin main page
    Then i should see sections links to test

Scenario 2: I want to test httpbin auth page
    Given that i send HTTP GET request with basic auth header to httpbin basic auth page
    Then i should get json with authenticated member set true

Scenario 3: I want to test httpbin http post method
    Given that i send HTTP POST request to httpbin post page
    Then i should get status code equal to sent in URL

Scenario 4: I want to test httpbin http delete method
    Given that i send HTTP DELETE request to httpbin delete page
    Then i should get status code equal to sent in URL

Scenario 5: I want to test httpbin http put status codes
    Given that i send HTTP PUT request to httpbin put page
    Then i should get status code equal to sent in URL

Scenario 6: I want to test httpbin request inspection functionality
    Given that i sent HTTP Get request with Test header to httpbin request inspection page
    Then i should get json with Test member set to sent header

Scenario 7: I want to test httpbin response inspection functionality
    Given that i open browser on httpbin response inspection page with parameter
    Then i should get json with parameter and its value

Scenario 8: I want to test httpbin dynamic data uuid responce
    Given that i open browser on httpbin dynamic data uuid page
    Then i should get json with uuid member set to random uuid

Scenario 9: I want to test httpbin image png page
   Given that i open browser on httpbin image png page
    Then i should see image on returned html page

Scenario 10: I want to test httpbin redirect functionality
    Given that i open browser on httpbin redirect page with parameter redirect to main page
    Then i should see sections links to test


*** Keywords ***

#Scenario 1
that i open browser on httpbin main page
    Go To  ${Main_Page}

Then i should see sections links to test
    Store Page
    Wait Until Page Contains Element  ${HTTP_selector}  timeout=5
    Page Should Contain Element  ${HTTP_selector}
    Page Should Contain Element  ${Auth_selector}
    Page Should Contain Element  ${Status_selector}
    Page Should Contain Element  ${Request_Inspection_selector}
    Page Should Contain Element  ${Response_Inspection_selector}
    Page Should Contain Element  ${Dynamic_Data_selector}
    Page Should Contain Element  ${Images_selector}
    Page Should Contain Element  ${Redirects_selector}

# Scenario 2
# sadly i cannot use selenium for test browser auth window
that i send HTTP GET request with basic auth header to httpbin basic auth page
    Create Session  test.httpbin  ${Auth_Page}
    ${b64}=  Base64 Encode  ${USER}:${PASSWORD}
    ${headers}=  Create Dictionary  Content-Type=application/json  Authorization=${AuthHeader}${b64}
    ${resp}=  GET Request  test.httpbin  ${EMPTY}  headers=${headers}
    Set Suite Variable  ${resp}

i should get json with authenticated member set true
    Store Page
    Should Be True  ${resp.status_code} == 200
    Dictionary Should Contain Key  ${resp.json()}  ${AUTH KEY}
    ${value}=  Get From Dictionary  ${resp.json()}  ${AUTH KEY}
    Should Be Equal As Strings  ${value}  ${AUTH VALUE}
    Dictionary Should Contain Key  ${resp.json()}  user
    ${user}=  Get From Dictionary  ${resp.json()}  user
    Should Be Equal As Strings  ${user}  ${USER}

#Scenario 3
that i send HTTP POST request to httpbin post page
    Create Session  test.httpbin  ${PostPage}
    ${data}=  To Json  {"para1":"test"}
    ${headers}=  Create Dictionary  Content-Type=application/json
    ${resp}=  POST Request  test.httpbin  ${EMPTY}  json=${data}  headers=${headers}
    Set Suite Variable  ${resp}
    Set Suite Variable  ${CODE}  ${POST_CODE}

i should get status code equal to sent in URL
    Should Be True  ${resp.status_code} == ${CODE}

#Scenario 4
that i send HTTP DELETE request to httpbin delete page
    Create Session  test.httpbin  ${DeletePage}
    ${data}=  To Json  {"para1":"test"}
    ${headers}=  Create Dictionary  Content-Type=application/json
    ${resp}=  DELETE Request  test.httpbin  ${EMPTY}  json=${data}  headers=${headers}
    Set Suite Variable  ${resp}
    Set Suite Variable  ${CODE}  ${DELETE_CODE}

#Scenario 5
that i send HTTP PUT request to httpbin put page
    Create Session  test.httpbin  ${PutPage}
    ${data}=  To Json  {"para1":"test"}
    ${headers}=  Create Dictionary  Content-Type=application/json
    ${resp}=  PUT Request  test.httpbin  ${EMPTY}  json=${data}  headers=${headers}
    Set Suite Variable  ${resp}
    Set Suite Variable  ${CODE}  ${PUT_CODE}

#Scenario 6
#Selenium have no API to set header sadly
that i sent HTTP Get request with Test header to httpbin request inspection page
    Create Session  test.httpbin  ${Request_Page}
    ${headers}=  Create Dictionary  Content-Type=application/json  Test=${REQUEST_VALUE}
    ${resp}=  GET Request  test.httpbin  ${EMPTY}  headers=${headers}
    Set Suite Variable  ${resp}
    Set Suite Variable  ${CODE}  ${GET_CODE}

i should get json with Test member set to sent header
    Should Be True  ${resp.status_code} == ${CODE}
    ${headers}=  Get From Dictionary  ${resp.json()}  headers
    Dictionary Should Contain Key  ${headers}  Test
    ${value}=  Get From Dictionary  ${headers}  Test
    Should Be Equal As Strings  ${value}  ${REQUEST_VALUE}

#Scenario 7
that i open browser on httpbin response inspection page with parameter
    Go To  ${ResponsePage}

i should get json with parameter and its value
    Store Page
    ${elem}=  Get WebElement  ${JsonSelector}
    ${json}=  Evaluate  json.loads('''${elem.text}''')
    Dictionary Should Contain Key  ${json}  ${ResponseParameter}
    ${val}=  Get From Dictionary  ${json}  ${ResponseParameter}
    Should Be Equal As Strings  ${val}  ${RESPONSE_VALUE}

#Scenario 8
that i open browser on httpbin dynamic data uuid page
    Go To  ${DynamicDataPage}

i should get json with uuid member set to random uuid
    Store Page
    ${elem}=  Get WebElement  ${JsonSelector}
    ${json}=  Evaluate  json.loads('''${elem.text}''')
    Dictionary Should Contain Key  ${json}  ${DynamicParameter}
    ${val}=  Get From Dictionary  ${json}  ${DynamicParameter}
    Should Match Regexp  ${val}  ${UUID_RegExp}

#Scenario 9
that i open browser on httpbin image png page
    Go To  ${ImagePage}

i should see image on returned html page
    Store Page
    Wait Until Page Contains Element  ${ImageSelector}  timeout=5
    Page Should Contain Element  ${ImageSelector}

#Scenario 10
that i open browser on httpbin redirect page with parameter redirect to main page
    Go To  ${RedirectPage}



