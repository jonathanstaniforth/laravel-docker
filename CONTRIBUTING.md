# Contributing
The following is a set of guidelines for contributing to this project. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

This repository uses [GitFlow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) for submitting changes.

## Pull requests
Please follow the process outlined below when requesting changes to be merged:

* Propose changes to be made early by creating a pull request, labelled with **WIP:** at the beginning of the title, along with details about the changes.
* Update the README.md and CHANGELOG.md files appropriately with information about the change.
* Before merging a release branch, update the CHANGELOG.md file with a new version number, then add a new tag on master with this number once the merge has complete.
* Before requesting review, clean the commit history.
* When merging, set to squash commits and set the squashed commit message to a list of all previous commit messages.

When submitting pull requests, please make sure to follow the style guides below. Additionally, the reviewer(s) may ask you to complete additional design work, tests, or other changes before your pull request can be ultimately accepted. Furthermore, please make sure to update documentation with details about the pull request.

## Style Guides
This section discusses styling guides to be applied when interacting with the project.

Git commit messages:

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

Documentation:

* Use [Markdown](https://www.markdownguide.org/)