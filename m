From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 12/14] Update arch/arm/configs/omap_innovator_1610_defconfig
Date: Tue, 18 Sep 2007 13:56:48 -0400
Message-ID: <1190138212298-git-send-email-felipe.lima@indt.org.br>
References: <1190138210438-git-send-email-felipe.lima@indt.org.br>
	<11901382113889-git-send-email-felipe.lima@indt.org.br>
	<11901382111511-git-send-email-felipe.lima@indt.org.br>
	<11901382112392-git-send-email-felipe.lima@indt.org.br>
	<11901382112428-git-send-email-felipe.lima@indt.org.br>
	<1190138211478-git-send-email-felipe.lima@indt.org.br>
	<11901382121172-git-send-email-felipe.lima@indt.org.br>
	<11901382123827-git-send-email-felipe.lima@indt.org.br>
	<11901382123346-git-send-email-felipe.lima@indt.org.br>
	<11901382123807-git-send-email-felipe.lima@indt.org.br>
	<11901382121603-git-send-email-felipe.lima@indt.org.br>
	<11901382122874-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11901382122874-git-send-email-felipe.lima@indt.org.br>
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

Update arch/arm/configs/omap_innovator_1610_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_innovator_1610_defconfig |  451 ++++++++++++++----------
 1 files changed, 270 insertions(+), 181 deletions(-)

diff --git a/arch/arm/configs/omap_innovator_1610_defconfig b/arch/arm/configs/omap_innovator_1610_defconfig
index 7baf3bc..95d9f2b 100644
--- a/arch/arm/configs/omap_innovator_1610_defconfig
+++ b/arch/arm/configs/omap_innovator_1610_defconfig
@@ -1,90 +1,140 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.14-rc4-omap1
-# Tue Oct 18 17:55:48 2005
+# Linux kernel version: 2.6.23-rc6-omap1
+# Tue Sep 18 11:45:05 2007
 #
 CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_MMU=y
-CONFIG_UID16=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
+# CONFIG_TASKSTATS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
-# CONFIG_HOTPLUG is not set
-CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
+CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
 
 #
 # System Type
 #
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
 # CONFIG_ARCH_CLPS7500 is not set
 # CONFIG_ARCH_CLPS711X is not set
 # CONFIG_ARCH_CO285 is not set
 # CONFIG_ARCH_EBSA110 is not set
-# CONFIG_ARCH_CAMELOT is not set
+# CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
-# CONFIG_ARCH_INTEGRATOR is not set
-# CONFIG_ARCH_IOP3XX is not set
-# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP13XX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IXP23XX is not set
 # CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
-# CONFIG_ARCH_VERSATILE is not set
-# CONFIG_ARCH_IMX is not set
-# CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_AAEC2000 is not set
 
 #
 # TI OMAP Implementations
@@ -92,15 +142,21 @@ CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP_OTG=y
 CONFIG_ARCH_OMAP1=y
 # CONFIG_ARCH_OMAP2 is not set
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
 #
 # CONFIG_OMAP_RESET_CLOCKS is not set
 # CONFIG_OMAP_BOOT_TAG is not set
+# CONFIG_OMAP_GPIO_SWITCH is not set
 CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MUX_DEBUG is not set
 CONFIG_OMAP_MUX_WARNINGS=y
+# CONFIG_OMAP_STI is not set
+CONFIG_OMAP_MCBSP=y
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
 # CONFIG_OMAP_DM_TIMER is not set
@@ -108,6 +164,7 @@ CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
 CONFIG_OMAP_SERIAL_WAKE=y
+# CONFIG_OMAP_DSP is not set
 
 #
 # OMAP Core Type
@@ -123,6 +180,7 @@ CONFIG_MACH_OMAP_INNOVATOR=y
 # CONFIG_MACH_OMAP_H2 is not set
 # CONFIG_MACH_OMAP_H3 is not set
 # CONFIG_MACH_OMAP_OSK is not set
+# CONFIG_MACH_NOKIA770 is not set
 # CONFIG_MACH_OMAP_GENERIC is not set
 
 #
@@ -135,7 +193,15 @@ CONFIG_OMAP_ARM_192MHZ=y
 # CONFIG_OMAP_ARM_120MHZ is not set
 # CONFIG_OMAP_ARM_60MHZ is not set
 # CONFIG_OMAP_ARM_30MHZ is not set
-# CONFIG_OMAP_DSP is not set
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
+
+#
+# Boot options
+#
+
+#
+# Power management
+#
 
 #
 # Processor Type
@@ -144,9 +210,12 @@ CONFIG_CPU_32=y
 CONFIG_CPU_ARM926T=y
 CONFIG_CPU_32v5=y
 CONFIG_CPU_ABRT_EV5TJ=y
+CONFIG_CPU_PABRT_NOIFAR=y
 CONFIG_CPU_CACHE_VIVT=y
 CONFIG_CPU_COPY_V4WB=y
 CONFIG_CPU_TLB_V4WBI=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
 
 #
 # Processor Features
