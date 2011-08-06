From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 9/9] OMAP: omap_device: decouple platform_device from omap_device
Date: Fri,  5 Aug 2011 17:19:25 -0700
Message-ID: <1312589965-19416-10-git-send-email-khilman@ti.com>
References: <1312589965-19416-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:47086 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932323Ab1HFATo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 20:19:44 -0400
Received: by mail-iy0-f173.google.com with SMTP id 2so5257392iyk.32
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 17:19:43 -0700 (PDT)
In-Reply-To: <1312589965-19416-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org

Rather than embedding a struct platform_device inside a struct
omap_device, decouple them, leaving only a pointer to the
platform_device inside the omap_device.

Use the arch-specific data field of the platform_device (pdev_archdata)
to add an omap_device pointer after the platform_device has been created.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/opp.c                     |    2 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    7 +-
 arch/arm/plat-omap/omap_device.c              |  100 +++++++++++++------------
 3 files changed, 58 insertions(+), 51 deletions(-)

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
index 4f98770..d4d9b96 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -68,7 +68,7 @@ extern struct device omap_device_parent;
  *
  */
 struct omap_device {
-	struct platform_device		pdev;
+	struct platform_device		*pdev;
 	struct omap_hwmod		**hwmods;
 	struct omap_device_pm_latency	*pm_lats;
 	u32				dev_wakeup_lat;
@@ -146,7 +146,10 @@ struct omap_device_pm_latency {
 #define OMAP_DEVICE_LATENCY_AUTO_ADJUST BIT(1)
 
 /* Get omap_device pointer from platform_device pointer */
-#define to_omap_device(x) container_of((x), struct omap_device, pdev)
+static inline struct omap_device *to_omap_device(struct platform_device *pdev)
+{
+	return pdev ? pdev->archdata.od : NULL;
+}
 
 static inline
 void omap_device_disable_idle_on_suspend(struct platform_device *pdev)
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 351df31..d8f2299 100644
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
-				dev_dbg(&od->pdev.dev,
+				dev_dbg(&od->pdev->dev,
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
-				dev_dbg(&od->pdev.dev,
+				dev_dbg(&od->pdev->dev,
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
@@ -445,8 +445,8 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 int pm_lats_cnt, int is_early_device)
 {
 	int ret = -ENOMEM;
+	struct platform_device *pdev;
 	struct omap_device *od;
-	char *pdev_name2;
 	struct resource *res = NULL;
 	int i, res_count;
 	struct omap_hwmod **hwmods;
@@ -457,72 +457,76 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	if (!pdata && pdata_len > 0)
 		return ERR_PTR(-EINVAL);
 
+	pdev = platform_device_alloc(pdev_name, pdev_id);
+	if (!pdev) {
+		ret = -ENOMEM;
+		goto odbs_exit;
+	}
+
 	pr_debug("omap_device: %s: building with %d hwmods\n", pdev_name,
 		 oh_cnt);
 
 	od = kzalloc(sizeof(struct omap_device), GFP_KERNEL);
-	if (!od)
-		return ERR_PTR(-ENOMEM);
-
+	if (!od) {
+		ret = -ENOMEM;
+		goto odbs_exit1;
+	}
 	od->hwmods_cnt = oh_cnt;
 
 	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt,
 			 GFP_KERNEL);
 	if (!hwmods)
-		goto odbs_exit1;
+		goto odbs_exit2;
 
 	memcpy(hwmods, ohs, sizeof(struct omap_hwmod *) * oh_cnt);
 	od->hwmods = hwmods;
-
-	pdev_name2 = kzalloc(strlen(pdev_name) + 1, GFP_KERNEL);
-	if (!pdev_name2)
-		goto odbs_exit2;
-	strcpy(pdev_name2, pdev_name);
-
-	od->pdev.name = pdev_name2;
-	od->pdev.id = pdev_id;
+	od->pdev = pdev;
 
 	res_count = omap_device_count_resources(od);
 	if (res_count > 0) {
 		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
 		if (!res)
 			goto odbs_exit3;
-	}
-	omap_device_fill_resources(od, res);
 
-	od->pdev.num_resources = res_count;
-	od->pdev.resource = res;
+		omap_device_fill_resources(od, res);
 
-	ret = platform_device_add_data(&od->pdev, pdata, pdata_len);
+		ret = platform_device_add_resources(pdev, res, res_count);
+		kfree(res);
+
+		if (ret)
+			goto odbs_exit3;
+	}
+
+	ret = platform_device_add_data(pdev, pdata, pdata_len);
 	if (ret)
-		goto odbs_exit4;
+		goto odbs_exit3;
 
-	od->pm_lats = pm_lats;
-	od->pm_lats_cnt = pm_lats_cnt;
+	pdev->archdata.od = od;
 
 	if (is_early_device)
-		ret = omap_early_device_register(&od->pdev);
+		ret = omap_early_device_register(pdev);
 	else
-		ret = omap_device_register(&od->pdev);
+		ret = omap_device_register(pdev);
+	if (ret)
+		goto odbs_exit3;
+
+	od->pm_lats = pm_lats;
+	od->pm_lats_cnt = pm_lats_cnt;
 
 	for (i = 0; i < oh_cnt; i++) {
 		hwmods[i]->od = od;
 		_add_hwmod_clocks_clkdev(od, hwmods[i]);
 	}
 
-	if (ret)
-		goto odbs_exit4;
-
-	return &od->pdev;
+	return pdev;
 
-odbs_exit4:
-	kfree(res);
 odbs_exit3:
-	kfree(pdev_name2);
-odbs_exit2:
 	kfree(hwmods);
-odbs_exit1:
+odbs_exit2:
 	kfree(od);
+odbs_exit1:
+	platform_device_put(pdev);
+odbs_exit:
 
 	pr_err("omap_device: %s: build failed (%d)\n", pdev_name, ret);
 
@@ -640,7 +644,7 @@ static int omap_device_register(struct platform_device *pdev)
 
 	pdev->dev.parent = &omap_device_parent;
 	pdev->dev.pm_domain = &omap_device_pm_domain;
-	return platform_device_register(pdev);
+	return platform_device_add(pdev);
 }
 
 
-- 
1.7.6

