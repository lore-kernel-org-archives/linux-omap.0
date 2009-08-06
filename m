From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 3/6] OMAP3: Add runtime check for OMAP35x
Date: Thu,  6 Aug 2009 16:06:07 +0530
Message-ID: <1249554967-20394-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36690 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbZHFKgQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 06:36:16 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n76AaAp2008525
	for <linux-omap@vger.kernel.org>; Thu, 6 Aug 2009 05:36:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Added runtime check via omap2_set_globals_35xx().

Parts of this patch have been derived from an earlier
earlier patch submitted by Tony Lindgren <tony@atomide.com>

 [1] http://marc.info/?l=linux-omap&m=123301852702797&w=2
 [2] http://marc.info/?l=linux-omap&m=123334055822212&w=2

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c                 |  115 ++++++++++++++++++++++++------
 arch/arm/plat-omap/common.c              |   18 +++++-
 arch/arm/plat-omap/include/mach/common.h |    1 +
 arch/arm/plat-omap/include/mach/cpu.h    |   64 ++++++++++++++++-
 4 files changed, 173 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a98201c..06770aa 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -28,6 +28,14 @@
 static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
+/* The new OMAP35x devices have assymetric names - OMAP3505 and OMAP3517.
+ * It is not possible to define a common macro to identify them.
+ *
+ * A quick way is to separate them across 'generations' as below.
+ */
+#define OMAP35XX_G1	0x1	/* Applies to 3503, 3515, 3525 and 3530 */
+#define OMAP35XX_G2	0x2	/* Applies to 3505 and 3517 */
+
 
 unsigned int omap_rev(void)
 {
@@ -155,12 +163,71 @@ void __init omap24xx_check_revision(void)
 	pr_info("\n");
 }
 
+static void __init omap34xx_set_revision(u8 rev, char *rev_name)
+{
+	switch (rev) {
+	case 0:
+		omap_revision = OMAP3430_REV_ES2_0;
+		strcat(rev_name, "ES2.0");
+		break;
+	case 2:
+		omap_revision = OMAP3430_REV_ES2_1;
+		strcat(rev_name, "ES2.1");
+		break;
+	case 3:
+		omap_revision = OMAP3430_REV_ES3_0;
+		strcat(rev_name, "ES3.0");
+		break;
+	case 4:
+		omap_revision = OMAP3430_REV_ES3_1;
+		strcat(rev_name, "ES3.1");
+		break;
+	default:
+		/* Use the latest known revision as default */
+		omap_revision = OMAP3430_REV_ES3_1;
+		strcat(rev_name, "Unknown revision");
+	}
+}
+
+static void __init omap35xx_set_revision(u8 rev, u8 gen, char *rev_name)
+{
+	omap_revision = OMAP35XX_CLASS ;
+
+	if (gen == OMAP35XX_G1) {
+		switch (rev) {
+		case 0:	/* Take care of some older boards */
+		case 1:
+			omap_revision |= OMAP35XX_MASK_ES2_0;
+			strcat(rev_name, "ES2.0");
+			break;
+		case 2:
+			omap_revision |= OMAP35XX_MASK_ES2_1;
+			strcat(rev_name, "ES2.1");
+			break;
+		case 3:
+			omap_revision |= OMAP35XX_MASK_ES3_0;
+			strcat(rev_name, "ES3.0");
+			break;
+		case 4:
+			omap_revision |= OMAP35XX_MASK_ES3_1;
+			strcat(rev_name, "ES3.1");
+			break;
+		default:
+			/* Use the latest known revision as default */
+			omap_revision |= OMAP35XX_MASK_ES3_0;
+			strcat(rev_name, "Unknown revision");
+		}
+	} else {
+		strcat(rev_name, "ES1.0");
+	}
+}
+
 void __init omap34xx_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
 	u8 rev;
