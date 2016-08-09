<?php
// Create connection

include "dbinfo.inc.php";

$conn = mysqli_connect($servername, $username, $password, $dbname);

$questions = mysqli_query($conn,"SELECT question FROM Questions ORDER BY id desc");
$users = mysqli_query($conn,"SELECT user FROM Questions ORDER BY id desc");
$questionids = mysqli_query($conn,"SELECT id FROM Questions ORDER BY id desc");
$leftoptions = mysqli_query($conn,"SELECT left_answer FROM Questions ORDER BY id desc");
$rightoptions = mysqli_query($conn,"SELECT right_answer FROM Questions ORDER BY id desc");
$left_texts = mysqli_query($conn,"SELECT left_text FROM Questions ORDER BY id desc");
$right_texts = mysqli_query($conn,"SELECT right_text FROM Questions ORDER BY id desc");

// Check connection
if (!$conn) {
	die("2\n" . mysqli_connect_error());
}

if(mysqli_num_rows($questions) == 0){
	die("0\n");
}
$questionlist;
//print stuff
for($i = 0; $i < mysqli_num_rows($questions);$i++){
	$question = mysqli_fetch_row($questions)[0];
	$questionid = mysqli_fetch_row($questionids)[0];
	$leftWord = mysqli_fetch_row($leftoptions)[0];
	$rightWord = mysqli_fetch_row($rightoptions)[0];
	$leftText = mysqli_fetch_row($left_texts)[0];
	$rightText = mysqli_fetch_row($right_texts)[0];
	$yes = mysqli_num_rows(mysqli_query($conn,"SELECT id FROM Votes WHERE questionid = '$questionid' AND response = '1' ORDER BY id desc"));
	$no = mysqli_num_rows(mysqli_query($conn,"SELECT id FROM Votes WHERE questionid = '$questionid' AND response = '0' ORDER BY id desc"));
	/*echo ($questionid[0].":");
	echo ($question[0]."\n");*/
	$questionlist["questions"][$i] = array("id" => $questionid,
			"content" => $question,
			"leftImage" => $leftWord,
			"rightImage" => $rightWord,
			"leftText" => $leftText,
			"rightText" => $rightText,
			"yes" => $yes,
			"no" => $no
	);
}

echo json_encode($questionlist);

mysqli_close($conn);
?>
