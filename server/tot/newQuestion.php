<?php
$name = $_GET["name"];
$question = $_GET["question"];
$leftWord = "img0.png";
$rightWord = "img1.png";
$leftText = $_GET["leftText"];
$rightText = $_GET["rightText"];

include "dbinfo.inc.php";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

if(empty($name) || empty($question)){
	die("invalid request\n");
}

// Check connection
if (!$conn) {
    die("db connection error\n" . mysqli_connect_error());
}

$sql = "INSERT INTO Questions (id, user, question, left_answer, right_answer, left_text, right_text, time)
VALUES (NULL, '".mysqli_real_escape_string($conn,$name)."', '".
mysqli_real_escape_string($conn,$question)."', '".
mysqli_real_escape_string($conn, $leftWord)."','".
mysqli_real_escape_string($conn, $rightWord)."','".
mysqli_real_escape_string($conn, $leftText)."','".
mysqli_real_escape_string($conn, $rightText).
"',CURRENT_TIMESTAMP)";
$result = mysqli_query($conn, $sql);

$questionid = mysqli_insert_id($conn);
echo "$questionid";


mysqli_close($conn);
?>