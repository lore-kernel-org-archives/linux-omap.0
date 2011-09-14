From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2] OMAP: id: remove OMAP_CHIP declarations, code
Date: Wed, 14 Sep 2011 17:49:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109141737370.15220@utopia.booyaka.com>
References: <alpine.DEB.2.00.1109042045180.9056@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54035 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab1INXtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 19:49:12 -0400
In-Reply-To: <alpine.DEB.2.00.1109042045180.9056@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Now that all of the users of the OMAP_CHIP bitfield code have been converted
to use lists, the OMAP_CHIP code, data, and declarations can be removed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
This version has been updated to apply after the recent changes.  It also 
removes a few stray references to CHIP_IS/omap_chip in comments.

omap_chip_remove_cleanup_3.2
   text	   data	    bss	    dec	    hex	filename
6330480	 655188	5591124	12576792	 bfe818	vmlinux.omap2plus_defconfig.orig
6330143	 655196	5591124	12576463	 bfe6cf	vmlinux.omap2plus_defconfig.patched

 arch/arm/mach-omap2/id.c                |   55 ---------------------------
 arch/arm/plat-omap/include/plat/clock.h |    2 -
 arch/arm/plat-omap/include/plat/cpu.h   |   62 -------------------------------
 3 files changed, 0 insertions(+), 119 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index ed1d439..d27daf9 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -28,7 +28,6 @@
 
 #include "control.h"
 
-static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
 u32 omap_features;
@@ -39,19 +38,6 @@ unsigned int omap_rev(void)
 }
 EXPORT_SYMBOL(omap_rev);
 
-/**
- * omap_chip_is - test whether currently running OMAP matches a chip type
- * @oc: omap_chip_t to test against
- *
- * Test whether the currently-running OMAP chip matches the supplied
- * chip type 'oc'.  Returns 1 upon a match; 0 upon failure.
- */
-int omap_chip_is(struct omap_chip_id oci)
-{
-	return (oci.oc & omap_chip.oc) ? 1 : 0;
-}
-EXPORT_SYMBOL(omap_chip_is);
-
 int omap_type(void)
 {
 	u32 val = 0;
@@ -248,8 +234,6 @@ static void __init omap3_check_revision(const char **cpu_rev)
 	u16 hawkeye;
 	u8 rev;
 
-	omap_chip.oc = CHIP_IS_OMAP3430;
-
 	/*
 	 * We cannot access revision registers on ES1.0.
 	 * If the processor type is Cortex-A8 and the revision is 0x0
@@ -258,7 +242,6 @@ static void __init omap3_check_revision(const char **cpu_rev)
 	cpuid = read_cpuid(CPUID_ID);
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
 		omap_revision = OMAP3430_REV_ES1_0;
-		omap_chip.oc |= CHIP_IS_OMAP3430ES1;
 		*cpu_rev = "1.0";
 		return;
 	}
@@ -280,22 +263,18 @@ static void __init omap3_check_revision(const char **cpu_rev)
 		case 0: /* Take care of early samples */
 		case 1:
 			omap_revision = OMAP3430_REV_ES2_0;
-			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
 			*cpu_rev = "2.0";
 			break;
 		case 2:
 			omap_revision = OMAP3430_REV_ES2_1;
-			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
 			*cpu_rev = "2.1";
 			break;
 		case 3:
 			omap_revision = OMAP3430_REV_ES3_0;
-			omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
 			*cpu_rev = "3.0";
 			break;
 		case 4:
 			omap_revision = OMAP3430_REV_ES3_1;
-			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 			*cpu_rev = "3.1";
 			break;
 		case 7:
@@ -303,9 +282,6 @@ static void __init omap3_check_revision(const char **cpu_rev)
 		default:
 			/* Use the latest known revision as default */
 			omap_revision = OMAP3430_REV_ES3_1_2;
-
-			/* REVISIT: Add CHIP_IS_OMAP3430ES3_1_2? */
-			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 			*cpu_rev = "3.1.2";
 		}
 		break;
