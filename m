From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/4] ARM: OMAP4: SMP: Enable SMP support for OMAP4430
Date: Wed, 27 May 2009 21:56:17 +0530
Message-ID: <1243441577-27012-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32769 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761835AbZE0Q0k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2009 12:26:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch enables SMP on OMAP4430 SDP platform.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/Kconfig             |    8 ++++----
 arch/arm/mach-omap2/Makefile |    4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 93d63bf..5468a32 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -858,10 +858,10 @@ source "kernel/time/Kconfig"
 
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP)
+	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP ||ARCH_OMAP4)
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
-	select HAVE_ARM_SCU if ARCH_REALVIEW
+	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4)
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -929,9 +929,9 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || REALVIEW_EB_A9MP)
+	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || REALVIEW_EB_A9MP || ARCH_OMAP4)
 	default y
-	select HAVE_ARM_TWD if ARCH_REALVIEW
+	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a51d811..d9175d4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -14,6 +14,10 @@ obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
+# SMP support ONLY available for OMAP4
+obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
+obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
+
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
-- 
1.5.4.7

