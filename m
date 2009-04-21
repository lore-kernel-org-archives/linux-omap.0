From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/7][RFC] OMAP4: Create architecture macros and config entries.
Date: Tue, 21 Apr 2009 18:38:07 +0530
Message-ID: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977AbZDUNIV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Apr 2009 09:08:21 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3LD8FFm017189
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 08:08:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch creates the architectural macros for OMAP4. The MULTI_OMAP
build is not yet supported by OMAP4.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig           |   16 +++++++++++++++-
 arch/arm/plat-omap/Kconfig            |   10 +++++++---
 arch/arm/plat-omap/include/mach/cpu.h |   17 +++++++++++++++--
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 64ab386..a28eb30 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -24,8 +24,18 @@ config ARCH_OMAP3430
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 	select ARCH_OMAP_OTG
 
+config ARCH_OMAP44XX
+	bool "OMAP44xx Based System"
+	depends on ARCH_OMAP4
+
+config ARCH_OMAP4430
+	bool "OMAP4430 support"
+	depends on ARCH_OMAP4 && ARCH_OMAP44XX
+	select ARM_GIC
+
+
 comment "OMAP Board Type"
-	depends on ARCH_OMAP2 || ARCH_OMAP3
+	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
 
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
@@ -67,3 +77,7 @@ config MACH_OMAP_3430SDP
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
+config MACH_OMAP_4430SDP
+	bool "OMAP 4430 SDP board"
+	depends on ARCH_OMAP4 && ARCH_OMAP44XX
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 9dd68fa..e2086d4 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -23,6 +23,10 @@ config ARCH_OMAP3
 	select CPU_V7
 	select COMMON_CLKDEV
 
+config ARCH_OMAP4
+	bool "TI OMAP4"
+	select CPU_V7
+
 endchoice
 
 comment "OMAP Feature Selections"
@@ -128,13 +132,13 @@ config OMAP_MPU_TIMER
 
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX || ARCH_OMAP44XX
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
 	  support for no tick during idle. The 32KHz timer provides less
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
-	  currently only available for OMAP16XX, 24XX and 34XX.
+	  currently only available for OMAP16XX, 24XX, 34XX and 44XX.
 
 endchoice
 
@@ -149,7 +153,7 @@ config OMAP_32K_TIMER_HZ
 
 config OMAP_DM_TIMER
 	bool "Use dual-mode timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX || ARCH_OMAP44XX
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 98b1442..7920d6a 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -155,6 +155,8 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 #define cpu_is_omap243x()		0
 #define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
+#define cpu_is_omap44xx()		0
+#define cpu_is_omap443x()		0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -348,12 +350,21 @@ IS_OMAP_TYPE(3430, 0x3430)
 # define cpu_is_omap3430()		is_omap3430()
 #endif
 
+# if defined(CONFIG_ARCH_OMAP44XX)
+# undef cpu_is_omap44xx
+# undef cpu_is_omap443x
+# define cpu_is_omap44xx()		1
+# define cpu_is_omap443x()		1
+# endif
+
 /* Macros to detect if we have OMAP1 or OMAP2 */
 #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
-#define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx())
+#define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
+				cpu_is_omap44xx())
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+			defined(CONFIG_ARCH_OMAP4)
 
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
@@ -370,6 +381,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES3_0	0x34303034
 #define OMAP3430_REV_ES3_1	0x34304034
 
+#define OMAP443X_CLASS		0x44300034
+
 /*
  * omap_chip bits
  *
-- 
1.5.4.7

