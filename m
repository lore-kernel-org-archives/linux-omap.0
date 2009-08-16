From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Sun, 16 Aug 2009 11:25:14 +0300
Message-ID: <20090816082513.GA22757@gandalf>
References: <20090815174352.c2883585.jhnikula@gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
 <20090815180701.7710de51.jhnikula@gmail.com>
 <20090815174000.GA13164@nokia.com>
 <20090816104415.e12a5e46.jhnikula@gmail.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090816104415.e12a5e46.jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Aug 16, 2009 at 10:44:15AM +0300, Jarkko Nikula wrote:
> On Sat, 15 Aug 2009 20:40:00 +0300
> Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > > CONFIG_TWL4030_USB=y
> > > CONFIG_NOP_USB_XCEIV=y
> > > 
> > > But anyway, I don't get Beagle booting with 2.6.31-rc6 if I disable any
> > > of them and IRCC another oops will follow if both are disabled.
> > 
> > There's a patch from me adding back the twl4030_usb pdata to beagle
> > board-file and another one from Paul which changed the defconfig.
> > 
> You mean this one?
> 
> http://marc.info/?l=linux-arm-kernel&m=125007992121335&w=2
> 
> It didn't help. Only way to get the mainline kernel booting is to revert
> e8e2ff462dd92693f29eb848f42d3eb720390d59 and activate both
> CONFIG_TWL4030_USB and CONFIG_NOP_USB_XCEIV.

NOP should not be necessary, beagle uses twl4030-usb as its transceiver,
unlike evm, which uses isp1504, if I'm not wrong.

Could you try the following patch ?

=============================== cut here ==================================

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 4c6fb7e..cec0df8 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27-rc8
-# Wed Oct  1 17:14:22 2008
+# Linux kernel version: 2.6.31-rc6
+# Sun Aug 16 11:18:27 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -9,7 +9,6 @@ CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_MMU=y
-# CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_HAVE_LATENCYTOP_SUPPORT=y
@@ -18,15 +17,12 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_ARCH_HAS_ILOG2_U32 is not set
-# CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_ARCH_SUPPORTS_AOUT=y
-CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -44,22 +40,35 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
-# CONFIG_CGROUPS is not set
 CONFIG_GROUP_SCHED=y
 CONFIG_FAIR_GROUP_SCHED=y
 # CONFIG_RT_GROUP_SCHED is not set
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
 CONFIG_UID16=y
 # CONFIG_SYSCTL_SYSCALL is not set
@@ -70,16 +79,21 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
-CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
-CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
+CONFIG_AIO=y
+
+#
+# Performance Counters
+#
 CONFIG_VM_EVENT_COUNTERS=y
+# CONFIG_STRIP_ASM_SYMS is not set
+CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
@@ -87,19 +101,17 @@ CONFIG_SLAB=y
 # CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
-# CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set
-# CONFIG_HAVE_IOREMAP_PROT is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
-# CONFIG_HAVE_ARCH_TRACEHOOK is not set
-# CONFIG_HAVE_DMA_ATTRS is not set
-# CONFIG_USE_GENERIC_SMP_HELPERS is not set
 CONFIG_HAVE_CLK=y
-CONFIG_PROC_PAGE_MONITOR=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_SLOW_WORK is not set
 CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 # CONFIG_MODULE_FORCE_LOAD is not set
@@ -107,11 +119,8 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_KMOD=y
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -127,7 +136,7 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
-CONFIG_CLASSIC_RCU=y
+CONFIG_FREEZER=y
 
 #
 # System Type
@@ -137,14 +146,15 @@ CONFIG_CLASSIC_RCU=y
 # CONFIG_ARCH_REALVIEW is not set
 # CONFIG_ARCH_VERSATILE is not set
 # CONFIG_ARCH_AT91 is not set
-# CONFIG_ARCH_CLPS7500 is not set
 # CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_GEMINI is not set
 # CONFIG_ARCH_EBSA110 is not set
 # CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_STMP3XXX is not set
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_IMX is not set
 # CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
