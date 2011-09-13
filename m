From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/6] OMAP3: id: remove identification codes that only
	correspond to marketing names
Date: Tue, 13 Sep 2011 15:28:02 -0600
Message-ID: <20110913212801.26161.47980.stgit@dusk>
References: <20110913212638.26161.62284.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40104 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932837Ab1IMVbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 17:31:20 -0400
In-Reply-To: <20110913212638.26161.62284.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

The OMAP3505/AM3505 appears to be based on the same silicon as the
OMAP3517/AM3517, with some features disabled via eFuse bits.  Follow
the same practice as OMAP3430 and identify these devices internally as
part of the OMAP3517/AM3517 family.

The OMAP3503/3515/3525/3530 chips appear to be based on the same silicon
as the OMAP3430, with some features disabled via eFuse bits.  Identify
these devices internally as part of the OMAP3430 family.

Remove the old OMAP35XX_CLASS, which actually covered two very different
chip families.  The OMAP3503/3515/3525/3530 chips will now be covered by
OMAP343X_CLASS, since the silicon appears to be identical.  For the
OMAP3517/AM3517 family, create a new class, OMAP3517_CLASS.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c              |   17 ++++++-----------
 arch/arm/plat-omap/include/plat/cpu.h |    9 ++-------
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37efb86..723e2f8 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -304,14 +304,15 @@ static void __init omap3_check_revision(void)
 		}
 		break;
 	case 0xb868:
-		/* Handle OMAP35xx/AM35xx devices
+		/*
+		 * Handle OMAP/AM 3505/3517 devices
 		 *
-		 * Set the device to be OMAP3505 here. Actual device
+		 * Set the device to be OMAP3517 here. Actual device
 		 * is identified later based on the features.
 		 *
 		 * REVISIT: AM3505/AM3517 should have their own CHIP_IS
 		 */
-		omap_revision = OMAP3505_REV(rev);
+		omap_revision = OMAP3517_REV(rev);
 		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 		break;
 	case 0xb891:
@@ -442,26 +443,20 @@ static void __init omap3_cpuinfo(void)
 		/*
 		 * AM35xx devices
 		 */
-		if (omap3_has_sgx()) {
-			omap_revision = OMAP3517_REV(rev);
+		if (omap3_has_sgx())
 			strcpy(cpu_name, "AM3517");
-		} else {
-			/* Already set in omap3_check_revision() */
+		else
 			strcpy(cpu_name, "AM3505");
-		}
 	} else if (cpu_is_ti816x()) {
 		strcpy(cpu_name, "TI816X");
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		strcpy(cpu_name, "OMAP3430/3530");
 	} else if (omap3_has_iva()) {
-		omap_revision = OMAP3525_REV(rev);
 		strcpy(cpu_name, "OMAP3525");
 	} else if (omap3_has_sgx()) {
-		omap_revision = OMAP3515_REV(rev);
 		strcpy(cpu_name, "OMAP3515");
 	} else {
-		omap_revision = OMAP3503_REV(rev);
 		strcpy(cpu_name, "OMAP3503");
 	}
 
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 67b3d75..b6bd8f7 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -397,13 +397,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3630_REV_ES1_1	(OMAP363X_CLASS | (OMAP_REVBITS_01 << 8))
 #define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (OMAP_REVBITS_02 << 8))
 
-#define OMAP35XX_CLASS		0x35000034
-#define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 8))
-#define OMAP3515_REV(v)		(OMAP35XX_CLASS | (0x3515 << 16) | (v << 8))
-#define OMAP3525_REV(v)		(OMAP35XX_CLASS | (0x3525 << 16) | (v << 8))
-#define OMAP3530_REV(v)		(OMAP35XX_CLASS | (0x3530 << 16) | (v << 8))
-#define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 8))
-#define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 8))
+#define OMAP3517_CLASS		0x35170000
+#define OMAP3517_REV(v)		(OMAP3517_CLASS | (v << 8))
 
 #define TI816X_CLASS		0x81600034
 #define TI8168_REV_ES1_0	TI816X_CLASS


