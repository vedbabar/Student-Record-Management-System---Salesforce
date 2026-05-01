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
