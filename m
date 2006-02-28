From: "prafulla chandra vejendla" <v.prafulla@gmail.com>
Subject: error in 2.6.8-rc3_080804 make
Date: Tue, 28 Feb 2006 20:59:33 +0530
Message-ID: <26d3a31c0602280729p122f8d4ble60d7d450642b004@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,
i am using linux 2.6.8-rc3_080804.tar with out any patch  to build kernal
for my osk5912 board. i am following accarding to the newbie guide pdf for
omap5912 . we are using gcc 3.4.1 . while i am doing the following steps.
along with this steps i am attaching the error and the config file .am i
missing any step.kindly guide

make clean
make omap_osk_5912_defconfig
make menuconfig
make

now i am getting error as cc1 error invalid option 'short-load-byters'
make[2]: ***[scripts/mod/empty.o]  Error 1
make[1]:***[scripts/mod] Error 2
make:*** [scripts] Errpr 2
/
/
/
/
and my config file is like this
/
/
/
*
* Linux Kernel Configuration
*
*
* Code maturity level options
*
Prompt for development and/or incomplete code/drivers (EXPERIMENTAL) [Y/n/?=
]
y
  Select only drivers expected to compile cleanly (CLEAN_COMPILE) [Y/n/?] y
*
* General setup
*
Support for paging of anonymous memory (swap) (SWAP) [Y/n/?] y
System V IPC (SYSVIPC) [Y/n/?] y
POSIX Message Queues (POSIX_MQUEUE) [N/y/?] n
BSD Process Accounting (BSD_PROCESS_ACCT) [N/y/?] n
Sysctl support (SYSCTL) [Y/n/?] y
Auditing support (AUDIT) [N/y/?] n
Support for hot-pluggable devices (HOTPLUG) [N/y/?] n
Kernel .config support (IKCONFIG) [N/y/?] n
*
* Configure standard kernel features (for small systems)
*
Configure standard kernel features (for small systems) (EMBEDDED) [N/y/?] n
  Load all symbols for debugging/kksymoops (KALLSYMS) [Y/?] (NEW) y
    Do an extra kallsyms pass (KALLSYMS_EXTRA_PASS) [N/y/?] (NEW) n
*
* Loadable module support
*
Enable loadable module support (MODULES) [Y/n/?] y
  Module unloading (MODULE_UNLOAD) [Y/n/?] y
    Forced module unloading (MODULE_FORCE_UNLOAD) [N/y/?] n
  Module versioning support (EXPERIMENTAL) (MODVERSIONS) [N/y/?] n
  Automatic kernel module loading (KMOD) [Y/n/?] y
*
* System Type
*
ARM system type
  1. Cirrus-CL-PS7500FE (ARCH_CLPS7500)
  2. CLPS711x/EP721x-based (ARCH_CLPS711X)
  3. Co-EBSA285 (ARCH_CO285)
  4. EBSA-110 (ARCH_EBSA110)
  5. Epxa10db (ARCH_CAMELOT)
  6. FootBridge (ARCH_FOOTBRIDGE)
  7. Integrator (ARCH_INTEGRATOR)
  8. IOP3xx-based (ARCH_IOP3XX)
  9. IXP4xx-based (ARCH_IXP4XX) (NEW)
  10. LinkUp-L7200 (ARCH_L7200)
  11. PXA2xx-based (ARCH_PXA)
  12. RiscPC (ARCH_RPC)
  13. SA1100-based (ARCH_SA1100)
  14. Samsung S3C2410 (ARCH_S3C2410)
  15. Shark (ARCH_SHARK)
  16. Sharp LH7A40X (ARCH_LH7A40X)
> 17. TI OMAP (ARCH_OMAP)
  18. Versatile PB (ARCH_VERSATILE_PB)
choice[1-18]: 17
*
* TI OMAP Implementations
*
*
* OMAP Core Type
*
OMAP730 Based System (ARCH_OMAP730) [N/y] n
OMAP1510 Based System (ARCH_OMAP1510) [N/y] n
OMAP1610 Based System (ARCH_OMAP1610) [N/y] n
OMAP1710 Based System (ARCH_OMAP1710) [N/y] (NEW) n
OMAP1611B or OMAP5912 Based System (ARCH_OMAP5912) [Y/n] y
*
* OMAP Board Type
*
TI H2 Support (MACH_OMAP_H2) [N/y/?] (NEW) n
TI OSK Support (MACH_OMAP_OSK) [Y/n/?] y
*
* OMAP Feature Selections
*
OMAP bootloader information passing (OMAP_BOOT_TAG) [N/y/?] n
OMAP multiplexing support (OMAP_MUX) [Y/n/?] y
  Multiplexing debug output (OMAP_MUX_DEBUG) [N/y/?] n
