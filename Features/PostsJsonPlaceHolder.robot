*** Settings ***
Documentation       Documentacao da API: https://jsonplaceholder.typicode.com/

Resource            ../Resource/ResourcePostsJsonPlaceHolder.robot

Suite Setup         Conectar a API


*** Test Cases ***
Boscar a listagem de todos os posts (GET em todos os posts)
    Quando requisitar todos os posts do jsonplaceholder
    Então o Status Code deverá ser    200
    E a Reason    OK

Buscar apenas um post pelo id (GET de um post específico)
    Quando requisitar o post 2
    Então o Status Code deverá ser    200
    E a Reason    OK
    E Conferir o retorno de todos os dados corretos do post 2

Cadastrar um novo post (POST de uma nova postagem)
    Quando Cadastrar um novo post no jsonplaceholder
    Então o Status Code deverá ser    201
    E a Reason    Created
    E realizar a conferência dos dados cadastrados do novo post

Alterar um post (PUT Alterando uma postagem existente)
    Quando Alterar o post "1" no jsonplaceholder
    Então o Status Code deverá ser    200
    E a Reason    OK
    Conferir se retorna todos os dados alterados do post "1"
