From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 1/6] TI816X: Create architecture macros and config entries
Date: Sat, 31 Jul 2010 02:21:27 +0530
Message-ID: <1280523087-25004-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59973 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab0G3Uvc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jul 2010 16:51:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch creates the architectural macros and configuration entries for
TI816X.

Also enables multi-omap build for TI816X.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/Kconfig             |    6 ++++++
 arch/arm/plat-omap/Kconfig              |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h   |   29 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/multi.h |    8 ++++++++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b48bacf..3a91a10 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,6 +44,12 @@ config ARCH_OMAP4
 	select CPU_V7
 	select ARM_GIC
 
+config ARCH_TI816X
+	bool "TI 816X"
+	depends on ARCH_OMAP2PLUS
+	default y
+	select CPU_V7
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e2ed952..1844da6 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -19,7 +19,7 @@ config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4"
 	select COMMON_CLKDEV
 	help
-	  "Systems based on omap24xx, omap34xx or omap44xx"
+	  "Systems based on omap24xx, omap34xx, omap44xx or ti816x"
 
 endchoice
 
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index aa2f4f0..a7d99ad 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -87,6 +87,7 @@ unsigned int omap_rev(void);
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
  * cpu_is_omap443x():	True for OMAP4430
+ * cpu_is_ti816x():	True for TI8168
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)
 
@@ -96,6 +97,12 @@ static inline int is_omap ##class (void)		\
 	return (GET_OMAP_CLASS == (id)) ? 1 : 0;	\
 }
 
+#define IS_TI_CLASS(class, id)				\
+static inline int is_ti ##class(void)			\
+{							\
+	return (GET_OMAP_CLASS == (id)) ? 1 : 0;	\
+}
+
 #define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)
 
 #define IS_OMAP_SUBCLASS(subclass, id)			\
@@ -104,6 +111,12 @@ static inline int is_omap ##subclass (void)		\
 	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
 }
 
+#define IS_TI_SUBCLASS(subclass, id)			\
+static inline int is_ti ##subclass(void)		\
+{							\
+	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
+}
+
 IS_OMAP_CLASS(7xx, 0x07)
 IS_OMAP_CLASS(15xx, 0x15)
 IS_OMAP_CLASS(16xx, 0x16)
@@ -111,12 +124,16 @@ IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_CLASS(44xx, 0x44)
 
+IS_TI_CLASS(81xx, 0x81)
+
 IS_OMAP_SUBCLASS(242x, 0x242)
 IS_OMAP_SUBCLASS(243x, 0x243)
 IS_OMAP_SUBCLASS(343x, 0x343)
 IS_OMAP_SUBCLASS(363x, 0x363)
 IS_OMAP_SUBCLASS(443x, 0x443)
 
+IS_TI_SUBCLASS(816x, 0x816)
+
 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
 #define cpu_is_omap16xx()		0
@@ -127,6 +144,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #define cpu_is_omap343x()		0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
+#define cpu_is_ti816x()			0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -353,11 +371,16 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap443x()		is_omap443x()
 # endif
 
+# if defined(CONFIG_ARCH_TI816X)
+# undef cpu_is_ti816x
+# define cpu_is_ti816x()		is_ti816x()
+# endif
+
 /* Macros to detect if we have OMAP1 or OMAP2 */
 #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
 #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
-				cpu_is_omap44xx())
+				cpu_is_omap44xx() || cpu_is_ti816x())
 
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
@@ -388,6 +411,9 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	0x44300044
 
+#define TI816X_CLASS		0x81600081
+#define TI8168_REV_ES1_0	0x81600081
+
 /*
  * omap_chip bits
  *
@@ -411,6 +437,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
 #define CHIP_IS_OMAP3630ES1		(1 << 7)
 #define CHIP_IS_OMAP4430ES1		(1 << 8)
+#define CHIP_IS_TI816X			(1 << 9)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
diff --git a/arch/arm/plat-omap/include/plat/multi.h b/arch/arm/plat-omap/include/plat/multi.h
index ffd909f..c9601f1 100644
--- a/arch/arm/plat-omap/include/plat/multi.h
+++ b/arch/arm/plat-omap/include/plat/multi.h
@@ -98,5 +98,13 @@
 #  define OMAP_NAME omap4
 # endif
 #endif
+#ifdef CONFIG_ARCH_TI816X
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME ti816x
+# endif
+#endif
 
 #endif	/* __PLAT_OMAP_MULTI_H */
-- 
1.6.2.4

