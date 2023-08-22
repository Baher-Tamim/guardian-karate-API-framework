@Regression
Feature: Updating an existed account car

  Background: Setting up test & generating token.
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccount.feature')
    And print createAccountResult
    * def createAccountId = createAccountResult.response.id
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token

  Scenario: Update existing account aar from an account
    #Add a car first to the account
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    And request
      """
      {
       "make": "BMW",
       "model": "M3",
       "year": "2020",
       "licensePlate": "API0002"
       }
      """
    When method post
    Then status 201
    And print response
    And assert response.licensePlate == "API0002"
    And assert response.make == "BMW"
    And assert response.year == "2020"
    * def carId = response.id
    #Update existing account car info
    And path "/api/accounts/update-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    And request
      """
      {
       "id": "#(carId)",
       "make": "Audi",
       "model": "A7",
       "year": "2021",
       "licensePlate": "API0003"
       }
      """
    When method put
    Then status 202
    And print response
    And assert response.licensePlate == "API0003"
    And assert response.make == "Audi"
    And assert response.year == "2021"
    
    