@@ -315,8 +291,6 @@ static void __init omap3_check_revision(const char **cpu_rev)
 		 *
 		 * Set the device to be OMAP3517 here. Actual device
 		 * is identified later based on the features.
-		 *
-		 * REVISIT: AM3505/AM3517 should have their own CHIP_IS
 		 */
 		switch (rev) {
 		case 0:
@@ -329,11 +303,9 @@ static void __init omap3_check_revision(const char **cpu_rev)
 			omap_revision = OMAP3517_REV_ES1_1;
 			*cpu_rev = "1.1";
 		}
-		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 		break;
 	case 0xb891:
 		/* Handle 36xx devices */
-		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
 
 		switch(rev) {
 		case 0: /* Take care of early samples */
@@ -342,20 +314,16 @@ static void __init omap3_check_revision(const char **cpu_rev)
 			break;
 		case 1:
 			omap_revision = OMAP3630_REV_ES1_1;
-			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
 			*cpu_rev = "1.1";
 			break;
 		case 2:
 		/* FALLTHROUGH */
 		default:
 			omap_revision = OMAP3630_REV_ES1_2;
-			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
 			*cpu_rev = "1.2";
 		}
 		break;
 	case 0xb81e:
-		omap_chip.oc = CHIP_IS_TI816X;
-
 		switch (rev) {
 		case 0:
 			omap_revision = TI8168_REV_ES1_0;
@@ -372,7 +340,6 @@ static void __init omap3_check_revision(const char **cpu_rev)
 	default:
 		/* Unknown default to latest silicon rev as default */
 		omap_revision = OMAP3630_REV_ES1_2;
-		omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
 		*cpu_rev = "1.2";
 		pr_warn("Warning: unknown chip type; assuming OMAP3630ES1.2\n");
 	}
@@ -407,24 +374,20 @@ static void __init omap4_check_revision(void)
 		switch (rev) {
 		case 0:
 			omap_revision = OMAP4430_REV_ES1_0;
-			omap_chip.oc |= CHIP_IS_OMAP4430ES1;
 			break;
 		case 1:
 		default:
 			omap_revision = OMAP4430_REV_ES2_0;
-			omap_chip.oc |= CHIP_IS_OMAP4430ES2;
 		}
 		break;
 	case 0xb95c:
 		switch (rev) {
 		case 3:
 			omap_revision = OMAP4430_REV_ES2_1;
-			omap_chip.oc |= CHIP_IS_OMAP4430ES2_1;
 			break;
 		case 4:
 		default:
 			omap_revision = OMAP4430_REV_ES2_2;
-			omap_chip.oc |= CHIP_IS_OMAP4430ES2_2;
 		}
 		break;
 	case 0xb94e:
@@ -432,14 +395,12 @@ static void __init omap4_check_revision(void)
 		case 0:
 		default:
 			omap_revision = OMAP4460_REV_ES1_0;
-			omap_chip.oc |= CHIP_IS_OMAP4460ES1_0;
 			break;
 		}
 		break;
 	default:
 		/* Unknown default to latest silicon rev as default */
 		omap_revision = OMAP4430_REV_ES2_2;
-		omap_chip.oc |= CHIP_IS_OMAP4430ES2_2;
 	}
 
 	pr_info("OMAP%04x ES%d.%d\n", omap_rev() >> 16,
@@ -523,22 +484,6 @@ void __init omap2_check_revision(void)
 	} else {
 		pr_err("OMAP revision unknown, please fix!\n");
 	}
