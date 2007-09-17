From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 05/14] ARM: OMAP: Update
	arch/arm/configs/omap_generic_1610_defconfig
Date: Mon, 17 Sep 2007 16:23:12 -0400
Message-ID: <11900606031155-git-send-email-felipe.lima@indt.org.br>
References: <11900606011267-git-send-email-felipe.lima@indt.org.br>
	<11900606021256-git-send-email-felipe.lima@indt.org.br>
	<1190060602235-git-send-email-felipe.lima@indt.org.br>
	<1190060602157-git-send-email-felipe.lima@indt.org.br>
	<1190060603498-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1190060603498-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Update omap_generic_1610_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_generic_1610_defconfig |  796 +++++++++++---------------
 1 files changed, 342 insertions(+), 454 deletions(-)

diff --git a/arch/arm/configs/omap_generic_1610_defconfig b/arch/arm/configs/omap_generic_1610_defconfig
index 7d30fe2..dcbff3e 100644
--- a/arch/arm/configs/omap_generic_1610_defconfig
+++ b/arch/arm/configs/omap_generic_1610_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc1-omap1
-# Thu Jun  7 04:38:00 2007
+# Linux kernel version: 2.6.23-rc6-omap1
+# Mon Sep 17 15:41:37 2007
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -26,26 +26,21 @@ CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
-CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
-# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -55,12 +50,12 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
-# CONFIG_EMBEDDED is not set
+CONFIG_EMBEDDED=y
 CONFIG_UID16=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
@@ -80,24 +75,17 @@ CONFIG_SLAB=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_MODVERSIONS is not set
-# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
 
 #
 # IO Schedulers
@@ -106,11 +94,11 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
-# CONFIG_DEFAULT_AS is not set
+CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_DEADLINE is not set
-CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="cfq"
+CONFIG_DEFAULT_IOSCHED="anticipatory"
 
 #
 # System Type
@@ -138,6 +126,7 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -152,17 +141,21 @@ CONFIG_ARCH_OMAP=y
 # TI OMAP Implementations
 #
 CONFIG_ARCH_OMAP_OTG=y
-CONFIG_ARCH_OMAP1=y
-# CONFIG_ARCH_OMAP2 is not set
+# CONFIG_ARCH_OMAP1 is not set
+CONFIG_ARCH_OMAP2=y
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
 #
+CONFIG_OMAP_DEBUG_DEVICES=y
 # CONFIG_OMAP_RESET_CLOCKS is not set
-# CONFIG_OMAP_BOOT_TAG is not set
+CONFIG_OMAP_BOOT_TAG=y
+# CONFIG_OMAP_BOOT_REASON is not set
+# CONFIG_OMAP_COMPONENT_VERSION is not set
 # CONFIG_OMAP_GPIO_SWITCH is not set
 CONFIG_OMAP_MUX=y
-# CONFIG_OMAP_MUX_DEBUG is not set
+CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_OMAP_MUX_WARNINGS=y
 # CONFIG_OMAP_STI is not set
 CONFIG_OMAP_MCBSP=y
@@ -170,68 +163,71 @@ CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
-# CONFIG_OMAP_DM_TIMER is not set
+CONFIG_OMAP_DM_TIMER=y
 CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
-# CONFIG_OMAP_LL_DEBUG_LCD is not set
 CONFIG_OMAP_SERIAL_WAKE=y
 # CONFIG_OMAP_DSP is not set
+# CONFIG_MACH_OMAP_GENERIC is not set
 
 #
 # OMAP Core Type
 #
-# CONFIG_ARCH_OMAP730 is not set
-# CONFIG_ARCH_OMAP15XX is not set
-CONFIG_ARCH_OMAP16XX=y
+CONFIG_ARCH_OMAP24XX=y
+CONFIG_ARCH_OMAP2420=y
+# CONFIG_ARCH_OMAP2430 is not set
 
 #
 # OMAP Board Type
 #
