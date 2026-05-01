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

## Troubleshooting
* **Permissions:** If you get an error saving a record, ensure your User Profile has "Read" and "Create" permissions for the `Student__c` object.
* **API Names:** Ensure the field API names in the Apex code match exactly with the ones created in your Salesforce Org (e.g., `Roll_No__c`).
