From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/3][RFC]OMAP4: SMP: Enable SMP support for OMAP4430
Date: Tue, 28 Apr 2009 21:27:20 +0530
Message-ID: <1240934240-21769-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45747 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbZD1P51 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Apr 2009 11:57:27 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3SFvL28012541
	for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 10:57:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch enables SMP on OMAP4430 SDP platform.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/Kconfig                        |    4 ++--
 arch/arm/configs/omap_4430sdp_defconfig |    7 ++++++-
 arch/arm/mach-omap2/Makefile            |    3 +++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e02b893..dc9f9fd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -807,7 +807,7 @@ source "kernel/time/Kconfig"
 
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP)
+	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || ARCH_OMAP4)
 	select USE_GENERIC_SMP_HELPERS
 	help
 	  This enables support for systems with more than one CPU. If you have
@@ -864,7 +864,7 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || REALVIEW_EB_A9MP)
+	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || REALVIEW_EB_A9MP || ARCH_OMAP4)
 	default y
 	help
 	  Enable support for local timers on SMP platforms, rather then the
diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 43532bc..fe2690e 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -30,7 +30,7 @@ CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 # General setup
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
@@ -104,6 +104,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -244,6 +245,9 @@ CONFIG_VMSPLIT_3G=y
 # CONFIG_VMSPLIT_2G is not set
 # CONFIG_VMSPLIT_1G is not set
 CONFIG_PAGE_OFFSET=0xC0000000
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_LOCAL_TIMERS=y
 # CONFIG_PREEMPT is not set
 CONFIG_HZ=128
 CONFIG_AEABI=y
@@ -695,6 +699,7 @@ CONFIG_HAVE_FUNCTION_TRACER=y
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
+# CONFIG_ARM_UNWIND is not set
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_ERRORS is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bfb21e0..8fbbb35 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -14,6 +14,9 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(omap-2-3-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
+# SMP support ONLY available for OMAP4
+obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o \
+					   timer-mpu.o
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
-- 
1.5.4.7