-# CONFIG_MACH_OMAP_INNOVATOR is not set
-# CONFIG_MACH_OMAP_H2 is not set
-# CONFIG_MACH_OMAP_H3 is not set
-# CONFIG_MACH_OMAP_OSK is not set
-# CONFIG_MACH_NOKIA770 is not set
-CONFIG_MACH_OMAP_GENERIC=y
+# CONFIG_MACH_NOKIA_N800 is not set
+CONFIG_MACH_OMAP_H4=y
+# CONFIG_MACH_OMAP_H4_TUSB is not set
+# CONFIG_MACH_OMAP_H4_OTG is not set
+# CONFIG_MACH_OMAP2_H4_USB1 is not set
+# CONFIG_MACH_OMAP_APOLLON is not set
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
+# CONFIG_MACH_OMAP_2430SDP is not set
+
+#
+# Boot options
+#
 
 #
-# OMAP CPU Speed
+# Power management
 #
-# CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER is not set
-# CONFIG_OMAP_ARM_216MHZ is not set
-CONFIG_OMAP_ARM_192MHZ=y
-# CONFIG_OMAP_ARM_168MHZ is not set
-# CONFIG_OMAP_ARM_120MHZ is not set
-# CONFIG_OMAP_ARM_60MHZ is not set
-# CONFIG_OMAP_ARM_30MHZ is not set
 
 #
 # Processor Type
 #
 CONFIG_CPU_32=y
-CONFIG_CPU_ARM926T=y
-CONFIG_CPU_32v5=y
-CONFIG_CPU_ABRT_EV5TJ=y
-CONFIG_CPU_CACHE_VIVT=y
-CONFIG_CPU_COPY_V4WB=y
-CONFIG_CPU_TLB_V4WBI=y
+CONFIG_CPU_V6=y
+# CONFIG_CPU_32v6K is not set
+CONFIG_CPU_32v6=y
+CONFIG_CPU_ABRT_EV6=y
+CONFIG_CPU_PABRT_NOIFAR=y
+CONFIG_CPU_CACHE_V6=y
+CONFIG_CPU_CACHE_VIPT=y
+CONFIG_CPU_COPY_V6=y
+CONFIG_CPU_TLB_V6=y
+CONFIG_CPU_HAS_ASID=y
 CONFIG_CPU_CP15=y
 CONFIG_CPU_CP15_MMU=y
 
 #
 # Processor Features
 #
-# CONFIG_ARM_THUMB is not set
+CONFIG_ARM_THUMB=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
-# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
-# CONFIG_CPU_CACHE_ROUND_ROBIN is not set
+# CONFIG_CPU_BPREDICT_DISABLE is not set
 # CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
+# CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
@@ -245,9 +241,10 @@ CONFIG_CPU_CP15_MMU=y
 # CONFIG_TICK_ONESHOT is not set
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
-CONFIG_PREEMPT=y
+# CONFIG_PREEMPT is not set
 CONFIG_HZ=100
-# CONFIG_AEABI is not set
+CONFIG_AEABI=y
+CONFIG_OABI_COMPAT=y
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
@@ -256,9 +253,11 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
-CONFIG_SPLIT_PTLOCK_CPUS=4096
+CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -267,7 +266,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="mem=64M console=ttyS2,115200 root=0803 ro init=/bin/sh"
+CONFIG_CMDLINE="root=/dev/ram0 rw console=ttyS0,115200n8 initrd=0x80600000,8M ramdisk_size=8192"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
@@ -293,17 +292,13 @@ CONFIG_FPE_NWFPE=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_AOUT is not set
-# CONFIG_BINFMT_MISC is not set
-# CONFIG_ARTHUR is not set
+CONFIG_BINFMT_MISC=y
 
 #
 # Power management options
 #
-CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
-# CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
-# CONFIG_APM_EMULATION is not set
+# CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -320,18 +315,18 @@ CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_XFRM_MIGRATE is not set
-# CONFIG_NET_KEY is not set
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
+# CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_FIB_HASH=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
@@ -353,20 +348,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -390,7 +373,48 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
+CONFIG_IRDA=y
+
+#
+# IrDA protocols
+#
+CONFIG_IRLAN=y
+CONFIG_IRCOMM=y
+# CONFIG_IRDA_ULTRA is not set
+
+#
+# IrDA options
+#
+# CONFIG_IRDA_CACHE_LAST_LSAP is not set
+# CONFIG_IRDA_FAST_RR is not set
+# CONFIG_IRDA_DEBUG is not set
+
+#
+# Infrared-port device drivers
+#
+
+#
+# SIR device drivers
+#
+# CONFIG_IRTTY_SIR is not set
+
+#
+# Dongle support
+#
+
+#
+# Old SIR device drivers
+#
+# CONFIG_IRPORT_SIR is not set
+
+#
+# Old Serial dongle support
+#
+
+#
+# FIR device drivers
+#
+CONFIG_OMAP_IR=y
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
 
@@ -402,6 +426,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -416,34 +441,91 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AFS_PARTS is not set
 
 #
-# Connector - unified userspace <-> kernelspace linker
+# User Modules And Translation Layers
 #
-# CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
 
 #
-# Parallel port support
+# RAM/ROM/Flash chip drivers
 #
-# CONFIG_PARPORT is not set
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_ARM_INTEGRATOR is not set
+CONFIG_MTD_OMAP_NOR=y
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
 
 #
-# Plug and Play support
+# Disk-On-Chip Device Drivers
 #
-# CONFIG_PNPACPI is not set
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
 
 #
-# Block devices
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -452,128 +534,39 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
-CONFIG_SCSI=y
-# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
-CONFIG_SCSI_PROC_FS=y
-
-#
-# SCSI support type (disk, tape, CD-ROM)
-#
-CONFIG_BLK_DEV_SD=y
-# CONFIG_CHR_DEV_ST is not set
-# CONFIG_CHR_DEV_OSST is not set
-CONFIG_BLK_DEV_SR=y
-# CONFIG_BLK_DEV_SR_VENDOR is not set
-CONFIG_CHR_DEV_SG=y
-# CONFIG_CHR_DEV_SCH is not set
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
-CONFIG_SCSI_MULTI_LUN=y
-# CONFIG_SCSI_CONSTANTS is not set
-# CONFIG_SCSI_LOGGING is not set
-# CONFIG_SCSI_SCAN_ASYNC is not set
-CONFIG_SCSI_WAIT_SCAN=m
-
-#
-# SCSI Transports
-#
-# CONFIG_SCSI_SPI_ATTRS is not set
-# CONFIG_SCSI_FC_ATTRS is not set
-# CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
-# CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
-# CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_DEBUG is not set
-# CONFIG_SCSI_ESP_CORE is not set
 # CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-# CONFIG_SMC91X is not set
+# CONFIG_AX88796 is not set
+CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
 CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 
 #
-# Token Ring devices
-#
-
-#
 # Wireless LAN
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
-
-#
-# USB Network Adapters
-#
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
-CONFIG_USB_RTL8150=y
-CONFIG_USB_USBNET_MII=y
-CONFIG_USB_USBNET=y
-CONFIG_USB_NET_AX8817X=y
-CONFIG_USB_NET_CDCETHER=y
-# CONFIG_USB_NET_DM9601 is not set
-# CONFIG_USB_NET_GL620A is not set
-CONFIG_USB_NET_NET1080=y
-# CONFIG_USB_NET_PLUSB is not set
-# CONFIG_USB_NET_MCS7830 is not set
-# CONFIG_USB_NET_RNDIS_HOST is not set
-CONFIG_USB_NET_CDC_SUBSET=y
-CONFIG_USB_ALI_M5632=y
-CONFIG_USB_AN2720=y
-CONFIG_USB_BELKIN=y
-CONFIG_USB_ARMLINUX=y
-CONFIG_USB_EPSON2888=y
-# CONFIG_USB_KC2190 is not set
-CONFIG_USB_NET_ZAURUS=y
 # CONFIG_WAN is not set
-CONFIG_PPP=y
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-# CONFIG_PPP_ASYNC is not set
-# CONFIG_PPP_SYNC_TTY is not set
-# CONFIG_PPP_DEFLATE is not set
-# CONFIG_PPP_BSDCOMP is not set
-# CONFIG_PPP_MPPE is not set
-# CONFIG_PPPOE is not set
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-CONFIG_SLHC=y
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
 
 #
