From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2] OMAP3: introduce OMAP3630
Date: Thu,  8 Oct 2009 12:31:52 -0500
Message-ID: <1255023112-14125-1-git-send-email-nm@ti.com>
References: <[RFC][PATCH] OMAP3: introduce OMAP3630>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35378 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757915AbZJHRcj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Oct 2009 13:32:39 -0400
In-Reply-To: <[RFC][PATCH] OMAP3: introduce OMAP3630>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Vikram Pandita <vikram.pandita@ti.com>, Allen Pais <allen.pais@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>

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

This patch was tested on SDP3430. zoom3/sdp3630 support needs
further follow on patches

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
---
 arch/arm/mach-omap2/id.c              |   31 ++++++++++++++++++++++++++++---
 arch/arm/plat-omap/include/mach/cpu.h |    6 ++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 03b80f2..3fc5e4e 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -186,6 +186,7 @@ void __init omap3_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
+	u16 omap_type;
 	u8 rev;
 	char *rev_name = "ES1.0";
 
@@ -210,7 +211,10 @@ void __init omap3_check_revision(void)
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0xff;
 
-	if (hawkeye == 0xb7ae) {
+	omap_type = omap_rev() >> 16;
+	switch (hawkeye) {
+	case 0xb7ae:
+		/* Handle 34xx devices */
 		switch (rev) {
 		case 0:
 			omap_revision = OMAP3430_REV_ES2_0;
@@ -231,12 +235,33 @@ void __init omap3_check_revision(void)
 		default:
 			/* Use the latest known revision as default */
 			omap_revision = OMAP3430_REV_ES3_1;
-			rev_name = "Unknown revision\n";
+			rev_name = "Unknown 34xx revision\n";
 		}
+		break;
+	case 0xb891:
+		/* Handle 36xx devices
+		 * But, override for display purposes
+		 */
+		omap_type = 0x3630;
+		switch (rev) {
+		case 0:
+			omap_revision = OMAP3630_REV_ES1_0;
+			rev_name = "ES1.0";
+			break;
+		default:
+			/* Use the latest known revision as default */
+			omap_revision = OMAP3630_REV_ES1_0;
+			rev_name = "Unknown 36xx revision\n";
+		}
+		break;
+	default:
+		/* Unknown default to latest rev as default*/
+		omap_revision = OMAP3630_REV_ES1_0;
+		rev_name = "Unknown revision\n";
 	}
 
 out:
-	pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
+	pr_info("OMAP%04x %s\n", omap_type, rev_name);
 }
 
 #define OMAP3_SHOW_FEATURE(feat)		\
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 431fec4..af1080f 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -383,6 +383,12 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES2_1	0x34302034
 #define OMAP3430_REV_ES3_0	0x34303034
 #define OMAP3430_REV_ES3_1	0x34304034
+/* NOTE: Add 36xx series below
+ * If additional 34xx series are added, OMAP3430_REV_ESXXXX can be
+ * added above the 3630 defines and series renumbered to ensure
+ * rev() > checks to work
+ */
+#define OMAP3630_REV_ES1_0	0x34305034
 
 #define OMAP443X_CLASS		0x44300034
 
-- 
1.6.0.4

