# This feature is tp test Register Account holder
# Requires an existing account
# Requires random username
@Regression
Feature: Register new useder with new account

  Background: Setup test & create new account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccount.feature')
    * def accountId = createAccountResult.response.id
    * def fullName = createAccountResult.response.firstName + " " + createAccountResult.response.lastName

  Scenario: Sign up & register new user
    Given path "/api/sign-up/register"
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def auto_username = dataGenerator.getUsername()
    And request
      """
      {
      "primaryPersonId": "#(accountId)",
      "fullname": "(fullName)",
      "username": "#(auto_username)",
      "password": "jackmA@123",
      "authority": "CUSTOMER",
      "accountType": "CUSTOMER"
      } 
      """
    When method post
    Then print response
    Then status 201
    And assert response.username == auto_username
    And assert response.accountType == "CUSTOMER"
