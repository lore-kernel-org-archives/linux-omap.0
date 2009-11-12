From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] omap3: Introduce OMAP3630
Date: Wed, 11 Nov 2009 19:03:37 -0800
Message-ID: <20091112030337.5159.87204.stgit@localhost>
References: <20091112025802.5159.97598.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59830 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760039AbZKLDDe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 22:03:34 -0500
In-Reply-To: <20091112025802.5159.97598.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Vikram Pandita <vikram.pandita@ti.com>, Sanjeev Premi <premi@ti.com>, Allen Pais <allen.pais@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>

From: Nishanth Menon <nm@ti.com>

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
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c              |   24 +++++++++++++++++++++---
 arch/arm/plat-omap/include/plat/cpu.h |    6 ++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 88999ea..1c15112 100644
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
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index a674393..f4f7a2f 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -180,6 +180,7 @@ IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_SUBCLASS(242x, 0x242)
 IS_OMAP_SUBCLASS(243x, 0x243)
 IS_OMAP_SUBCLASS(343x, 0x343)
+IS_OMAP_SUBCLASS(363x, 0x363)
 
 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
@@ -325,6 +326,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_is_omap3525()		0
 #define cpu_is_omap3530()		0
 #define cpu_is_omap3430()		0
+#define cpu_is_omap3630()		0
 
 /*
  * Whether we have MULTI_OMAP1 or not, we still need to distinguish
@@ -389,6 +391,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 						(omap3_has_sgx()) &&	\
 						(!omap3_has_iva()))
 # define cpu_is_omap3530()		(cpu_is_omap3430())
+# undef cpu_is_omap3630
+# define cpu_is_omap3630()		is_omap363x()
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
@@ -419,6 +423,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES3_0	0x34303034
 #define OMAP3430_REV_ES3_1	0x34304034
 
+#define OMAP3630_REV_ES1_0	0x36300034
+
 #define OMAP35XX_CLASS		0x35000034
 #define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 12))
 #define OMAP3515_REV(v)		(OMAP35XX_CLASS | (0x3515 << 16) | (v << 12))

