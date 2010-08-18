From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 08/13] OMAP: Introduce device set_rate and get_rate.
Date: Wed, 18 Aug 2010 16:50:07 +0530
Message-ID: <1282130412-12027-9-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45577 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab0HRLU0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:26 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch adds omap_device_set_rate and omap_device_get_rate
API's which can be used to generic device rate scaling.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    3 +
 arch/arm/plat-omap/omap_device.c              |   74 +++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 25cd9ac..2ebf2e2 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -116,6 +116,9 @@ int omap_device_enable_hwmods(struct omap_device *od);
 int omap_device_disable_clocks(struct omap_device *od);
 int omap_device_enable_clocks(struct omap_device *od);
 
+int omap_device_set_rate(struct device *req_dev, struct device *dev,
+			 unsigned long rate);
+unsigned long omap_device_get_rate(struct device *dev);
 
 /*
  * Entries should be kept in latency order ascending
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d2b1609..3c3ba43 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -85,6 +85,8 @@
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
+#include <plat/opp.h>
+#include <plat/voltage.h>
 
 /* These parameters are passed to _omap_device_{de,}activate() */
 #define USE_WAKEUP_LAT			0
@@ -757,3 +759,75 @@ int omap_device_enable_clocks(struct omap_device *od)
 	/* XXX pass along return value here? */
 	return 0;
 }
+
+/**
+ * omap_device_set_rate - Set a new rate at which the device is to operate
+ * @req_dev : pointer to the device requesting the scaling.
+ * @dev : pointer to the device that is to be scaled
+ * @rate : the rnew rate for the device.
+ *
+ * This API gets the device opp table associated with this device and
+ * tries putting the device to the requested rate and the voltage domain
+ * associated with the device to the voltage corresponding to the
+ * requested rate. Since multiple devices can be assocciated with a
+ * voltage domain this API finds out the possible voltage the
+ * voltage domain can enter and then decides on the final device
+ * rate. Return 0 on success else the error value
+ */
+int omap_device_set_rate(struct device *req_dev, struct device *dev,
+			unsigned long rate)
+{
+	struct omap_opp *opp;
+	unsigned long volt, freq;
+	struct voltagedomain *voltdm;
+	struct platform_device *pdev;
+	struct omap_device *od;
+	int ret;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	od = _find_by_pdev(pdev);
+
+	/* Get the possible rate from the opp layer */
+	freq = rate;
+	opp = opp_find_freq_ceil(dev, &freq);
+	if (IS_ERR(opp)) {
+		dev_err(dev, "%s: Unable to find OPP for freq%ld\n",
+			__func__, rate);
+		return -ENODEV;
+	}
+	if (unlikely(freq != rate))
+		dev_warn(dev, "%s: Available freq %ld != dpll freq %ld.\n",
+			__func__, freq, rate);
+
+	/* Get the voltage corresponding to the requested frequency */
+	volt = opp_get_voltage(opp);
+
+	/*
+	 * Call into the voltage layer to get the final voltage possible
+	 * for the voltage domain associated with the device.
+	 */
+	voltdm = od->hwmods[0]->voltdm;
+	ret = omap_voltage_add_userreq(voltdm, req_dev, &volt);
+	if (ret) {
+		dev_err(dev, "%s: Unable to get the final volt for scaling\n",
+			__func__);
+		return ret;
+	}
+
+	/* Do the actual scaling */
+	return omap_voltage_scale(voltdm, volt);
+}
+EXPORT_SYMBOL(omap_device_set_rate);
+
+/**
+ * omap_device_get_rate - Gets the current operating rate of the device
+ * @dev - the device pointer
+ *
+ * This API returns the current operating rate of the device on success.
+ * Else returns the error value.
+ */
+unsigned long omap_device_get_rate(struct device *dev)
+{
+	return opp_get_rate(dev);
+}
+EXPORT_SYMBOL(omap_device_get_rate);
-- 
1.7.1.GIT

