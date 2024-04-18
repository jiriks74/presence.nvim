# Contributing

## Table of Contents

- [Issues](#issues)
  - [Bugs/Issues](#bugsissues)
  - [Feature Requests](#feature-requests)
- [Pull Requests](#pull-requests)
  - [Make sure code is up to standards](#make-sure-code-is-up-to-standards)
    - [Using StyLua and Luacheck directly](#using-stylua-and-luacheck-directly)
    - [Using `act`](#using-act)
      - [First time setup](#first-time-setup)
      - [Running `act`](#running-act)
        - [Luacheck Issues](#luacheck-issues)
        - [StyLua Issues](#stylua-issues)
- [Assets](#assets)

## Issues

My repository uses Github's forms so it's easier to create a new issue or
feature request with all the necessary information.

When reporting a new issue or creating a feature request:

1. Check that it doesn't exist already
  - Even if an issue is closed add a command and/or reopen it.
  It's easier to track one issue in one
  issue report than in 3.
2. Use the appropriate form
  - When clicking the `New Issue` button you can either select `Issue Report`
  or `Feature Request`
3. Fill out all the information
  - Eg. if the form asks for logs provide them.
  If you cannot provide some information say so and why.
4. Wait for feedback
  - I'm a college student doing this for free.
  I'll try to respond ASAP but finding time for maintaining something like
  this is hard so please keep that in mind.

### Bugs/Issues

To create a new bug report just use the
[Issue Form](https://github.com/jiriks74/presence.nvim/issues/new?assignees=jiriks74&labels=bug&projects=&template=bug_report.yml&title=%5BBug%5D%3A+)
from the selection after clicking the `New Issue` button.
The form will guide you through the process.

### Feature Requests

To create a feature request just use the
[Feature Request Form](https://github.com/jiriks74/presence.nvim/issues/new?assignees=jiriks74&labels=enhancement&projects=&template=feature_request.yml&title=%5BFEAT%5D%3A+)
from the selection after clicking the `New Issue` button. The form will guide you through the process.

## Pull Requests

*I know that it can be annoying to adopt standard from every project but if
there weren't any the project would be soon unreadable and unmaintainable.*

To have your PR merged more quickly you'll need to keep the following things in mind:

- StyLua
  - While I understand that everybody is used to their code
  formatting I'll have to enforce StyLua. There were contributions that
  reformatted the whole codebase while modifying 2 lines of code.
  It takes a lot of time to go through such contributions and figure out
  what was really changed and what was their formatting tool.
  - So please use StyLua (`v0.20.0`) to format your code.
- Luacheck
  - Luacheck is here to catch errors that anyone could overlook.
  Some warnings/issues may feel like small things when they basically don't
  impact anything (eg. unused argument) but once there's enough issues it
  becomes hard to find the *real* ones in the large number of issues
  that *don't matter*.
  - So please use Luacheck and fix any issues/warnings you can.
- Conventional commits
  - Everybody is used to writing commits their own way. But everybody
  communicates differently and people like to commit things like:
  `test`, `test2`, `small changes`, etc. It's then hard to figure
  out what that commit actually means, what changes were made and what parts of
  the codebase are affected.
  - Your PRs will most likely be squashed and merged so you can keep doing
  commit messages as you're used to.
  But please use Conventional commits for the PR title
  (and description if aplicable) for better readability and better commit
  message when the PR is squashed and merged.

### Make sure code is up to standards

#### Using StyLua and Luacheck directly

To run Luacheck use the following command in the repository's root directory:

```bash
luacheck --config .luacheckrc .
```

To format using StyLua first make sure that you're using StyLua `0.20.0`
(`stylua --version`) to prevent any formatting changes between the versions.
Then you can run the following command to format the code:

```bash
stylua .
```

#### Using `act`

If you don't want to mess around with StyLua and Luacheck you can use [`act`](https://github.com/nektos/act).
It's a runner for Github workflows that allows you to run them locally.

Using `act` you can run the same StyLua and Luacheck workflows
that will run on your PR before it's merged. 

If you use `nix` and `direnv` I've setup `default.nix` and `.envrc` files
in the project's root for easy environment setup.


##### First time setup

1. Install prerequisites
  - `docker`
2. [Install `act`](https://nektosact.com/installation/index.html)
3. Run `act`
4. Select the `Medium` image size
5. Let it run
  - The initial run takes longer because it requires pulling the Docker images
  and installing the necessary packages within the container. My workflows
  utilize cache so any subsequent runs will take considerably less time
  unless there's a package update.

##### Running `act`

Just run `act` without any arguments and it will run all the workflows in the `.github/workflows`
directory.

You should see something like:

```bash
[StyLua/StyLua] 🏁  Job succeeded
```

and

```bash
[Luacheck/Luacheck ] 🏁  Job succeeded
```

if there were no issues found. 

If there were issues you'll see something like this at the end of `act` output:

```bash
Error: Job 'StyLua' failed
```

or

```bash
Error: Job 'Luacheck' failed
```

If both workflows fail it will show `Error: Job 'xy' failed`
only for the fist one that failed.

###### Luacheck Issues

If there are issues the output will have something like this:

```bash
[Luacheck/Luacheck ]   ❌  Failure - Main Luacheck linter
[Luacheck/Luacheck ] exitcode '2': failure
[Luacheck/Luacheck ] ⭐ Run Post Install Luacheck
[Luacheck/Luacheck ]   🐳  docker cp src=<dir-xy> dst=<dir-ab>
[Luacheck/Luacheck ]   ✅  Success - Post Install Luacheck
[Luacheck/Luacheck ] 🏁  Job failed
```

To know what exactly what's wrong look a bit above in the output and see
somethings like:

```bash
[Luacheck/Luacheck ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3] user= workdir=
| Checking lua/lib/log.lua                          OK
| Checking lua/presence/discord.lua                 OK
| Checking lua/presence/file_assets.lua             OK
| Checking lua/presence/file_explorers.lua          OK
| Checking lua/presence/init.lua                    1 error
| 
|     lua/presence/init.lua:1268:1: expected <eof> near 'end'
| 
| Checking lua/presence/plugin_managers.lua         OK
| 
| Total: 0 warnings / 1 error in 6 files
```

###### StyLua Issues

If there are issues the output will have something like this:

```bash
[StyLua/StyLua]   ❌  Failure - Main Check code formatting
[StyLua/StyLua] exitcode '1': failure
[StyLua/StyLua] ⭐ Run Post Install cargo
[StyLua/StyLua]   🐳  docker cp src=/home/jirka/.cache/act/awalsh128-cache-apt-pkgs-action@latest/ dst=/var/run/act/actions/awalsh128-cache-apt-pkgs-action@latest/
[StyLua/StyLua]   ✅  Success - Post Install cargo
[StyLua/StyLua] 🏁  Job failed
```

StyLua creates a `diff` between the expected formatting
and the formatting that is used.
Look a bit above in the output to see it:

```bash
[StyLua/StyLua]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/4] user= workdir=
| Diff in ./lua/presence/init.lua:
| 12721272 | function Presence:handle_buf_add()
| 12731273 |    self.log:debug("Handling BufAdd event...")
| 12741274 | 
| 1275     |-vim.schedule(function()
| 1276     |-  if vim.bo.filetype == "qf" then
| 1277     |-    self.log:debug("Skipping presence update for quickfix window...")
| 1278     |-    return
| 1279     |-  end
|     1275 |+   vim.schedule(function()
|     1276 |+           if vim.bo.filetype == "qf" then
|     1277 |+                   self.log:debug("Skipping presence update for quickfix window...")
|     1278 |+                   return
|     1279 |+           end
| 12801280 | 
| 1281     |-  self:update()
| 1282     |-end)
|     1281 |+           self:update()
|     1282 |+   end)
| 12831283 | end
| 12841284 | 
| 12851285 | return Presence
```

To fix these issues you can either manually modify the file using the diff
or you can run `stylua .` and it will apply the formatting automatically.

## Assets

All the assets are in the [`file_assets.lua`](lua/presence/file_assets.lua).

If you'd like to add/modify any assets create a PR to the mentioned
[`file_assets.lua`](lua/presence/file_assets.lua).
