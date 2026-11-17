# dashboards

Four ESG / sustainability dashboards, one per folder. **The contents are encrypted** (AES-256-CBC, PBKDF2 with 600,000 iterations). You need the key shared with you separately to open them.

| Folder | Encrypted file |
|---|---|
| `bachmai/` | `bachmai/bachmai.tar.gz.enc` |
| `tranphu/` | `tranphu/tranphu.tar.gz.enc` |
| `vtm/` | `vtm/vtm.tar.gz.enc` |
| `rangdong/` | `rangdong/rangdong.tar.gz.enc` |

Once decrypted, each folder has its own `SETUP.md` with install, run, build and deploy steps.

## Decrypt

You need `openssl` (3.x) and `tar`. macOS and Linux have both. On Windows, use **Git Bash** (it ships with Git for Windows and includes both).

1. Save the key you were given into a file named `dashboards.key` in the repo root. It is git-ignored, so don't commit it.

   ```bash
   printf '%s' 'PASTE-KEY-HERE' > dashboards.key
   ```

2. Decrypt all four folders:

   ```bash
   ./decrypt.sh            # or: ./decrypt.sh path/to/dashboards.key
   ```

   Or decrypt a single folder by hand:

   ```bash
   openssl enc -d -aes-256-cbc -pbkdf2 -iter 600000 -pass file:dashboards.key \
     -in vtm/vtm.tar.gz.enc | tar -xzf -
   ```

   Each archive unpacks into its own folder next to the `.enc` file (`vtm/package.json`, `vtm/src/`, ...). Decrypted files are git-ignored, so they won't be committed by accident.

3. Run a dashboard:

   ```bash
   cd vtm
   npm install
   npm run dev
   ```

A wrong key fails with `bad decrypt` and writes nothing.

## Re-encrypt after changes (maintainers)

```bash
./encrypt.sh            # re-packs each decrypted folder into its .enc file
git add */*.enc && git commit -m "Update dashboards"
```
