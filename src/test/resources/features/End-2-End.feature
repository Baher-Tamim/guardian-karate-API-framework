Feature: End-2-End testing for Account Creation to Deletion

  Background: Setting up test & generating token.
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccount.feature')
    And print createAccountResult
    * def createAccountId = createAccountResult.response.id
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token

  Scenario: Validate user can create an account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    * def generateDataObjects = Java.type('api.utility.data.GenerateData')
    * def autoGenerateEmail = generateDataObjects.getEmail()
    * def autoGenerateName = Java.type('api.utility.data.NameGenerator')
    * def authoGenerateTitle = Java.type('api.utility.data.TitleGenerator')
    And request
      """
          {
          "email": "#(autoGenerateEmail)",
          "firstName": "#(generateFirstName)",
          "lastName": "#(generateLastName)",
          "title": "#(generateTitle)",
          "gender": "MALE",
          "maritalStatus": "MARRIED",
          "employmentStatus": "student",
          "dateOfBirth": "2003-08-03"
          }
      """
    And print autoGenerateName
    When method post
    Then status 201
    And print response
    And assert response.email == autoGenerateEmail

  Scenario: Validate user can add a Phone Number to an Existing Account
    Then path "/api/accounts/add-account-phone"
    And param primaryPersonId = createAccountId
    And header Authorization = "Bearer " + validToken
    And request
      """
      {
      "phoneNumber": "#(phoneNumer)",
      "phoneExtension": "N/A",
      "phoneTime": "Anytime",
      "phoneType": "Cell"
      }
      """
    When method post
    Then status 201
    And print response

  Scenario: Validate user can add an Address to an Existing Account
    Then path "/api/accounts/add-account-address"
    And param primaryPersonId = createAccountId
    And header Authorization = "Bearer " + validToken
    And request
      """
      {
      "addressType": "House",
      "addressLine1": "1234 A st",
      "city": "Hayward",
      "state": "CA",
      "postalCode": "94540",
      "countryCode": "001",
      "current": true
      }
      """
    When method post
    Then status 201

  Scenario: Validate user can add a Car to an Existing Account
    Then path "/api/accounts/add-account-car"
    And param primaryPersonId = createAccountId
    And header Authorization = "Bearer " + validToken
    And request
      """
      {
      "make": "Mercedes Benz",
      "model": "G50",
      "year": "2021",
      "licensePlate": "generatedLicensePlate"
      }
      """
    When method post
    Then status 201

  Scenario: Validated user can delete an Excisting Account
    Then path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = createAccountId
    When method delete
    Then status 200
