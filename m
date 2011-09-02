From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 1/6] OMAP: omap_device: Add omap_hwmod_name_get_dev
Date: Fri, 2 Sep 2011 16:25:15 +0200
Message-ID: <1314973520-3585-2-git-send-email-b-cousson@ti.com>
References: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37921 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab1IBO0T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 10:26:19 -0400
In-Reply-To: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Nishanth Menon <nm@ti.com>

An API which translates a standard hwmod name to corresponding
platform_device is useful for drivers when they need to look up the
device associated with a hwmod name to map back into the device
structure pointers. These ideally should be used by drivers in
mach directory. Using a generic hwmod name like "gpu" instead of
the actual device name which could change in the future, allows
us to:
a) Could in effect help replace apis such as omap2_get_mpuss_device,
omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device,
etc..
b) Scale to more devices rather than be restricted to named functions
c) Simplify driver's platform_data from passing additional fields
all doing the same thing with different function pointer names
just for accessing a different device name.

Provide an omap_hwmod_name_get_dev helper function to convert
hwmod to device pointer.
This wrapper provides ability for drivers to convert directly
from hwmod name back to device pointer without having to handle
this on a driver by driver basis.

Signed-off-by: Nishanth Menon <nm@ti.com>
[b-cousson@ti.com: Adapt it to the new pdev pointer inside od,
remove the unneeded helpers, and fold the next patch here]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |   10 +++++++
 arch/arm/plat-omap/omap_device.c              |   32 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index d4d9b96..a3db748 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -101,6 +101,7 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 int pm_lats_cnt, int is_early_device);
 
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
+struct platform_device *omap_hwmod_name_get_pdev(const char *oh_name);
 
 /* OMAP PM interface */
 int omap_device_align_pm_lat(struct platform_device *pdev,
@@ -151,6 +152,15 @@ static inline struct omap_device *to_omap_device(struct platform_device *pdev)
 	return pdev ? pdev->archdata.od : NULL;
 }
 
+/* Convert omap_hwmod name to device pointer */
+static inline struct device *omap_hwmod_name_get_dev(const char *oh_name)
+{
+	struct platform_device *pdev = omap_hwmod_name_get_pdev(oh_name);
+	if (IS_ERR_OR_NULL(pdev))
+		return ERR_PTR(pdev ? PTR_ERR(pdev) : -ENODEV);
+	return &pdev->dev;
+}
+
 static inline
 void omap_device_disable_idle_on_suspend(struct platform_device *pdev)
 {
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 7a0d248..320b1f4 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -841,6 +841,38 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
 	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
 }
 
+/**
+ * omap_hwmod_name_get_pdev() - convert a hwmod name to platform_device pointer
+ * @oh_name: name of the hwmod device
+ *
+ * Returns back a struct platform_device * pointer associated with a hwmod
+ * device represented by a hwmod_name
+ */
+struct platform_device *omap_hwmod_name_get_pdev(const char *oh_name)
+{
+	struct omap_hwmod *oh;
+
+	if (!oh_name) {
+		WARN(1, "%s: no hwmod name!\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (IS_ERR_OR_NULL(oh)) {
+		WARN(1, "%s: no hwmod for %s\n", __func__,
+			oh_name);
+		return ERR_PTR(oh ? PTR_ERR(oh) : -ENODEV);
+	}
+	if (IS_ERR_OR_NULL(oh->od)) {
+		WARN(1, "%s: no omap_device for %s\n", __func__,
+			oh_name);
+		return ERR_PTR(oh->od ? PTR_ERR(oh->od) : -ENODEV);
+	}
+
+	return oh->od->pdev;
+}
+EXPORT_SYMBOL(omap_hwmod_name_get_pdev);
+
 /*
  * Public functions intended for use in omap_device_pm_latency
  * .activate_func and .deactivate_func function pointers
-- 
1.7.0.4

