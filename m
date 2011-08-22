From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/7] OMAP: PM: omap_device: add omap_hwmod_name_get_odev
Date: Mon, 22 Aug 2011 17:19:01 +0200
Message-ID: <1314026347-21623-2-git-send-email-b-cousson@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44824 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1HVPTp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Aug 2011 11:19:45 -0400
In-Reply-To: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Nishanth Menon <nm@ti.com>

An API which translates a standard hwmod name to corresponding
omap_device is useful for drivers when they need to look up the
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

Signed-off-by: Nishanth Menon <nm@ti.com>
[b-cousson@ti.com: rebased on top of Kevin's changes]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |   32 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index d4d9b96..bdc2804 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -101,6 +101,7 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 int pm_lats_cnt, int is_early_device);
 
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
+struct omap_device *omap_hwmod_name_get_odev(const char *oh_name);
 
 /* OMAP PM interface */
 int omap_device_align_pm_lat(struct platform_device *pdev,
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d8f2299..455594a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -840,6 +840,38 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
 	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
 }
 
+/**
+ * omap_hwmod_name_get_odev() - convert a hwmod name to omap_device pointer
+ * @oh_name: name of the hwmod device
+ *
+ * returns back a struct omap_device * pointer associated with a hwmod
+ * device represented by a hwmod_name
+ */
+struct omap_device *omap_hwmod_name_get_odev(const char *oh_name)
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
+	return oh->od;
+}
+EXPORT_SYMBOL(omap_hwmod_name_get_odev);
+
 /*
  * Public functions intended for use in omap_device_pm_latency
  * .activate_func and .deactivate_func function pointers
-- 
1.7.0.4

