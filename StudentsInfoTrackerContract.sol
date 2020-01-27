pragma solidity >=0.4.22 <0.6.2;
//pragma experimental ABIEncoderV2; // This is experimental.  don't use in main net.
// https://blog.ethereum.org/2019/03/26/solidity-optimizer-and-abiencoderv2-bug/

contract StudensInfoTrackerContract {
    event StudentEvent(
        string name,
        address studentAddr
    );
    event ClassEvent(
        string name,
        string grade
    );
    // event DEBUG (
    //     string message
    // );
    struct Class {
        string name;
        string grade;
    }
    struct Student {
        string name;
        address studentAdr;
        Class[] lectures;
    }
    Student[] private students;
    Student private wStudent;
    Class private wLecture;
    address private owner;
    mapping(address => Student) private addressMap; // to manage duplicate student addresses

    constructor() public {
        owner = msg.sender;
    }

    function addStudent(string memory name, address studentAdr) public {
        require(owner == msg.sender,"you must be teacher to perform this function");
        bool found = false;
        for(uint i; i < students.length; i++) {
            if(hashCompareWithLengthCheck(students[i].name,name)) {
                found = true;
            }
        }
        require(found == false,"Student already exists.");
        require(addressMap[studentAdr].studentAdr != studentAdr,"Duplicate student address");
        wStudent.name = name;
        wStudent.studentAdr = studentAdr;
        students.push(wStudent);
        addressMap[studentAdr] = wStudent;
        emit StudentEvent(wStudent.name,wStudent.studentAdr);
    }

    function addStudentNewClassAndGrade(string memory name, address studentAdr, string memory className, string memory grade) public {
        require(owner == msg.sender,"you must be teacher to perform this function");
        require(addressMap[studentAdr].studentAdr != studentAdr,"Duplicate student address");
        wLecture = Class(className,grade);
        bool sfound = false;
        uint sindex = 0;
        for(uint i; i < students.length; i++) {
            if(hashCompareWithLengthCheck(students[i].name,name)) {
                sfound = true;
                sindex = i;
            }
        }
        require(sfound == false,"Student already exists.");
        wStudent.lectures.push(wLecture);
        wStudent.name = name;
        wStudent.studentAdr = studentAdr;
        students.push(wStudent);
        addressMap[studentAdr] = wStudent;
        emit StudentEvent(wStudent.name,wStudent.studentAdr);
        emit ClassEvent(wLecture.name,wLecture.grade);
    }

    function addClass(string memory studentName, string memory className) public {
        require(owner == msg.sender,"you must be teacher to perform this function");
        bool sfound = false;
        uint sindex = 0;
        bool cfound = false;
        uint cindex = 0;
        for(uint i = 0; i < students.length; i++) {
            if(hashCompareWithLengthCheck(students[i].name,studentName)) {
                sfound = true;
                sindex = i;
            }
        }
        require(sfound,"student does not exist");
        for(uint i = 0; i < students[sindex].lectures.length; i++) {
            if(hashCompareWithLengthCheck(students[sindex].lectures[i].name,className)) {
                cfound = true;
                cindex = i;
            }
        }
        require(cfound == false,"duplicate class for student");
        Class memory class;
        class.name = className;
        students[sindex].lectures.push(class);
        emit StudentEvent(students[sindex].name,students[sindex].studentAdr);
        emit ClassEvent(class.name,class.grade);
    }

    function updateGrade(string memory studentName, string memory className, string memory grade) public {
        require(owner == msg.sender,"you must be teacher to perform this function");
        bool sfound = false;
        bool cfound = false;
        uint sindex = 0;
        uint cindex = 0;
        for(uint i = 0; i < students.length; i++) {
            if(hashCompareWithLengthCheck(students[i].name,studentName)) {
                sfound = true;
                sindex = i;
            }
        }
        require(sfound,"student does not exists");
        for(uint i = 0; i < students[sindex].lectures.length; i++) {
            if(hashCompareWithLengthCheck(students[sindex].lectures[i].name,className)) {
                cfound = true;
                cindex = i;
            }
        }
        require(cfound,"class does not exists");
        students[sindex].lectures[cindex].grade = grade;
        emit StudentEvent(students[sindex].name,students[sindex].studentAdr);
        emit ClassEvent(students[sindex].lectures[cindex].name,students[sindex].lectures[cindex].grade);
    }

    function getStudentNameAndAddress(uint index) public view returns(string memory, address) {
        require(students.length > index,"index is out of bounds.");
        Student memory student = students[index];
        return(student.name, student.studentAdr);
    }

    function getGrade(uint index,string memory className) public view returns(string memory, string memory, string memory) {
        require(students.length > index,"index is out of bounds.");
        Student memory student = students[index];
        bool cfound = false;
        uint cindex = 0;
        for(uint i = 0; i < student.lectures.length; i++) {
            if(hashCompareWithLengthCheck(student.lectures[i].name,className)) {
                cfound = true;
                cindex = i;
            }
        }
        require(cfound,"class is not found.");
        return(student.name,student.lectures[cindex].name,student.lectures[cindex].grade);
    }

    function getClasses(uint index) public view returns (string memory){
        require(students.length > index,"index is out of bounds.");
        string memory rString;
        Student memory student = students[index];
        for(uint i = 0; i < student.lectures.length; i++) {
            rString = strConcat(rString,"classname=");
            rString = strConcat(rString,student.lectures[i].name);
            rString = strConcat(rString,"->grade=");
            rString = strConcat(rString,student.lectures[i].grade);
            rString = strConcat(rString, ",");
        }
        return rString;
    }

    function hashCompareWithLengthCheck(string memory a, string memory b) internal pure returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(bytes(a)) == keccak256(bytes(b));
        }
    }

    function strConcat(string memory _a, string memory _b) internal pure returns (string memory) {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ab = new string(_ba.length + _bb.length);
        bytes memory bab = bytes(ab);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) bab[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) bab[k++] = _bb[i];
        return string(bab);
    }
}