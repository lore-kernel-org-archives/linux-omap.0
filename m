From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 6/7] OMAP: omap_device: device register functions now take platform_device pointer
Date: Thu, 21 Jul 2011 16:52:17 -0700
Message-ID: <1311292338-11830-8-git-send-email-khilman@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:35278 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753223Ab1GUXwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 19:52:23 -0400
Received: by mail-iy0-f179.google.com with SMTP id 35so1327193iyn.10
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 16:52:22 -0700 (PDT)
In-Reply-To: <1311292338-11830-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

The internal device register functions do not need or use any omap_device
internals, so pass in a platform_device pointer instead of an omap_device
pointer.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 932a7e6..c420b94 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -94,8 +94,8 @@
 #define USE_WAKEUP_LAT			0
 #define IGNORE_WAKEUP_LAT		1
 
-static int omap_device_register(struct omap_device *od);
-static int omap_early_device_register(struct omap_device *od);
+static int omap_device_register(struct platform_device *pdev);
+static int omap_early_device_register(struct platform_device *pdev);
 
 /* Private functions */
 
@@ -501,9 +501,9 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	od->pm_lats_cnt = pm_lats_cnt;
 
 	if (is_early_device)
-		ret = omap_early_device_register(od);
+		ret = omap_early_device_register(&od->pdev);
 	else
-		ret = omap_device_register(od);
+		ret = omap_device_register(&od->pdev);
 
 	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
@@ -538,11 +538,11 @@ odbs_exit1:
  * platform_early_add_device() on the underlying platform_device.
  * Returns 0 by default.
  */
-static int omap_early_device_register(struct omap_device *od)
+static int omap_early_device_register(struct platform_device *pdev)
 {
 	struct platform_device *devices[1];
 
-	devices[0] = &(od->pdev);
+	devices[0] = pdev;
 	early_platform_add_devices(devices, 1);
 	return 0;
 }
@@ -591,13 +591,13 @@ static struct dev_power_domain omap_device_power_domain = {
  * platform_device_register() on the underlying platform_device.
  * Returns the return value of platform_device_register().
  */
-static int omap_device_register(struct omap_device *od)
+static int omap_device_register(struct platform_device *pdev)
 {
-	pr_debug("omap_device: %s: registering\n", od->pdev.name);
+	pr_debug("omap_device: %s: registering\n", pdev->name);
 
-	od->pdev.dev.parent = &omap_device_parent;
-	od->pdev.dev.pwr_domain = &omap_device_power_domain;
-	return platform_device_register(&od->pdev);
+	pdev->dev.parent = &omap_device_parent;
+	pdev->dev.pwr_domain = &omap_device_power_domain;
+	return platform_device_add(pdev);
 }
 
 
-- 
1.7.6

