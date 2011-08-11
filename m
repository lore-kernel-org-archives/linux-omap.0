From: jean.pihet@newoldbits.com
Subject: [PATCH 08/15] OMAP: convert I2C driver to PM QoS for latency constraints
Date: Thu, 11 Aug 2011 17:06:45 +0200
Message-ID: <1313075212-8366-9-git-send-email-j-pihet@ti.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46608 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab1HKPHr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 11:07:47 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1487550wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 08:07:46 -0700 (PDT)
In-Reply-To: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.ke
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
API to the new PM QoS API.
Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
class of PM QoS. The resulting MPU constraints are used by cpuidle to
decide the next power state of the MPU subsystem.

Currently only OMAP3 is placing constraints on the MPU.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/i2c.c      |   20 --------------------
 drivers/i2c/busses/i2c-omap.c |   31 ++++++++++++++++++-------------
 2 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 2388b8e..98f7ea5 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -34,7 +34,6 @@
 #include <mach/irqs.h>
 #include <plat/mux.h>
 #include <plat/i2c.h>
-#include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 
 #define OMAP_I2C_SIZE		0x3f
@@ -129,16 +128,6 @@ static inline int omap1_i2c_add_bus(int bus_id)
 
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
-/*
- * XXX This function is a temporary compatibility wrapper - only
- * needed until the I2C driver can be converted to call
- * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
- */
-static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
-{
-	omap_pm_set_max_mpu_wakeup_lat(dev, t);
-}
-
 static struct omap_device_pm_latency omap_i2c_latency[] = {
 	[0] = {
 		.deactivate_func	= omap_device_idle_hwmods,
@@ -178,15 +167,6 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
 	pdata->flags = dev_attr->flags;
 
-	/*
-	 * When waiting for completion of a i2c transfer, we need to
-	 * set a wake up latency constraint for the MPU. This is to
-	 * ensure quick enough wakeup from idle, when transfer
-	 * completes.
-	 * Only omap3 has support for constraints
-	 */
-	if (cpu_is_omap34xx())
-		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
 	od = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d53cd61..649937e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -180,8 +181,7 @@ struct omap_i2c_dev {
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
-	void			(*set_mpu_wkup_lat)(struct device *dev,
-						    long latency);
+	struct pm_qos_request	pm_qos_request;
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
@@ -657,8 +657,16 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (r < 0)
 		goto out;
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
+	/*
+	 * When waiting for completion of a i2c transfer, we need to
+	 * set a wake up latency constraint for the MPU. This is to
+	 * ensure quick enough wakeup from idle, when transfer
+	 * completes.
+	 * Used on OMAP3 Only
+	 */
+	if (cpu_is_omap34xx())
+		pm_qos_add_request(&dev->pm_qos_request, PM_QOS_CPU_DMA_LATENCY,
+				   dev->latency);
 
 	for (i = 0; i < num; i++) {
 		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
@@ -666,8 +674,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
+	if (cpu_is_omap34xx())
+		pm_qos_remove_request(&dev->pm_qos_request);
 
 	if (r == 0)
 		r = num;
@@ -1021,13 +1029,10 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
-	if (pdata != NULL) {
+	if (pdata != NULL)
 		speed = pdata->clkrate;
-		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
-	} else {
+	else
 		speed = 100;	/* Default speed */
-		dev->set_mpu_wkup_lat = NULL;
-	}
 
 	dev->speed = speed;
 	dev->idle = 1;
@@ -1075,8 +1080,8 @@ omap_i2c_probe(struct platform_device *pdev)
 			dev->fifo_size = (dev->fifo_size / 2);
 			dev->b_hw = 1; /* Enable hardware fixes */
 		}
-		/* calculate wakeup latency constraint for MPU */
-		if (dev->set_mpu_wkup_lat != NULL)
+		/* calculate wakeup latency constraint */
+		if (cpu_is_omap34xx())
 			dev->latency = (1000000 * dev->fifo_size) /
 				       (1000 * speed / 8);
 	}
-- 
1.7.2.5

