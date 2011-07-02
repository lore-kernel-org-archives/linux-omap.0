From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/6] OMAP: ID: introduce chip detection for OMAP4460
Date: Sat, 2 Jul 2011 08:00:21 +0530
Message-ID: <1309573826-10615-2-git-send-email-rnayak@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43115 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337Ab1GBCbe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 22:31:34 -0400
In-Reply-To: <1309573826-10615-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Aneesh V <aneesh@ti.com>

Add support for detecting the latest in the OMAP4 family: OMAP4460
Among other changes, the new chip also can support 1.5GHz A9s,
1080p stereoscopic 3D and 12 MP stereo (dual camera). In addition,
we have changes to OPPs supported, clock tree etc, hence having a
chip detection is required.

For more details on OMAP4460, see
Highlights:
http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?contentId=53243&navigationId=12843&templateId=6123
Public TRM is available here as usual:
http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?templateId=6123&navigationId=12667

[nm@ti.com: cleanups and introduction of ramp system]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
V2:
* Removed un-necessary movement of variable declaration(hawkeye)
---
 arch/arm/mach-omap2/id.c              |   13 +++++++++++--
 arch/arm/plat-omap/include/plat/cpu.h |   13 ++++++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2537090..743889a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -344,10 +344,10 @@ static void __init omap4_check_revision(void)
 	rev = (idcode >> 28) & 0xf;
 
 	/*
-	 * Few initial ES2.0 samples IDCODE is same as ES1.0
+	 * Few initial 4430 ES2.0 samples IDCODE is same as ES1.0
 	 * Use ARM register to detect the correct ES version
 	 */
-	if (!rev) {
+	if (!rev && (hawkeye != 0xb94e)) {
 		idcode = read_cpuid(CPUID_ID);
 		rev = (idcode & 0xf) - 1;
 	}
@@ -377,6 +377,15 @@ static void __init omap4_check_revision(void)
 			omap_chip.oc |= CHIP_IS_OMAP4430ES2_2;
 		}
 		break;
+	case 0xb94e:
+		switch (rev) {
+		case 0:
+		default:
+			omap_revision = OMAP4460_REV_ES1_0;
+			omap_chip.oc |= CHIP_IS_OMAP4460ES1_0;
+			break;
+		}
+		break;
 	default:
 		/* Unknown default to latest silicon rev as default */
 		omap_revision = OMAP4430_REV_ES2_2;
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 96850a6..86b1420 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -88,6 +88,7 @@ unsigned int omap_rev(void);
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
  * cpu_is_omap443x():	True for OMAP4430
+ * cpu_is_omap446x():	True for OMAP4460
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)
 
@@ -123,6 +124,7 @@ IS_OMAP_SUBCLASS(243x, 0x243)
 IS_OMAP_SUBCLASS(343x, 0x343)
 IS_OMAP_SUBCLASS(363x, 0x363)
 IS_OMAP_SUBCLASS(443x, 0x443)
+IS_OMAP_SUBCLASS(446x, 0x446)
 
 IS_TI_SUBCLASS(816x, 0x816)
 
@@ -137,6 +139,7 @@ IS_TI_SUBCLASS(816x, 0x816)
 #define cpu_is_ti816x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
+#define cpu_is_omap446x()		0
 
 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -361,8 +364,10 @@ IS_OMAP_TYPE(3517, 0x3517)
 # if defined(CONFIG_ARCH_OMAP4)
 # undef cpu_is_omap44xx
 # undef cpu_is_omap443x
+# undef cpu_is_omap446x
 # define cpu_is_omap44xx()		is_omap44xx()
 # define cpu_is_omap443x()		is_omap443x()
+# define cpu_is_omap446x()		is_omap446x()
 # endif
 
 /* Macros to detect if we have OMAP1 or OMAP2 */
@@ -410,6 +415,9 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP4430_REV_ES2_1	(OMAP443X_CLASS | (0x21 << 8))
 #define OMAP4430_REV_ES2_2	(OMAP443X_CLASS | (0x22 << 8))
 
+#define OMAP446X_CLASS		0x44600044
+#define OMAP4460_REV_ES1_0	(OMAP446X_CLASS | (0x10 << 8))
+
 /*
  * omap_chip bits
  *
@@ -439,6 +447,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP4430ES2_1		(1 << 12)
 #define CHIP_IS_OMAP4430ES2_2		(1 << 13)
 #define CHIP_IS_TI816X			(1 << 14)
+#define CHIP_IS_OMAP4460ES1_0		(1 << 15)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
@@ -447,7 +456,9 @@ IS_OMAP_TYPE(3517, 0x3517)
 					 CHIP_IS_OMAP4430ES2_1 |	\
 					 CHIP_IS_OMAP4430ES2_2)
 
-#define CHIP_IS_OMAP44XX		(CHIP_IS_OMAP4430)
+#define CHIP_IS_OMAP446X		CHIP_IS_OMAP4460ES1_0
+
+#define CHIP_IS_OMAP44XX		(CHIP_IS_OMAP4430 | CHIP_IS_OMAP446X)
 
 /*
  * "GE" here represents "greater than or equal to" in terms of ES
-- 
1.7.4.1