@@ -153,22 +163,25 @@ CONFIG_CLASSIC_RCU=y
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_KIRKWOOD is not set
-# CONFIG_ARCH_KS8695 is not set
-# CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_LOKI is not set
 # CONFIG_ARCH_MV78XX0 is not set
-# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_ORION5X is not set
+# CONFIG_ARCH_MMP is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_W90X900 is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_MSM is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
 # CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_S3C64XX is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_U300 is not set
 # CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
-# CONFIG_ARCH_MSM7X00A is not set
 
 #
 # TI OMAP Implementations
@@ -177,6 +190,7 @@ CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
 # CONFIG_ARCH_OMAP2 is not set
 CONFIG_ARCH_OMAP3=y
+# CONFIG_ARCH_OMAP4 is not set
 
 #
 # OMAP Feature Selections
@@ -186,6 +200,7 @@ CONFIG_ARCH_OMAP3=y
 # CONFIG_OMAP_RESET_CLOCKS is not set
 # CONFIG_OMAP_MUX is not set
 # CONFIG_OMAP_MCBSP is not set
+# CONFIG_OMAP_MBOX_FWK is not set
 # CONFIG_OMAP_MPU_TIMER is not set
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_32K_TIMER_HZ=128
@@ -200,14 +215,13 @@ CONFIG_ARCH_OMAP3430=y
 # OMAP Board Type
 #
 CONFIG_MACH_OMAP3_BEAGLE=y
-
-#
-# Boot options
-#
-
-#
-# Power management
-#
+# CONFIG_MACH_OMAP_LDP is not set
+# CONFIG_MACH_OVERO is not set
+# CONFIG_MACH_OMAP3EVM is not set
+# CONFIG_MACH_OMAP3_PANDORA is not set
+# CONFIG_MACH_OMAP_3430SDP is not set
+# CONFIG_MACH_NOKIA_RX51 is not set
+# CONFIG_MACH_OMAP_ZOOM2 is not set
 
 #
 # Processor Type
@@ -235,7 +249,10 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
-# CONFIG_OUTER_CACHE is not set
+# CONFIG_ARM_ERRATA_430973 is not set
+# CONFIG_ARM_ERRATA_458693 is not set
+# CONFIG_ARM_ERRATA_460075 is not set
+CONFIG_COMMON_CLKDEV=y
 
 #
 # Bus support
@@ -259,24 +276,26 @@ CONFIG_PAGE_OFFSET=0xC0000000
 CONFIG_HZ=128
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
-CONFIG_ARCH_FLATMEM_HAS_HOLES=y
-# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
+# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
+# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
+# CONFIG_HIGHMEM is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
-# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=1
-CONFIG_BOUNCE=y
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
+# CONFIG_UACCESS_WITH_MEMCPY is not set
 
 #
 # Boot options
@@ -311,13 +330,20 @@ CONFIG_VFPv3=y
 # Userspace binary formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_HAVE_AOUT=y
 # CONFIG_BINFMT_AOUT is not set
 CONFIG_BINFMT_MISC=y
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_APM_EMULATION is not set
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
@@ -369,6 +395,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -378,7 +405,10 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
 # CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
 
 #
 # Network testing
@@ -389,14 +419,17 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
+CONFIG_WIRELESS=y
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_OLD_REGULATORY is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_LIB80211 is not set
 
 #
-# Wireless
+# CFG80211 needs to be enabled for MAC80211
 #
-# CONFIG_CFG80211 is not set
-# CONFIG_WIRELESS_EXT is not set
-# CONFIG_MAC80211 is not set
-# CONFIG_IEEE80211 is not set
+CONFIG_MAC80211_DEFAULT_PS_VALUE=0
+# CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
 
@@ -419,6 +452,7 @@ CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 # CONFIG_MTD_CONCAT is not set
 CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
 # CONFIG_MTD_AFS_PARTS is not set
