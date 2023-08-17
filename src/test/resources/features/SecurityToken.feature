@Smoke
Feature: Security Token Test

  Background: Setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  Scenario: Genearate valid token with valid username & password
    #Prepare request
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

  Scenario Outline: Validate token with invalid username
    And request
      """
      {
      "username": "<username>", 
      "password": "<password>"
      }
      """
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "<errorMessage>"

    Examples: 
      | username      | password       | statusCode | errorMessage   |
      | wrongUsername | tek_supervisor |        400 | User not found |
      | supervisor    | wrongPassword  |        400 | Password Not Matched |