@@ -581,24 +574,22 @@ CONFIG_SLHC=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
 #
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_KEYBOARD_SUNKBD is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
@@ -615,10 +606,7 @@ CONFIG_KEYBOARD_OMAP=y
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-CONFIG_SERIO_SERPORT=y
-CONFIG_SERIO_LIBPS2=y
-# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -635,9 +623,13 @@ CONFIG_HW_CONSOLE=y
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_NR_UARTS=32
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
 
 #
 # Non-8250 serial port support
@@ -646,30 +638,29 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
 
 #
-# IPMI
+# Watchdog Device Drivers
 #
-# CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_OMAP_WATCHDOG=y
 CONFIG_HW_RANDOM=m
 CONFIG_HW_RANDOM_OMAP=m
 # CONFIG_NVRAM is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
-CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_CHARDEV is not set
 
 #
 # I2C Algorithms
 #
-CONFIG_I2C_ALGOBIT=y
+# CONFIG_I2C_ALGOBIT is not set
 # CONFIG_I2C_ALGOPCF is not set
 # CONFIG_I2C_ALGOPCA is not set
 
@@ -678,25 +669,30 @@ CONFIG_I2C_ALGOBIT=y
 #
 # CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
-# CONFIG_I2C_OMAP is not set
+CONFIG_I2C_OMAP=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
-# CONFIG_I2C_TINY_USB is not set
 
 #
 # Miscellaneous I2C Chip support
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_ISP1301_OMAP is not set
 # CONFIG_TPS65010 is not set
-# CONFIG_GPIOEXPANDER_OMAP is not set
+# CONFIG_SENSORS_TLV320AIC23 is not set
+CONFIG_GPIOEXPANDER_OMAP=y
+# CONFIG_TWL4030_CORE is not set
 # CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+CONFIG_MENELAUS=y
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -707,87 +703,23 @@ CONFIG_I2C_ALGOBIT=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
-CONFIG_HWMON=y
-# CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_ABITUGURU is not set
-# CONFIG_SENSORS_AD7418 is not set
-# CONFIG_SENSORS_ADM1021 is not set
-# CONFIG_SENSORS_ADM1025 is not set
-# CONFIG_SENSORS_ADM1026 is not set
-# CONFIG_SENSORS_ADM1029 is not set
-# CONFIG_SENSORS_ADM1031 is not set
-# CONFIG_SENSORS_ADM9240 is not set
-# CONFIG_SENSORS_ASB100 is not set
-# CONFIG_SENSORS_ATXP1 is not set
-# CONFIG_SENSORS_DS1621 is not set
-# CONFIG_SENSORS_F71805F is not set
-# CONFIG_SENSORS_FSCHER is not set
-# CONFIG_SENSORS_FSCPOS is not set
-# CONFIG_SENSORS_GL518SM is not set
-# CONFIG_SENSORS_GL520SM is not set
-# CONFIG_SENSORS_IT87 is not set
-# CONFIG_SENSORS_LM63 is not set
-# CONFIG_SENSORS_LM75 is not set
-# CONFIG_SENSORS_LM77 is not set
-# CONFIG_SENSORS_LM78 is not set
-# CONFIG_SENSORS_LM80 is not set
-# CONFIG_SENSORS_LM83 is not set
-# CONFIG_SENSORS_LM85 is not set
-# CONFIG_SENSORS_LM87 is not set
-# CONFIG_SENSORS_LM90 is not set
-# CONFIG_SENSORS_LM92 is not set
-# CONFIG_SENSORS_MAX1619 is not set
-# CONFIG_SENSORS_MAX6650 is not set
-# CONFIG_SENSORS_PC87360 is not set
-# CONFIG_SENSORS_PC87427 is not set
-# CONFIG_SENSORS_SMSC47M1 is not set
-# CONFIG_SENSORS_SMSC47M192 is not set
-# CONFIG_SENSORS_SMSC47B397 is not set
-# CONFIG_SENSORS_VT1211 is not set
-# CONFIG_SENSORS_W83781D is not set
-# CONFIG_SENSORS_W83791D is not set
-# CONFIG_SENSORS_W83792D is not set
-# CONFIG_SENSORS_W83793 is not set
-# CONFIG_SENSORS_W83L785TS is not set
-# CONFIG_SENSORS_W83627HF is not set
-# CONFIG_SENSORS_W83627EHF is not set
-# CONFIG_HWMON_DEBUG_CHIP is not set
-
-#
-# Misc devices
-#
-# CONFIG_BLINK is not set
+# CONFIG_HWMON is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 
 #
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
-
-#
-# LED devices
-#
 # CONFIG_NEW_LEDS is not set
 
 #
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
 CONFIG_DAB=y
-# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
@@ -799,132 +731,72 @@ CONFIG_DAB=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
-# CONFIG_FB is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
+CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_OMAP=y
+# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_LOGO_LINUX_CLUT224=y
 
 #
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
-
-#
-# USB Input Devices
-#
-CONFIG_USB_HID=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_HID_FF is not set
-# CONFIG_USB_HIDDEV is not set
-
-#
-# USB support
-#
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
-CONFIG_USB=y
-CONFIG_USB_DEBUG=y
-
-#
-# Miscellaneous USB options
-#
-CONFIG_USB_DEVICEFS=y
-# CONFIG_USB_DEVICE_CLASS is not set
-# CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_SUSPEND is not set
-# CONFIG_USB_OTG is not set
-
-#
-# USB Host Controller Drivers
-#
-# CONFIG_USB_ISP116X_HCD is not set
-CONFIG_USB_OHCI_HCD=y
-# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
-# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
-CONFIG_USB_OHCI_LITTLE_ENDIAN=y
-# CONFIG_USB_SL811_HCD is not set
-# CONFIG_USB_MUSB_HDRC is not set
+# CONFIG_USB is not set
 
 #
-# USB Device Class drivers
+# Enable Host or Gadget support to see Inventra options
 #
-# CONFIG_USB_ACM is not set
-# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
-# may also be needed; see USB_STORAGE Help for more information
-#
-CONFIG_USB_STORAGE=y
-# CONFIG_USB_STORAGE_DEBUG is not set
-CONFIG_USB_STORAGE_DATAFAB=y
-CONFIG_USB_STORAGE_FREECOM=y
-CONFIG_USB_STORAGE_DPCM=y
-# CONFIG_USB_STORAGE_USBAT is not set
-CONFIG_USB_STORAGE_SDDR09=y
-CONFIG_USB_STORAGE_SDDR55=y
-CONFIG_USB_STORAGE_JUMPSHOT=y
-# CONFIG_USB_STORAGE_ALAUDA is not set
-# CONFIG_USB_STORAGE_KARMA is not set
-# CONFIG_USB_LIBUSUAL is not set
-
-#
-# USB Imaging devices
-#
-# CONFIG_USB_MDC800 is not set
-# CONFIG_USB_MICROTEK is not set
-CONFIG_USB_MON=y
-
-#
-# USB port drivers
-#
-
-#
-# USB Serial Converter support
-#
-# CONFIG_USB_SERIAL is not set
-
-#
-# USB Miscellaneous drivers
-#
-# CONFIG_USB_EMI62 is not set
-# CONFIG_USB_EMI26 is not set
-# CONFIG_USB_ADUTUX is not set
-# CONFIG_USB_AUERSWALD is not set
-# CONFIG_USB_RIO500 is not set
-# CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_LCD is not set
-# CONFIG_USB_BERRY_CHARGE is not set
-# CONFIG_USB_LED is not set
-# CONFIG_USB_CYPRESS_CY7C63 is not set
-# CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGET is not set
-# CONFIG_USB_IDMOUSE is not set
-# CONFIG_USB_FTDI_ELAN is not set
-# CONFIG_USB_APPLEDISPLAY is not set
-# CONFIG_USB_LD is not set
-# CONFIG_USB_TRANCEVIBRATOR is not set
-# CONFIG_USB_IOWARRIOR is not set
-# CONFIG_USB_TEST is not set
-
-#
-# USB DSL modem support
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -936,61 +808,29 @@ CONFIG_MMC=y
 # MMC/SD Card Drivers
 #
 CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
 
 #
 # MMC/SD Host Controller Drivers
 #
 CONFIG_MMC_OMAP=y
