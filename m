From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 1/8] OMAP: convert I2C driver to PM QoS for latency constraints
Date: Fri,  2 Sep 2011 15:13:17 +0200
Message-ID: <1314969204-21704-2-git-send-email-j-pihet@ti.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40419 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab1IBNNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 09:13:41 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so2916254wwf.1
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 06:13:40 -0700 (PDT)
In-Reply-To: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

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
index 3341ca4..e1e2502 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -34,7 +34,6 @@
 #include <mach/irqs.h>
 #include <plat/mux.h>
 #include <plat/i2c.h>
-#include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 
 #define OMAP_I2C_SIZE		0x3f
@@ -113,16 +112,6 @@ static inline int omap1_i2c_add_bus(int bus_id)
 
 
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
@@ -151,15 +140,6 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	}
 
 	pdata = &i2c_pdata[bus_id - 1];
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
index 1a766cf..1c762ba 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_REV_2			0x20
@@ -179,8 +180,7 @@ struct omap_i2c_dev {
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
-	void			(*set_mpu_wkup_lat)(struct device *dev,
-						    long latency);
+	struct pm_qos_request	pm_qos_request;
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
@@ -648,8 +648,16 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
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
@@ -657,8 +665,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
+	if (cpu_is_omap34xx())
+		pm_qos_remove_request(&dev->pm_qos_request);
 
 	if (r == 0)
 		r = num;
@@ -1007,13 +1015,10 @@ omap_i2c_probe(struct platform_device *pdev)
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
@@ -1066,8 +1071,8 @@ omap_i2c_probe(struct platform_device *pdev)
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
1.7.4.1

