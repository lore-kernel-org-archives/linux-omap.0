From: Ravi KK <ravikk@huawei.com>
Subject: Problem when Flashing JFFS2 Ramdisk on OMAP 1710
Date: Wed, 20 Dec 2006 15:27:17 +0530
Message-ID: <000d01c7241d$3c5dcbe0$4414120a@china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_zNW13LuyvDjF7YjSzuUZpw)"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

This is a multi-part message in MIME format.

--Boundary_(ID_zNW13LuyvDjF7YjSzuUZpw)
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: quoted-printable

Hi all,
We are trying to put JFFS2 Linux File System onto NOR flash of OMAP 1710 =
Board
For this we compiled the linux kernel with the following configuration =
file.
At the time of booting, we are getting following error.

We are using the kernel & filesystem present at =
http://linux.omap.com/pub/kernel/h3/
Kernel is present at 40000 & File system is present at 300000 locations.
Please let me know if U have any suggestions.
 - Ravi

Starting kernel ...
Uncompressing =
Linux....................................................................=
..... done, booting the kernel.
Linux version 2.6.9-omap1 (root@linux) (gcc version 3.4.4) #1 Tue Dec 19 =
18:00:59 IST 2006
CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv5TEJ)
CPU: D VIPT write-back cache
CPU: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU: D cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
Machine: TI OMAP1710 H3 board
Memory policy: ECC disabled, Data cache writeback
OMAP_DIE_ID_0: 0x03330200
OMAP_DIE_ID_1: 0x8b5f702f DIE_REV: 15
OMAP_PRODUCTION_ID_0: 0x0000000c
OMAP_PRODUCTION_ID_1: 0xcafeb5f7 JTAG_ID: 0xb5f7
OMAP32_ID_0: 0x03330200
OMAP32_ID_1: 0x8b5f702f
JTAG_ID: 0xb5f7 DIE_REV: 8
OMAP1710 revision 8 handled as 16xx id: 8b5f702f03330200
<7>On node 0 totalpages: 8192
<7>  DMA zone: 8192 pages, LIFO batch:2
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: mem=3D32M console=3DttyS0,115200n8 =
root=3D/dev/mtdblock3 rw rootfstype=3Djffs2 devfs=3Dmount
<7>Relocating machine vectors to 0xffff0000
Total of 128 interrupts in 4 interrupt banks
PID hash table entries: 256 (order: 8, 4096 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
<6>Memory: 32MB =3D 32MB total
<5>Memory: 29992KB available (1831K code, 440K data, 96K init)
<7>Calibrating delay loop... 83.76 BogoMIPS (lpj=3D418816)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<6>CPU: Testing write buffer coherency: ok
<6>NET: Registered protocol family 16
<6>OMAP DMA hardware version 1
<6>DMA capabilities: 000c0000:00000000:01ff:003f:007f
<6>OMAP GPIO hardware version 1.1
Initializing OMAP McBSP system
<3>USB: No board-specific platform config found
<6>OMAP I2C: Driver ver. 1.3
<7>OMAP I2C DEBUG: 17:59:28 Dec 19 2006
<6>tps65010: version dev/17:59:28
<6>NET: Registered protocol family 23
OMAP OCPI interconnect driver loaded
<4>NetWinder Floating Point Emulator V0.97 (double precision)
<6>devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
<6>devfs: boot_options: 0x1
<6>JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
<6>omapfb: configured for panel h3
<6>OMAP LCD controller initialized.
Console: switching to colour frame buffer device 30x40
<6>OMAP framebuffer initialized. vram=3D262144
<6>Real Time Clock Driver v1.0
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled
ttyS0 at MMIO 0xfefb0000 =
(ir=C3=B3=C3=B8=C2=B3i=C3=BA=E2=80=9CO=E2=80=A0=C6=92f=C3=BA=C2=B3v0p=C5=A1=
)r=C5=A1)<7>Chip erase failed at 0x006000
00: status 0xa0. Retrying...
<7>Chip erase failed at 0x00600000: status 0xa0. Retrying...
<7>Chip erase failed at 0x00600000: status 0xa0. Retrying...
<7>Chip erase failed at 0x00600000: status 0xa0
<4>Erase at 0x003c0000 failed immediately: errno -5
Erase at 0x003c0000 failed immediately: errno -5