-	char *rev_name = "ES1.0";
+	char rev_name[16] = "";
 
 	/*
 	 * We cannot access revision registers on ES1.0.
@@ -184,28 +251,12 @@ void __init omap34xx_check_revision(void)
 	rev = (idcode >> 28) & 0xff;
 
 	if (hawkeye == 0xb7ae) {
-		switch (rev) {
-		case 0:
-			omap_revision = OMAP3430_REV_ES2_0;
-			rev_name = "ES2.0";
-			break;
-		case 2:
-			omap_revision = OMAP3430_REV_ES2_1;
-			rev_name = "ES2.1";
-			break;
-		case 3:
-			omap_revision = OMAP3430_REV_ES3_0;
-			rev_name = "ES3.0";
-			break;
-		case 4:
-			omap_revision = OMAP3430_REV_ES3_1;
-			rev_name = "ES3.1";
-			break;
-		default:
-			/* Use the latest known revision as default */
-			omap_revision = OMAP3430_REV_ES3_1;
-			rev_name = "Unknown revision\n";
-		}
+		if (cpu_is_omap35xx())
+			omap35xx_set_revision(rev, OMAP35XX_G1, rev_name);
+		else
+			omap34xx_set_revision(rev, rev_name);
+	} else if (hawkeye == 0xb868) {
+		omap35xx_set_revision(rev, OMAP35XX_G2, rev_name);
 	}
 
 out:
@@ -241,6 +292,24 @@ void __init omap2_check_revision(void)
 	} else if (cpu_is_omap242x()) {
 		/* Currently only supports 2420ES2.1.1 and 2420-all */
 		omap_chip.oc |= CHIP_IS_OMAP2420;
+	} else if (cpu_is_omap35xx()) {
+		/*
+		 * FIXME : Update for OMAP35XX_G2
+		 */
+		omap_chip.oc = CHIP_IS_OMAP3430;
+
+		switch (omap35xx_rev_mask())
+		{
+		case OMAP35XX_MASK_ES3_0:
+			omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
+			break;
+		case OMAP35XX_MASK_ES3_1:
+			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
+			break;
+		default:
+			/* Use ES2 as default */
+			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
+		}
 	} else if (cpu_is_omap343x()) {
 		omap_chip.oc = CHIP_IS_OMAP3430;
 		if (omap_rev() == OMAP3430_REV_ES1_0)
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index ebcf006..2e956cd 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -347,7 +347,7 @@ void __init omap2_set_globals_243x(void)
 }
 #endif
 
