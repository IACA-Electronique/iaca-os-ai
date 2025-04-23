# IACA OS AI

Executable for *IACA OS Executable system*.

Command to manage AI stuff.

[See Google TPU Coral support setup instructions](#google-tpu-coral-support)

## ⚠️ Requirement

### Supported devices

| Device           | Support    |
|------------------|------------|
| Compute module 5 | ✅ `Tested` |

## ⏬ Install

```bash
os install ai
```

## 📖 Usage

```bash
os ai --help
```

## ✍️ Development

### Build

```bash
dpkg-deb --build src/ ai.deb
```

### Deploy

```bash
apt install ./display.deb
```

___

## Google TPU Coral support

**Please follow this step in order.**

**Instructions only for IACA OS.**

### 1. Update `config.txt`

> Unlock boot part : `mount -o remount,rw /boot/firmware/`

> /boot/firmware/config.txt

```
auto_initramfs=0
...
[cm5]
dtoverlay=dwc2,dr_mode=host
dtparam=pciex1
dtparam=pciex1_gen=2

# Enable kernel8
kernel=kernel8.img
initramfs initramfs8 followkernel

# UART Debug (optionnal, don't put if you don't use it !)
enable_uart=1
uart_2ndstage=1
```

### 3. Reboot

### 2. Regenerate `initramfs`

At this moment, IACA OS overlay is not loaded. So each update is directly written in the system.

> Unlock boot part : `mount -o remount,rw /boot/firmware/`

```
sudo update-initramfs -u
```

### 3. Reboot

### 4. Setup coral support

```
os install ai
os ai setup coral
```
