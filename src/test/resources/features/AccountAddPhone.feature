@Regression
Feature: Create Account and Add Phone Number

  Background: Test Setup and Creating Account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccount.feature')
    And print createAccountResult
    * def validToken = createAccountResult.validToken
    * def createAccountId = createAccountResult.response.id

  Scenario: Adding Phone Number to an Account
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = createAccountId
    And header Authorization = "Bearer " + validToken
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
        "phoneNumber": "#(phoneNumber)",
        "phoneExtension": "",
        "phoneTime": "Day Time",
        "phoneType": "Cell"
      }
      """
    When method post
    Then status 201
    And assert response.phoneNumber == phoneNumber
