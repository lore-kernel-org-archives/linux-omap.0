From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2 1/1] Runtime detection of OMAP35x devices
Date: Sat, 10 Oct 2009 01:17:48 +0530
Message-ID: <1255117668-28109-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46482 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbZJITs3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Oct 2009 15:48:29 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n99JlnHg024149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Oct 2009 14:47:52 -0500
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
 arch/arm/mach-omap2/id.c              |   65 +++++++++++++++++++++++++++------
 arch/arm/plat-omap/include/mach/cpu.h |   37 +++++++++++++++++++
 2 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 03b80f2..d4d563b 100644
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
@@ -212,31 +211,24 @@ void __init omap3_check_revision(void)
 
 	if (hawkeye == 0xb7ae) {
 		switch (rev) {
-		case 0:
+		case 0: /* Take care of early samples */
+		case 1:
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
@@ -248,6 +240,57 @@ out:
 
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
+		omap_revision = OMAP3525_REV(rev);
+		strcpy(cpu_name, "3525");
+	}
+	else if (omap3_has_iva()) {
+		omap_revision = OMAP3515_REV(rev);
+		strcpy(cpu_name, "3515");
+	}
+	else {
+		omap_revision = OMAP3503_REV(rev);
+		strcpy(cpu_name, "3503");
+	}
+
+	switch (rev) {
+	case OMAP_REVBITS_00:
+		strcpy(cpu_rev, "1.0");
+		break;
+	case OMAP_REVBITS_10:
+		strcpy(cpu_rev, "2.0");
+		break;
+	case OMAP_REVBITS_20:
+		strcpy(cpu_rev, "2.1");
+		break;
+	case OMAP_REVBITS_30:
+		strcpy(cpu_rev, "3.0");
+		break;
+	case OMAP_REVBITS_40:
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
index 431fec4..8d0841b 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -59,6 +59,23 @@ struct omap_chip_id {
 unsigned int omap_rev(void);
 
 /*
+ * Define CPU revision bits
+ *
+ * Verbose meaning of the revision bits may be different for a silicon
+ * family. This difference can be handled separately.
+ */
+#define OMAP_REVBITS_00		0x00
+#define OMAP_REVBITS_10		0x10
+#define OMAP_REVBITS_20		0x20
+#define OMAP_REVBITS_30		0x30
+#define OMAP_REVBITS_40		0x40
+
+/*
+ * Get the CPU revision for OMAP devices
+ */
+#define GET_OMAP_REVISION()	((omap_rev() >> 8) & 0xff)
+
+/*
  * Test if multicore OMAP support is needed
  */
 #undef MULTI_OMAP1
@@ -353,7 +370,21 @@ IS_OMAP_TYPE(3430, 0x3430)
 
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
@@ -384,6 +415,12 @@ IS_OMAP_TYPE(3430, 0x3430)
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

