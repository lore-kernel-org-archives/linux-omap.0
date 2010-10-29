From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 08/14] OMAP: Introduce device scale
Date: Fri, 29 Oct 2010 21:08:22 +0530
Message-ID: <1288366708-32302-9-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51563 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932823Ab0J2Pik (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 11:38:40 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds omap_device_scale API  which can be used to generic
device rate scaling.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    3 +-
 arch/arm/plat-omap/omap_device.c              |   78 +++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 2a37345..daafb5a 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -116,6 +116,8 @@ unsigned long omap_device_get_rate(struct device *dev);
 void omap_device_populate_rate_fns(struct device *dev,
 		int (*set_rate)(struct device *dev, unsigned long rate),
 		unsigned long (*get_rate) (struct device *dev));
+int omap_device_scale(struct device *req_dev, struct device *dev,
+		unsigned long rate);
 
 /* Other */
 
@@ -125,7 +127,6 @@ int omap_device_enable_hwmods(struct omap_device *od);
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
 
-
 /*
  * Entries should be kept in latency order ascending
  *
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index ffe06eb..a273230 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -83,6 +83,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/opp.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -834,6 +835,83 @@ void omap_device_populate_rate_fns(struct device *dev,
 	od->get_rate = get_rate;
 }
 
+/**
+ * omap_device_scale() - Set a new rate at which the device is to operate
+ * @req_dev:	pointer to the device requesting the scaling.
+ * @dev:	pointer to the device that is to be scaled
+ * @rate:	the rnew rate for the device.
+ *
+ * This API gets the device opp table associated with this device and
+ * tries putting the device to the requested rate and the voltage domain
+ * associated with the device to the voltage corresponding to the
+ * requested rate. Since multiple devices can be assocciated with a
+ * voltage domain this API finds out the possible voltage the
+ * voltage domain can enter and then decides on the final device
+ * rate. Return 0 on success else the error value
+ */
+int omap_device_scale(struct device *req_dev, struct device *dev,
+			unsigned long rate)
+{
+	struct opp *opp;
+	unsigned long volt, freq, min_freq, max_freq;
+	struct voltagedomain *voltdm;
+	struct platform_device *pdev;
+	struct omap_device *od;
+	int ret;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	od = _find_by_pdev(pdev);
+
+	/*
+	 * Figure out if the desired frquency lies between the
+	 * maximum and minimum possible for the particular device
+	 */
+	min_freq = 0;
+	if (IS_ERR(opp_find_freq_ceil(dev, &min_freq))) {
+		dev_err(dev, "%s: Unable to find lowest opp\n", __func__);
+		return -ENODEV;
+	}
+
+	max_freq = ULONG_MAX;
+	if (IS_ERR(opp_find_freq_floor(dev, &max_freq))) {
+		dev_err(dev, "%s: Unable to find highest opp\n", __func__);
+		return -ENODEV;
+	}
+
+	if (rate < min_freq)
+		freq = min_freq;
+	else if (rate > max_freq)
+		freq = max_freq;
+	else
+		freq = rate;
+
+	opp = opp_find_freq_ceil(dev, &freq);
+	if (IS_ERR(opp)) {
+		dev_err(dev, "%s: Unable to find OPP for freq%ld\n",
+			__func__, rate);
+		return -ENODEV;
+	}
+
+	/* Get the voltage corresponding to the requested frequency */
+	volt = opp_get_voltage(opp);
+
+	/*
+	 * Call into the voltage layer to get the final voltage possible
+	 * for the voltage domain associated with the device.
+	 */
+	voltdm = od->hwmods[0]->voltdm;
+	ret = omap_voltage_add_request(voltdm, req_dev, &volt);
+	if (ret) {
+		dev_err(dev, "%s: Unable to get the final volt for scaling\n",
+			__func__);
+		return ret;
+	}
+
+	/* Do the actual scaling */
+	return omap_voltage_scale(voltdm, volt);
+}
+EXPORT_SYMBOL(omap_device_scale);
+
 struct device omap_device_parent = {
 	.init_name	= "omap",
 	.parent         = &platform_bus,
-- 
1.7.0.4

