From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple platform_device from omap_device
Date: Thu, 21 Jul 2011 16:52:18 -0700
Message-ID: <1311292338-11830-9-git-send-email-khilman@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51520 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753223Ab1GUXwZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 19:52:25 -0400
Received: by mail-iy0-f179.google.com with SMTP id 35so1398764iyn.38
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 16:52:24 -0700 (PDT)
In-Reply-To: <1311292338-11830-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Rather than embedding a struct platform_device inside a struct
omap_device, decouple them, leaving only a pointer to the
platform_device inside the omap_device.

This patch uses devres to allocate and attach the omap_device to the
struct device, so finding an omap_device from a struct device means
using devres_find(), and the to_omap_device() helper function was
modified accordingly.

RFC/Hack alert:

Currently the driver core (drivers/base/dd.c) doesn't expect any
devres resources to exist before the driver's ->probe() is called.  In
this patch, I just comment out the warning, but we'll need to
understand why that limitation exists, and if it's a real limitation.
A first glance suggests that it's not really needed.  If this is a
true limitation, we'll need to find some way other than devres to
attach an omap_device to a struct device.

On OMAP, we will need an omap_device attached to a struct device
before probe because device HW may be disabled in probe and drivers
are expected to use runtime PM in ->probe() to activate the hardware
before access.  Because the runtime PM API calls use omap_device (via
our PM domain layer), we need omap_device attached to a
platform_device before probe.
---
 arch/arm/mach-omap2/opp.c                     |    2 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    4 +-
 arch/arm/plat-omap/omap_device.c              |   78 +++++++++++++++----------
 drivers/base/dd.c                             |    2 +-
 4 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index ab8b35b..9262a6b 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -69,7 +69,7 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 				opp_def->hwmod_name, i);
 			return -EINVAL;
 		}
