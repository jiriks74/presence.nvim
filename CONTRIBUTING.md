# Contributing

## Issues

## Pull Requests

*I know that it can be annoying to adopt standard from every project but if there weren't any the
project would be soon unreadable and unmaintainable.*

To have your PR merged in this repository you'll need to keep the following things in mind:

- StyLua
  - While I understand that everybody is used to their code formatting I'll have to enforce StyLua.
  There were contributions that reformatted the whole codebase while modifying 2 lines of code.
  It takes a lot of time to go through such contributions and figure out what was really changed.
  - So please use StyLua (for Lua 5.1) to format your code.
- LuaCheck
  - LuaCheck is here to catch errors that I could overlook since I'm not that great with Lua.
  Some warnings/issues may feel like small things that don't impact anything but once there's enough
  issues it becomes hard to find the *real* ones in the large number of issues that *don't matter*.
  - So please use LuaCheck and fix any issues/warnings you can.
- Conventional commits
  - Everybody is used to writing commits their own way. But everybody communicates differently and
  people like to commit things like: `test`, `test2`, `small changes`, ... It's then hard to figure
  out what commit changed what and what parts of the codebase it affects.
  - Your PRs will most likely be squashed and merged so you can keep doing commit messages as you're
  used to. But please use Conventional commits for the PR title (and description if aplicable) for
  better readability and better commit message when squashed and merged.

### Easily use StyLua and LuaCheck

If you don't want to mess around with StyLua and LuaCheck you can use [`act`]().
It's a runner for Github Actions that allows you to run the actions locally.

Using `act` you can run the same StyLua and LuaCheck actions that will be run on your PR before
you create it. 

If you use `nix` and `direnv` I've setup `default.nix` and `.envrc` files in the project's root
for easy environment setup.

#### Using `act`

##### First time setup

1. Install prerequisites
  - `docker`
2. [Install `act`](https://nektosact.com/installation/index.html)
3. Run `act`
4. Select the `Medium` image size
5. Let it run
  - First time run takes longer because it needs to pull the Docker images and install the necessary
  packages. My workflows utilize cache so any subsequent runs will take considerably less time unless
  there's a package update.

##### Using `act`

Just run `act` without any arguments and it will run all the workflows in the `.github/workflows`
directory.

You should see something like:

```
[StyLua/StyLua] 🏁  Job succeeded
```

and

```
[Luacheck/Luacheck ] 🏁  Job succeeded
```

If there were issues you'll see something like this at the end of `act` output:

```
Error: Job 'StyLua' failed
```

or

```
Error: Job 'Luacheck' failed
```

If both workflows fail it will show `Error: Job 'xy' failed`
only for the fist one that failed at the end.

###### LuaCheck Issues

If there are issues the output will have something like this:

```
[Luacheck/Luacheck ]   ❌  Failure - Main Luacheck linter
[Luacheck/Luacheck ] exitcode '2': failure
[Luacheck/Luacheck ] ⭐ Run Post Install Luacheck
[Luacheck/Luacheck ]   🐳  docker cp src=<dir-xy> dst=<dir-ab>
[Luacheck/Luacheck ]   ✅  Success - Post Install Luacheck
[Luacheck/Luacheck ] 🏁  Job failed
```

To know what exactly what's wrong look a bit above in the logs and see somethings like:

```
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

```
[StyLua/StyLua]   ❌  Failure - Main Check code formatting
[StyLua/StyLua] exitcode '1': failure
[StyLua/StyLua] ⭐ Run Post Install cargo
[StyLua/StyLua]   🐳  docker cp src=/home/jirka/.cache/act/awalsh128-cache-apt-pkgs-action@latest/ dst=/var/run/act/actions/awalsh128-cache-apt-pkgs-action@latest/
[StyLua/StyLua]   ✅  Success - Post Install cargo
[StyLua/StyLua] 🏁  Job failed
```

StyLua creates a `diff` between the expected formatting and the formatting that is used.

```
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

To fix these issues you can either manually modify the file using the diff or run `stylua .` and it
will apply the formatting automatically.