--Boundary_(ID_zNW13LuyvDjF7YjSzuUZpw)
Content-type: application/octet-stream; name=config.jffs2.h3
Content-transfer-encoding: quoted-printable
Content-disposition: attachment; filename=config.jffs2.h3

#=0A=
# Automatically generated make config: don't edit=0A=
# Linux kernel version: 2.6.9-omap1=0A=
# Tue Dec 19 15:51:22 2006=0A=
#=0A=
CONFIG_ARM=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy=0A=
CONFIG_GENERIC_IOMAP=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_BROKEN_ON_SMP=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_LOCALVERSION=3D""=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_POSIX_MQUEUE is not set=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
# CONFIG_AUDIT is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D14=0A=
# CONFIG_HOTPLUG is not set=0A=
# CONFIG_IKCONFIG is not set=0A=
# CONFIG_EMBEDDED is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
# CONFIG_KALLSYMS_ALL is not set=0A=
# CONFIG_KALLSYMS_EXTRA_PASS is not set=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
CONFIG_IOSCHED_CFQ=3Dy=0A=
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy=0A=
CONFIG_SHMEM=3Dy=0A=
# CONFIG_TINY_SHMEM is not set=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
# CONFIG_MODULE_FORCE_UNLOAD is not set=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
# CONFIG_KMOD is not set=0A=
=0A=
#=0A=
# System Type=0A=
#=0A=
# CONFIG_ARCH_CLPS7500 is not set=0A=
# CONFIG_ARCH_CLPS711X is not set=0A=
# CONFIG_ARCH_CO285 is not set=0A=
# CONFIG_ARCH_EBSA110 is not set=0A=
# CONFIG_ARCH_CAMELOT is not set=0A=
# CONFIG_ARCH_FOOTBRIDGE is not set=0A=
# CONFIG_ARCH_INTEGRATOR is not set=0A=
# CONFIG_ARCH_IOP3XX is not set=0A=
# CONFIG_ARCH_IXP4XX is not set=0A=
# CONFIG_ARCH_IXP2000 is not set=0A=
# CONFIG_ARCH_L7200 is not set=0A=
# CONFIG_ARCH_PXA is not set=0A=
# CONFIG_ARCH_RPC is not set=0A=
# CONFIG_ARCH_SA1100 is not set=0A=
# CONFIG_ARCH_S3C2410 is not set=0A=
# CONFIG_ARCH_SHARK is not set=0A=
# CONFIG_ARCH_LH7A40X is not set=0A=
CONFIG_ARCH_OMAP=3Dy=0A=
# CONFIG_ARCH_VERSATILE_PB is not set=0A=
# CONFIG_ARCH_IMX is not set=0A=
# CONFIG_ARCH_H720X is not set=0A=
=0A=
#=0A=
# TI OMAP Implementations=0A=
#=0A=
=0A=
#=0A=
# OMAP Core Type=0A=
#=0A=
# CONFIG_ARCH_OMAP730 is not set=0A=
# CONFIG_ARCH_OMAP1510 is not set=0A=
CONFIG_ARCH_OMAP16XX=3Dy=0A=
CONFIG_ARCH_OMAP_OTG=3Dy=0A=
=0A=
#=0A=
# OMAP Board Type=0A=
#=0A=
# CONFIG_MACH_OMAP_INNOVATOR is not set=0A=
# CONFIG_MACH_OMAP_H2 is not set=0A=
CONFIG_MACH_OMAP_H3=3Dy=0A=
# CONFIG_MACH_OMAP_H4 is not set=0A=
# CONFIG_MACH_OMAP_OSK is not set=0A=
# CONFIG_MACH_OMAP_GENERIC is not set=0A=
=0A=
#=0A=
# OMAP Feature Selections=0A=
#=0A=
# CONFIG_OMAP_BOOT_TAG is not set=0A=
CONFIG_OMAP_MUX=3Dy=0A=
# CONFIG_OMAP_MUX_DEBUG is not set=0A=
CONFIG_OMAP_MUX_WARNINGS=3Dy=0A=
CONFIG_OMAP_LL_DEBUG_UART1=3Dy=0A=
# CONFIG_OMAP_LL_DEBUG_UART2 is not set=0A=
# CONFIG_OMAP_LL_DEBUG_UART3 is not set=0A=
# CONFIG_OMAP_ARM_192MHZ is not set=0A=
CONFIG_OMAP_ARM_168MHZ=3Dy=0A=
# CONFIG_OMAP_ARM_120MHZ is not set=0A=
# CONFIG_OMAP_ARM_60MHZ is not set=0A=
# CONFIG_OMAP_ARM_30MHZ is not set=0A=
# CONFIG_OMAP_DSP is not set=0A=
=0A=
#=0A=
# h720x Implementations=0A=
#=0A=
=0A=
#=0A=
# Processor Type=0A=
#=0A=
CONFIG_CPU_32=3Dy=0A=
CONFIG_CPU_ARM926T=3Dy=0A=
CONFIG_CPU_32v5=3Dy=0A=
CONFIG_CPU_ABRT_EV5TJ=3Dy=0A=
CONFIG_CPU_COPY_V4WB=3Dy=0A=
CONFIG_CPU_TLB_V4WBI=3Dy=0A=
=0A=
#=0A=
# Processor Features=0A=
#=0A=
CONFIG_ARM_THUMB=3Dy=0A=
# CONFIG_CPU_ICACHE_DISABLE is not set=0A=
# CONFIG_CPU_DCACHE_DISABLE is not set=0A=
# CONFIG_CPU_DCACHE_WRITETHROUGH is not set=0A=
# CONFIG_CPU_CACHE_ROUND_ROBIN is not set=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
# CONFIG_ZBOOT_ROM is not set=0A=
CONFIG_ZBOOT_ROM_TEXT=3D0x10C08000=0A=
CONFIG_ZBOOT_ROM_BSS=3D0x10200000=0A=
=0A=
#=0A=
# At least one math emulation must be selected=0A=
#=0A=
CONFIG_FPE_NWFPE=3Dy=0A=
# CONFIG_FPE_NWFPE_XP is not set=0A=
# CONFIG_FPE_FASTFPE is not set=0A=
# CONFIG_VFP is not set=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_AOUT=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
CONFIG_STANDALONE=3Dy=0A=
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
# CONFIG_DEBUG_DRIVER is not set=0A=
# CONFIG_PM is not set=0A=
# CONFIG_PREEMPT is not set=0A=
# CONFIG_ARTHUR is not set=0A=
CONFIG_CMDLINE=3D"mem=3D32M console=3DttyS0,115200n8 =
initrd=3D0x10A00000,8M root=3D/dev/ram0 rw ip=3Ddhcp devfs=3Dmount"=0A=
CONFIG_LEDS=3Dy=0A=
CONFIG_ALIGNMENT_TRAP=3Dy=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
CONFIG_MTD=3Dy=0A=
# CONFIG_MTD_DEBUG is not set=0A=
CONFIG_MTD_PARTITIONS=3Dy=0A=
CONFIG_MTD_CONCAT=3Dy=0A=
# CONFIG_MTD_REDBOOT_PARTS is not set=0A=
CONFIG_MTD_CMDLINE_PARTS=3Dy=0A=
# CONFIG_MTD_AFS_PARTS is not set=0A=
=0A=
#=0A=
# User Modules And Translation Layers=0A=
#=0A=
CONFIG_MTD_CHAR=3Dy=0A=
CONFIG_MTD_BLOCK=3Dy=0A=
# CONFIG_FTL is not set=0A=
# CONFIG_NFTL is not set=0A=
# CONFIG_INFTL is not set=0A=
=0A=
#=0A=
# RAM/ROM/Flash chip drivers=0A=
#=0A=
CONFIG_MTD_CFI=3Dy=0A=
CONFIG_MTD_JEDECPROBE=3Dy=0A=
CONFIG_MTD_GEN_PROBE=3Dy=0A=
CONFIG_MTD_CFI_ADV_OPTIONS=3Dy=0A=
CONFIG_MTD_CFI_NOSWAP=3Dy=0A=
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set=0A=
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set=0A=
CONFIG_MTD_CFI_GEOMETRY=3Dy=0A=
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy=0A=
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy=0A=
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set=0A=
CONFIG_MTD_CFI_I1=3Dy=0A=
CONFIG_MTD_CFI_I2=3Dy=0A=
# CONFIG_MTD_CFI_I4 is not set=0A=
# CONFIG_MTD_CFI_I8 is not set=0A=
CONFIG_MTD_CFI_INTELEXT=3Dy=0A=
CONFIG_MTD_CFI_AMDSTD=3Dy=0A=
CONFIG_MTD_CFI_AMDSTD_RETRY=3D0=0A=
# CONFIG_MTD_CFI_STAA is not set=0A=
CONFIG_MTD_CFI_UTIL=3Dy=0A=
# CONFIG_MTD_RAM is not set=0A=
# CONFIG_MTD_ROM is not set=0A=
# CONFIG_MTD_ABSENT is not set=0A=
=0A=
#=0A=
# Mapping drivers for chip access=0A=
#=0A=
# CONFIG_MTD_COMPLEX_MAPPINGS is not set=0A=
# CONFIG_MTD_PHYSMAP is not set=0A=
# CONFIG_MTD_ARM_INTEGRATOR is not set=0A=
# CONFIG_MTD_EDB7312 is not set=0A=
# CONFIG_MTD_IMPA7 is not set=0A=
CONFIG_MTD_OMAP_NORv2=3Dy=0A=
=0A=
#=0A=
# Self-contained MTD device drivers=0A=
#=0A=
# CONFIG_MTD_SLRAM is not set=0A=
# CONFIG_MTD_PHRAM is not set=0A=
CONFIG_MTD_OMAP_NOR=3Dy=0A=
# CONFIG_MTD_MTDRAM is not set=0A=
# CONFIG_MTD_BLKMTD is not set=0A=
=0A=
#=0A=
# Disk-On-Chip Device Drivers=0A=
#=0A=
# CONFIG_MTD_DOC2000 is not set=0A=
# CONFIG_MTD_DOC2001 is not set=0A=
# CONFIG_MTD_DOC2001PLUS is not set=0A=
=0A=
#=0A=
# NAND Flash Device Drivers=0A=
#=0A=
# CONFIG_MTD_NAND is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
# CONFIG_BLK_DEV_LOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_UB is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Networking support=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
CONFIG_IP_PNP=3Dy=0A=
CONFIG_IP_PNP_DHCP=3Dy=0A=
CONFIG_IP_PNP_BOOTP=3Dy=0A=
# CONFIG_IP_PNP_RARP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
# CONFIG_INET_IPCOMP is not set=0A=
# CONFIG_INET_TUNNEL is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_NETFILTER is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
# CONFIG_NET_CLS_ROUTE is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
# CONFIG_HAMRADIO is not set=0A=
CONFIG_IRDA=3Dy=0A=
=0A=
#=0A=
# IrDA protocols=0A=
#=0A=
# CONFIG_IRLAN is not set=0A=
# CONFIG_IRNET is not set=0A=
# CONFIG_IRCOMM is not set=0A=
# CONFIG_IRDA_ULTRA is not set=0A=
=0A=
#=0A=
# IrDA options=0A=
#=0A=
# CONFIG_IRDA_CACHE_LAST_LSAP is not set=0A=
# CONFIG_IRDA_FAST_RR is not set=0A=
# CONFIG_IRDA_DEBUG is not set=0A=
=0A=
#=0A=
# Infrared-port device drivers=0A=
#=0A=
=0A=
#=0A=
# SIR device drivers=0A=
#=0A=
# CONFIG_IRTTY_SIR is not set=0A=
=0A=
#=0A=
# Dongle support=0A=
#=0A=
=0A=
#=0A=
# Old SIR device drivers=0A=
#=0A=
# CONFIG_IRPORT_SIR is not set=0A=
=0A=
#=0A=
# Old Serial dongle support=0A=
#=0A=
=0A=
#=0A=
# FIR device drivers=0A=
#=0A=
# CONFIG_USB_IRDA is not set=0A=
# CONFIG_SIGMATEL_FIR is not set=0A=
CONFIG_OMAP1610_IR=3Dy=0A=
# CONFIG_BT is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
# CONFIG_DUMMY is not set=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dy=0A=
CONFIG_NET_VENDOR_SMC=3Dy=0A=
CONFIG_SMC91X=3Dy=0A=
# CONFIG_SMC9194 is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
CONFIG_PPP=3Dy=0A=
# CONFIG_PPP_MULTILINK is not set=0A=
# CONFIG_PPP_FILTER is not set=0A=
# CONFIG_PPP_ASYNC is not set=0A=
# CONFIG_PPP_SYNC_TTY is not set=0A=
# CONFIG_PPP_DEFLATE is not set=0A=
# CONFIG_PPP_BSDCOMP is not set=0A=
# CONFIG_PPPOE is not set=0A=
CONFIG_SLIP=3Dy=0A=
CONFIG_SLIP_COMPRESSED=3Dy=0A=
# CONFIG_SLIP_SMART is not set=0A=
# CONFIG_SLIP_MODE_SLIP6 is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
CONFIG_INPUT_EVDEV=3Dy=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
# CONFIG_GAMEPORT is not set=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_SERPORT=3Dy=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_RAW is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
# CONFIG_KEYBOARD_ATKBD is not set=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_LKKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_KEYBOARD_OMAP=3Dy=0A=
# CONFIG_INPUT_MOUSE is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
# CONFIG_INPUT_MISC is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
CONFIG_SERIAL_8250_CONSOLE=3Dy=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_8250_OMAP=3Dy=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_SERIAL_CORE_CONSOLE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
# CONFIG_LEGACY_PTYS is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
CONFIG_WATCHDOG=3Dy=0A=
CONFIG_WATCHDOG_NOWAYOUT=3Dy=0A=
=0A=
#=0A=
# Watchdog Device Drivers=0A=
#=0A=
# CONFIG_SOFT_WATCHDOG is not set=0A=
=0A=
#=0A=
# USB-based Watchdog Cards=0A=
#=0A=
# CONFIG_USBPCWATCHDOG is not set=0A=
# CONFIG_OMAP16XX_WATCHDOG is not set=0A=
# CONFIG_NVRAM is not set=0A=
# CONFIG_RTC is not set=0A=
CONFIG_OMAP_RTC=3Dy=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
CONFIG_I2C=3Dy=0A=
# CONFIG_I2C_CHARDEV is not set=0A=
=0A=
#=0A=
# I2C Algorithms=0A=
#=0A=
# CONFIG_I2C_ALGOBIT is not set=0A=
# CONFIG_I2C_ALGOPCF is not set=0A=
# CONFIG_I2C_ALGOPCA is not set=0A=
=0A=
#=0A=
# I2C Hardware Bus support=0A=
#=0A=
# CONFIG_I2C_AMD756 is not set=0A=
# CONFIG_I2C_AMD8111 is not set=0A=
# CONFIG_I2C_ISA is not set=0A=
# CONFIG_I2C_PARPORT_LIGHT is not set=0A=
# CONFIG_SCx200_ACB is not set=0A=
# CONFIG_I2C_PCA_ISA is not set=0A=
CONFIG_I2C_OMAP=3Dy=0A=
=0A=
#=0A=
# Hardware Sensors Chip support=0A=
#=0A=
# CONFIG_I2C_SENSOR is not set=0A=
# CONFIG_SENSORS_ADM1021 is not set=0A=
# CONFIG_SENSORS_ADM1025 is not set=0A=
# CONFIG_SENSORS_ADM1031 is not set=0A=
# CONFIG_SENSORS_ASB100 is not set=0A=
# CONFIG_SENSORS_DS1621 is not set=0A=
# CONFIG_SENSORS_FSCHER is not set=0A=
# CONFIG_SENSORS_GL518SM is not set=0A=
# CONFIG_SENSORS_IT87 is not set=0A=
# CONFIG_SENSORS_LM75 is not set=0A=
# CONFIG_SENSORS_LM77 is not set=0A=
# CONFIG_SENSORS_LM78 is not set=0A=
# CONFIG_SENSORS_LM80 is not set=0A=
# CONFIG_SENSORS_LM83 is not set=0A=
# CONFIG_SENSORS_LM85 is not set=0A=
# CONFIG_SENSORS_LM90 is not set=0A=
# CONFIG_SENSORS_MAX1619 is not set=0A=
# CONFIG_SENSORS_SMSC47M1 is not set=0A=
# CONFIG_SENSORS_W83781D is not set=0A=
# CONFIG_SENSORS_W83L785TS is not set=0A=
# CONFIG_SENSORS_W83627HF is not set=0A=
=0A=
#=0A=
# Other I2C Chip support=0A=
#=0A=
# CONFIG_SENSORS_EEPROM is not set=0A=
# CONFIG_SENSORS_PCF8574 is not set=0A=
# CONFIG_SENSORS_PCF8591 is not set=0A=
# CONFIG_SENSORS_RTC8564 is not set=0A=
# CONFIG_ISP1301_OMAP is not set=0A=
CONFIG_TPS65010=3Dy=0A=
# CONFIG_SENSORS_TLV320AIC23 is not set=0A=
CONFIG_GPIOEXPANDER_OMAP=3Dy=0A=
# CONFIG_I2C_DEBUG_CORE is not set=0A=
# CONFIG_I2C_DEBUG_ALGO is not set=0A=
# CONFIG_I2C_DEBUG_BUS is not set=0A=
# CONFIG_I2C_DEBUG_CHIP is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
CONFIG_VIDEO_DEV=3Dy=0A=
=0A=
#=0A=
# Video For Linux=0A=
#=0A=
=0A=
#=0A=
# Video Adapters=0A=
#=0A=
# CONFIG_VIDEO_CPIA is not set=0A=
# CONFIG_VIDEO_SAA5246A is not set=0A=
# CONFIG_VIDEO_SAA5249 is not set=0A=
# CONFIG_TUNER_3036 is not set=0A=
# CONFIG_VIDEO_OVCAMCHIP is not set=0A=
=0A=
#=0A=
# Radio Adapters=0A=
#=0A=
# CONFIG_RADIO_MAESTRO is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
CONFIG_EXT2_FS_XATTR=3Dy=0A=
# CONFIG_EXT2_FS_POSIX_ACL is not set=0A=
# CONFIG_EXT2_FS_SECURITY is not set=0A=
# CONFIG_EXT3_FS is not set=0A=
# CONFIG_JBD is not set=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
CONFIG_ROMFS_FS=3Dy=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
# CONFIG_ISO9660_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
# CONFIG_MSDOS_FS is not set=0A=
# CONFIG_VFAT_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
CONFIG_DEVFS_FS=3Dy=0A=
CONFIG_DEVFS_MOUNT=3Dy=0A=
# CONFIG_DEVFS_DEBUG is not set=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
# CONFIG_TMPFS is not set=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
CONFIG_JFFS2_FS=3Dy=0A=
CONFIG_JFFS2_FS_DEBUG=3D0=0A=
# CONFIG_JFFS2_FS_NAND is not set=0A=
CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy=0A=
CONFIG_JFFS2_ZLIB=3Dy=0A=
CONFIG_JFFS2_RTIME=3Dy=0A=
CONFIG_JFFS2_RUBIN=3Dy=0A=
# CONFIG_JFFS2_CMODE_NONE is not set=0A=
CONFIG_JFFS2_CMODE_PRIORITY=3Dy=0A=
# CONFIG_JFFS2_CMODE_SIZE is not set=0A=
CONFIG_CRAMFS=3Dy=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_NFS_V3=3Dy=0A=
# CONFIG_NFS_V4 is not set=0A=
# CONFIG_NFS_DIRECTIO is not set=0A=
# CONFIG_NFSD is not set=0A=
CONFIG_ROOT_NFS=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
# CONFIG_EXPORTFS is not set=0A=
CONFIG_SUNRPC=3Dy=0A=
# CONFIG_RPCSEC_GSS_KRB5 is not set=0A=
# CONFIG_RPCSEC_GSS_SPKM3 is not set=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
# CONFIG_NLS is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
CONFIG_FB=3Dy=0A=
CONFIG_FB_MODE_HELPERS=3Dy=0A=
CONFIG_FB_OMAP=3Dy=0A=
CONFIG_FB_OMAP_INTERNAL_LCDC=3Dy=0A=
# CONFIG_FB_OMAP_EXTERNAL_LCDC is not set=0A=
# CONFIG_FB_OMAP_DELAY_ACTIVATION is not set=0A=
# CONFIG_FB_OMAP_DMA_TUNE is not set=0A=
# CONFIG_FB_VIRTUAL is not set=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
# CONFIG_VGA_CONSOLE is not set=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
CONFIG_FRAMEBUFFER_CONSOLE=3Dy=0A=
# CONFIG_FONTS is not set=0A=
CONFIG_FONT_8x8=3Dy=0A=
CONFIG_FONT_8x16=3Dy=0A=
=0A=
#=0A=
# Logo configuration=0A=
#=0A=
CONFIG_LOGO=3Dy=0A=
# CONFIG_LOGO_LINUX_MONO is not set=0A=
# CONFIG_LOGO_LINUX_VGA16 is not set=0A=
CONFIG_LOGO_LINUX_CLUT224=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
CONFIG_SOUND=3Dy=0A=
=0A=
#=0A=
# Advanced Linux Sound Architecture=0A=
#=0A=
# CONFIG_SND is not set=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
CONFIG_SOUND_PRIME=3Dy=0A=
# CONFIG_SOUND_BT878 is not set=0A=
# CONFIG_SOUND_FUSION is not set=0A=
# CONFIG_SOUND_CS4281 is not set=0A=
# CONFIG_SOUND_SONICVIBES is not set=0A=
# CONFIG_SOUND_TRIDENT is not set=0A=
# CONFIG_SOUND_MSNDCLAS is not set=0A=
# CONFIG_SOUND_MSNDPIN is not set=0A=
# CONFIG_SOUND_OSS is not set=0A=
# CONFIG_SOUND_TVMIXER is not set=0A=
# CONFIG_SOUND_AD1980 is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dm=0A=
# CONFIG_USB_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
# CONFIG_USB_DEVICEFS is not set=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
# CONFIG_USB_DYNAMIC_MINORS is not set=0A=
# CONFIG_USB_OTG is not set=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
# CONFIG_USB_EHCI_HCD is not set=0A=
CONFIG_USB_OHCI_HCD=3Dm=0A=
# CONFIG_USB_UHCI_HCD is not set=0A=
# CONFIG_USB_SL811HS is not set=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_MIDI is not set=0A=
# CONFIG_USB_ACM is not set=0A=
# CONFIG_USB_PRINTER is not set=0A=
# CONFIG_USB_STORAGE is not set=0A=
=0A=
#=0A=
# USB Human Interface Devices (HID)=0A=
#=0A=
# CONFIG_USB_HID is not set=0A=
=0A=
#=0A=
# USB HID Boot Protocol drivers=0A=
#=0A=
# CONFIG_USB_KBD is not set=0A=
# CONFIG_USB_MOUSE is not set=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_MTOUCH is not set=0A=
# CONFIG_USB_EGALAX is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
# CONFIG_USB_ATI_REMOTE is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
# CONFIG_USB_DABUSB is not set=0A=
# CONFIG_USB_VICAM is not set=0A=
# CONFIG_USB_DSBR is not set=0A=
# CONFIG_USB_IBMCAM is not set=0A=
# CONFIG_USB_KONICAWC is not set=0A=
# CONFIG_USB_OV511 is not set=0A=
# CONFIG_USB_SE401 is not set=0A=
# CONFIG_USB_SN9C102 is not set=0A=
# CONFIG_USB_STV680 is not set=0A=
=0A=
#=0A=
# USB Network adaptors=0A=
#=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_RTL8150 is not set=0A=
# CONFIG_USB_USBNET is not set=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
# CONFIG_USB_SERIAL is not set=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
# CONFIG_USB_EMI62 is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_LEGOTOWER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_LED is not set=0A=
# CONFIG_USB_CYTHERM is not set=0A=
# CONFIG_USB_PHIDGETSERVO is not set=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# Synchronous Serial Interfaces (SSI)=0A=
#=0A=
CONFIG_OMAP_UWIRE=3Dy=0A=
=0A=
#=0A=
# MMC/SD Card support=0A=
#=0A=
CONFIG_MMC=3Dy=0A=
# CONFIG_MMC_DEBUG is not set=0A=
CONFIG_MMC_BLOCK=3Dy=0A=
# CONFIG_MMC_BLOCK_BROKEN_RFD is not set=0A=
CONFIG_MMC_OMAP=3Dy=0A=
# CONFIG_MMC_OMAP16XX_BLOCK1 is not set=0A=
CONFIG_MMC_OMAP16XX_BLOCK2=3Dy=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_DEBUG_SLAB is not set=0A=
# CONFIG_DEBUG_SPINLOCK is not set=0A=
CONFIG_DEBUG_BUGVERBOSE=3Dy=0A=
CONFIG_DEBUG_INFO=3Dy=0A=
CONFIG_FRAME_POINTER=3Dy=0A=
CONFIG_DEBUG_USER=3Dy=0A=
# CONFIG_DEBUG_WAITQ is not set=0A=
CONFIG_DEBUG_ERRORS=3Dy=0A=
CONFIG_DEBUG_LL=3Dy=0A=
# CONFIG_DEBUG_ICEDCC is not set=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
# CONFIG_CRYPTO is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC_CCITT=3Dy=0A=
CONFIG_CRC32=3Dy=0A=
# CONFIG_LIBCRC32C is not set=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=

--Boundary_(ID_zNW13LuyvDjF7YjSzuUZpw)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary_(ID_zNW13LuyvDjF7YjSzuUZpw)--