@@ -480,6 +514,8 @@ CONFIG_MTD_NAND=y
 # CONFIG_MTD_NAND_VERIFY_WRITE is not set
 # CONFIG_MTD_NAND_ECC_SMC is not set
 # CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_GPIO is not set
+# CONFIG_MTD_NAND_OMAP2 is not set
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
@@ -488,6 +524,11 @@ CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_ONENAND is not set
 
 #
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
 # UBI - Unsorted block images
 #
 # CONFIG_MTD_UBI is not set
@@ -504,6 +545,7 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
 # CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_MG_DISK is not set
 # CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
@@ -527,10 +569,6 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_BLK_DEV_SR is not set
 # CONFIG_CHR_DEV_SG is not set
 # CONFIG_CHR_DEV_SCH is not set
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
@@ -547,8 +585,11 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
+# CONFIG_LIBFC is not set
+# CONFIG_LIBFCOE is not set
 # CONFIG_SCSI_DEBUG is not set
 # CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
 CONFIG_NETDEVICES=y
@@ -567,7 +608,10 @@ CONFIG_NETDEVICES=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
-# CONFIG_IWLWIFI_LEDS is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
 
 #
 # USB Network Adapters
@@ -646,10 +690,11 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=y
-# CONFIG_NVRAM is not set
+# CONFIG_HW_RANDOM_TIMERIOMEM is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
@@ -665,6 +710,7 @@ CONFIG_I2C_HELPER_AUTO=y
 #
 # I2C system bus drivers (mostly embedded / system-on-chip)
 #
+# CONFIG_I2C_DESIGNWARE is not set
 # CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
 CONFIG_I2C_OMAP=y
@@ -687,15 +733,9 @@ CONFIG_I2C_OMAP=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_EEPROM_AT24 is not set
-# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_ISP1301_OMAP is not set
-# CONFIG_TPS65010 is not set
-# CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
@@ -708,11 +748,16 @@ CONFIG_GPIOLIB=y
 # CONFIG_GPIO_SYSFS is not set
 
 #
+# Memory mapped GPIO expanders:
+#
+
+#
 # I2C GPIO expanders:
 #
 # CONFIG_GPIO_MAX732X is not set
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+# CONFIG_GPIO_TWL4030 is not set
 
 #
 # PCI GPIO expanders:
@@ -727,11 +772,11 @@ CONFIG_GPIOLIB=y
 # CONFIG_THERMAL is not set
 # CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
 # Sonics Silicon Backplane
 #
-CONFIG_SSB_POSSIBLE=y
 # CONFIG_SSB is not set
 
 #
@@ -739,30 +784,21 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
-# CONFIG_UCB1400_CORE is not set
+# CONFIG_TPS65010 is not set
+CONFIG_TWL4030_CORE=y
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
-
-#
-# Multimedia devices
-#
-
-#
-# Multimedia core support
-#
-# CONFIG_VIDEO_DEV is not set
-# CONFIG_DVB_CORE is not set
-# CONFIG_VIDEO_MEDIA is not set
-
-#
-# Multimedia drivers
-#
-CONFIG_DAB=y
-# CONFIG_USB_DABUSB is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
@@ -798,30 +834,35 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_OTG is not set
+CONFIG_USB_SUSPEND=y
+CONFIG_USB_OTG=y
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 CONFIG_USB_MON=y
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
 
 #
 # USB Host Controller Drivers
 #
 # CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_OXU210HP_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_ISP1760_HCD is not set
 # CONFIG_USB_OHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
 # CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_MUSB_SOC=y
 
 #
 # OMAP 343x high speed USB support
 #
-CONFIG_USB_MUSB_HOST=y
+# CONFIG_USB_MUSB_HOST is not set
 # CONFIG_USB_MUSB_PERIPHERAL is not set
