From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH 2/2] OMAP3: PM: Update SRF driver to use omap_device layer
Date: Mon, 27 Jul 2009 16:58:42 +0530
Message-ID: <1248694122-7230-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47025 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbZG0L2t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jul 2009 07:28:49 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n6RBSh5p007214
	for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2009 06:28:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ranjithl@ti.com

This patch will fix the build issues currently seen when SRF driver is selected
for DVFS (cpufreq) support. SRF code is updated to use the new omap_device layer.

Patch tested on OMAP3 EVM.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/plat-omap/omap-pm-srf.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
index cac08e4..4350650 100644
--- a/arch/arm/plat-omap/omap-pm-srf.c
+++ b/arch/arm/plat-omap/omap-pm-srf.c
@@ -26,7 +26,7 @@
 #include <mach/omap-pm.h>
 #include <mach/powerdomain.h>
 #include <mach/resource.h>
-#include <mach/omapdev.h>
+#include <mach/omap_device.h>
 
 struct omap_opp *dsp_opps;
 struct omap_opp *mpu_opps;
@@ -96,7 +96,7 @@ void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 
 void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)
 {
-	struct omapdev *odev;
+	struct omap_device *odev;
 	struct powerdomain *pwrdm_dev;
 	struct platform_device *pdev;
 	char *lat_res_name;
@@ -121,9 +121,9 @@ void omap_pm_set_max_dev_wakeup_lat(struct device *dev, long t)
 		return;
 	}
 
-	odev = omapdev_find_pdev(pdev);
+	odev = omap_device_find_pdev(pdev);
 	if (odev) {
-		pwrdm_dev = omapdev_get_pwrdm(odev);
+		pwrdm_dev = omap_device_get_pwrdm(odev);
 	} else {
 		printk(KERN_ERR "OMAP-PM: Error: Could not find omapdev "
 						"for %s\n", pdev->name);
@@ -277,7 +277,7 @@ EXPORT_SYMBOL(omap_pm_cpu_get_freq);
 int omap_pm_get_dev_context_loss_count(struct device *dev)
 {
 	struct platform_device *pdev;
-	struct omapdev *odev;
+	struct omap_device *odev;
 	struct powerdomain *pwrdm;
 
 	if (!dev) {
@@ -293,10 +293,10 @@ int omap_pm_get_dev_context_loss_count(struct device *dev)
 	 * off counter.
 	 */
 	pdev = to_platform_device(dev);
-	odev = omapdev_find_pdev(pdev);
+	odev = omap_device_find_pdev(pdev);
 
 	if (odev) {
-		pwrdm = omapdev_get_pwrdm(odev);
+		pwrdm = omap_device_get_pwrdm(odev);
 		if (pwrdm)
 			return pwrdm->state_counter[0];
 	}
-- 
1.6.2.4

