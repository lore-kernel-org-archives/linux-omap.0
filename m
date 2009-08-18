From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Runtime detection of OMAP35x devices
Date: Tue, 18 Aug 2009 21:45:50 +0530
Message-ID: <1250612150-16345-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50166 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861AbZHRQP6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Aug 2009 12:15:58 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7IGFqso021526
	for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 11:15:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Add runtime check for these OMAP35x variations
based on the detected Si features:
  OMAP3503, OMAP3515, OMAP3525 and OMA3530.

Also, delayed the call to pr_info() into actual
variant is detected in omap3_cpuinfo()

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c              |   59 +++++++++++++++++++++++++++-----
 arch/arm/plat-omap/include/mach/cpu.h |   25 ++++++++++++++
 2 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 03b80f2..f041d3b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -187,7 +187,6 @@ void __init omap3_check_revision(void)
 	u32 cpuid, idcode;
 	u16 hawkeye;
 	u8 rev;
-	char *rev_name = "ES1.0";
 
 	/*
 	 * We cannot access revision registers on ES1.0.
@@ -197,7 +196,7 @@ void __init omap3_check_revision(void)
 	cpuid = read_cpuid(CPUID_ID);
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
 		omap_revision = OMAP3430_REV_ES1_0;
-		goto out;
+		return;
 	}
 
 	/*
@@ -214,29 +213,21 @@ void __init omap3_check_revision(void)
 		switch (rev) {
 		case 0:
 			omap_revision = OMAP3430_REV_ES2_0;
-			rev_name = "ES2.0";
 			break;
 		case 2:
 			omap_revision = OMAP3430_REV_ES2_1;
-			rev_name = "ES2.1";
 			break;
 		case 3:
 			omap_revision = OMAP3430_REV_ES3_0;
-			rev_name = "ES3.0";
 			break;
 		case 4:
 			omap_revision = OMAP3430_REV_ES3_1;
-			rev_name = "ES3.1";
 			break;
 		default:
 			/* Use the latest known revision as default */
 			omap_revision = OMAP3430_REV_ES3_1;
-			rev_name = "Unknown revision\n";
 		}
 	}
-
-out:
-	pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
 }
 
 #define OMAP3_SHOW_FEATURE(feat)		\
@@ -248,6 +239,54 @@ out:
 
 void __init omap3_cpuinfo(void)
 {
+	u8 rev = GET_OMAP_REVISION();
+	char cpu_name[16], cpu_rev[16];
+
+	/* OMAP3430 and OMAP3530 are assumed to be same.
+	 *
+	 * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
+	 * on available features. Upon detection, update the CPU id
+	 * and CPU class bits.
+	 */
+	if (omap3_has_iva() && omap3_has_sgx()) {
+		strcpy(cpu_name, "3430/3530");
+	}
+	else if (omap3_has_sgx()) {
+		omap_revision = OMAP3525_REV (rev);
+		strcpy(cpu_name, "3525");
+	}
+	else if (omap3_has_iva()) {
+		omap_revision = OMAP3515_REV (rev);
+		strcpy(cpu_name, "3515");
+	}
+	else {
+		omap_revision = OMAP3503_REV (rev);
+		strcpy(cpu_name, "3503");
+	}
+
+	switch (rev) {
+	case 0x10:
+		strcpy(cpu_rev, "2.0");
+		break;
+	case 0x20:
+		strcpy(cpu_rev, "2.1");
+		break;
+	case 0x30:
+		strcpy(cpu_rev, "3.0");
+		break;
+	case 0x40:
+		strcpy(cpu_rev, "3.1");
+		break;
+	default:
+		/* Use the latest known revision as default */
+		strcpy(cpu_rev, "3.1");
+	}
+
+	/*
+	 * Print verbose information
+	 */
+	pr_info("OMAP%s ES%s\n", cpu_name, cpu_rev);
+
 	OMAP3_SHOW_FEATURE(l2cache);
 	OMAP3_SHOW_FEATURE(iva);
 	OMAP3_SHOW_FEATURE(sgx);
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 4a04f77..a0dbbb4 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -57,6 +57,11 @@ struct omap_chip_id {
 unsigned int omap_rev(void);
 
 /*
+ * Get the CPU revision for OMAP devices
+ */
+#define GET_OMAP_REVISION()	((omap_rev() >> 8) & 0xff)
+
+/*
  * Test if multicore OMAP support is needed
  */
 #undef MULTI_OMAP1
@@ -360,7 +365,21 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #if defined(CONFIG_ARCH_OMAP34XX)
 # undef cpu_is_omap3430
+# undef cpu_is_omap3503
+# undef cpu_is_omap3515
+# undef cpu_is_omap3525
+# undef cpu_is_omap3530
 # define cpu_is_omap3430()		is_omap3430()
+# define cpu_is_omap3503		(cpu_is_omap3430() &		\
+						(!omap3_has_iva()) &	\
+						(!omap3_has_sgx()))
+# define cpu_is_omap3515		(cpu_is_omap3430() &		\
+						(omap3_has_iva()) &	\
+						(!omap3_has_sgx()))
+# define cpu_is_omap3525		(cpu_is_omap3430() &		\
+						(omap3_has_sgx()) &	\
+						(!omap3_has_iva()))
+# define cpu_is_omap3530		(cpu_is_omap3430())
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
@@ -391,6 +410,12 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES3_0	0x34303034
 #define OMAP3430_REV_ES3_1	0x34304034
 
+#define OMAP35XX_CLASS		0x35000034
+#define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 12))
+#define OMAP3515_REV(v)		(OMAP35XX_CLASS | (0x3515 << 16) | (v << 12))
+#define OMAP3525_REV(v)		(OMAP35XX_CLASS | (0x3525 << 16) | (v << 12))
+#define OMAP3530_REV(v)		(OMAP35XX_CLASS | (0x3530 << 16) | (v << 12))
+
 #define OMAP443X_CLASS		0x44300034
 
 /*
-- 
1.6.2.2

