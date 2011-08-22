From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 1/3] OMAP: omap_device: Add omap_device_[alloc|delete] for DT integration
Date: Mon, 22 Aug 2011 20:22:21 +0200
Message-ID: <1314037343-19783-2-git-send-email-b-cousson@ti.com>
References: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55436 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1HVSXw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Aug 2011 14:23:52 -0400
In-Reply-To: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, grant.likely@secretlab.ca, Benoit Cousson <b-cousson@ti.com>

Split the omap_device_build_ss into two smaller functions
that will allow to populate a platform_device already alocated by
device-tree.
The functionality of the omap_device_build_ss is still the same, but
the omap_device_alloc will be usable with devices already built by
device-tree.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |  168 ++++++++++++++++++++++++++------------
 1 files changed, 114 insertions(+), 54 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index f2149be..752d72a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -96,6 +96,11 @@
 
 static int omap_device_register(struct platform_device *pdev);
 static int omap_early_device_register(struct platform_device *pdev);
+static struct omap_device *omap_device_alloc(struct platform_device *pdev,
+				      struct omap_hwmod **ohs, int oh_cnt,
+				      struct omap_device_pm_latency *pm_lats,
+				      int pm_lats_cnt);
+
 
 static struct omap_device_pm_latency omap_default_latency[] = {
 	{
@@ -397,6 +402,105 @@ static int omap_device_fill_resources(struct omap_device *od,
 }
 
 /**
+ * omap_device_alloc - allocate an omap_device
+ * @pdev: platform_device that will be represent this omap_device
+ * @oh: ptr to the single omap_hwmod that backs this omap_device
+ * @pdata: platform_data ptr to associate with the platform_device
+ * @pdata_len: amount of memory pointed to by @pdata
+ * @pm_lats: pointer to a omap_device_pm_latency array for this device
+ * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
+ *
+ * Convenience function for allocating an omap_device structure and filling
+ * hwmods, resources and pm_latency attributes.
+ *
+ * Returns an struct omap_device pointer or ERR_PTR() on error;
+ */
+static struct omap_device *omap_device_alloc(struct platform_device *pdev,
+					struct omap_hwmod **ohs, int oh_cnt,
+					struct omap_device_pm_latency *pm_lats,
+					int pm_lats_cnt)
+{
+	int ret = -ENOMEM;
+	struct omap_device *od;
+	struct resource *res = NULL;
+	int i, res_count;
+	struct omap_hwmod **hwmods;
+
+	od = kzalloc(sizeof(struct omap_device), GFP_KERNEL);
+	if (!od) {
+		ret = -ENOMEM;
+		goto oda_exit1;
+	}
+	od->hwmods_cnt = oh_cnt;
+
+	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt,
+			 GFP_KERNEL);
+	if (!hwmods)
+		goto oda_exit2;
+
+	memcpy(hwmods, ohs, sizeof(struct omap_hwmod *) * oh_cnt);
+	od->hwmods = hwmods;
+	od->pdev = pdev;
+
+	if (pdev->num_resources && pdev->resource)
+		dev_warn(&pdev->dev, "%s(): ressources already allocated %d\n",
+			__func__, pdev->num_resources);
+	/*
+	 * HACK: Idealy the resources from DT should match, and hwmod
+	 * should just add the missing ones. Since the name is not
+	 * properly populated by DT, stick to hwmod resources only.
+	 */
+	res_count = omap_device_count_resources(od);
+	if (res_count > 0) {
+		dev_dbg(&pdev->dev, "%s(): ressources allocated from hwmod %d\n",
+			__func__, res_count);
+		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
+		if (!res)
+			goto oda_exit3;
+
+		omap_device_fill_resources(od, res);
+
+		ret = platform_device_add_resources(pdev, res, res_count);
+		kfree(res);
+
+		if (ret)
+			goto oda_exit3;
+	}
+
+	if (pm_lats) {
+		od->pm_lats = pm_lats;
+		od->pm_lats_cnt = pm_lats_cnt;
+	} else {
+		od->pm_lats = omap_default_latency;
+		od->pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
+	}
+
+	pdev->archdata.od = od;
+
+	for (i = 0; i < oh_cnt; i++) {
+		hwmods[i]->od = od;
+		_add_hwmod_clocks_clkdev(od, hwmods[i]);
+	}
+
+	return od;
+
+oda_exit3:
+	kfree(hwmods);
+oda_exit2:
+	kfree(od);
+oda_exit1:
+	dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
+
+	return ERR_PTR(ret);
+}
+
+void omap_device_delete(struct omap_device *od)
+{
+	kfree(od->hwmods);
+	kfree(od);
+}
+
+/**
  * omap_device_build - build and register an omap_device with one omap_hwmod
  * @pdev_name: name of the platform_device driver to use
  * @pdev_id: this platform_device's connection ID
@@ -455,9 +559,6 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	int ret = -ENOMEM;
 	struct platform_device *pdev;
 	struct omap_device *od;
-	struct resource *res = NULL;
-	int i, res_count;
-	struct omap_hwmod **hwmods;
 
 	if (!ohs || oh_cnt == 0 || !pdev_name)
 		return ERR_PTR(-EINVAL);
@@ -471,72 +572,31 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 		goto odbs_exit;
 	}
 
-	pr_debug("omap_device: %s: building with %d hwmods\n", pdev_name,
-		 oh_cnt);
+	/* Set the dev_name early to allow dev_xxx in omap_device_alloc */
+	if (pdev->id != -1)
+		dev_set_name(&pdev->dev, "%s.%d", pdev->name,  pdev->id);
+	else
+		dev_set_name(&pdev->dev, "%s", pdev->name);
 
-	od = kzalloc(sizeof(struct omap_device), GFP_KERNEL);
-	if (!od) {
-		ret = -ENOMEM;
+	od = omap_device_alloc(pdev, ohs, oh_cnt, pm_lats, pm_lats_cnt);
+	if (!od)
 		goto odbs_exit1;
-	}
-	od->hwmods_cnt = oh_cnt;
-
-	hwmods = kzalloc(sizeof(struct omap_hwmod *) * oh_cnt,
-			 GFP_KERNEL);
-	if (!hwmods)
-		goto odbs_exit2;
-
-	memcpy(hwmods, ohs, sizeof(struct omap_hwmod *) * oh_cnt);
-	od->hwmods = hwmods;
-	od->pdev = pdev;
-
-	res_count = omap_device_count_resources(od);
-	if (res_count > 0) {
-		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
-		if (!res)
-			goto odbs_exit3;
-
-		omap_device_fill_resources(od, res);
-
-		ret = platform_device_add_resources(pdev, res, res_count);
-		kfree(res);
-
-		if (ret)
-			goto odbs_exit3;
-	}
 
 	ret = platform_device_add_data(pdev, pdata, pdata_len);
 	if (ret)
-		goto odbs_exit3;
-
-	pdev->archdata.od = od;
+		goto odbs_exit2;
 
 	if (is_early_device)
 		ret = omap_early_device_register(pdev);
 	else
 		ret = omap_device_register(pdev);
 	if (ret)
-		goto odbs_exit3;
-
-	if (pm_lats) {
-		od->pm_lats = pm_lats;
-		od->pm_lats_cnt = pm_lats_cnt;
-	} else {
-		od->pm_lats = omap_default_latency;
-		od->pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
-	}
-
-	for (i = 0; i < oh_cnt; i++) {
-		hwmods[i]->od = od;
-		_add_hwmod_clocks_clkdev(od, hwmods[i]);
-	}
+		goto odbs_exit2;
 
 	return pdev;
 
-odbs_exit3:
-	kfree(hwmods);
 odbs_exit2:
-	kfree(od);
+	omap_device_delete(od);
 odbs_exit1:
 	platform_device_put(pdev);
 odbs_exit:
-- 
1.7.0.4

