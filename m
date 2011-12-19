From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 1/2] arm:omap: Make cpu_rev static global variable
Date: Mon, 19 Dec 2011 15:50:14 +0530
Message-ID: <1324290015-12679-2-git-send-email-hvaibhav@ti.com>
References: <1324290015-12679-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57665 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab1LSKUW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 05:20:22 -0500
In-Reply-To: <1324290015-12679-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

As part of omap revision code cleanup, make cpu_rev variable static
global to the file (id.c).

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |  146 +++++++++++++++++++++++-----------------------
 1 files changed, 72 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 6c58266..752dcae 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -29,7 +29,7 @@
 #include "control.h"

 static unsigned int omap_revision;
-
+static const char *cpu_rev;
 u32 omap_features;

 unsigned int omap_rev(void)
@@ -166,6 +166,56 @@ static void __init omap24xx_check_revision(void)
 	pr_info("\n");
 }

+#define OMAP3_SHOW_FEATURE(feat)		\
+	if (omap3_has_ ##feat())		\
+		printk(#feat" ");
+
+static void __init omap3_cpuinfo(void)
+{
+	const char *cpu_name;
+
+	/*
+	 * OMAP3430 and OMAP3530 are assumed to be same.
+	 *
+	 * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
+	 * on available features. Upon detection, update the CPU id
+	 * and CPU class bits.
+	 */
+	if (cpu_is_omap3630()) {
+		cpu_name = "OMAP3630";
+	} else if (cpu_is_omap3517()) {
+		/* AM35xx devices */
+		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
+	} else if (cpu_is_ti816x()) {
+		cpu_name = "TI816X";
+	} else if (cpu_is_am335x()) {
+		cpu_name =  "AM335X";
+	} else if (cpu_is_ti814x()) {
+		cpu_name = "TI814X";
+	} else if (omap3_has_iva() && omap3_has_sgx()) {
+		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
+		cpu_name = "OMAP3430/3530";
+	} else if (omap3_has_iva()) {
+		cpu_name = "OMAP3525";
+	} else if (omap3_has_sgx()) {
+		cpu_name = "OMAP3515";
+	} else {
+		cpu_name = "OMAP3503";
+	}
+
+	/* Print verbose information */
+	pr_info("%s ES%s (", cpu_name, cpu_rev);
+
+	OMAP3_SHOW_FEATURE(l2cache);
+	OMAP3_SHOW_FEATURE(iva);
+	OMAP3_SHOW_FEATURE(sgx);
+	OMAP3_SHOW_FEATURE(neon);
+	OMAP3_SHOW_FEATURE(isp);
+	OMAP3_SHOW_FEATURE(192mhz_clk);
+
+	printk(")\n");
+}
+
 #define OMAP3_CHECK_FEATURE(status,feat)				\
 	if (((status & OMAP3_ ##feat## _MASK) 				\
 		>> OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat## _NONE) { 	\
@@ -231,7 +281,7 @@ static void __init ti81xx_check_features(void)
 	omap_features = OMAP3_HAS_NEON;
 }

-static void __init omap3_check_revision(const char **cpu_rev)
+static void __init omap3_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
@@ -245,7 +295,7 @@ static void __init omap3_check_revision(const char **cpu_rev)
 	cpuid = read_cpuid(CPUID_ID);
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
 		omap_revision = OMAP3430_REV_ES1_0;
-		*cpu_rev = "1.0";
+		cpu_rev = "1.0";
 		return;
 	}

@@ -266,26 +316,26 @@ static void __init omap3_check_revision(const char **cpu_rev)
 		case 0: /* Take care of early samples */
 		case 1:
 			omap_revision = OMAP3430_REV_ES2_0;
-			*cpu_rev = "2.0";
+			cpu_rev = "2.0";
 			break;
 		case 2:
 			omap_revision = OMAP3430_REV_ES2_1;
-			*cpu_rev = "2.1";
+			cpu_rev = "2.1";
 			break;
 		case 3:
 			omap_revision = OMAP3430_REV_ES3_0;
-			*cpu_rev = "3.0";
+			cpu_rev = "3.0";
 			break;
 		case 4:
 			omap_revision = OMAP3430_REV_ES3_1;
-			*cpu_rev = "3.1";
+			cpu_rev = "3.1";
 			break;
 		case 7:
 		/* FALLTHROUGH */
 		default:
 			/* Use the latest known revision as default */
 			omap_revision = OMAP3430_REV_ES3_1_2;
-			*cpu_rev = "3.1.2";
+			cpu_rev = "3.1.2";
 		}
 		break;
 	case 0xb868:
@@ -298,13 +348,13 @@ static void __init omap3_check_revision(const char **cpu_rev)
 		switch (rev) {
 		case 0:
 			omap_revision = OMAP3517_REV_ES1_0;
-			*cpu_rev = "1.0";
+			cpu_rev = "1.0";
 			break;
 		case 1:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = OMAP3517_REV_ES1_1;
-			*cpu_rev = "1.1";
+			cpu_rev = "1.1";
 		}
 		break;
 	case 0xb891:
@@ -313,60 +363,60 @@ static void __init omap3_check_revision(const char **cpu_rev)
 		switch(rev) {
 		case 0: /* Take care of early samples */
 			omap_revision = OMAP3630_REV_ES1_0;
-			*cpu_rev = "1.0";
+			cpu_rev = "1.0";
 			break;
 		case 1:
 			omap_revision = OMAP3630_REV_ES1_1;
-			*cpu_rev = "1.1";
+			cpu_rev = "1.1";
 			break;
 		case 2:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = OMAP3630_REV_ES1_2;
-			*cpu_rev = "1.2";
+			cpu_rev = "1.2";
 		}
 		break;
 	case 0xb81e:
 		switch (rev) {
 		case 0:
 			omap_revision = TI8168_REV_ES1_0;
-			*cpu_rev = "1.0";
+			cpu_rev = "1.0";
 			break;
 		case 1:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = TI8168_REV_ES1_1;
-			*cpu_rev = "1.1";
+			cpu_rev = "1.1";
 			break;
 		}
 		break;
 	case 0xb944:
 		omap_revision = AM335X_REV_ES1_0;
-		*cpu_rev = "1.0";
+		cpu_rev = "1.0";
 	case 0xb8f2:
 		switch (rev) {
 		case 0:
 		/* FALLTHROUGH */
 		case 1:
 			omap_revision = TI8148_REV_ES1_0;
-			*cpu_rev = "1.0";
+			cpu_rev = "1.0";
 			break;
 		case 2:
 			omap_revision = TI8148_REV_ES2_0;
-			*cpu_rev = "2.0";
+			cpu_rev = "2.0";
 			break;
 		case 3:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = TI8148_REV_ES2_1;
-			*cpu_rev = "2.1";
+			cpu_rev = "2.1";
 			break;
 		}
 		break;
 	default:
 		/* Unknown default to latest silicon rev as default */
 		omap_revision = OMAP3630_REV_ES1_2;
-		*cpu_rev = "1.2";
+		cpu_rev = "1.2";
 		pr_warn("Warning: unknown chip type; assuming OMAP3630ES1.2\n");
 	}
 }