Low-level debug console UART
> 1. UART1 (OMAP_LL_DEBUG_UART1)
  2. UART2 (OMAP_LL_DEBUG_UART2)
  3. UART3 (OMAP_LL_DEBUG_UART3)
choice[1-3]: 1
OMAP ARM 192 MHz CPU (OMAP_ARM_192MHZ) [Y/n/?] y
OMAP ARM 168 MHz CPU (OMAP_ARM_168MHZ) [N/y/?] n
*
* Processor Type
*
*
* Processor Features
*
Support Thumb user binaries (ARM_THUMB) [N/y/?] n
Disable I-Cache (CPU_ICACHE_DISABLE) [N/y/?] n
Disable D-Cache (CPU_DCACHE_DISABLE) [N/y/?] n
Force write through D-cache (CPU_DCACHE_WRITETHROUGH) [Y/n/?] y
Round robin I and D cache replacement algorithm (CPU_CACHE_ROUND_ROBIN)
[N/y/?] n
*
* General setup
*
Compressed boot loader in ROM/flash (ZBOOT_ROM) [N/y/?] n
Compressed ROM boot loader base address (ZBOOT_ROM_TEXT) [0x0] 0x0
Compressed ROM boot loader BSS address (ZBOOT_ROM_BSS) [0x0] 0x0
*
* At least one math emulation must be selected
*
NWFPE math emulation (FPE_NWFPE) [Y/n/?] y
  Support extended precision (FPE_NWFPE_XP) [N/y/?] n
FastFPE math emulation (EXPERIMENTAL) (FPE_FASTFPE) [N/y/?] n
VFP-format floating point maths (VFP) [N/y/?] (NEW) n
Kernel support for ELF binaries (BINFMT_ELF) [Y/n/?] y
Kernel support for a.out and ECOFF binaries (BINFMT_AOUT) [N/m/y/?] n
Kernel support for MISC binaries (BINFMT_MISC) [N/m/y/?] n
*
* Generic Driver Options
*
Select only drivers that don't need compile-time external firmware
(STANDALONE) [Y/n/?] y
Prevent firmware from being built (PREVENT_FIRMWARE_BUILD) [Y/n/?] (NEW) y
Power Management support (PM) [Y/n/?] y
Preemptible Kernel (EXPERIMENTAL) (PREEMPT) [N/y/?] n
Advanced Power Management Emulation (APM) [N/m/y/?] n
RISC OS personality (ARTHUR) [N/m/y/?] n
Default kernel command string (CMDLINE) [mem=3D32M console=3Dtty0
console=3DttyS0,115200 initrd=3D0x10200000,8M root=3D/dev/ram0 rw] mem=3D32=
M
console=3Dtty0 console=3DttyS0,115200 initrd=3D0x10200000,8M root=3D/dev/ra=
m0 rw
Timer and CPU usage LEDs (LEDS) [N/y/?] n
*
* Parallel port support
*
Parallel port support (PARPORT) [N/m/y/?] n
*
* Memory Technology Devices (MTD)
*
Memory Technology Device (MTD) support (MTD) [N/m/y/?] n
*
* Plug and Play support
*
*
* Block devices
*
Normal floppy disk support (BLK_DEV_FD) [N/m/y/?] n
Loopback device support (BLK_DEV_LOOP) [Y/n/m/?] y
  Cryptoloop Support (BLK_DEV_CRYPTOLOOP) [N/m/y/?] n
Network block device support (BLK_DEV_NBD) [N/m/y/?] n
RAM disk support (BLK_DEV_RAM) [Y/n/m/?] y
  Default RAM disk size (kbytes) (BLK_DEV_RAM_SIZE) [8192] 8192
  Initial RAM disk (initrd) support (BLK_DEV_INITRD) [Y/n/?] y
