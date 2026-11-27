# JPNproxy

Growtopia (CreativePS) proxy script with an ImGui control panel, automation tools, and in-game dialog menus.

## Features
- ImGui panel and in-game dialog menu (`/imgui`, `/menu`)
- Auto Pull, Wrench actions, SpamPull and RePull
- Auto Spam, Super Broadcast and Super Duper Broadcast
- Casino helpers, Telephone auto-buy, Calculator, Item Database
- Custom command aliases and hotkeys
- Access control with a remote UID whitelist (`uids.txt`)

## Installation
1. Execute `loader_JPNproxy.lua` in B'INTERNAL.
2. The loader downloads the encrypted script from this repo, decrypts it, and runs it automatically.
3. Open the panel with `/imgui` or the in-game menu with `/menu`.

## How the loader works
- Downloads `JPNproxy_encryt.lua` (base64 + XOR encrypted with key `87844221913`)
- Decodes with the built-in `b64decode`, XOR-decrypts with native Lua 5.4 bitwise, then `load()` + run
- Does NOT depend on B'INTERNAL's internal `Encrypt`/`LoadEncrypt` algorithm, so it works on any version
- Adds a cache-busting parameter so script updates are picked up instantly (no 5-minute GitHub raw cache)

## Access control
- On startup the script reads `uids.txt` from this repository (`W.WhitelistURL` in the script) and checks the player's UID.
- The UID must be listed in `uids.txt`, one UID per line. If it is not listed, or the list cannot be loaded, the script stops completely.
- To grant access, add the UID to `uids.txt` and push.
- Optional: set `W.AuthWebhook` to a Discord webhook to get status notifications.

## Updating the script (for owner)
The encrypted file `JPNproxy_encryt.lua` was produced with:
`base64( XOR( JPNproxy.lua , "87844221913" ) )`

To ship a new version:
1. Encrypt the new `JPNproxy.lua` with the same method/key.
2. Replace `JPNproxy_encryt.lua` in this repo.
3. Users need no update — the loader always fetches the latest version.

## Disclaimer
Use at your own risk. Automation may violate the game's terms of service.
