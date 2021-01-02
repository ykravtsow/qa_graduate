*** Settings ***
Resource  Variables.robot

*** Variables ***
${Auth_Page}  ${URL}/basic-auth/${USER}/${PASSWORD}
${Auth_header}  Basic ${EMPTY}
${AUTH KEY}  authenticated
${AUTH VALUE}  True
${AUTH VALUE ENCODED}  dGVzdGVyOnRlc3Rlcg==