*
* Multi-device support (RAID and LVM)
*
Multiple devices driver support (RAID and LVM) (MD) [N/y/?] n
*
* Networking support
*
Networking support (NET) [Y/n/?] y
  *
  * Networking options
  *
  Packet socket (PACKET) [M/n/y/?] m
    Packet socket: mmapped IO (PACKET_MMAP) [N/y/?] n
  Netlink device emulation (NETLINK_DEV) [N/m/y/?] n
  Unix domain sockets (UNIX) [Y/n/m/?] y
  PF_KEY sockets (NET_KEY) [N/m/y/?] n
  TCP/IP networking (INET) [Y/n/?] y
    IP: multicasting (IP_MULTICAST) [Y/n/?] y
    IP: advanced router (IP_ADVANCED_ROUTER) [N/y/?] n
    IP: kernel level autoconfiguration (IP_PNP) [Y/n/?] y
      IP: DHCP support (IP_PNP_DHCP) [Y/n/?] y
      IP: BOOTP support (IP_PNP_BOOTP) [Y/n/?] y
      IP: RARP support (IP_PNP_RARP) [N/y/?] n
    IP: tunneling (NET_IPIP) [N/m/y/?] n
    IP: GRE tunnels over IP (NET_IPGRE) [N/m/y/?] n
  IP: multicast routing (IP_MROUTE) [N/y/?] n
  IP: ARP daemon support (EXPERIMENTAL) (ARPD) [N/y/?] n
  IP: TCP syncookie support (disabled per default) (SYN_COOKIES) [N/y/?] n
  IP: AH transformation (INET_AH) [N/m/y/?] n
  IP: ESP transformation (INET_ESP) [N/m/y/?] n
  IP: IPComp transformation (INET_IPCOMP) [N/m/y/?] n
  The IPv6 protocol (EXPERIMENTAL) (IPV6) [N/m/y/?] n
  *
  * Network packet filtering (replaces ipchains)
  *
  Network packet filtering (replaces ipchains) (NETFILTER) [N/y/?] n
  *
  * SCTP Configuration (EXPERIMENTAL)
  *
  The SCTP Protocol (EXPERIMENTAL) (IP_SCTP) [N/m/y/?] n
  Asynchronous Transfer Mode (ATM) (EXPERIMENTAL) (ATM) [N/m/y/?] n
  802.1d Ethernet Bridging (BRIDGE) [N/m/y/?] n
  802.1Q VLAN Support (VLAN_8021Q) [N/m/y] n
  DECnet Support (DECNET) [N/m/y/?] n
  ANSI/IEEE 802.2 LLC type 2 Support (LLC2) [N/m/y/?] n
  The IPX protocol (IPX) [N/m/y/?] n
  Appletalk protocol support (ATALK) [N/m/y/?] n
  CCITT X.25 Packet Layer (EXPERIMENTAL) (X25) [N/m/y/?] n
  LAPB Data Link Driver (EXPERIMENTAL) (LAPB) [N/m/y/?] n
  Frame Diverter (EXPERIMENTAL) (NET_DIVERT) [N/y/?] n
  Acorn Econet/AUN protocols (EXPERIMENTAL) (ECONET) [N/m/y/?] n
  WAN router (WAN_ROUTER) [N/m/y/?] n
  Fast switching (read help!) (NET_FASTROUTE) [N/y/?] n
  Forwarding between high speed interfaces (NET_HW_FLOWCONTROL) [N/y/?] n
  *
  * QoS and/or fair queueing
  *
  QoS and/or fair queueing (NET_SCHED) [N/y/?] n
  *
  * Network testing
  *
  Packet Generator (USE WITH CAUTION) (NET_PKTGEN) [N/m/y/?] n