-		dev = &oh->od->pdev.dev;
+		dev = &oh->od->pdev->dev;
 
 		r = opp_add(dev, opp_def->freq, opp_def->u_volt);
 		if (r) {
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 7a3ec4f..6bd4f6f 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -64,7 +64,7 @@ extern struct device omap_device_parent;
  *
  */
 struct omap_device {
-	struct platform_device		pdev;
+	struct platform_device		*pdev;
 	struct omap_hwmod		**hwmods;
 	struct omap_device_pm_latency	*pm_lats;
 	u32				dev_wakeup_lat;
@@ -142,6 +142,6 @@ struct omap_device_pm_latency {
 #define OMAP_DEVICE_LATENCY_AUTO_ADJUST BIT(1)
 
 /* Get omap_device pointer from platform_device pointer */
-#define to_omap_device(x) container_of((x), struct omap_device, pdev)
+struct omap_device *to_omap_device(struct platform_device *pdev);
 
 #endif
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index c420b94..52ce013 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -117,7 +117,7 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 {
 	struct timespec a, b, c;
 
-	dev_dbg(&od->pdev.dev, "omap_device: activating\n");
+	dev_dbg(&od->pdev->dev, "omap_device: activating\n");
 
 	while (od->pm_lat_level > 0) {
 		struct omap_device_pm_latency *odpl;
@@ -141,7 +141,7 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		c = timespec_sub(b, a);
 		act_lat = timespec_to_ns(&c);
 
-		dev_dbg(&od->pdev.dev,
+		dev_dbg(&od->pdev->dev,
 			"omap_device: pm_lat %d: activate: elapsed time "
 			"%llu nsec\n", od->pm_lat_level, act_lat);
 
@@ -149,12 +149,12 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 			odpl->activate_lat_worst = act_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->activate_lat = act_lat;
-				dev_warn(&od->pdev.dev,
+				dev_warn(&od->pdev->dev,
 					 "new worst case activate latency "
 					 "%d: %llu\n",
 					 od->pm_lat_level, act_lat);
 			} else
-				dev_warn(&od->pdev.dev,
+				dev_warn(&od->pdev->dev,
 					 "activate latency %d "
 					 "higher than exptected. (%llu > %d)\n",
 					 od->pm_lat_level, act_lat,
@@ -185,7 +185,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 {
 	struct timespec a, b, c;
 
-	dev_dbg(&od->pdev.dev, "omap_device: deactivating\n");
+	dev_dbg(&od->pdev->dev, "omap_device: deactivating\n");
 
 	while (od->pm_lat_level < od->pm_lats_cnt) {
 		struct omap_device_pm_latency *odpl;
@@ -208,7 +208,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		c = timespec_sub(b, a);
 		deact_lat = timespec_to_ns(&c);
 
-		dev_dbg(&od->pdev.dev,
+		dev_dbg(&od->pdev->dev,
 			"omap_device: pm_lat %d: deactivate: elapsed time "
 			"%llu nsec\n", od->pm_lat_level, deact_lat);
 
@@ -216,12 +216,12 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 			odpl->deactivate_lat_worst = deact_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->deactivate_lat = deact_lat;
-				dev_warn(&od->pdev.dev,
+				dev_warn(&od->pdev->dev,
 					 "new worst case deactivate latency "
 					 "%d: %llu\n",
 					 od->pm_lat_level, deact_lat);
 			} else
-				dev_warn(&od->pdev.dev,
+				dev_warn(&od->pdev->dev,
 					 "deactivate latency %d "
 					 "higher than exptected. (%llu > %d)\n",
 					 od->pm_lat_level, deact_lat,
@@ -245,11 +245,11 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 	if (!clk_alias || !clk_name)
 		return;
 
-	dev_dbg(&od->pdev.dev, "Creating %s -> %s\n", clk_alias, clk_name);
+	dev_dbg(&od->pdev->dev, "Creating %s -> %s\n", clk_alias, clk_name);
 
-	r = clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
+	r = clk_get_sys(dev_name(&od->pdev->dev), clk_alias);
 	if (!IS_ERR(r)) {
-		dev_warn(&od->pdev.dev,
+		dev_warn(&od->pdev->dev,
 			 "alias %s already exists\n", clk_alias);
 		clk_put(r);
 		return;
@@ -257,14 +257,14 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 
 	r = omap_clk_get_by_name(clk_name);
 	if (IS_ERR(r)) {
-		dev_err(&od->pdev.dev,
+		dev_err(&od->pdev->dev,
 			"omap_clk_get_by_name for %s failed\n", clk_name);
 		return;
 	}
 
-	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
+	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev->dev));
 	if (!l) {
-		dev_err(&od->pdev.dev,
+		dev_err(&od->pdev->dev,
 			"clkdev_alloc for %s failed\n", clk_alias);
 		return;
 	}
@@ -351,7 +351,7 @@ static int omap_device_count_resources(struct omap_device *od)
 		c += omap_hwmod_count_resources(od->hwmods[i]);
 
 	pr_debug("omap_device: %s: counted %d total resources across %d "
-		 "hwmods\n", od->pdev.name, c, od->hwmods_cnt);
+		 "hwmods\n", od->pdev->name, c, od->hwmods_cnt);
 
 	return c;
 }
@@ -388,6 +388,21 @@ static int omap_device_fill_resources(struct omap_device *od,
 	return 0;
 }
 
+static void _od_dr_release(struct device *dev, void *res)
+{
+	kfree(res);
+}
+
+struct omap_device *to_omap_device(struct platform_device *pdev)
+{
+	void *res;
+
+	res = devres_find(&pdev->dev, _od_dr_release, NULL, NULL);
+	WARN_ON(!res);
+
+	return (struct omap_device *)res;
+}
+
 /**
  * omap_device_build - build and register an omap_device with one omap_hwmod
  * @pdev_name: name of the platform_device driver to use
@@ -445,8 +460,8 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 int pm_lats_cnt, int is_early_device)
 {
 	int ret = -ENOMEM;
+	struct platform_device *pdev;
 	struct omap_device *od;
-	char *pdev_name2;
 	struct resource *res = NULL;
 	int i, res_count;
 	struct omap_hwmod **hwmods;
@@ -460,7 +475,8 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	pr_debug("omap_device: %s: building with %d hwmods\n", pdev_name,
 		 oh_cnt);
 
-	od = kzalloc(sizeof(struct omap_device), GFP_KERNEL);
+	od = devres_alloc(_od_dr_release, sizeof(struct omap_device),
+			  GFP_KERNEL);
 	if (!od)
 		return ERR_PTR(-ENOMEM);
 
@@ -474,13 +490,9 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	memcpy(hwmods, ohs, sizeof(struct omap_hwmod *) * oh_cnt);
 	od->hwmods = hwmods;
 
-	pdev_name2 = kzalloc(strlen(pdev_name) + 1, GFP_KERNEL);
-	if (!pdev_name2)
+	pdev = platform_device_alloc(pdev_name, pdev_id);
+	if (!pdev)
 		goto odbs_exit2;
-	strcpy(pdev_name2, pdev_name);
-
-	od->pdev.name = pdev_name2;
-	od->pdev.id = pdev_id;
 
 	res_count = omap_device_count_resources(od);
 	if (res_count > 0) {
@@ -490,35 +502,37 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	}
 	omap_device_fill_resources(od, res);
 
-	od->pdev.num_resources = res_count;
-	od->pdev.resource = res;
+	pdev->num_resources = res_count;
+	pdev->resource = res;
 
-	ret = platform_device_add_data(&od->pdev, pdata, pdata_len);
+	ret = platform_device_add_data(pdev, pdata, pdata_len);
 	if (ret)
 		goto odbs_exit4;
 
 	od->pm_lats = pm_lats;
 	od->pm_lats_cnt = pm_lats_cnt;
 
-	if (is_early_device)
-		ret = omap_early_device_register(&od->pdev);
-	else
-		ret = omap_device_register(&od->pdev);
+	od->pdev = pdev;
+	devres_add(&pdev->dev, od);
 
 	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
 		_add_hwmod_clocks_clkdev(od, hwmods[i]);
 	}
 
+	if (is_early_device)
+		ret = omap_early_device_register(pdev);
+	else
+		ret = omap_device_register(pdev);
+
 	if (ret)
 		goto odbs_exit4;
 
-	return &od->pdev;
+	return pdev;
 
 odbs_exit4:
 	kfree(res);
 odbs_exit3:
-	kfree(pdev_name2);
 odbs_exit2:
 	kfree(hwmods);
 odbs_exit1:
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 6658da7..9289dac 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -112,7 +112,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
-	WARN_ON(!list_empty(&dev->devres_head));
+	/* WARN_ON(!list_empty(&dev->devres_head)); */
 
 	dev->driver = drv;
 	if (driver_sysfs_add(dev)) {
-- 
1.7.6

