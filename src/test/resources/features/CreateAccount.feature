@Regression
Feature: Create Account feature

  Background: Setup test and generate token.
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Valid Account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    # Calling GenerateData.java class in feature file. this utility will creat object
    # (generated email) object from GenerateData.java class
    * def generateDataObjects = Java.type('api.utility.data.GenerateData')
    * def autoGeneratedEmail = generateDataObjects.getEmail();
    And request
      """
      {
      "email": "#(autoGeneratedEmail)",
      "firstName": "anak",
      "lastName": "yonaki",
      "title": "student",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "student",
      "dateOfBirth": "2003-08-03"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoGeneratedEmail
    # Using delete endpoint to remove generated account for continues execution.
 #   Given path "/api/accounts/delete-account"
 #   And param primaryPersonId = response.id
 #   And header Authorization = "Bearer " + validToken
 #   When method delete
 #   Then status 200
 #   And print response
 #   And assert response == "Account Successfully deleted"
