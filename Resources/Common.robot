*** Settings ***
Resource  Variables.robot

*** Variables ***
${JsonSelector}  //pre[text()]

*** Keywords ***
Open Selenoid Browser
    [Arguments]  ${PAGE_URL}  ${browser}=${BROWSER}  ${delay}=${DELAY}  ${selenoid_server}=${SELENOID_SERVER}
    Open Browser  ${PAGE_URL}  ${browser}  None  ${selenoid_server}  desired_capabilities=${DESIRED_CAPS}
    Set Selenium Speed  ${DELAY}

Store Page
    ${myHtml} =    Get Source
    Capture Page Screenshot
    Write Advanced testlog  ${OUTPUT DIR}/rf.log  ${myHtml}