*
* Amateur Radio support
*
Amateur Radio support (HAMRADIO) [N/y/?] n
*
* IrDA (infrared) subsystem support
*
IrDA (infrared) subsystem support (IRDA) [N/m/y/?] n
*
* Bluetooth subsystem support
*
Bluetooth subsystem support (BT) [N/m/y/?] n
Network device support (NETDEVICES) [Y/n/?] y
  Dummy net driver support (DUMMY) [N/m/y/?] n
  Bonding driver support (BONDING) [N/m/y/?] n
  EQL (serial line load balancing) support (EQUALIZER) [N/m/y/?] n
  Universal TUN/TAP device driver support (TUN) [N/m/y/?] n
  *
  * Ethernet (10 or 100Mbit)
  *
  Ethernet (10 or 100Mbit) (NET_ETHERNET) [Y/n/?] y
    Generic Media Independent Interface device support (MII) [Y/?] y
  SMC 91C9x/91C1xxx support (SMC91X) [Y/n/m/?] y
  Western Digital/SMC cards (NET_VENDOR_SMC) [N/y/?] n
  SMC 91C9x/91C1xxx support (SMC91X) [Y/n/m/?] y
  *
  * Ethernet (1000 Mbit)
  *
  *
  * Ethernet (10000 Mbit)
  *
  *
  * Token Ring devices
  *
  *
  * Wireless LAN (non-hamradio)
  *
  Wireless LAN drivers (non-hamradio) & Wireless Extensions (NET_RADIO)
[N/y/?] n
  *
  * Wan interfaces
  *
  Wan interfaces support (WAN) [N/y/?] n
  PPP (point-to-point protocol) support (PPP) [Y/n/m/?] y
    PPP multilink support (EXPERIMENTAL) (PPP_MULTILINK) [Y/n/?] y
    PPP filtering (PPP_FILTER) [N/y/?] n
    PPP support for async serial ports (PPP_ASYNC) [N/m/y/?] n
    PPP support for sync tty ports (PPP_SYNC_TTY) [N/m/y/?] n
    PPP Deflate compression (PPP_DEFLATE) [N/m/y/?] n
    PPP BSD-Compress compression (PPP_BSDCOMP) [N/m/y/?] n
    PPP over Ethernet (EXPERIMENTAL) (PPPOE) [N/m/y/?] n
  SLIP (serial line) support (SLIP) [N/m/y/?] n
  Traffic Shaper (EXPERIMENTAL) (SHAPER) [N/m/y/?] n
  Network console logging support (EXPERIMENTAL) (NETCONSOLE) [N/m/y/?] n
*
* SCSI device support
*
SCSI device support (SCSI) [N/m/y/?] n
*
* Fusion MPT device support
*
*
* IEEE 1394 (FireWire) support
*
*
* I2O device support
*
*
* ISDN subsystem
*
ISDN support (ISDN) [N/m/y/?] n
*
* Input device support
*
*
* Userland interfaces
*
Mouse interface (INPUT_MOUSEDEV) [Y/?] (NEW) y
  Provide legacy /dev/psaux device (INPUT_MOUSEDEV_PSAUX) [Y/n/?] y
  Horizontal screen resolution (INPUT_MOUSEDEV_SCREEN_X) [1024] 1024
  Vertical screen resolution (INPUT_MOUSEDEV_SCREEN_Y) [768] 768
Joystick interface (INPUT_JOYDEV) [N/m/y/?] n
Touchscreen interface (INPUT_TSDEV) [N/m/y/?] n
Event interface (INPUT_EVDEV) [N/m/y/?] n
Event debugging (INPUT_EVBUG) [N/m/y/?] n
*
* Input I/O drivers
*
Gameport support (GAMEPORT) [N/m/y/?] n
Serial i/o support (SERIO) [Y/n/m/?] y
i8042 PC Keyboard controller (SERIO_I8042) [N/m/y/?] n
Serial port line discipline (SERIO_SERPORT) [Y/n/m/?] y
ct82c710 Aux port controller (SERIO_CT82C710) [N/m/y/?] n
*
* Input Device Drivers
*
Keyboards (INPUT_KEYBOARD) [Y/n/?] y
  AT keyboard support (KEYBOARD_ATKBD) [N/m/y/?] n
  Sun Type 4 and Type 5 keyboard support (KEYBOARD_SUNKBD) [N/m/y/?] n
  DECstation/VAXstation LK201/LK401 keyboard support (KEYBOARD_LKKBD)
[N/m/y/?] n
  XT Keyboard support (KEYBOARD_XTKBD) [N/m/y/?] n
  Newton keyboard (KEYBOARD_NEWTON) [N/m/y/?] n
  TI OMAP keypad support (KEYBOARD_OMAP) [Y/n/m/?] y
