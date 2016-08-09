<?php
// Create connection
$questionid = $_GET["questionid"];

if(empty($questionid)){
	die("need more info");
}

include "dbinfo.inc.php";

$conn = mysqli_connect($servername, $username, $password, $dbname);

$yes = mysqli_query($conn,"SELECT id FROM Votes WHERE questionid = '$questionid' AND response = '1'");
$no = mysqli_query($conn,"SELECT id FROM Votes WHERE questionid = '$questionid' AND response = '0'");

echo mysqli_num_rows($yes).",".mysqli_num_rows($no);

mysqli_close($conn);
?>
