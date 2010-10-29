From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 05/14] OMAP: Introduce device specific set rate and get rate in omap_device structure
Date: Fri, 29 Oct 2010 21:08:19 +0530
Message-ID: <1288366708-32302-6-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34611 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932801Ab0J2Pik (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 11:38:40 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch extends the omap_device structure to contain
pointers to scale the operating rate of the
device and to retrieve the operating rate of the device.
This patch also adds the three new APIs in the omap device layer
namely omap_device_set_rate that can be called to set a new operating
rate for a device, omap_device_get_rate that can be called to retrieve
the operating frequency for a device and omap_device_populate_rate_fns
to populte the device specific set_rate and get_rate API's.
The omap_device_set_rate and omap_device_get_rate does some routine error
checks and finally calls into the device specific set_rate
and get_rate APIs populated through omap_device_populate_rate_fns.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    9 +++++
 arch/arm/plat-omap/omap_device.c              |   49 +++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 28e2d1a..2a37345 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -50,6 +50,8 @@ extern struct device omap_device_parent;
  * @hwmods: (one .. many per omap_device)
  * @hwmods_cnt: ARRAY_SIZE() of @hwmods
  * @pm_lats: ptr to an omap_device_pm_latency table
+ * @set_rate: fn ptr to change the operating rate.
+ * @get_rate: fn ptr to retrieve the current operating rate.
  * @pm_lats_cnt: ARRAY_SIZE() of what is passed to @pm_lats
  * @pm_lat_level: array index of the last odpl entry executed - -1 if never
  * @dev_wakeup_lat: dev wakeup latency in nanoseconds
@@ -67,6 +69,8 @@ struct omap_device {
 	struct platform_device		pdev;
 	struct omap_hwmod		**hwmods;
 	struct omap_device_pm_latency	*pm_lats;
+	int (*set_rate)(struct device *dev, unsigned long rate);
+	unsigned long (*get_rate) (struct device *dev);
 	u32				dev_wakeup_lat;
 	u32				_dev_wakeup_lat_limit;
 	u8				pm_lats_cnt;
@@ -107,6 +111,11 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od);
 int omap_device_align_pm_lat(struct platform_device *pdev,
 			     u32 new_wakeup_lat_limit);
 struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
+int omap_device_set_rate(struct device *dev, unsigned long freq);
+unsigned long omap_device_get_rate(struct device *dev);
+void omap_device_populate_rate_fns(struct device *dev,
+		int (*set_rate)(struct device *dev, unsigned long rate),
+		unsigned long (*get_rate) (struct device *dev));
 
 /* Other */
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 7c902a6..ffe06eb 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -785,6 +785,55 @@ int omap_device_enable_clocks(struct omap_device *od)
 	return 0;
 }
 
+int omap_device_set_rate(struct device *dev, unsigned long freq)
+{
+	struct platform_device *pdev;
+	struct omap_device *od;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	od = _find_by_pdev(pdev);
+
+	if (!od->set_rate) {
+		dev_err(dev, "%s: No set_rate API for scaling device\n",
+			__func__);
+		return -ENODATA;
+	}
+
+	return od->set_rate(dev, freq);
+}
+
+unsigned long omap_device_get_rate(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct omap_device *od;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	od = _find_by_pdev(pdev);
+
+
+	if (!od->get_rate) {
+		dev_err(dev, "%s: No get rate API for the device\n",
+			__func__);
+		return 0;
+	}
+
+	return od->get_rate(dev);
+}
+
+void omap_device_populate_rate_fns(struct device *dev,
+		int (*set_rate)(struct device *dev, unsigned long rate),
+		unsigned long (*get_rate) (struct device *dev))
+{
+	struct platform_device *pdev;
+	struct omap_device *od;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	od = _find_by_pdev(pdev);
+
+	od->set_rate = set_rate;
+	od->get_rate = get_rate;
+}
+
 struct device omap_device_parent = {
 	.init_name	= "omap",
 	.parent         = &platform_bus,
-- 
1.7.0.4

