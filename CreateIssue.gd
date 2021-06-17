extends Control
"""
Send issues to your Gitlab istance
"""
const GITLAB_URL = "https://my-gitlab-server.com"
const PROJECT_ID = "1"
const OAUTH_TOKEN = "xxxxxxxxxx"
const LABEL = "UserFeedback"
const USE_SSL = false

var headers = ["Content-Type: application/json", "Authorization: Bearer " + OAUTH_TOKEN]


func _ready() -> void:
	$HTTPRequest.connect("request_completed", self, "_on_HTTPRequest_request_completed")
	$SendButton.connect("pressed", self, "_on_SendButton_pressed")


func _on_SendButton_pressed() -> void:
	if not $HeaderText.text.empty() and not $BodyText.text.empty():
		var Dict : Dictionary = {
			"title": $HeaderText.text.http_escape(),
			"description": $BodyText.text.replace("\n", " | ").http_escape(),
			"labels": LABEL
		}
		_send_event(Dict, HTTPClient.METHOD_POST)


func _send_event(_parameters:Dictionary,
				_method=HTTPClient.METHOD_POST) -> void:

	if $HTTPRequest.get_http_client_status() == HTTPClient.STATUS_DISCONNECTED:
		var url = GITLAB_URL + "/api/v4/projects/" + PROJECT_ID + "/issues?"
		for u in _parameters:
			url += u + "=" + _parameters[u] + "&"

		var error = $HTTPRequest.request(url, headers, USE_SSL, _method)
		if error != OK:
			print("http error")


func _on_HTTPRequest_request_completed(result: int,
										response_code: int,
										headers: PoolStringArray,
										body: PoolByteArray) -> void:

	if result == HTTPRequest.RESULT_SUCCESS and response_code == 201:
		var message = parse_json( body.get_string_from_utf8() )
		var issue_id = message["iid"]
		print("Feedback send to server: ok", 2)
		print("Issue created: " + str(issue_id))
		$HeaderText.text = ""
		$BodyText.text = ""

	else:
		print("Error while sending feedback to server: code " + str(response_code))

