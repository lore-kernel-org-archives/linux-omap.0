From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 2/5] OMAP: I2C: Reset support
Date: Thu, 21 Jul 2011 12:23:02 +0530
Message-ID: <1311231185-5503-3-git-send-email-shubhrajyoti@ti.com>
References: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34003 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab1GUGx0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 02:53:26 -0400
In-Reply-To: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

Under some error conditions the i2c  driver may do a reset
adding support in the platform.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/i2c.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 2388b8e..3d144d1 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -146,6 +146,22 @@ static struct omap_device_pm_latency omap_i2c_latency[] = {
 		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
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
 
 static inline int omap2_i2c_add_bus(int bus_id)
 {
@@ -187,6 +203,8 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	 */
 	if (cpu_is_omap34xx())
 		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
+
+	pdata->device_reset = omap2_i2c_reset;
 	od = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
-- 
1.7.1

