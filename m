From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 1/5] TEMP: OMAP3: beagle rev-c4: enable OPP6
Date: Fri, 9 Dec 2011 17:29:45 +0200
Message-ID: <1323444589-19940-2-git-send-email-t-kristo@ti.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59047 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1LIP37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 10:29:59 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pB9FTwVn019847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:59 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTw7F000572
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:58 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTwSB018707
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:58 -0600 (CST)
Received: from localhost.localdomain (h88-4.vpn.ti.com [172.24.88.4])	by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTtvC006466	for
 <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:57 -0600
In-Reply-To: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Beagleboard rev-c4 has a speed sorted OMAP3530 chip which can run at 720MHz.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   29 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.c      |    4 ++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 3ae16b4..a7c3d60 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -489,6 +489,35 @@ static void __init beagle_opp_init(void)
 		return;
 	}
 
+	if (omap3_beagle_version == OMAP3BEAGLE_BOARD_C4) {
+		struct device *mpu_dev, *iva_dev;
+
+		mpu_dev = omap2_get_mpuss_device();
+		iva_dev = omap2_get_iva_device();
+
+		if (!mpu_dev || !iva_dev) {
+			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
+				__func__, mpu_dev, iva_dev);
+			return;
+		}
+		/* Enable MPU 720MHz opp */
+		r = opp_enable(mpu_dev, 720000000);
+
+		/* Enable IVA 520MHz opp */
+		r |= opp_enable(iva_dev, 520000000);
+
+		if (r) {
+			pr_err("%s: failed to enable higher opp %d\n",
+				__func__, r);
+			/*
+			 * Cleanup - disable the higher freqs - we dont care
+			 * about the results
+			 */
+			opp_disable(mpu_dev, 720000000);
+			opp_disable(iva_dev, 520000000);
+		}
+	}
+
 	/* Custom OPP enabled for all xM versions */
 	if (cpu_is_omap3630()) {
 		struct device *mpu_dev, *iva_dev;
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

