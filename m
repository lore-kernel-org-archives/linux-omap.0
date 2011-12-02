From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 1/3] OMAP: I2C: Reset support
Date: Fri, 2 Dec 2011 14:51:12 +0530
Message-ID: <1322817674-25384-2-git-send-email-shubhrajyoti@ti.com>
References: <1322817674-25384-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44564 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223Ab1LBJVk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Dec 2011 04:21:40 -0500
In-Reply-To: <1322817674-25384-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, ben-linux@fluff.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Under some error conditions the i2c driver may do a reset.
Adding a reset field and support in the device-specific code.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/i2c.c |   18 ++++++++++++++++++
 include/linux/i2c-omap.h |    1 +
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index db071bc..883229c 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -74,6 +74,22 @@ static struct omap_i2c_bus_platform_data i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
 };
+/**
+ * omap2_i2c_reset - reset the omap i2c module.
+ * @dev: struct device*
+ */
+
+static int omap2_i2c_reset(struct device *dev)
+{
+	int r = 0;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	struct omap_hwmod *oh;
+
+	oh = odev->hwmods[0];
+	r = omap_hwmod_reset(oh);
+	return r;
+}
 
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
 
@@ -179,6 +195,8 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	 */
 	if (cpu_is_omap34xx())
 		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
+
+	pdata->device_reset = omap2_i2c_reset;
 	pdev = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			NULL, 0, 0);
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 92a0dc7..fd38249 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -35,6 +35,7 @@ struct omap_i2c_bus_platform_data {
 	u32		rev;
 	u32		flags;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
+	int		(*device_reset) (struct device *dev);
 };
 
 #endif
-- 
1.7.1

