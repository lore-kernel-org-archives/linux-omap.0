From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/6] OMAP4: Sync up omap4430 defconfig
Date: Wed,  9 Dec 2009 23:59:10 +0530
Message-ID: <1260383350-32681-6-git-send-email-santosh.shilimkar@ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-2-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-3-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-4-git-send-email-santosh.shilimkar@ti.com>
 <1260383350-32681-5-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53203 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756542AbZLIS3e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 13:29:34 -0500
In-Reply-To: <1260383350-32681-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

Enable minimum features to boot omap4430 on es1.0 samples

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |  146 ++++++++++++++++++-------------
 1 files changed, 84 insertions(+), 62 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index a464ca3..49df3ad 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -1,26 +1,29 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.30-rc7
-# Tue Jun  9 12:36:23 2009
+# Linux kernel version: 2.6.32
+# Sun Dec  6 23:37:45 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CLOCKEVENTS=y
-CONFIG_MMU=y
+CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_GENERIC_LOCKBREAK=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_ARCH_HAS_CPUFREQ=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -39,11 +42,12 @@ CONFIG_BSD_PROCESS_ACCT=y
 #
 # RCU Subsystem
 #
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
 # CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_GROUP_SCHED=y
@@ -52,8 +56,7 @@ CONFIG_FAIR_GROUP_SCHED=y
 CONFIG_USER_SCHED=y
 # CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
-# CONFIG_SYSFS_DEPRECATED=y is not set
-# CONFIG_SYSFS_DEPRECATED_V2=y is not set
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
 # CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -70,7 +73,6 @@ CONFIG_UID16=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
@@ -83,6 +85,10 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
 CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLUB_DEBUG=y
 CONFIG_COMPAT_BRK=y
@@ -90,13 +96,16 @@ CONFIG_COMPAT_BRK=y
 CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_USE_GENERIC_SMP_HELPERS=y
 CONFIG_HAVE_CLK=y
+
+#
+# GCOV-based kernel profiling
+#
 # CONFIG_SLOW_WORK is not set
 CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
@@ -110,7 +119,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -131,6 +140,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # System Type
 #
+CONFIG_MMU=y
 # CONFIG_ARCH_AAEC2000 is not set
 # CONFIG_ARCH_INTEGRATOR is not set
 # CONFIG_ARCH_REALVIEW is not set
@@ -142,8 +152,10 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
 # CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_STMP3XXX is not set
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_NOMADIK is not set
 # CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
@@ -166,10 +178,13 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_SA1100 is not set
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_S3C64XX is not set
+# CONFIG_ARCH_S5PC1XX is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_U300 is not set
 # CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
+# CONFIG_ARCH_BCMRING is not set
 
 #
 # TI OMAP Implementations
@@ -190,9 +205,12 @@ CONFIG_ARCH_OMAP4=y
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_32K_TIMER_HZ=128
 CONFIG_OMAP_DM_TIMER=y
-CONFIG_OMAP_LL_DEBUG_UART1=y
+# CONFIG_OMAP_LL_DEBUG_UART1 is not set
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
-# CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_LL_DEBUG_UART3=y
+# CONFIG_OMAP_LL_DEBUG_NONE is not set
+# CONFIG_OMAP_PM_NONE is not set
+CONFIG_OMAP_PM_NOOP=y
 
 #
 # OMAP Board Type
@@ -207,7 +225,7 @@ CONFIG_CPU_32v6K=y
 CONFIG_CPU_V7=y
 CONFIG_CPU_32v7=y
 CONFIG_CPU_ABRT_EV7=y
-CONFIG_CPU_PABRT_IFAR=y
+CONFIG_CPU_PABRT_V7=y
 CONFIG_CPU_CACHE_V7=y
 CONFIG_CPU_CACHE_VIPT=y
 CONFIG_CPU_COPY_V6=y
@@ -222,9 +240,10 @@ CONFIG_CPU_CP15_MMU=y
 # CONFIG_ARM_THUMB is not set
 # CONFIG_ARM_THUMBEE is not set
 # CONFIG_CPU_ICACHE_DISABLE is not set
-CONFIG_CPU_DCACHE_DISABLE=y
+# CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
+CONFIG_ARM_L1_CACHE_SHIFT=5
 # CONFIG_ARM_ERRATA_430973 is not set
 # CONFIG_ARM_ERRATA_458693 is not set
 # CONFIG_ARM_ERRATA_460075 is not set
@@ -245,18 +264,20 @@ CONFIG_ARM_GIC=y
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 CONFIG_SMP=y
 CONFIG_HAVE_ARM_SCU=y
