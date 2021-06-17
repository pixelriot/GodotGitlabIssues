# GodotGitlabIssues

Simple interface to create issues in your Gitlab board straight from your Godot game.
You can use it to gather feedback data from your audience or create bug reports during playtest sessions.

![alt text](https://user-images.githubusercontent.com/21098503/122400144-bdf7e900-cf7b-11eb-8b6a-aef1f5c5640f.png)


## How to use

1. Download the project and add the files *CreateIssue.tscn* and *CreateIssue.gd* to your project.
2. Set the following constants in *CreateIssue.gd* according to your Gitlab instance and Gitlab project:
  * const GITLAB_URL = "my-gitlab-server-url"
  * const PROJECT_ID = "1"
  * const OAUTH_TOKEN = "xxxxxxxxxx"
3. Add an issue headline into the **HeaderText** and a full issue description to the **BodyText**.
4. Press the **Send-button** and a second later a new issue should be created in your Gitlab board.


## How to get an Oauth token

1. Open Gitlab and click on your user profile in the top right corner.
2. Select *Settings* and from there, *Access Tokens* in the left side bar.
3. Create a new token with the scope *api*.

## How to get project id

1. Open your project on Gitlab and go to *Project Overview → Details*.
2. Your project id should be visible right under your project name.