-#if defined(CONFIG_ARCH_OMAP3430)
+#if defined(CONFIG_ARCH_OMAP3430) && !defined(CONFIG_ARCH_OMAP35XX)
 
 static struct omap_globals omap343x_globals = {
 	.class	= OMAP343X_CLASS,
@@ -381,3 +381,19 @@ void __init omap2_set_globals_443x(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP35XX
+static struct omap_globals omap35xx_globals = {
+	.class	= OMAP35XX_CLASS,
+	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
+	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+};
+
+void __init omap2_set_globals_35xx(void)
+{
+	__omap2_set_globals(&omap35xx_globals);
+}
+#endif	/* CONFIG_ARCH_OMAP35XX */
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index fdeab42..28830f2 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -60,6 +60,7 @@ struct omap_globals {
 void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_343x(void);
+void omap2_set_globals_35xx(void);
 void omap2_set_globals_443x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 285eaa3..94a5cbb 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -116,7 +116,7 @@ unsigned int omap_rev(void);
 #  define OMAP_NAME omap2430
 # endif
 #endif
-#ifdef CONFIG_ARCH_OMAP3430
+#if defined(CONFIG_ARCH_OMAP3430) && !defined(CONFIG_ARCH_OMAP35XX)
 # ifdef OMAP_NAME
 #  undef  MULTI_OMAP2
 #  define MULTI_OMAP2
@@ -124,6 +124,14 @@ unsigned int omap_rev(void);
 #  define OMAP_NAME omap3430
 # endif
 #endif
+#ifdef CONFIG_ARCH_OMAP35XX
+# ifdef OMAP_NAME
+#   undef  MULTI_OMAP2
+#   define MULTI_OMAP2
+# else
+#   define OMAP_NAME omap35xx
+# endif
+#endif  /* ifdef CONFIG_ARCH_OMAP35XX */
 
 /*
  * Macros to group OMAP into cpu classes.
@@ -135,6 +143,8 @@ unsigned int omap_rev(void);
  * cpu_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
+ * cpu_is_omap35xx():	True for OMAP3503, OMAP3515, OMAP3525, OMAP3530,
+ *                      OMAP355, OMAP3517
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)
 
@@ -170,6 +180,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 #define cpu_is_omap243x()		0
 #define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
+#define cpu_is_omap35xx()		0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 
@@ -224,6 +235,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
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
@@ -245,6 +260,10 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 #  undef  cpu_is_omap343x
 #  define cpu_is_omap343x()		1
 # endif
+# if defined(CONFIG_ARCH_OMAP35XX)
+#  undef  cpu_is_omap35xx
+#  define cpu_is_omap35xx()		1
+# endif
 #endif
 
 /*
@@ -264,6 +283,12 @@ IS_OMAP_SUBCLASS(343x, 0x343)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
+ * cpu_is_omap3503():	True for OMAP3503
+ * cpu_is_omap3515():	True for OMAP3515
+ * cpu_is_omap3525():	True for OMAP3525
+ * cpu_is_omap3530():	True for OMAP3530
+ * cpu_is_omap3505():	True for OMAP3505
+ * cpu_is_omap3517():	True for OMAP3517
  */
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
@@ -287,6 +312,12 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
+IS_OMAP_TYPE(3503, 0x3503)
+IS_OMAP_TYPE(3515, 0x3515)
+IS_OMAP_TYPE(3525, 0x3525)
+IS_OMAP_TYPE(3530, 0x3530)
+IS_OMAP_TYPE(3505, 0x3505)
+IS_OMAP_TYPE(3517, 0x3517)
 
 #define cpu_is_omap310()		0
 #define cpu_is_omap730()		0
@@ -372,6 +403,22 @@ IS_OMAP_TYPE(3430, 0x3430)
 # define cpu_is_omap443x()		1
 # endif
 
+#if defined(CONFIG_ARCH_OMAP35XX)
+# undef cpu_is_omap3503
+# undef cpu_is_omap3515
+# undef cpu_is_omap3525
+# undef cpu_is_omap3530
+# undef cpu_is_omap3505
+# undef cpu_is_omap3517
+
+# define cpu_is_omap3503()		is_omap3503()
+# define cpu_is_omap3515()		is_omap3515()
+# define cpu_is_omap3525()		is_omap3525()
+# define cpu_is_omap3530()		is_omap3530()
+# define cpu_is_omap3505()		is_omap3505()
+# define cpu_is_omap3517()		is_omap3517()
+#endif	/* if defined(CONFIG_ARCH_OMAP35XX) */
+
 /* Macros to detect if we have OMAP1 or OMAP2 */
 #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
@@ -398,6 +445,21 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #define OMAP443X_CLASS		0x44300034
 
+#define OMAP35XX_CLASS		0x35000035
+#define OMAP3503_MASK		0x00030000
+#define OMAP3515_MASK		0x00150000
+#define OMAP3525_MASK		0x00250000
+#define OMAP3530_MASK		0x00300000
+#define OMAP3505_MASK		0x00050000
+#define OMAP3517_MASK		0x00170000
+
+#define OMAP35XX_MASK_ES2_0	0x00001000
+#define OMAP35XX_MASK_ES2_1	0x00002000
+#define OMAP35XX_MASK_ES3_0	0x00003000
+#define OMAP35XX_MASK_ES3_1	0x00004000
+
+#define omap35xx_rev_mask()	(omap_rev() & 0x0000F000)
+
 /*
  * omap_chip bits
  *
-- 
1.6.2.2