-CONFIG_HAVE_ARM_TWD=y
 CONFIG_VMSPLIT_3G=y
 # CONFIG_VMSPLIT_2G is not set
 # CONFIG_VMSPLIT_1G is not set
 CONFIG_PAGE_OFFSET=0xC0000000
 CONFIG_NR_CPUS=2
 # CONFIG_HOTPLUG_CPU is not set
-CONFIG_LOCAL_TIMERS=y
-# CONFIG_PREEMPT is not set
+# CONFIG_LOCAL_TIMERS is not set
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
 CONFIG_HZ=128
+# CONFIG_THUMB2_KERNEL is not set
 CONFIG_AEABI=y
-# CONFIG_OABI_COMPAT is not set
+CONFIG_OABI_COMPAT=y
 # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
 # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
 # CONFIG_HIGHMEM is not set
@@ -271,10 +292,13 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-# CONFIG_UNEVICTABLE_LRU is not set
 CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
+# CONFIG_UACCESS_WITH_MEMCPY is not set
 
 #
 # Boot options
@@ -298,9 +322,11 @@ CONFIG_CMDLINE="root=/dev/ram0 rw mem=128M console=ttyS0,115200n8 initrd=0x81600
 #
 # At least one emulation must be selected
 #
+# CONFIG_FPE_NWFPE is not set
+# CONFIG_FPE_FASTFPE is not set
 CONFIG_VFP=y
 CONFIG_VFPv3=y
-# CONFIG_NEON is not set
+CONFIG_NEON=y
 
 #
 # Userspace binary formats
@@ -325,6 +351,7 @@ CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # Generic Driver Options
 #
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
@@ -342,6 +369,7 @@ CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=16384
 # CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_MG_DISK is not set
 # CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
@@ -355,6 +383,7 @@ CONFIG_HAVE_IDE=y
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
+# CONFIG_PHONE is not set
 
 #
 # Input device support
@@ -427,6 +456,11 @@ CONFIG_HW_RANDOM=y
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
 # CONFIG_DEBUG_GPIO is not set
@@ -447,11 +481,14 @@ CONFIG_GPIOLIB=y
 #
 # SPI GPIO expanders:
 #
+
+#
+# AC97 GPIO expanders:
+#
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
-# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
 
@@ -472,21 +509,8 @@ CONFIG_SSB_POSSIBLE=y
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
-# CONFIG_VIDEO_MEDIA is not set
-
-#
-# Multimedia drivers
-#
-CONFIG_DAB=y
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
@@ -511,14 +535,17 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
-# CONFIG_ACCESSIBILITY is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
-# CONFIG_REGULATOR is not set
 # CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
 # CONFIG_STAGING is not set
 
 #
@@ -535,9 +562,12 @@ CONFIG_JBD=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
-CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -601,7 +631,6 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 
 #
 # Partition Types
@@ -673,23 +702,24 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-CONFIG_DETECT_SOFTLOCKUP=y
-# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+# CONFIG_DETECT_SOFTLOCKUP is not set
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
 CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
-CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHED_DEBUG is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_SLUB_STATS is not set
+# CONFIG_DEBUG_KMEMLEAK is not set
+# CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -708,31 +738,22 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
 CONFIG_FRAME_POINTER=y
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
 # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_PAGE_POISONING is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
 CONFIG_TRACING_SUPPORT=y
-
-#
-# Tracers
-#
-# CONFIG_FUNCTION_TRACER is not set
-# CONFIG_IRQSOFF_TRACER is not set
-# CONFIG_SCHED_TRACER is not set
-# CONFIG_CONTEXT_SWITCH_TRACER is not set
-# CONFIG_EVENT_TRACER is not set
-# CONFIG_BOOT_TRACER is not set
-# CONFIG_TRACE_BRANCH_PROFILING is not set
-# CONFIG_STACK_TRACER is not set
-# CONFIG_KMEMTRACE is not set
-# CONFIG_WORKQUEUE_TRACER is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_FTRACE is not set
+# CONFIG_BRANCH_PROFILE_NONE is not set
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
@@ -754,7 +775,6 @@ CONFIG_CRYPTO=y
 #
 # Crypto core or helper
 #
-# CONFIG_CRYPTO_FIPS is not set
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_ALGAPI2=y
 CONFIG_CRYPTO_AEAD2=y
@@ -796,11 +816,13 @@ CONFIG_CRYPTO_PCBC=m
 #
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
 
 #
 # Digest
 #
 CONFIG_CRYPTO_CRC32C=y
+# CONFIG_CRYPTO_GHASH is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
-- 
1.6.0.4

