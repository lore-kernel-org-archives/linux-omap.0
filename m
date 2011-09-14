From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 5/6] OMAP3: id: remove duplicate code for testing SoC ES
	level
Date: Wed, 14 Sep 2011 06:39:38 -0600
Message-ID: <20110914123935.25282.93889.stgit@dusk>
References: <20110914123708.25282.78122.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37247 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932429Ab1INMm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 08:42:26 -0400
In-Reply-To: <20110914123708.25282.78122.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

omap3_cpuinfo() contains essentially duplicated code from
omap3_check_revision(), just for the purpose of determining the chip ES level.
Set the cpu_rev char array pointer in omap3_check_revision() instead,
and drop the now-useless code from omap3_cpuinfo().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/id.c |   80 +++++++++++++---------------------------------
 1 files changed, 23 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 18c3797..307e186 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -242,7 +242,7 @@ static void __init ti816x_check_features(void)
 	omap_features = OMAP3_HAS_NEON;
 }
 
-static void __init omap3_check_revision(void)
+static void __init omap3_check_revision(const char **cpu_rev)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
@@ -259,6 +259,7 @@ static void __init omap3_check_revision(void)
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
 		omap_revision = OMAP3430_REV_ES1_0;
 		omap_chip.oc |= CHIP_IS_OMAP3430ES1;
+		*cpu_rev = "1.0";
 		return;
 	}
 
@@ -280,18 +281,22 @@ static void __init omap3_check_revision(void)
 		case 1:
 			omap_revision = OMAP3430_REV_ES2_0;
 			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
+			*cpu_rev = "2.0";
 			break;
 		case 2:
 			omap_revision = OMAP3430_REV_ES2_1;
 			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
+			*cpu_rev = "2.1";
 			break;
 		case 3:
 			omap_revision = OMAP3430_REV_ES3_0;
 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
+			*cpu_rev = "3.0";
 			break;
 		case 4:
 			omap_revision = OMAP3430_REV_ES3_1;
 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
+			*cpu_rev = "3.1";
 			break;
 		case 7:
 		/* FALLTHROUGH */
@@ -301,6 +306,7 @@ static void __init omap3_check_revision(void)
 
 			/* REVISIT: Add CHIP_IS_OMAP3430ES3_1_2? */
 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
+			*cpu_rev = "3.1.2";
 		}
 		break;
 	case 0xb868:
@@ -315,11 +321,13 @@ static void __init omap3_check_revision(void)
 		switch (rev) {
 		case 0:
 			omap_revision = OMAP3517_REV_ES1_0;
+			*cpu_rev = "1.0";
 			break;
 		case 1:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = OMAP3517_REV_ES1_1;
+			*cpu_rev = "1.1";
 		}
 		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 		break;
@@ -330,16 +338,19 @@ static void __init omap3_check_revision(void)
 		switch(rev) {
 		case 0: /* Take care of early samples */
 			omap_revision = OMAP3630_REV_ES1_0;
+			*cpu_rev = "1.0";
 			break;
 		case 1:
 			omap_revision = OMAP3630_REV_ES1_1;
 			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
+			*cpu_rev = "1.1";
 			break;
 		case 2:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = OMAP3630_REV_ES1_2;
 			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
+			*cpu_rev = "1.2";
 		}
 		break;
 	case 0xb81e:
@@ -348,17 +359,21 @@ static void __init omap3_check_revision(void)
 		switch (rev) {
 		case 0:
 			omap_revision = TI8168_REV_ES1_0;
+			*cpu_rev = "1.0";
 			break;
 		case 1:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = TI8168_REV_ES1_1;
+			*cpu_rev = "1.1";
+			break;
 		}
 		break;
 	default:
 		/* Unknown default to latest silicon rev as default */
-		omap_revision =  OMAP3630_REV_ES1_2;
+		omap_revision = OMAP3630_REV_ES1_2;
 		omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
+		*cpu_rev = "1.2";
 		pr_warn("Warning: unknown chip type; assuming OMAP3630ES1.2\n");
 	}
 }
@@ -435,10 +450,9 @@ static void __init omap4_check_revision(void)
 	if (omap3_has_ ##feat())		\
 		printk(#feat" ");
 
-static void __init omap3_cpuinfo(void)
+static void __init omap3_cpuinfo(const char *cpu_rev)
 {
-	u8 rev = GET_OMAP_REVISION();
-	const char *cpu_name, *cpu_rev;
+	const char *cpu_name;
 
 	/*
 	 * OMAP3430 and OMAP3530 are assumed to be same.
@@ -465,56 +479,6 @@ static void __init omap3_cpuinfo(void)
 		cpu_name = "OMAP3503";
 	}
 
-	if (cpu_is_omap3630() || cpu_is_ti816x()) {
-		switch (rev) {
-		case OMAP_REVBITS_00:
-			cpu_rev = "1.0";
-			break;
-		case OMAP_REVBITS_01:
-			cpu_rev = "1.1";
-			break;
-		case OMAP_REVBITS_02:
-			/* FALLTHROUGH */
-		default:
-			/* Use the latest known revision as default */
-			cpu_rev = "1.2";
-		}
-	} else if (cpu_is_omap3505() || cpu_is_omap3517()) {
-		switch (rev) {
-		case OMAP_REVBITS_00:
-			cpu_rev = "1.0";
-			break;
-		case OMAP_REVBITS_01:
-			/* FALLTHROUGH */
-		default:
-			/* Use the latest known revision as default */
-			cpu_rev = "1.1";
-		}
-	} else {
-		switch (rev) {
-		case OMAP_REVBITS_00:
-			cpu_rev = "1.0";
-			break;
-		case OMAP_REVBITS_01:
-			cpu_rev = "2.0";
-			break;
-		case OMAP_REVBITS_02:
-			cpu_rev = "2.1";
-			break;
-		case OMAP_REVBITS_03:
-			cpu_rev = "3.0";
-			break;
-		case OMAP_REVBITS_04:
-			cpu_rev = "3.1";
-			break;
-		case OMAP_REVBITS_05:
-			/* FALLTHROUGH */
-		default:
-			/* Use the latest known revision as default */
-			cpu_rev = "3.1.2";
-		}
-	}
-
 	/* Print verbose information */
 	pr_info("%s ES%s (", cpu_name, cpu_rev);
 
@@ -533,6 +497,8 @@ static void __init omap3_cpuinfo(void)
  */
 void __init omap2_check_revision(void)
 {
+	const char *cpu_rev;
+
 	/*
 	 * At this point we have an idea about the processor revision set
 	 * earlier with omap2_set_globals_tap().
@@ -540,7 +506,7 @@ void __init omap2_check_revision(void)
 	if (cpu_is_omap24xx()) {
 		omap24xx_check_revision();
 	} else if (cpu_is_omap34xx()) {
-		omap3_check_revision();
+		omap3_check_revision(&cpu_rev);
 
 		/* TI816X doesn't have feature register */
 		if (!cpu_is_ti816x())
@@ -548,7 +514,7 @@ void __init omap2_check_revision(void)
 		else
 			ti816x_check_features();
 
-		omap3_cpuinfo();
+		omap3_cpuinfo(cpu_rev);
 		return;
 	} else if (cpu_is_omap44xx()) {
 		omap4_check_revision();


