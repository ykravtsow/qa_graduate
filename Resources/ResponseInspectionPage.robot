*** Settings ***
Resource  Variables.robot

*** Variables ***
${RESPONSE_VALUE}  Test
${ResponseParameter}  freeform
${PARAMETER}  ${ResponseParameter}=${RESPONSE_VALUE}
${ResponsePage}  view-source:${URL}/response-headers?${PARAMETER}

