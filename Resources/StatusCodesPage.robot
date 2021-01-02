*** Settings ***
Resource  Variables.robot

*** Variables ***
${POST_CODE}  202
${DELETE_CODE}  406
${PUT_CODE}  304
${Post_Page}  ${URL}/status/${POST_CODE}
${Delete_Page}  ${URL}/status/${DELETE_CODE}
${Put_Page}  ${URL}/status/${PUT_CODE}
