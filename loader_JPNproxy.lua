-- ============================================================
--  JPNPROXY LOADER v2 - B'INTERNAL (Growtopia)
--  Download script ter-encrypt dari GitHub, decrypt
--  menggunakan pure-Lua (b64decode bawaan + XOR native Lua 5.4),
--  lalu jalankan.
--
--  TIDAK PAKAI LoadEncrypt -> tidak tergantung algoritma
--  internal B'INTERNAL yang bisa berubah antar versi.
-- ============================================================

--------------------------------------------------------------
-- PENGATURAN
--------------------------------------------------------------
local URL = "https://raw.githubusercontent.com/ACHALFINMU/JPNproxy/main/JPNproxy_encryt.lua"
local KEY = "87844221913"          -- string key, WAJIB sama dengan saat encrypt
local NO_CACHE = true              -- bypass cache GitHub 5 menit

--------------------------------------------------------------
-- 1. Download
--------------------------------------------------------------
local fetchURL = URL
if NO_CACHE then
    fetchURL = URL .. "?t=" .. os.time()
end

local resp = MakeRequest(fetchURL, "GET")

if resp.error or resp.status ~= 200 then
    print("[JPN] Download GAGAL! status: " .. tostring(resp.status))
    print("[JPN] Cek: repo public? link raw benar?")
    return
end

local enc = resp.content
if not enc or #enc < 100 then
    print("[JPN] Isi file kecil/korup: " .. tostring(enc))
    return
end

print("[JPN] Download sukses: " .. #enc .. " karakter")

--------------------------------------------------------------
-- 2. Base64 decode (pakai b64decode bawaan B'INTERNAL)
--------------------------------------------------------------
local okB64, raw = pcall(b64decode, enc)
if not okB64 or not raw or #raw == 0 then
    print("[JPN] Base64 decode gagal - file korup atau bukan base64")
    return
end

--------------------------------------------------------------
-- 3. XOR decrypt (bitwise ~ native Lua 5.4)
--------------------------------------------------------------
local out = {}
for i = 1, #raw do
    out[i] = string.char(
        string.byte(raw, i) ~ string.byte(KEY, (i - 1) % #KEY + 1)
    )
end
local source = table.concat(out)

--------------------------------------------------------------
-- 4. Load + jalanin
--------------------------------------------------------------
local fn, err = load(source)
if not fn then
    print("[JPN] Load script GAGAL: " .. tostring(err))
    print("[JPN] Kemungkinan KEY tidak sama dengan saat encrypt")
    return
end

local okRun, errRun = pcall(fn)
if not okRun then
    print("[JPN] Error saat menjalankan script: " .. tostring(errRun))
end

-- ============================================================
--  CARA ENCRYPT / UPDATE SCRIPT (untuk owner):
--
--  Script kamu di-encrypt di luar (sudah diberikan file
--  JPNproxy_encryt.lua dengan key "87844221913").
--
--  Kalau mau update isi script dengan versi baru, kirim
--  file JPNproxy.lua yang baru untuk di-encrypt ulang,
--  atau jalankan encryptor yang sama dengan KEY di atas.
--
--  Kalau memang mau pakai sistem bawaan B'INTERNAL
--  (EncryptFile / LoadEncrypt), hati-hati: algoritma
--  internalnya bisa beda antar versi (contoh: file
--  WinProxy .lua_enc formatnya beda dengan JPN).
-- ============================================================
