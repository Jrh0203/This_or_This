<?php
// Create connection

include "dbinfo.inc.php";

$conn = mysqli_connect($servername, $username, $password, $dbname);

$questions = mysqli_query($conn,"SELECT question FROM Questions");
$users = mysqli_query($conn,"SELECT user FROM Questions");
$questionids = mysqli_query($conn,"SELECT id FROM Questions");

// Check connection
if (!$conn) {
	die("2\n" . mysqli_connect_error());
}

if(mysqli_num_rows($questions) == 0){
	die("0\n");
}
$questionlist = array();
//print stuff
for($i = 0; $i < mysqli_num_rows($questions);$i++){
	$question = mysqli_fetch_row($questions)[0];
	$questionid = mysqli_fetch_row($questionids)[0];
	/*echo ($questionid[0].":");
	echo ($question[0]."\n");*/
	$questionlist[$questionid] = $question;
}

echo json_encode($questionlist);

mysqli_close($conn);
?>
