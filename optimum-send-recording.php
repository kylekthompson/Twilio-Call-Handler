<?php
/**
 * This section ensures that Twilio gets a response.
 */
header('Content-type: text/xml');
echo '<?xml version="1.0" encoding="UTF-8"?>';
echo '<Response></Response>'; //Place the desired response (if any) here

/**
 * This section actually sends the email.
 */
$to      = "kyle@kylekthompson.com"; // Your email address
$subject = "Recording Received! (Optimum Anesthesia Phone Service)";
$message = "You have received a recording of a phone call through your phone service.
Phone Call Status: {$_REQUEST['DialCallStatus']}
Phone Call Duration: {$_REQUEST['DialCallDuration']}
Recording URL: {$_REQUEST['RecordingUrl']}.mp3";
$headers = "From: webmaster@onlyoptimum.com"; // Who should it come from?

mail($to, $subject, $message, $headers);
?>
