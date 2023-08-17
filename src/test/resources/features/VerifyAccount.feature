@Regression
Feature: Verify Account

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def validToken = result.response.token

  # Scenario #7
  Scenario: Verify an account which exists
    Given path "/api/accounts/get-account"
    # With def step we create variable and assign value to it for reusability
    * def existingId = 9571
    And param primaryPersonId = existingId
    # Header have to add request
    And header Authorization = "Bearer " + validToken
    When method get
    Then status 200
    And print response
    And assert  response.primaryPerson.id == existingId

  # Scenario #8
  Scenario: Verify get-account with id does not exist
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer " + validToken
    * def notExistingId = 2228989
    And param primaryPersonId = notExistingId
    When method get
    Then status 404
    And print response
    And assert response.errorMessage == "Account with id " + notExistingId + " not found"
