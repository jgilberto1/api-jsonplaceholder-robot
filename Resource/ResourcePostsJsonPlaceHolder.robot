*** Settings ***
Documentation       Documentacao da API: https://jsonplaceholder.typicode.com/

Library             RequestsLibrary
Library             Collections


*** Variables ***
${URL_API}      https://jsonplaceholder.typicode.com/
${USER_ID_1}    1
&{POST_2}       userId=1
...             id=2
...             title=qui est esse
&{NEW_POST}     userId=1
...             id=101
...             title=Teste Post Api title
...             body=Teste Post Api body


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

Quando Cadastrar um novo post no jsonplaceholder
    ${headers}    Create Dictionary    Content-Type=application/json
    ${data}    Create Dictionary    userId=${NEW_POST.userId}    title=${NEW_POST.title}    body=${NEW_POST.body}
    ${json_data}    Evaluate    json.dumps($data)    json

    ${RESPOSTA}    Post Request
    ...    jsonplaceholder
    ...    posts
    ...    data=${data}
    ...    headers=${headers}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Quando Alterar o post "${ID_POST}" no jsonplaceholder
    ${headers}    Create Dictionary    Content-Type=application/json
    ${data}    Create Dictionary    userId=${NEW_POST.userId}    title=${NEW_POST.title}    body=${NEW_POST.body}
    ${json_data}    Evaluate    json.dumps($data)    json

    ${RESPOSTA}    Put Request
    ...    jsonplaceholder
    ...    posts/${ID_POST}
    ...    data=${data}
    ...    headers=${headers}
    Log    ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Quando Deletar o post "${ID_POST}" no jsonplaceholder
    ${RESPOSTA}    Delete Request    jsonplaceholder    posts/${ID_POST}
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
    ${USER_ID}    Convert To Integer    ${POST_2.userId}
    ${ID}    Convert To Integer    ${ID_POST}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    userId    ${USER_ID}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title    ${POST_2.title}

E realizar a conferência dos dados cadastrados do novo post
    ${ID}    Convert To Integer    ${NEW_POST.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id    ${ID}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    userId    ${NEW_POST.userId}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title    ${NEW_POST.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    body    ${NEW_POST.body}

Conferir se retorna todos os dados alterados do post "${ID_POST}"
    Dictionary Should Contain Item    ${RESPOSTA.json()}    userId    ${NEW_POST.userId}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title    ${NEW_POST.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    body    ${NEW_POST.body}