-# CONFIG_USB_MUSB_OTG is not set
-# CONFIG_USB_GADGET_MUSB_HDRC is not set
+CONFIG_USB_MUSB_OTG=y
+CONFIG_USB_GADGET_MUSB_HDRC=y
 CONFIG_USB_MUSB_HDRC_HCD=y
 # CONFIG_MUSB_PIO_ONLY is not set
 CONFIG_USB_INVENTRA_DMA=y
@@ -834,13 +875,14 @@ CONFIG_USB_INVENTRA_DMA=y
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
 # CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
 
 #
-# may also be needed; see USB_STORAGE Help for more information
+# also be needed; see USB_STORAGE Help for more info
 #
 # CONFIG_USB_STORAGE is not set
 # CONFIG_USB_LIBUSUAL is not set
@@ -862,6 +904,7 @@ CONFIG_USB_INVENTRA_DMA=y
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
 # CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
@@ -869,35 +912,42 @@ CONFIG_USB_INVENTRA_DMA=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
 # CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
 CONFIG_USB_GADGET=y
 # CONFIG_USB_GADGET_DEBUG is not set
 # CONFIG_USB_GADGET_DEBUG_FILES is not set
+CONFIG_USB_GADGET_VBUS_DRAW=2
 CONFIG_USB_GADGET_SELECTED=y
-# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_AT91 is not set
 # CONFIG_USB_GADGET_ATMEL_USBA is not set
 # CONFIG_USB_GADGET_FSL_USB2 is not set
-# CONFIG_USB_GADGET_NET2280 is not set
-# CONFIG_USB_GADGET_PXA25X is not set
-CONFIG_USB_GADGET_M66592=y
-CONFIG_USB_M66592=y
-# CONFIG_USB_GADGET_PXA27X is not set
-# CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_LH7A40X is not set
 # CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_PXA25X is not set
+# CONFIG_USB_GADGET_PXA27X is not set
+# CONFIG_USB_GADGET_S3C_HSOTG is not set
+# CONFIG_USB_GADGET_IMX is not set
 # CONFIG_USB_GADGET_S3C2410 is not set
-# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_M66592 is not set
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_FSL_QE is not set
+# CONFIG_USB_GADGET_CI13XXX is not set
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LANGWELL is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 CONFIG_USB_GADGET_DUALSPEED=y
 # CONFIG_USB_ZERO is not set
+# CONFIG_USB_AUDIO is not set
 CONFIG_USB_ETH=m
 CONFIG_USB_ETH_RNDIS=y
 # CONFIG_USB_GADGETFS is not set
@@ -906,12 +956,21 @@ CONFIG_USB_ETH_RNDIS=y
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
 # CONFIG_USB_CDC_COMPOSITE is not set
+
+#
+# OTG and related infrastructure
+#
+CONFIG_USB_OTG_UTILS=y
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_ISP1301_OMAP is not set
+CONFIG_TWL4030_USB=y
+# CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
-# MMC/SD Card Drivers
+# MMC/SD/SDIO Card Drivers
 #
 CONFIG_MMC_BLOCK=y
 CONFIG_MMC_BLOCK_BOUNCE=y
@@ -919,10 +978,11 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 # CONFIG_MMC_TEST is not set
 
 #
-# MMC/SD Host Controller Drivers
+# MMC/SD/SDIO Host Controller Drivers
 #
 # CONFIG_MMC_SDHCI is not set
 # CONFIG_MMC_OMAP is not set
+# CONFIG_MMC_OMAP_HS is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_NEW_LEDS is not set
@@ -954,8 +1014,11 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_PCF8563 is not set
 # CONFIG_RTC_DRV_PCF8583 is not set
 # CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_TWL4030 is not set
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
 
 #
 # SPI RTC drivers
@@ -965,27 +1028,33 @@ CONFIG_RTC_INTF_DEV=y
 # Platform RTC drivers
 #
 # CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
 # CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
 # on-CPU RTC drivers
 #
 # CONFIG_DMADEVICES is not set
