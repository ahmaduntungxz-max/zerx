# 🎯 MCHR-BL CLI (Mi-Community Hero Request-BL)

**MCHR-BL CLI** adalah bot script untuk merebut tiket Unlock Bootloader (UBL) Xiaomi Global.

---

## 🛠️ Tutorial Install (Android)

1. Download **Termux** wajib versi [F-Droid](https://f-droid.org/id/packages/com.termux/) atau versi [GitHub Release](https://github.com/termux/termux-app/releases) karena versi Playstore sudah kadaluarsa.

2. Jalankan perintah ini terlebih dahulu untuk persiapan.

```bash
termux-setup-storage
```
3. lalu izinkan dan lanjutkan perintah berikutnya.

```bash
pkg update && pkg upgrade -y
```
```bash
pkg install python git curl -y
```
4. lalu paste ini di termux.

```bash
bash <(curl -s https://raw.githubusercontent.com/ProjectRedis/mchrbl-cli/refs/heads/main/install.sh)
```
5. Reload termux dan ketik.

```bash
ubl-go
```
