<?php
$questionid = $_GET["questionid"];
$vote = $_GET["vote"];

$response = false;

if(strcmp($vote,"YES")==0){
	$response = 1;
}else if(strcmp($vote,"NO")==0){
	$response = 0;
}else{
	die("invalid resquest\n");
}

include "dbinfo.inc.php";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

if(!is_numeric($questionid)){
	die("invalid request\n");
}

// Check connection
if (!$conn) {
    die("db connection error\n" . mysqli_connect_error());
}

$sql = "INSERT INTO Votes (id,questionid,response)
VALUES (NULL, '".mysqli_real_escape_string($conn,$questionid)."', '".$response."')";

if (mysqli_query($conn, $sql)) {
    echo "success\n";
} else {
    echo "3\n" . $sql . "<br>" . mysqli_error($conn);
}
mysqli_close($conn);
?>