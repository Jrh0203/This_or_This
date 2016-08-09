<?php
// Create connection
$questionid = $_GET["questionid"];
$side = $_GET["side"];

if(empty($questionid) || empty($side)){
	die("need more info");
}

include "dbinfo.inc.php";

$conn = mysqli_connect($servername, $username, $password, $dbname);
$location = mysqli_query($conn,"SELECT ".$side."_answer FROM Questions WHERE id = $questionid");

echo mysqli_fetch_row($location)[0];

mysqli_close($conn);
?>