Mice (INPUT_MOUSE) [N/y/?] n
Joysticks (INPUT_JOYSTICK) [N/y/?] n
Touchscreens (INPUT_TOUCHSCREEN) [N/y/?] n
Misc (INPUT_MISC) [N/y/?] n
*
* Character devices
*
Non-standard serial port support (SERIAL_NONSTANDARD) [N/y/?] n
*
* Serial drivers
*
8250/16550 and compatible serial support (SERIAL_8250) [Y/n/m/?] y
  Console on 8250/16550 and compatible serial port (SERIAL_8250_CONSOLE)
[Y/n/?] y
  Maximum number of non-legacy 8250/16550 serial ports
(SERIAL_8250_NR_UARTS) [4] 4
  Extended 8250/16550 serial driver options (SERIAL_8250_EXTENDED) [N/y/?] =
n
*
* Non-8250 serial port support
*
OMAP serial port support (SERIAL_8250_OMAP) [Y/n/m/?] y
Legacy (BSD) PTY support (LEGACY_PTYS) [Y/n/?] y
  Maximum number of legacy PTY in use (LEGACY_PTY_COUNT) [256] 256
QIC-02 tape support (QIC02_TAPE) [N/m/y/?] n
*
* IPMI
*
IPMI top-level message handler (IPMI_HANDLER) [N/m/y/?] n
*
* Watchdog Cards
*
Watchdog Timer Support (WATCHDOG) [N/y/?] n
/dev/nvram support (NVRAM) [N/m/y/?] n
Enhanced Real Time Clock Support (RTC) [N/m/y/?] n
Generic /dev/rtc emulation (GEN_RTC) [N/m/y/?] n
Double Talk PC internal speech card support (DTLK) [N/m/y/?] n
Siemens R3964 line discipline (R3964) [N/m/y/?] n
*
* Ftape, the floppy tape device driver
*
/dev/agpgart (AGP Support) (AGP) [N/m/y/?] n
Direct Rendering Manager (XFree86 4.1.0 and higher DRI support) (DRM)
[N/y/?] n
RAW driver (/dev/raw/rawN) (OBSOLETE) (RAW_DRIVER) [N/m/y/?] n
*
* I2C support
*
I2C support (I2C) [Y/?] y
  I2C device interface (I2C_CHARDEV) [N/m/y/?] (NEW) n
  *
  * I2C Algorithms
  *
  I2C bit-banging interfaces (I2C_ALGOBIT) [N/m/y/?] (NEW) n
  I2C PCF 8584 interfaces (I2C_ALGOPCF) [N/m/y/?] (NEW) n
  *
  * I2C Hardware Bus support
  *
  AMD 756/766 (I2C_AMD756) [N/m/y/?] (NEW) n
  AMD 8111 (I2C_AMD8111) [N/m/y/?] (NEW) n
  ISA Bus support (I2C_ISA) [N/m/y/?] (NEW) n
  Parallel port adapter (light) (I2C_PARPORT_LIGHT) [N/m/y/?] (NEW) n
  NatSemi SCx200 ACCESS.bus (SCx200_ACB) [N/m/y/?] (NEW) n
  OMAP I2C adapter (I2C_OMAP) [Y/?] (NEW) y
  *
  * Hardware Sensors Chip support
  *
  Analog Devices ADM1021 and compatibles (SENSORS_ADM1021) [N/m/y/?] (NEW) =
n
  Analog Devices ADM1025 and compatibles (SENSORS_ADM1025) [N/m/y/?] (NEW) =
n
  Analog Devices ADM1031 and compatibles (SENSORS_ADM1031) [N/m/y/?] (NEW) =
