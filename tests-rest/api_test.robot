*** Settings ***
Library			REST	https://jsonplaceholder.typicode.com

*** Test Cases ***
GET many users
    GET         /users?_limit=5
    Array       response body               maxItems=5
