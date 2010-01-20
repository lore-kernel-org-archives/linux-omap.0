From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap3: Fix cpu detection
Date: Tue, 19 Jan 2010 18:33:50 -0800
Message-ID: <20100120023349.GA23467@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52342 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127Ab0ATCdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 21:33:39 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

We need to set the omap_chip.oc carefully for the clocks to work.

To fix this, set the omap_chip.oc in omap3_check_features() based
on the CONTROL_IDCODE and silicon revision registers.

Also add handling for 34xx es3.1.2 as es3.1 for now.

Fixes booting on at least overo board.

Based on an earlier patch by Paul Walmsley <paul@pwsan.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a091b53..3d65c50 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -188,6 +188,8 @@ void __init omap3_check_revision(void)
 	u16 hawkeye;
 	u8 rev;
 
+	omap_chip.oc = CHIP_IS_OMAP3430;
+
 	/*
 	 * We cannot access revision registers on ES1.0.
 	 * If the processor type is Cortex-A8 and the revision is 0x0
@@ -196,6 +198,7 @@ void __init omap3_check_revision(void)
 	cpuid = read_cpuid(CPUID_ID);
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
 		omap_revision = OMAP3430_REV_ES1_0;
+		omap_chip.oc |= CHIP_IS_OMAP3430ES1;
 		return;
 	}
 
@@ -216,18 +219,28 @@ void __init omap3_check_revision(void)
 		case 0: /* Take care of early samples */
 		case 1:
 			omap_revision = OMAP3430_REV_ES2_0;
+			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
 			break;
 		case 2:
 			omap_revision = OMAP3430_REV_ES2_1;
+			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
 			break;
 		case 3:
 			omap_revision = OMAP3430_REV_ES3_0;
+			omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
 			break;
 		case 4:
+			omap_revision = OMAP3430_REV_ES3_1;
+			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
+			break;
+		case 7:
 		/* FALLTHROUGH */
 		default:
 			/* Use the latest known revision as default */
-			omap_revision = OMAP3430_REV_ES3_1;
+			omap_revision = OMAP3430_REV_ES3_1_2;
+
+			/* REVISIT: Add CHIP_IS_OMAP3430ES3_1_2? */
+			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 		}
 		break;
 	case 0xb868:
@@ -235,14 +248,18 @@ void __init omap3_check_revision(void)
 		 *
 		 * Set the device to be OMAP3505 here. Actual device
 		 * is identified later based on the features.
+		 *
+		 * REVISIT: AM3505/AM3517 should have their own CHIP_IS
 		 */
 		omap_revision = OMAP3505_REV(rev);
+		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 		break;
 	case 0xb891:
 	/* FALLTHROUGH */
 	default:
 		/* Unknown default to latest silicon rev as default*/
 		omap_revision = OMAP3630_REV_ES1_0;
+		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
 	}
 }
 
@@ -360,6 +377,7 @@ void __init omap2_check_revision(void)
 		omap3_check_revision();
 		omap3_check_features();
 		omap3_cpuinfo();
+		return;
 	} else if (cpu_is_omap44xx()) {
 		omap4_check_revision();
 		return;
@@ -374,27 +392,14 @@ void __init omap2_check_revision(void)
 	if (cpu_is_omap243x()) {
 		/* Currently only supports 2430ES2.1 and 2430-all */
 		omap_chip.oc |= CHIP_IS_OMAP2430;
+		return;
 	} else if (cpu_is_omap242x()) {
 		/* Currently only supports 2420ES2.1.1 and 2420-all */
 		omap_chip.oc |= CHIP_IS_OMAP2420;
-	} else if (cpu_is_omap3505() || cpu_is_omap3517()) {
-		omap_chip.oc = CHIP_IS_OMAP3430 | CHIP_IS_OMAP3430ES3_1;
-	} else if (cpu_is_omap343x()) {
-		omap_chip.oc = CHIP_IS_OMAP3430;
-		if (omap_rev() == OMAP3430_REV_ES1_0)
-			omap_chip.oc |= CHIP_IS_OMAP3430ES1;
-		else if (omap_rev() >= OMAP3430_REV_ES2_0 &&
-			 omap_rev() <= OMAP3430_REV_ES2_1)
-			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
-		else if (omap_rev() == OMAP3430_REV_ES3_0)
-			omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
-		else if (omap_rev() == OMAP3430_REV_ES3_1)
-			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
-		else if (omap_rev() == OMAP3630_REV_ES1_0)
-			omap_chip.oc |= CHIP_IS_OMAP3630ES1;
-	} else {
-		pr_err("Uninitialized omap_chip, please fix!\n");
+		return;
 	}
+
+	pr_err("Uninitialized omap_chip, please fix!\n");
 }
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 9a028bd..a162f58 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -434,6 +434,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3430_REV_ES2_1	0x34302034
 #define OMAP3430_REV_ES3_0	0x34303034
 #define OMAP3430_REV_ES3_1	0x34304034
+#define OMAP3430_REV_ES3_1_2	0x34305034
 
 #define OMAP3630_REV_ES1_0	0x36300034
 
