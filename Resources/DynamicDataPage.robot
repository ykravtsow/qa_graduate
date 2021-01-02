*** Settings ***
Resource  Variables.robot

*** Variables ***
${DynamicParameter}  uuid
${DynamicDataPage}  view-source:${URL}/uuid
${UUID_RegExp}  [0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}
