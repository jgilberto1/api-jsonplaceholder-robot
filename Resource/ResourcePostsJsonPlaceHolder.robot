*** Settings ***
Documentation       Documentacao da API: https://jsonplaceholder.typicode.com/

Library             RequestsLibrary
Library             Collections


*** Variables ***
${URL_API}      https://jsonplaceholder.typicode.com/
${USER_ID_1}    1
&{POST_1}       userId=1
...             id=2
...             title=qui est esse


*** Keywords ***
# SETUP E TEARDOWN
Conectar a API
    Create Session    jsonplaceholder    ${URL_API}

# AÇÕES

Quando requisitar todos os posts do jsonplaceholder
    ${RESPOSTA}    GET On Session    jsonplaceholder    posts
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Quando requisitar o post ${ID_POST}
    ${RESPOSTA}    GET On Session    jsonplaceholder    posts/${ID_POST}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

# CONFERÊNCIAS

Então o Status Code deverá ser
    [Arguments]    ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

E a Reason
    [Arguments]    ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}

E Conferir o retorno de todos os dados corretos do post ${ID_POST}
    ${USER_ID}    Convert To Integer    ${POST_1.userId}
    ${ID}    Convert To Integer    ${ID_POST}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    userId    ${USER_ID}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id    ${ID}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title    ${POST_1.title}
