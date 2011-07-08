From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 4/4] OMAP3: beagle rev-c4: enable OPP6
Date: Fri, 8 Jul 2011 18:56:28 +0300
Message-ID: <1310140588-26078-5-git-send-email-t-kristo@ti.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35157 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446Ab1GHP5K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 11:57:10 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@ti.com, broonie@opensource.wolfsonmicro.com

Beagleboard rev-c4 has a speed sorted OMAP3530 chip which can run at 720MHz.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   32 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.c      |    4 +++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6d3a266..bc3e5ed 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -574,6 +574,38 @@ static void __init beagle_opp_init(void)
 		return;
 	}
 
+	/* Custom OPP enabled for C4 */
+	if (omap3_beagle_version == OMAP3BEAGLE_BOARD_C4) {
+		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
+		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
+		struct device *dev;
+
+		if (!mh || !dh) {
+			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
+				__func__, mh, dh);
+		}
+		/* Enable MPU 720MHz opp */
+		dev = &mh->od->pdev.dev;
+		r = opp_enable(dev, 720000000);
+
+		/* Enable IVA 520MHz opp */
+		dev = &dh->od->pdev.dev;
+		r |= opp_enable(dev, 520000000);
+
+		if (r) {
+			pr_err("%s: failed to enable higher opp %d\n",
+				__func__, r);
+			/*
+			 * Cleanup - disable the higher freqs - we dont care
+			 * about the results
+			 */
+			dev = &mh->od->pdev.dev;
+			opp_disable(dev, 720000000);
+			dev = &dh->od->pdev.dev;
+			opp_disable(dev, 520000000);
+		}
+	}
+
 	/* Custom OPP enabled for all xM versions */
 	if (cpu_is_omap3630()) {
 		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index d95f3f9..a0f5fe1 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -98,6 +98,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
 	OPP_INITIALIZER("mpu", true, 550000000, OMAP3430_VDD_MPU_OPP4_UV),
 	/* MPU OPP5 */
 	OPP_INITIALIZER("mpu", true, 600000000, OMAP3430_VDD_MPU_OPP5_UV),
+	/* MPU OPP6 : omap3530 high speed grade only */
+	OPP_INITIALIZER("mpu", false, 720000000, OMAP3430_VDD_MPU_OPP5_UV),
 
 	/*
 	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
@@ -123,6 +125,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
 	OPP_INITIALIZER("iva", true, 400000000, OMAP3430_VDD_MPU_OPP4_UV),
 	/* DSP OPP5 */
 	OPP_INITIALIZER("iva", true, 430000000, OMAP3430_VDD_MPU_OPP5_UV),
+	/* DSP OPP6 : omap3530 high speed grade only */
+	OPP_INITIALIZER("iva", false, 520000000, OMAP3430_VDD_MPU_OPP5_UV),
 };
 
 static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