@@ -156,11 +225,13 @@ CONFIG_CPU_TLB_V4WBI=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 CONFIG_CPU_DCACHE_WRITETHROUGH=y
 # CONFIG_CPU_CACHE_ROUND_ROBIN is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
-CONFIG_ISA_DMA_API=y
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -170,8 +241,12 @@ CONFIG_ISA_DMA_API=y
 #
 # Kernel Features
 #
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 # CONFIG_PREEMPT is not set
-# CONFIG_NO_IDLE_HZ is not set
+CONFIG_HZ=100
+# CONFIG_AEABI is not set
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
@@ -180,6 +255,11 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4096
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -190,6 +270,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=32M console=tty0 console=ttyS0,115200 initrd=0x10200000,8M root=/dev/ram0 rw"
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
 # CPU Frequency scaling
@@ -220,6 +301,7 @@ CONFIG_BINFMT_ELF=y
 # Power management options
 #
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -232,6 +314,10 @@ CONFIG_NET=y
 CONFIG_PACKET=m
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -249,23 +335,25 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
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
+# CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
@@ -275,11 +363,13 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
 # CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -288,7 +378,17 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -300,24 +400,11 @@ CONFIG_TCP_CONG_BIC=y
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
 # CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
@@ -325,16 +412,8 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
@@ -342,67 +421,31 @@ CONFIG_IOSCHED_CFQ=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
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
-
-#
-# PHY device support
-#
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
 CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
 
 #
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
 CONFIG_PPP=y
 CONFIG_PPP_MULTILINK=y
@@ -411,22 +454,23 @@ CONFIG_PPP_MULTILINK=y
 # CONFIG_PPP_SYNC_TTY is not set
 # CONFIG_PPP_DEFLATE is not set
 # CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_MPPE is not set
 # CONFIG_PPPOE is not set
+# CONFIG_PPPOL2TP is not set
 # CONFIG_SLIP is not set
+CONFIG_SLHC=y
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
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -449,9 +493,12 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_KEYBOARD_OMAP=y
+# CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -469,6 +516,7 @@ CONFIG_SERIO_SERPORT=y
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -477,6 +525,7 @@ CONFIG_HW_CONSOLE=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
@@ -487,77 +536,88 @@ CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
-# CONFIG_OMAP_RNG is not set
+CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_OMAP=m
 # CONFIG_NVRAM is not set
-# CONFIG_RTC is not set
-# CONFIG_OMAP_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
-
-#
-# I2C support
-#
+# CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 
 #
-# Hardware Monitoring support
+# SPI support
 #
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_ABITUGURU3 is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 
 #
-# Misc devices
-#
-
-#
-# Multimedia Capabilities Port drivers
+# Multifunction device drivers
 #
+# CONFIG_MFD_SM501 is not set
+# CONFIG_NEW_LEDS is not set
 
 #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
-# CONFIG_DVB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
-CONFIG_FB_SOFT_CURSOR=y
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
 CONFIG_FB_MODE_HELPERS=y
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_OMAP=y
-CONFIG_FB_OMAP_LCDC_INTERNAL=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
 # CONFIG_FB_VIRTUAL is not set
 
@@ -567,6 +627,8 @@ CONFIG_FB_OMAP_LCDC_INTERNAL=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
@@ -578,43 +640,57 @@ CONFIG_FONT_8x16=y
 # CONFIG_FONT_SUN8x16 is not set
 # CONFIG_FONT_SUN12x22 is not set
 # CONFIG_FONT_10x18 is not set
-
-#
-# Logo configuration
-#
 CONFIG_LOGO=y
 CONFIG_LOGO_LINUX_MONO=y
 CONFIG_LOGO_LINUX_VGA16=y
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# USB support
-#
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+CONFIG_HID_DEBUG=y
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
 # CONFIG_USB is not set
 
 #
+# Enable Host or Gadget support to see Inventra options
+#
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
 
 #
-# MMC/SD Card support
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
 #
-# CONFIG_MMC is not set
 
 #
-# Synchronous Serial Interfaces (SSI)
+# CBUS support
 #
-# CONFIG_OMAP_UWIRE is not set
-# CONFIG_OMAP_TSC2101 is not set
+# CONFIG_CBUS is not set
 
 #
 # File systems
@@ -623,14 +699,17 @@ CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+# CONFIG_EXT4DEV_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=y
@@ -654,11 +733,12 @@ CONFIG_AUTOFS4_FS=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 # CONFIG_TMPFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -691,6 +771,7 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -698,7 +779,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -712,6 +792,11 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Profiling support
 #
 # CONFIG_PROFILING is not set
@@ -720,8 +805,13 @@ CONFIG_MSDOS_PARTITION=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_SLUB_DEBUG_ON is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_FRAME_POINTER=y
 # CONFIG_DEBUG_USER is not set
@@ -731,20 +821,19 @@ CONFIG_FRAME_POINTER=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 # CONFIG_CRYPTO is not set
 
 #
-# Hardware crypto devices
-#
-
-#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
-- 
1.5.3.1.91.gd3392