n
  Asus ASB100 Bach (SENSORS_ASB100) [N/m/y/?] (NEW) n
  Dallas Semiconductor DS1621 and DS1625 (SENSORS_DS1621) [N/m/y/?] (NEW) n
  FSC Hermes (SENSORS_FSCHER) [N/m/y/?] (NEW) n
  Genesys Logic GL518SM (SENSORS_GL518SM) [N/m/y/?] (NEW) n
  ITE IT87xx and compatibles (SENSORS_IT87) [N/m/y/?] (NEW) n
  National Semiconductor LM75 and compatibles (SENSORS_LM75) [N/m/y/?] (NEW=
)
n
  National Semiconductor LM77 (SENSORS_LM77) [N/m/y/?] (NEW) n
  National Semiconductor LM78 and compatibles (SENSORS_LM78) [N/m/y/?] (NEW=
)
n
  National Semiconductor LM80 (SENSORS_LM80) [N/m/y/?] (NEW) n
  National Semiconductor LM83 (SENSORS_LM83) [N/m/y/?] (NEW) n
  National Semiconductor LM85 and compatibles (SENSORS_LM85) [N/m/y/?] (NEW=
)
n
  National Semiconductor LM90 and compatibles (SENSORS_LM90) [N/m/y/?] (NEW=
)
n
  Maxim MAX1619 sensor chip (SENSORS_MAX1619) [N/m/y/?] (NEW) n
  Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F
(SENSORS_W83781D) [N/m/y/?] (NEW) n
  Winbond W83L785TS-S (SENSORS_W83L785TS) [N/m/y/?] (NEW) n
  Winbond W83627HF, W83627THF, W83637HF, W83697HF (SENSORS_W83627HF)
[N/m/y/?] (NEW) n
  *
  * Other I2C Chip support
  *
  EEPROM reader (SENSORS_EEPROM) [N/m/y/?] (NEW) n
  Philips PCF8574 and PCF8574A (SENSORS_PCF8574) [N/m/y/?] (NEW) n
  Philips PCF8591 (SENSORS_PCF8591) [N/m/y/?] (NEW) n
  Epson 8564 RTC chip (SENSORS_RTC8564) [N/m/y/?] (NEW) n
  TPS65010 Power management chip (TPS65010) [Y/?] (NEW) y
  I2C Core debugging messages (I2C_DEBUG_CORE) [N/y/?] (NEW) n
  I2C Algorithm debugging messages (I2C_DEBUG_ALGO) [N/y/?] (NEW) n
  I2C Bus debugging messages (I2C_DEBUG_BUS) [N/y/?] (NEW) n
  I2C Chip debugging messages (I2C_DEBUG_CHIP) [N/y/?] (NEW) n
*
* Multimedia devices
*
Video For Linux (VIDEO_DEV) [N/m/y/?] n
*
* Digital Video Broadcasting Devices
*
DVB For Linux (DVB) [N/y/?] n
*
* MMC/SD Card support
*
MMC support (MMC) [N/m/y/?] n
*
* File systems
*
Second extended fs support (EXT2_FS) [Y/n/m/?] y
  Ext2 extended attributes (EXT2_FS_XATTR) [N/y/?] n
Ext3 journalling file system support (EXT3_FS) [N/m/y/?] n
Reiserfs support (REISERFS_FS) [N/m/y/?] n
JFS filesystem support (JFS_FS) [N/m/y/?] n
XFS filesystem support (XFS_FS) [N/m/y/?] n
Minix fs support (MINIX_FS) [N/m/y/?] n
ROM file system support (ROMFS_FS) [N/m/y/?] n
Quota support (QUOTA) [N/y/?] n
Kernel automounter support (AUTOFS_FS) [Y/n/m/?] y
Kernel automounter version 4 support (also supports v3) (AUTOFS4_FS)
[Y/n/m/?] y
*
* CD-ROM/DVD Filesystems
*
ISO 9660 CDROM file system support (ISO9660_FS) [N/m/y/?] n
UDF file system support (UDF_FS) [N/m/y/?] n
*
* DOS/FAT/NT Filesystems
*
MSDOS fs support (MSDOS_FS) [N/m/y/?] (NEW) n
VFAT (Windows-95) fs support (VFAT_FS) [N/m/y/?] (NEW) n
NTFS file system support (NTFS_FS) [N/m/y/?] n
*
* Pseudo filesystems
*
/proc file system support (PROC_FS) [Y/n/?] y
/dev file system support (OBSOLETE) (DEVFS_FS) [Y/n/?] y
  Automatically mount at boot (DEVFS_MOUNT) [N/y/?] n
  Debug devfs (DEVFS_DEBUG) [N/y/?] n
