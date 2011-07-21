From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
Date: Thu, 21 Jul 2011 16:52:13 -0700
Message-ID: <1311292338-11830-4-git-send-email-khilman@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:58750 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753199Ab1GUXwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 19:52:12 -0400
Received: by mail-iy0-f175.google.com with SMTP id 12so1551716iyj.20
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 16:52:10 -0700 (PDT)
In-Reply-To: <1311292338-11830-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Board code should not touch omap_device internals.  To get the MPU/IVA devices,
use existing APIs: omap2_get_mpu_device(), omap2_get_iva_device().

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 32f5f89..3ae16b4 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -491,23 +491,22 @@ static void __init beagle_opp_init(void)
 
 	/* Custom OPP enabled for all xM versions */
 	if (cpu_is_omap3630()) {
-		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
-		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
-		struct device *dev;
+		struct device *mpu_dev, *iva_dev;
 
-		if (!mh || !dh) {
+		mpu_dev = omap2_get_mpuss_device();
+		iva_dev = omap2_get_iva_device();
+
+		if (!mpu_dev || !iva_dev) {
 			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
-				__func__, mh, dh);
+				__func__, mpu_dev, iva_dev);
 			return;
 		}
 		/* Enable MPU 1GHz and lower opps */
-		dev = &mh->od->pdev.dev;
-		r = opp_enable(dev, 800000000);
+		r = opp_enable(mpu_dev, 800000000);
 		/* TODO: MPU 1GHz needs SR and ABB */
 
 		/* Enable IVA 800MHz and lower opps */
-		dev = &dh->od->pdev.dev;
-		r |= opp_enable(dev, 660000000);
+		r |= opp_enable(iva_dev, 660000000);
 		/* TODO: DSP 800MHz needs SR and ABB */
 		if (r) {
 			pr_err("%s: failed to enable higher opp %d\n",
@@ -516,10 +515,8 @@ static void __init beagle_opp_init(void)
 			 * Cleanup - disable the higher freqs - we dont care
 			 * about the results
 			 */
-			dev = &mh->od->pdev.dev;
-			opp_disable(dev, 800000000);
-			dev = &dh->od->pdev.dev;
-			opp_disable(dev, 660000000);
+			opp_disable(mpu_dev, 800000000);
+			opp_disable(iva_dev, 660000000);
 		}
 	}
 	return;
-- 
1.7.6

