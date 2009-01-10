From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/3] Runitme check for OMAP35x
Date: Sun, 11 Jan 2009 01:30:54 +0530
Message-ID: <1231617654-18729-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55797 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbZAJUBE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jan 2009 15:01:04 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0AK0sEB010819
	for <linux-omap@vger.kernel.org>; Sat, 10 Jan 2009 14:01:00 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Added runtime check via omap2_set_globals_35xx()

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/plat-omap/common.c              |   68 +++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/common.h |    1 +
 arch/arm/plat-omap/include/mach/cpu.h    |   88 +++++++++++++++++++++++++++++-
 3 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 8c53125..7861a25 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -333,3 +333,71 @@ void __init omap2_set_globals_343x(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_OMAP35XX)
+
+#if defined(CONFIG_ARCH_OMAP3503)
+static struct omap_globals omap3503_globals = {
+	.class	= OMAP35XX_CLASS,
+	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+#endif	/* if defined(CONFIG_ARCH_OMAP3503) */
+
+#if defined(CONFIG_ARCH_OMAP3515)
+static struct omap_globals omap3515_globals = {
+	.class	= OMAP35XX_CLASS,
+	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+#endif	/* if defined(CONFIG_ARCH_OMAP3515) */
+
+#if defined(CONFIG_ARCH_OMAP3525)
+static struct omap_globals omap3525_globals = {
+	.class	= OMAP35XX_CLASS,
+	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+#endif	/* if defined(CONFIG_ARCH_OMAP3525) */
+
+#if defined(CONFIG_ARCH_OMAP3530)
+static struct omap_globals omap3530_globals = {
+	.class	= OMAP35XX_CLASS,
+	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+#endif	/* if defined(CONFIG_ARCH_OMAP3530) */
+
+void __init omap2_set_globals_35xx(void)
+{
+#if defined(CONFIG_ARCH_OMAP3503)
+	omap2_globals = &omap3503_globals;
+#endif
+#if defined(CONFIG_ARCH_OMAP3515)
+	omap2_globals = &omap3515_globals;
+#endif
+#if defined(CONFIG_ARCH_OMAP3525)
+	omap2_globals = &omap3525_globals;
+#endif
+#if defined(CONFIG_ARCH_OMAP3530)
+	omap2_globals = &omap3530_globals;
+#endif
+
+	__omap2_set_globals();
+}
+#endif	/* if defined(CONFIG_ARCH_OMAP35XX) */
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index af4105f..f41cba2 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -60,6 +60,7 @@ struct omap_globals {
 void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_343x(void);
+void omap2_set_globals_35xx(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index b2062f1..f583042 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -93,7 +93,7 @@ unsigned int omap_rev(void);
 #  define OMAP_NAME omap2430
 # endif
 #endif
-#ifdef CONFIG_ARCH_OMAP3430
+#if defined(CONFIG_ARCH_OMAP3430) && !defined(CONFIG_ARCH_OMAP35XX)
 # ifdef OMAP_NAME
 #  undef  MULTI_OMAP2
 #  define MULTI_OMAP2
@@ -102,6 +102,46 @@ unsigned int omap_rev(void);
 # endif
 #endif
 
+#ifdef CONFIG_ARCH_OMAP35XX
+# ifdef CONFIG_ARCH_OMAP3503
+#  ifdef OMAP_NAME
+#   undef  MULTI_OMAP2
+#   define MULTI_OMAP2
+#  else
+#   define OMAP_NAME omap3503
+#  endif
+# endif  /* ifdef CONFIG_ARCH_OMAP3503 */
+
+# ifdef CONFIG_ARCH_OMAP3515
+#  ifdef OMAP_NAME
+#   undef  MULTI_OMAP2
+#   define MULTI_OMAP2
+#  else
+#   define OMAP_NAME omap3515
+#  endif
+# endif  /* ifdef CONFIG_ARCH_OMAP3515 */
+
+# ifdef CONFIG_ARCH_OMAP3525
+#  ifdef OMAP_NAME
+#   undef  MULTI_OMAP2
+#   define MULTI_OMAP2
+#  else
+#   define OMAP_NAME omap3525
+#  endif
+# endif  /* ifdef CONFIG_ARCH_OMAP3525 */
+
+# ifdef CONFIG_ARCH_OMAP3530
+#  ifdef OMAP_NAME
+#   undef  MULTI_OMAP2
+#   define MULTI_OMAP2
+#  else
+#   define OMAP_NAME omap3530
+#  endif
+# endif  /* ifdef CONFIG_ARCH_OMAP3530 */
+
+#endif  /* ifdef CONFIG_ARCH_OMAP35XX */
+
+
 /*
  * Macros to group OMAP into cpu classes.
  * These can be used in most places.
@@ -112,6 +152,7 @@ unsigned int omap_rev(void);
  * cpu_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
+ * cpu_is_omap35xx():	True for OMAP35XX
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)
 
@@ -147,6 +188,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 #define cpu_is_omap243x()		0
 #define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
+#define cpu_is_omap35xx()		0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -191,6 +233,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 #  define cpu_is_omap34xx()		is_omap34xx()
 #  define cpu_is_omap343x()		is_omap343x()
 # endif
+# if defined(CONFIG_ARCH_OMAP35XX)
+#  undef  cpu_is_omap35xx
+#  define cpu_is_omap35xx()		is_omap35xx()
+# endif
 #else
 # if defined(CONFIG_ARCH_OMAP24XX)
 #  undef  cpu_is_omap24xx
@@ -212,6 +258,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 #  undef  cpu_is_omap343x
 #  define cpu_is_omap343x()		1
 # endif
+# if defined(CONFIG_ARCH_OMAP35XX)
+#  undef  cpu_is_omap35xx
+#  define cpu_is_omap35xx()		1
+# endif
 #endif
 
 /*
@@ -230,7 +280,11 @@ IS_OMAP_SUBCLASS(343x, 0x343)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
- */
+ * cpu_is_omap3503():	True for OMAP3503
+ * cpu_is_omap3515():	True for OMAP3515
+ * cpu_is_omap3525():	True for OMAP3525
+ * cpu_is_omap3530():	True for OMAP3530
+ */;
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
 #define IS_OMAP_TYPE(type, id)				\
@@ -252,6 +306,10 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
+IS_OMAP_TYPE(3503, 0x3430)
+IS_OMAP_TYPE(3515, 0x3430)
+IS_OMAP_TYPE(3525, 0x3430)
+IS_OMAP_TYPE(3530, 0x3430)
 
 #define cpu_is_omap310()		0
 #define cpu_is_omap730()		0
@@ -266,6 +324,10 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
 #define cpu_is_omap3430()		0
+#define cpu_is_omap3503()		0
+#define cpu_is_omap3515()		0
+#define cpu_is_omap3525()		0
+#define cpu_is_omap3530()		0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -319,6 +381,26 @@ IS_OMAP_TYPE(3430, 0x3430)
 # define cpu_is_omap3430()		is_omap3430()
 #endif
 
+#if defined(CONFIG_ARCH_OMAP35XX)
+# undef cpu_is_omap3503
+# undef cpu_is_omap3515
+# undef cpu_is_omap3525
+# undef cpu_is_omap3530
+
+# if defined(CONFIG_ARCH_OMAP3503)
+#  define cpu_is_omap3503()		1
+# endif
+# if defined(CONFIG_ARCH_OMAP3515)
+#  define cpu_is_omap3515()		1
+# endif
+# if defined(CONFIG_ARCH_OMAP3525)
+#  define cpu_is_omap3525()		1
+# endif
+# if defined(CONFIG_ARCH_OMAP3525)
+#  define cpu_is_omap3530()		1
+# endif
+#endif	/* if defined(CONFIG_ARCH_OMAP35XX) */
+
 /* Macros to detect if we have OMAP1 or OMAP2 */
 #define cpu_class_is_omap1()	(cpu_is_omap730() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
@@ -340,6 +422,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES2_1	0x34302034
 #define OMAP3430_REV_ES3_0	0x34303034
 
+#define OMAP35XX_CLASS		0x34300000
+
 /*
  * omap_chip bits
  *
-- 
1.5.6
