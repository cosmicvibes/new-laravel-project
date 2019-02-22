<!-- Please don't remove this: Grab your social icons from https://github.com/carlsednaoui/gitsocial -->

<!-- links to social media icons -->
<!-- no need to change these -->

<!-- icons with padding -->

[1.1]: http://i.imgur.com/tXSoThF.png (twitter icon with padding)
[2.1]: http://i.imgur.com/P3YfQoD.png (facebook icon with padding)
[3.1]: http://i.imgur.com/yCsTjba.png (google plus icon with padding)
[4.1]: http://i.imgur.com/YckIOms.png (tumblr icon with padding)
[5.1]: http://i.imgur.com/1AGmwO3.png (dribbble icon with padding)
[6.1]: http://i.imgur.com/0o48UoR.png (github icon with padding)

<!-- icons without padding -->

[1.2]: http://i.imgur.com/wWzX9uB.png (twitter icon without padding)
[2.2]: http://i.imgur.com/fep1WsG.png (facebook icon without padding)
[3.2]: http://i.imgur.com/VlgBKQ9.png (google plus icon without padding)
[4.2]: http://i.imgur.com/jDRp47c.png (tumblr icon without padding)
[5.2]: http://i.imgur.com/Vvy3Kru.png (dribbble icon without padding)
[6.2]: http://i.imgur.com/9I6NRUm.png (github icon without padding)
<!-- update these accordingly -->

[1]: http://www.twitter.com/cosmicvibes
<!-- Please don't remove this: Grab your social icons from https://github.com/carlsednaoui/gitsocial -->


# new-laravel-project
Simple bash script to create a new Laravel project, create a git repo, push it and configure/run Homestead & Vagrant. 

Motivation
----------

I frequently create new Laravel projects, and tire of having to run the same set of commands over and over again. This script wraps it all up.

Files
-----

| File                       | Description                                                                            |
| -------------------------- |--------------------------------------------------------------------------------------- |
| **new_laravel_project.sh** | Creates a new project, if no options specified it will prompt for options.             |

Usage
-----

Feel free to adjust to your own needs. If you make changes that would be useful to others then pull requests will be welcomed.

The script is not marked as executable by default, if you wish to do so use: ```chmod +x new_laravel_project.sh```

I like to keep my projects in a folder set like this: ```Awesome/awesome``` with the top level (capitalised) folder giving me a place to add any miscellaneous files that will not be added to the git repository, and the lowercase folder inside being the actual code/git repository. As such this script expects you to specify the project name in lowercase and it will automatically create the aforementioned folder structure. If you don't like this, do change it as you require. 

Options:

```
-n|--name               Name of the project (it expects lowercase)
-r|--repo-url           Optional: Git repository URL to push to
-u|--vagrant-up         Optional: Run "vagrant up"
-e|--edit-homestead     Optional: Prompt to edit the Homestead.yaml file
-i|--interactive        Optional: Run interactively
-y|--no-prompts         Optional: Run without any confirmation
```

Example:

```
$ bash new_laravel_project.sh --name SomeProjectName --repo-url git@github.com:myusername/myproject.git --edit-homestead --vagrant-up
```

Feel free to get in touch with feedback: [@cosmicvibes][1] [![alt text][1.2]][1]
