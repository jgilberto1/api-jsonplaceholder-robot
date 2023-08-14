*** Setting ***
Documentation  Documentacao da API: https://jsonplaceholder.typicode.com/
Resource       ../Resource/ResourcePostsJsonPlaceHolder.robot
Suite Setup    Conectar a API

*** Test Case ***
Boscar a listagem de todos os posts (GET em todos os posts)
    Quando requisitar todos os posts do jsonplaceholder
    Então o Status Code deverá ser  200
    E a Reason  OK

Buscar apenas um post pelo id (GET de um post específico)
    Quando requisitar o post 2
    Então o Status Code deverá ser  200
    E a Reason  OK
    E Conferir o retorno de todos os dados corretos do post 2