From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHV4 1/4] OMAP: I2C: Reset support
Date: Thu, 21 Jul 2011 20:53:35 +0530
Message-ID: <1311261818-25784-2-git-send-email-shubhrajyoti@ti.com>
References: <1311261818-25784-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1311261818-25784-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 Under some error conditions the i2c  driver may do a reset.
 Adding a reset field  and support in the platform.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 arch/arm/plat-omap/i2c.c |   17 +++++++++++++++++
 include/linux/i2c-omap.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 2388b8e..98a97b0 100644
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
@@ -187,6 +203,7 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	 */
 	if (cpu_is_omap34xx())
 		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
+	pdata->device_reset = omap2_i2c_reset;
 	od = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 98ae49b..8aa91b6 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -38,6 +38,7 @@ struct omap_i2c_bus_platform_data {
 	int		(*device_enable) (struct platform_device *pdev);
 	int		(*device_shutdown) (struct platform_device *pdev);
 	int		(*device_idle) (struct platform_device *pdev);
+	int		(*device_reset) (struct device *dev);
 };
 
 #endif
-- 
1.7.1
