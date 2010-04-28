From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP3630: Update ES1.1 silicon revision detection
Date: Wed, 28 Apr 2010 20:21:20 +0530
Message-ID: <1272466280-2784-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58082 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab0D1Ovg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 10:51:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>

This patch updates ES1.1 silicon revision ID for OMAP3630
processor. The silicon revision can be read by reading hawkeye
and revision bits in IDCODE register.

Tested on 3630sdp(with ES1.1 silicon) and Zoom3(with ES1.0) silicon.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c              |   20 ++++++++++++++++----
 arch/arm/plat-omap/include/plat/cpu.h |    3 +++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37b8a1a..dd26092 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -259,11 +259,20 @@ void __init omap3_check_revision(void)
 		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 		break;
 	case 0xb891:
-	/* FALLTHROUGH */
-	default:
-		/* Unknown default to latest silicon rev as default*/
-		omap_revision = OMAP3630_REV_ES1_0;
+		/* Handle 36xx devices */
 		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
+
+		switch(rev) {
+		case 0: /* Take care of early samples */
+			omap_revision = OMAP3630_REV_ES1_0;
+			break;
+		case 1:
+		/* Fall through */
+		default:
+			/* Use the latest known revision as default */
+			omap_revision =  OMAP3630_REV_ES1_1;
+			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
+		}
 	}
 }
 
@@ -339,6 +348,9 @@ void __init omap3_cpuinfo(void)
 	case OMAP_REVBITS_00:
 		strcpy(cpu_rev, "1.0");
 		break;
+	case OMAP_REVBITS_01:
+		strcpy(cpu_rev, "1.1");
+		break;
 	case OMAP_REVBITS_10:
 		strcpy(cpu_rev, "2.0");
 		break;
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 7514174..04c7baa 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -66,6 +66,7 @@ unsigned int omap_rev(void);
  * family. This difference can be handled separately.
  */
 #define OMAP_REVBITS_00		0x00
+#define OMAP_REVBITS_01		0x01
 #define OMAP_REVBITS_10		0x10
 #define OMAP_REVBITS_20		0x20
 #define OMAP_REVBITS_30		0x30
@@ -376,6 +377,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3430_REV_ES3_1_2	0x34305034
 
 #define OMAP3630_REV_ES1_0	0x36300034
+#define OMAP3630_REV_ES1_1	0x36300134
 
 #define OMAP35XX_CLASS		0x35000034
 #define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 8))
@@ -411,6 +413,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
 #define CHIP_IS_OMAP3630ES1		(1 << 7)
 #define CHIP_IS_OMAP4430ES1		(1 << 8)
+#define CHIP_IS_OMAP3630ES1_1           (1 << 9)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
-- 
1.6.0.4