-
-#
-# Real Time Clock
-#
 CONFIG_RTC_LIB=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_HCTOSYS=y
-CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
-# CONFIG_RTC_DEBUG is not set
+# CONFIG_RTC_CLASS is not set
 
 #
-# RTC interfaces
+# DMA Engine support
 #
-CONFIG_RTC_INTF_SYSFS=y
-CONFIG_RTC_INTF_PROC=y
-CONFIG_RTC_INTF_DEV=y
-# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
-# CONFIG_RTC_DRV_TEST is not set
+# CONFIG_DMA_ENGINE is not set
 
 #
-# I2C RTC drivers
+# DMA Clients
 #
-# CONFIG_RTC_DRV_DS1307 is not set
-# CONFIG_RTC_DRV_DS1672 is not set
-# CONFIG_RTC_DRV_MAX6900 is not set
-# CONFIG_RTC_DRV_RS5C372 is not set
-# CONFIG_RTC_DRV_ISL1208 is not set
-# CONFIG_RTC_DRV_X1205 is not set
-# CONFIG_RTC_DRV_PCF8563 is not set
-# CONFIG_RTC_DRV_PCF8583 is not set
 
 #
-# SPI RTC drivers
+# DMA Devices
 #
 
 #
-# Platform RTC drivers
-#
-# CONFIG_RTC_DRV_CMOS is not set
-# CONFIG_RTC_DRV_DS1553 is not set
-# CONFIG_RTC_DRV_DS1742 is not set
-# CONFIG_RTC_DRV_M48T86 is not set
-# CONFIG_RTC_DRV_V3020 is not set
-
-#
-# on-CPU RTC drivers
-#
-CONFIG_RTC_DRV_OMAP=y
-
-#
 # CBUS support
 #
 # CONFIG_CBUS is not set
@@ -1002,13 +842,10 @@ CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
@@ -1019,26 +856,27 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
-# CONFIG_QUOTA is not set
+CONFIG_QUOTA=y
+# CONFIG_QFMT_V1 is not set
+CONFIG_QFMT_V2=y
+CONFIG_QUOTACTL=y
 CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=y
-CONFIG_AUTOFS4_FS=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
 #
-CONFIG_ISO9660_FS=y
-CONFIG_JOLIET=y
-# CONFIG_ZISOFS is not set
+# CONFIG_ISO9660_FS is not set
 # CONFIG_UDF_FS is not set
 
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_CODEPAGE=437
 CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
@@ -1049,7 +887,8 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 CONFIG_PROC_FS=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -1064,6 +903,15 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -1075,23 +923,25 @@ CONFIG_RAMFS=y
 # Network File Systems
 #
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
-# CONFIG_NFS_V4 is not set
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+CONFIG_NFS_V4=y
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
-# CONFIG_ROOT_NFS is not set
+CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
 # CONFIG_SUNRPC_BIND34 is not set
-# CONFIG_RPCSEC_GSS_KRB5 is not set
+CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -1120,7 +970,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
 # CONFIG_NLS_CODEPAGE_850 is not set
@@ -1181,20 +1031,21 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
-CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_DEBUG_MUTEXES is not set
+CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_LOCK_ALLOC is not set
 # CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
-CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
@@ -1204,28 +1055,65 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_ERRORS is not set
-# CONFIG_DEBUG_LL is not set
+CONFIG_DEBUG_LL=y
+# CONFIG_DEBUG_ICEDCC is not set
 
 #
 # Security options
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-# CONFIG_CRYPTO is not set
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_TEST is not set
+CONFIG_CRYPTO_HW=y
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-# CONFIG_CRC_CCITT is not set
+CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-# CONFIG_LIBCRC32C is not set
+# CONFIG_CRC7 is not set
+CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
-- 
1.5.3.1.91.gd3392