/dev/pts Extended Attributes (DEVPTS_FS_XATTR) [N/y/?] n
Virtual memory file system support (former shm fs) (TMPFS) [N/y/?] n
*
* Miscellaneous filesystems
*
ADFS file system support (EXPERIMENTAL) (ADFS_FS) [N/m/y/?] n
Amiga FFS file system support (EXPERIMENTAL) (AFFS_FS) [N/m/y/?] n
Apple Macintosh file system support (EXPERIMENTAL) (HFS_FS) [N/m/y/?] n
Apple Extended HFS file system support (HFSPLUS_FS) [N/m/y/?] n
BeOS file system (BeFS) support (read only) (EXPERIMENTAL) (BEFS_FS)
[N/m/y/?] n
BFS file system support (EXPERIMENTAL) (BFS_FS) [N/m/y/?] n
EFS file system support (read only) (EXPERIMENTAL) (EFS_FS) [N/m/y/?] n
Advanced compression options for JFFS2 (JFFS2_COMPRESSION_OPTIONS) [N/y/?]
(NEW) n
Compressed ROM file system support (CRAMFS) [N/m/y/?] n
FreeVxFS file system support (VERITAS VxFS(TM) compatible) (VXFS_FS)
[N/m/y/?] n
OS/2 HPFS file system support (HPFS_FS) [N/m/y/?] n
QNX4 file system support (read only) (QNX4FS_FS) [N/m/y/?] n
System V/Xenix/V7/Coherent file system support (SYSV_FS) [N/m/y/?] n
UFS file system support (read only) (UFS_FS) [N/m/y/?] n
*
* Network File Systems
*
NFS file system support (NFS_FS) [Y/n/m/?] y
  Provide NFSv3 client support (NFS_V3) [Y/n/?] y
  Provide NFSv4 client support (EXPERIMENTAL) (NFS_V4) [N/y/?] n
  Allow direct I/O on NFS files (EXPERIMENTAL) (NFS_DIRECTIO) [N/y/?] n
NFS server support (NFSD) [N/m/y/?] n
Root file system on NFS (ROOT_NFS) [N/y/?] n
Secure RPC: Kerberos V mechanism (EXPERIMENTAL) (RPCSEC_GSS_KRB5) [N/m/y/?]
n
SMB file system support (to mount Windows shares etc.) (SMB_FS) [N/m/y/?] n
CIFS support (advanced network filesystem for Samba, Window and other CIFS
compliant servers) (CIFS) [N/m/y/?] n
NCP file system support (to mount NetWare volumes) (NCP_FS) [N/m/y/?] n
Coda file system support (advanced network fs) (CODA_FS) [N/m/y/?] n
Andrew File System support (AFS) (Experimental) (AFS_FS) [N/m/y/?] n
*
* Partition Types
*
Advanced partition selection (PARTITION_ADVANCED) [N/y/?] n
*
* Native Language Support
*
Base native language support (NLS) [N/m/y/?] n
*
* Profiling support
*
Profiling support (EXPERIMENTAL) (PROFILING) [N/y/?] n
*
* Graphics support
*
Support for frame buffer devices (FB) [N/y/?] n
*
* Console display driver support
*
VGA text console (VGA_CONSOLE) [N/y/?] n
MDA text console (dual-headed) (EXPERIMENTAL) (MDA_CONSOLE) [N/m/y/?] n
*
* Sound
*
Sound card support (SOUND) [N/m/y/?] n
*
* Misc devices
*
*
* USB support
*
Support for Host-side USB (USB) [N/m/y/?] n
*
* USB Gadget Support
*
Support for USB Gadgets (USB_GADGET) [N/m/y/?] n
*
* Synchronous Serial Interfaces (SSI)
*
MicroWire support on OMAP (OMAP_UWIRE) [N/m/y/?] n
*
* Kernel hacking
*
Verbose user fault messages (DEBUG_USER) [N/y/?] n
Include GDB debugging information in kernel binary (DEBUG_INFO) [N/y/?] n
Kernel debugging (DEBUG_KERNEL) [N/y/?] n
*
* Security options
*
Enable different security models (SECURITY) [N/y/?] n
*
* Cryptographic options
*
Cryptographic API (CRYPTO) [N/y/?] n
*
* Library routines
*
CRC-CCITT functions (CRC_CCITT) [N/m/y/?] (NEW) n
CRC32 functions (CRC32) [Y/?] y
CRC32c (Castagnoli, et al) Cyclic Redundancy-Check (LIBCRC32C) [N/m/y/?] n

-v prafulla
