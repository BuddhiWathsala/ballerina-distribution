import ballerina/io;

type Student record {
    string firstName;
    string lastName;
    int intakeYear;
    float gpa;
};

type Report record {
    string name;
    string degree;
    int graduationYear;
};

public function main() {
    Student s1 = { firstName: "Martin", lastName: "Sadler", intakeYear: 1990,
                   gpa: 3.5 };
    Student s2 = { firstName: "Ranjan", lastName: "Fonseka", intakeYear: 2001, 
                   gpa: 1.9 };
    Student s3 = { firstName: "Michelle", lastName: "Guthrie", intakeYear: 2002,
                   gpa: 3.7 };
    Student s4 = { firstName: "George", lastName: "Fernando", intakeYear: 2005, 
                   gpa: 4.0 };

    Student[] studentList = [s1, s2, s3, s4];

    //The `from` clause works similarly to a `foreach` statement.
    //It can be used to iterate any iterable value.
    //The `reportList` is the result of the `query` expression.
    Report[] reportList = from var student in studentList
       //The `where` clause provides a way to perform conditional execution and works similarly to an `if` condition.
       //It can refer to variables bound by the `from` clause.
       //When the `where` condition evaluates to false, the current iteration is skipped.
       where student.gpa >= 2.0
       //The `let` clause binds the variables.
       let string degreeName = "Bachelor of Medicine",
       int graduationYear = calGraduationYear(student.intakeYear)
       //The `order by` clause sorts the output items based on the given `order-key` and `order-direction`.
       //The `order-key` must be an ordered type. The `order-direction` is `ascending` if not specified explicitly.
       order by student.firstName descending
       //The `limit` clause limits the output items.
       limit 2
       //The `select` clause is evaluated for each iteration.
       //The result of the query expression is a list (`reportList`) whose members are the result of
       //the `select` clause.
       select {
              name: student.firstName + " " + student.lastName,
              degree: degreeName,
              graduationYear: graduationYear
       };

    error? e = reportList.forEach(function (Report report) {
       io:println(report);
    });
}

function calGraduationYear(int year) returns int {
    return year + 5;
}

