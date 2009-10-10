From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v5] OMAP3: introduce OMAP3630
Date: Fri,  9 Oct 2009 19:46:42 -0500
Message-ID: <1255135602-31673-1-git-send-email-nm@ti.com>
References: <[PATCHv2 1/1] Runtime detection of OMAP35x devices>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47772 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbZJJArc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 20:47:32 -0400
In-Reply-To: <[PATCHv2 1/1] Runtime detection of OMAP35x devices>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Vikram Pandita <vikram.pandita@ti.com>, Allen Pais <allen.pais@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>

**--- SNIP ME --
Hi,
A bit of history for this patchset
V5 - Rebase after syncing with Sanjeev's patch
     +IS_OMAP_SUBCLASS for 3630
     +cpu_is_omap3630() introduced to print cpuinfo -> this also
     helps the comments from Santosh
V4 - Sergio's improvement to the handling of rev decision as we just
     change the define to 3630 and remove crapy override logic in
     omap3_check_revision from v3 patch
V3 - Fixes from Sergio's comments + boot tested on SDP3430+3630.
V2 - fixes of generic comments from Felipe Balbi+minor cleanups
V1 - inital implementation of (b) approach
V0 - original approach introducing a new silicon family
**--- END OF SNIP ME --
Device intro:
OMAP3630 is the latest in the family of OMAP3 devices
and among the changes it introduces are:

New OPP levels for new voltage and frequency levels. a bunch of
Bug fixes to various modules feature additions, notably with ISP,
sDMA etc.

Details about the chip is available here:
http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12836&contentId=52606

Strategy used:
Strategy to introduce this device into Linux was discussed here:
Ref: http://marc.info/?t=125343303400003&r=1&w=2

Two approaches were available:
a) Consider 3630 generation of devices as a new family of silicon
b) Consider 3630 as an offshoot of 3430 family of devices

As a common consensus, (b) seems to be more valid for 3630 as:
* There are changes which are easily handled by using "FEATURES"
  infrastructure.
  For details how to do this, see thread:
  http://marc.info/?t=125050998500001&r=1&w=2
* Most of existing 34xx infrastructure can be reused(almost 90%+)
	- so no ugly if (cpu_is_omap34xx() || cpu_is_omap36xx())
	  all over the place
	- lesser chance of bugs due to reuse of proven code flow
	- 36xx specific handling can still be done where required
	  within the existing infrastructure

NOTE:
* If additional 34xx series are added, OMAP3430_REV_ESXXXX can be
  added on top of the existing 3630 ones are renumbered

This patch was tested on SDP3430, boot tested on 3630 platform using
3430sdp defconfig

Signed-off-by: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Allen Pais <allen.pais@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
-
---
 arch/arm/mach-omap2/id.c              |   24 +++++++++++++++++++++---
 arch/arm/plat-omap/include/mach/cpu.h |    4 ++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index d4d563b..71d5568 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -209,7 +209,9 @@ void __init omap3_check_revision(void)
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0xff;
 
-	if (hawkeye == 0xb7ae) {
+	switch (hawkeye) {
+	case 0xb7ae:
+		/* Handle 34xx/35xx devices */
 		switch (rev) {
 		case 0: /* Take care of early samples */
 		case 1:
@@ -228,6 +230,21 @@ void __init omap3_check_revision(void)
 			/* Use the latest known revision as default */
 			omap_revision = OMAP3430_REV_ES3_1;
 		}
+		break;
+	case 0xb891:
+		/* Handle 36xx devices */
+		switch (rev) {
+		case 0:
+			omap_revision = OMAP3630_REV_ES1_0;
+			break;
+		default:
+			/* Use the latest known revision as default */
+			omap_revision = OMAP3630_REV_ES1_0;
+		}
+		break;
+	default:
+		/* Unknown default to latest silicon rev as default*/
+		omap_revision = OMAP3630_REV_ES1_0;
 	}
 }
 
@@ -249,9 +266,10 @@ void __init omap3_cpuinfo(void)
 	 * on available features. Upon detection, update the CPU id
 	 * and CPU class bits.
 	 */
-	if (omap3_has_iva() && omap3_has_sgx()) {
+	if (cpu_is_omap3630())
+		strcpy(cpu_name, "3630");
+	else if (omap3_has_iva() && omap3_has_sgx())
 		strcpy(cpu_name, "3430/3530");
-	}
 	else if (omap3_has_sgx()) {
 		omap_revision = OMAP3525_REV(rev);
 		strcpy(cpu_name, "3525");
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 8d0841b..da9e8f8 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -180,6 +180,7 @@ IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_SUBCLASS(242x, 0x242)
 IS_OMAP_SUBCLASS(243x, 0x243)
 IS_OMAP_SUBCLASS(343x, 0x343)
+IS_OMAP_SUBCLASS(363x, 0x363)
 
 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
@@ -385,6 +386,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 						(omap3_has_sgx()) &	\
 						(!omap3_has_iva()))
 # define cpu_is_omap3530		(cpu_is_omap3430())
+# define cpu_is_omap3630()		is_omap363x()
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
@@ -415,6 +417,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES3_0	0x34303034
 #define OMAP3430_REV_ES3_1	0x34304034
 
+#define OMAP3630_REV_ES1_0	0x36300034
+
 #define OMAP35XX_CLASS		0x35000034
 #define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 12))
 #define OMAP3515_REV(v)		(OMAP35XX_CLASS | (0x3515 << 16) | (v << 12))
-- 
1.6.0.4

