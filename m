From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/6] OMAP3: id: remove identification codes that only
	correspond to marketing names
Date: Wed, 14 Sep 2011 06:39:24 -0600
Message-ID: <20110914123920.25282.9602.stgit@dusk>
References: <20110914123708.25282.78122.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37234 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406Ab1INMmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 08:42:25 -0400
In-Reply-To: <20110914123708.25282.78122.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Sanjeev Premi <premi@ti.com>

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

Thanks to Tony Lindgren <tony@atomide.com> for some help with the second
revision of this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c              |   17 ++++++-----------
 arch/arm/plat-omap/include/plat/cpu.h |   14 +++++---------
 2 files changed, 11 insertions(+), 20 deletions(-)

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
index 67b3d75..34df171 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -262,7 +262,7 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
-IS_OMAP_TYPE(3505, 0x3505)
+IS_OMAP_TYPE(3505, 0x3517)
 IS_OMAP_TYPE(3517, 0x3517)
 
 #define cpu_is_omap310()		0
@@ -354,8 +354,9 @@ IS_OMAP_TYPE(3517, 0x3517)
 						(!omap3_has_sgx()) &&	\
 						(omap3_has_iva()))
 # define cpu_is_omap3530()		(cpu_is_omap3430())
-# define cpu_is_omap3505()		is_omap3505()
 # define cpu_is_omap3517()		is_omap3517()
+# define cpu_is_omap3505()		(cpu_is_omap3517() &&		\
+						!omap3_has_sgx())
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 # define cpu_is_ti816x()		is_ti816x()
@@ -397,13 +398,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3630_REV_ES1_1	(OMAP363X_CLASS | (OMAP_REVBITS_01 << 8))
 #define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (OMAP_REVBITS_02 << 8))
 
-#define OMAP35XX_CLASS		0x35000034
-#define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 8))
-#define OMAP3515_REV(v)		(OMAP35XX_CLASS | (0x3515 << 16) | (v << 8))
-#define OMAP3525_REV(v)		(OMAP35XX_CLASS | (0x3525 << 16) | (v << 8))
-#define OMAP3530_REV(v)		(OMAP35XX_CLASS | (0x3530 << 16) | (v << 8))
-#define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 8))
-#define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 8))
+#define OMAP3517_CLASS		0x35170034
+#define OMAP3517_REV(v)		(OMAP3517_CLASS | (v << 8))
 
 #define TI816X_CLASS		0x81600034
 #define TI8168_REV_ES1_0	TI816X_CLASS


