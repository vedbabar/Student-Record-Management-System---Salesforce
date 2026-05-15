# Student Record Management System
A lightweight Student Record Management System built on the Salesforce platform. This application allows users to create and manage student records (Name, Roll No, Class, Mobile No) using a custom object, Apex controller, and a Visualforce user interface.
## Features
* **Data Persistence:** Stores student information in a custom Salesforce Object (`Student__c`).
* **Input Interface:** Simple Visualforce form to capture student details.
* **Real-time Display:** Automatically fetches and displays the latest student records in a table format.
* **Error Handling:** Built-in validation messaging for successful saves or errors.
---
## Prerequisites
* A Salesforce Developer Edition Org or Trailhead Playground.
* Basic knowledge of Salesforce Setup (Object Manager, Apex, Visualforce).
---
## Installation Steps
### Step 1: Create the Custom Object
1. Log in to your Salesforce Org.
2. Go to **Setup** > **Object Manager**.
3. Create a new Custom Object:
   - **Label:** `Student`
   - **Plural Label:** `Students`
   - **Record Name:** `Student Name`
4. Add the following Fields & Relationships:
   - `Roll No` (Number, Length 10)
   - `Class` (Text, Length 50)
   - `Mobile No` (Phone)
### Step 2: Create the Apex Controller
1. Go to **Setup** > **Apex Classes**.
2. Click **New** and paste the code from `StudentController.cls`.
3. Save the class.
### Step 3: Create the Visualforce Page
1. Go to **Setup** > **Visualforce Pages**.
2. Click **New** and paste the code from `StudentManagement.page`.
3. Save the page.
---
## How to Use
1. Once saved, click the **Preview** button on the `StudentManagement` Visualforce page.
2. Fill in the form fields.
3. Click **Save Record**.
4. The record will be saved to the database, and the "Existing Students" table below will refresh automatically.
---
## Project Structure
* `/StudentController.cls` - The backend logic containing the SOQL queries and save functionality.
* `/StudentManagement.page` - The front-end user interface built with Visualforce components.
---
## Code

### `StudentController.cls`

```apex
public class StudentController {
    // Variable to hold the new student being entered
    public Student__c student { get; set; }
    
    // List to display existing students
    public List<Student__c> studentList { get; set; }

    // Constructor runs when the page loads
    public StudentController() {
        student = new Student__c(); // Initialize a blank record
        loadStudents(); // Fetch existing records
    }

    // Method to query the database for students
    public void loadStudents() {
        studentList = [SELECT Id, Name, Roll_No__c, Class__c, Mobile_No__c 
                       FROM Student__c 
                       ORDER BY CreatedDate DESC];
    }

    // Method triggered by the "Save" button
    public PageReference saveRecord() {
        try {
            insert student; // Save to database
            student = new Student__c(); // Clear the form for the next entry
            loadStudents(); // Refresh the table
            
            // Show success message
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Student Record Saved Successfully!'));
        } catch (Exception e) {
            // Show error message if something goes wrong
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error saving record: ' + e.getMessage()));
        }
        return null; // Stay on the same page
    }
}
```

---

### `StudentManagement.page`

```xml
<apex:page controller="StudentController" docType="html-5.0">
    <apex:form >
        <!-- This displays our success or error messages -->
        <apex:pageMessages />

        <!-- Input Section -->
        <apex:pageBlock title="Student Record Management">
            <apex:pageBlockSection title="Enter Student Details" columns="1">
                <apex:inputField value="{!student.Name}" required="true"/>
                <apex:inputField value="{!student.Roll_No__c}" required="true"/>
                <apex:inputField value="{!student.Class__c}" />
                <apex:inputField value="{!student.Mobile_No__c}" />
            </apex:pageBlockSection>
            
            <apex:pageBlockButtons location="bottom">
                <apex:commandButton value="Save Record" action="{!saveRecord}" />
            </apex:pageBlockButtons>
        </apex:pageBlock>

        <!-- Display Section -->
        <apex:pageBlock title="Existing Students">
            <apex:pageBlockTable value="{!studentList}" var="stu">
                <apex:column value="{!stu.Name}" headerValue="Student Name"/>
                <apex:column value="{!stu.Roll_No__c}" />
                <apex:column value="{!stu.Class__c}" />
                <apex:column value="{!stu.Mobile_No__c}" />
            </apex:pageBlockTable>
        </apex:pageBlock>
    </apex:form>
</apex:page>
```

---
## Troubleshooting
* **Permissions:** If you get an error saving a record, ensure your User Profile has "Read" and "Create" permissions for the `Student__c` object.
* **API Names:** Ensure the field API names in the Apex code match exactly with the ones created in your Salesforce Org (e.g., `Roll_No__c`).