-
-#
-# Voltage and Current regulators
-#
-# CONFIG_REGULATOR is not set
+# CONFIG_AUXDISPLAY is not set
+CONFIG_REGULATOR=y
+# CONFIG_REGULATOR_DEBUG is not set
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
+# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
+# CONFIG_REGULATOR_MAX1586 is not set
+CONFIG_REGULATOR_TWL4030=y
+# CONFIG_REGULATOR_LP3971 is not set
 # CONFIG_UIO is not set
+# CONFIG_STAGING is not set
 
 #
 # File systems
@@ -994,20 +1063,26 @@ CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_EXT3_FS_XATTR is not set
-# CONFIG_EXT4DEV_FS is not set
+# CONFIG_EXT4_FS is not set
 CONFIG_JBD=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 CONFIG_QUOTA=y
 # CONFIG_QUOTA_NETLINK_INTERFACE is not set
 CONFIG_PRINT_QUOTA_WARNING=y
+CONFIG_QUOTA_TREE=y
 # CONFIG_QFMT_V1 is not set
 CONFIG_QFMT_V2=y
 CONFIG_QUOTACTL=y
@@ -1016,6 +1091,11 @@ CONFIG_QUOTACTL=y
 # CONFIG_FUSE_FS is not set
 
 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 # CONFIG_ISO9660_FS is not set
@@ -1036,15 +1116,13 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 # CONFIG_CONFIGFS_FS is not set
-
-#
-# Miscellaneous filesystems
-#
+CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
@@ -1064,6 +1142,7 @@ CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_OMFS_FS is not set
@@ -1072,11 +1151,13 @@ CONFIG_JFFS2_RTIME=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
+# CONFIG_NFS_V4_1 is not set
 CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
 CONFIG_LOCKD=y
@@ -1171,11 +1252,15 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KMEMLEAK is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -1193,21 +1278,22 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_MEMORY_INIT is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
-CONFIG_FRAME_POINTER=y
+# CONFIG_DEBUG_NOTIFIERS is not set
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
-CONFIG_HAVE_FTRACE=y
-CONFIG_HAVE_DYNAMIC_FTRACE=y
+# CONFIG_PAGE_POISONING is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_TRACING_SUPPORT=y
 # CONFIG_FTRACE is not set
-# CONFIG_IRQSOFF_TRACER is not set
-# CONFIG_SCHED_TRACER is not set
-# CONFIG_CONTEXT_SWITCH_TRACER is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
+CONFIG_ARM_UNWIND=y
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_ERRORS is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
@@ -1218,17 +1304,28 @@ CONFIG_HAVE_ARCH_KGDB=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
 
 #
 # Crypto core or helper
 #
+# CONFIG_CRYPTO_FIPS is not set
 CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=y
 CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
 CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
 # CONFIG_CRYPTO_CRYPTD is not set
 # CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_TEST is not set
@@ -1260,7 +1357,7 @@ CONFIG_CRYPTO_PCBC=m
 #
 # Digest
 #
-# CONFIG_CRYPTO_CRC32C is not set
+CONFIG_CRYPTO_CRC32C=y
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
@@ -1297,15 +1394,21 @@ CONFIG_CRYPTO_DES=y
 # Compression
 #
 # CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
 # CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_HW=y
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-# CONFIG_GENERIC_FIND_FIRST_BIT is not set
-# CONFIG_GENERIC_FIND_NEXT_BIT is not set
+CONFIG_GENERIC_FIND_LAST_BIT=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_T10DIF is not set
@@ -1315,7 +1418,8 @@ CONFIG_CRC32=y
 CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
-CONFIG_PLIST=y
+CONFIG_DECOMPRESS_GZIP=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 991ac9c..8e1f603 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -249,11 +249,16 @@ static struct regulator_init_data beagle_vpll2 = {
 	.consumer_supplies	= &beagle_vdvi_supply,
 };
 
+static struct twl4030_usb_data beagle_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
 static struct twl4030_platform_data beagle_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
 	.vmmc1		= &beagle_vmmc1,
 	.vsim		= &beagle_vsim,

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