-
-	/*
-	 * OK, now we know the exact revision. Initialize omap_chip bits
-	 * for powerdowmain and clockdomain code.
-	 */
-	if (cpu_is_omap243x()) {
-		/* Currently only supports 2430ES2.1 and 2430-all */
-		omap_chip.oc |= CHIP_IS_OMAP2430;
-		return;
-	} else if (cpu_is_omap242x()) {
-		/* Currently only supports 2420ES2.1.1 and 2420-all */
-		omap_chip.oc |= CHIP_IS_OMAP2420;
-		return;
-	}
-
-	pr_err("Uninitialized omap_chip, please fix!\n");
 }
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index df4b968..197ca03 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -80,8 +80,6 @@ struct clkops {
  *
  * @div is the divisor that should be applied to the parent clock's rate
  * to produce the current clock's rate.
- *
- * XXX @flags probably should be replaced with an struct omap_chip.
  */
 struct clksel_rate {
 	u32			val;
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index ddbc025..2f90269 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -44,13 +44,6 @@
 
 int omap_type(void);
 
-struct omap_chip_id {
-	u16 oc;
-	u8 type;
-};
-
-#define OMAP_CHIP_INIT(x)	{ .oc = x }
-
 /*
  * omap_rev bits:
  * CPU id bits	(0730, 1510, 1710, 2422...)	[31:16]
@@ -402,61 +395,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP446X_CLASS		0x44600044
 #define OMAP4460_REV_ES1_0	(OMAP446X_CLASS | (0x10 << 8))
 
-/*
- * omap_chip bits
- *
- * CHIP_IS_OMAP{2420,2430,3430} indicate that a particular structure is
- * valid on all chips of that type.  CHIP_IS_OMAP3430ES{1,2} indicates
- * something that is only valid on that particular ES revision.
- *
- * These bits may be ORed together to indicate structures that are
- * available on multiple chip types.
- *
- * To test whether a particular structure matches the current OMAP chip type,
- * use omap_chip_is().
- *
- */
-#define CHIP_IS_OMAP2420		(1 << 0)
-#define CHIP_IS_OMAP2430		(1 << 1)
-#define CHIP_IS_OMAP3430		(1 << 2)
-#define CHIP_IS_OMAP3430ES1		(1 << 3)
-#define CHIP_IS_OMAP3430ES2		(1 << 4)
-#define CHIP_IS_OMAP3430ES3_0		(1 << 5)
-#define CHIP_IS_OMAP3430ES3_1		(1 << 6)
-#define CHIP_IS_OMAP3630ES1		(1 << 7)
-#define CHIP_IS_OMAP4430ES1		(1 << 8)
-#define CHIP_IS_OMAP3630ES1_1           (1 << 9)
-#define CHIP_IS_OMAP3630ES1_2           (1 << 10)
-#define CHIP_IS_OMAP4430ES2		(1 << 11)
-#define CHIP_IS_OMAP4430ES2_1		(1 << 12)
-#define CHIP_IS_OMAP4430ES2_2		(1 << 13)
-#define CHIP_IS_TI816X			(1 << 14)
-#define CHIP_IS_OMAP4460ES1_0		(1 << 15)
-
-#define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
-
-#define CHIP_IS_OMAP4430		(CHIP_IS_OMAP4430ES1 |		\
-					 CHIP_IS_OMAP4430ES2 |		\
-					 CHIP_IS_OMAP4430ES2_1 |	\
-					 CHIP_IS_OMAP4430ES2_2 |	\
-					 CHIP_IS_OMAP4460ES1_0)
-
-/*
- * "GE" here represents "greater than or equal to" in terms of ES
- * levels.  So CHIP_GE_OMAP3430ES2 is intended to match all OMAP3430
- * chips at ES2 and beyond, but not, for example, any OMAP lines after
- * OMAP3.
- */
-#define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
-					 CHIP_IS_OMAP3430ES3_0 | \
-					 CHIP_GE_OMAP3430ES3_1)
-#define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1 | \
-					 CHIP_IS_OMAP3630ES1 | \
-					 CHIP_GE_OMAP3630ES1_1)
-#define CHIP_GE_OMAP3630ES1_1		(CHIP_IS_OMAP3630ES1_1 | \
-					 CHIP_IS_OMAP3630ES1_2)
-
-int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);
 
 /*
-- 
1.7.5.4

