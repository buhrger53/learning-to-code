# learning_to_code

repository about learning to code in godot but also learning about some things in github, along with some practices or customs
<br>
i use github desktop, so i didn't memorize the terminal commands



## info about branch naming:

automated rulesets are used to set a consistent way of naming branches

## branch naming rules:
new branches can't be pushed unless they contain these prefixes:
*   `feature/feature-name`, which is used for adding new features or code
*   `bugfix/name-of-the-fix`, which is used for fixing bugs or resolving errors
*   `refactor/what-is-being-changed`, which is used for simplifying/updating the logic, changing the formatting, or rewording the/adding new comments of the code
*   `docs/document-name`, which is for adding new documentation or things related to that
*   `experiment/what-you're-testing`, which is for doing random things and testing, without a clear idea in mind like feature could be
*   `test/name-of-thing-for-tests`, which i just added because i don't think tests would fit into the other branches

## how to add changes to the project:
1. make a branch that follows the naming rules
2. code your changes inside your branch
3. push your branch
4. open a pull request that targets the main branch
5. ask someone else to review your work and approve your pull request, so it can be merged



## committing changes:

for organizational purposes and a way to see the general category the changes of the commit are considered, the summary and description of the commit are formatted a specific way
<br>
i just partially used the "conventional commits" style

## how commit messages are formatted:

`feat:` new features or functionalities <br>
`fix:` bugfix <br>
`refactor:` rewriting/simplifying code, but it still does the same thing <br>
`docs:` changing comments for code, but it could also be for changing general documentation in .txt or .md files <br>
`style:` formatting some things, like brackets or whitespace <br>
`chore:` doing some random thing that counts as changes (i included this cuz i had to move a file) <br>
`revert:` for when you revert a change <br>
`test:` for doing stuff with automated testing <br>
`experiment:` random testing for ideas (optionally) <br>

commit summary: `<commit type>: <short description of the purpose of the changes in the commit>` <br>
commit description: with either hyphens to list things, put `- <more specific change>: <what changed>` if you changed multiple things <br>

imperative form should also be used for consistency when talking about changes