@@ -444,63 +494,11 @@ static void __init omap4_check_revision(void)
 		((omap_rev() >> 12) & 0xf), ((omap_rev() >> 8) & 0xf));
 }

-#define OMAP3_SHOW_FEATURE(feat)		\
-	if (omap3_has_ ##feat())		\
-		printk(#feat" ");
-
-static void __init omap3_cpuinfo(const char *cpu_rev)
-{
-	const char *cpu_name;
-
-	/*
-	 * OMAP3430 and OMAP3530 are assumed to be same.
-	 *
-	 * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
-	 * on available features. Upon detection, update the CPU id
-	 * and CPU class bits.
-	 */
-	if (cpu_is_omap3630()) {
-		cpu_name = "OMAP3630";
-	} else if (cpu_is_omap3517()) {
-		/* AM35xx devices */
-		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
-	} else if (cpu_is_ti816x()) {
-		cpu_name = "TI816X";
-	} else if (cpu_is_am335x()) {
-		cpu_name =  "AM335X";
-	} else if (cpu_is_ti814x()) {
-		cpu_name = "TI814X";
-	} else if (omap3_has_iva() && omap3_has_sgx()) {
-		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
-		cpu_name = "OMAP3430/3530";
-	} else if (omap3_has_iva()) {
-		cpu_name = "OMAP3525";
-	} else if (omap3_has_sgx()) {
-		cpu_name = "OMAP3515";
-	} else {
-		cpu_name = "OMAP3503";
-	}
-
-	/* Print verbose information */
-	pr_info("%s ES%s (", cpu_name, cpu_rev);
-
-	OMAP3_SHOW_FEATURE(l2cache);
-	OMAP3_SHOW_FEATURE(iva);
-	OMAP3_SHOW_FEATURE(sgx);
-	OMAP3_SHOW_FEATURE(neon);
-	OMAP3_SHOW_FEATURE(isp);
-	OMAP3_SHOW_FEATURE(192mhz_clk);
-
-	printk(")\n");
-}
-
 /*
  * Try to detect the exact revision of the omap we're running on
  */
 void __init omap2_check_revision(void)
 {
-	const char *cpu_rev;
-
 	/*
 	 * At this point we have an idea about the processor revision set
 	 * earlier with omap2_set_globals_tap().
@@ -508,7 +506,7 @@ void __init omap2_check_revision(void)
 	if (cpu_is_omap24xx()) {
 		omap24xx_check_revision();
 	} else if (cpu_is_omap34xx()) {
-		omap3_check_revision(&cpu_rev);
+		omap3_check_revision();

 		/* TI81XX doesn't have feature register */
 		if (!cpu_is_ti81xx())
@@ -516,7 +514,7 @@ void __init omap2_check_revision(void)
 		else
 			ti81xx_check_features();

-		omap3_cpuinfo(cpu_rev);
+		omap3_cpuinfo();
 		return;
 	} else if (cpu_is_omap44xx()) {
 		omap4_check_revision();
--
1.7.0.4

