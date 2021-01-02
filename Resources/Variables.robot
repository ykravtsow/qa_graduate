*** Variables ***
${BROWSER}  firefox
${DELAY}  5
${SELENOID_SERVER}  http://localhost:4444/wd/hub
&{Enable_Vnc}  enable_VNC = ${True}
${DESIRED_CAPS}  &{Enable_VNC}
${USER}  tester
${PASSWORD}  tester
${URL}  http://172.18.0.1:80
