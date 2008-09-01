From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/3] Runtime check for OMAP35x
Date: Tue,  2 Sep 2008 01:27:46 +0530
Message-ID: <1220299067-17307-2-git-send-email-premi@ti.com>
References: <1220299067-17307-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44899 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbYIAT56 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2008 15:57:58 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81JvnIN005141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 14:57:57 -0500
In-Reply-To: <1220299067-17307-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Based on earlier review comments, added runtime
check of the OMAP35x via omap2_set_globasl_3503() etc.
---
 arch/arm/plat-omap/common.c        |   76 ++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/common.h |    4 ++
 include/asm-arm/arch-omap/cpu.h    |   79 ++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 3a5f05e..f8b04cc 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -334,3 +334,79 @@ void __init omap2_set_globals_343x(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_OMAP3503)
+
+static struct omap_globals omap3503_globals = {
+	.class	= OMAP35XX_CLASS,
+	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+
+void __init omap2_set_globals_3503(void)
+{
+	omap2_globals = &omap3503_globals;
+	__omap2_set_globals();
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3515)
+
+static struct omap_globals omap3515_globals = {
+	.class	= OMAP35XX_CLASS,
+	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+
+void __init omap2_set_globals_3515(void)
+{
+	omap2_globals = &omap3515_globals;
+	__omap2_set_globals();
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3525)
+
+static struct omap_globals omap3525_globals = {
+	.class	= OMAP35XX_CLASS,
+	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+
+void __init omap2_set_globals_3525(void)
+{
+	omap2_globals = &omap3525_globals;
+	__omap2_set_globals();
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3530)
+
+static struct omap_globals omap3530_globals = {
+	.class	= OMAP35XX_CLASS,
+	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= (__force void __iomem *)OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+
+void __init omap2_set_globals_3530(void)
+{
+	omap2_globals = &omap3530_globals;
+	__omap2_set_globals();
+}
+#endif
+
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index 8a525ed..9bdb353 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -62,6 +62,10 @@ struct omap_globals {
 void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_343x(void);
+void omap2_set_globals_3503(void);
+void omap2_set_globals_3515(void);
+void omap2_set_globals_3525(void);
+void omap2_set_globals_3535(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
diff --git a/include/asm-arm/arch-omap/cpu.h b/include/asm-arm/arch-omap/cpu.h
index 33f26e9..bbe69ce 100644
--- a/include/asm-arm/arch-omap/cpu.h
+++ b/include/asm-arm/arch-omap/cpu.h
@@ -97,6 +97,45 @@ extern unsigned int system_rev;
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
 /*
  * Macros to group OMAP into cpu classes.
  * These can be used in most places.
@@ -107,6 +146,7 @@ extern unsigned int system_rev;
  * cpu_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
+ * cpu_is_omap35x():	True for OMAP35x
  */
 #define GET_OMAP_CLASS	((system_rev >> 24) & 0xff)
 
@@ -142,6 +182,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 #define cpu_is_omap243x()		0
 #define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
+#define cpu_is_omap35xx()		0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -186,6 +227,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
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
@@ -225,6 +270,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
+ * cpu_is_omap3503():	True for OMAP3503
+ * cpu_is_omap3515():	True for OMAP3515
+ * cpu_is_omap3525():	True for OMAP3525
+ * cpu_is_omap3530():	True for OMAP3530
  */
 #define GET_OMAP_TYPE	((system_rev >> 16) & 0xffff)
 
@@ -247,6 +296,10 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
+IS_OMAP_TYPE(3503, 0x3430)
+IS_OMAP_TYPE(3515, 0x3430)
+IS_OMAP_TYPE(3525, 0x3430)
+IS_OMAP_TYPE(3530, 0x3430)
 
 #define cpu_is_omap310()		0
 #define cpu_is_omap730()		0
@@ -261,6 +314,10 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
 #define cpu_is_omap3430()		0
+#define cpu_is_omap3503()		0
+#define cpu_is_omap3515()		0
+#define cpu_is_omap3525()		0
+#define cpu_is_omap3530()		0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -314,6 +371,26 @@ IS_OMAP_TYPE(3430, 0x3430)
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
@@ -359,6 +436,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES2_1	0x34302000
 #define OMAP3430_REV_ES2_2	0x34303000
 
+#define OMAP35XX_CLASS		0x34300000
+
 /*
  * omap_chip bits
  *
-- 
1.5.6
