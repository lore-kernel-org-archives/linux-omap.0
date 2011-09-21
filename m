From: jean.pihet@newoldbits.com
Subject: [PATCH 1/8] OMAP: convert I2C driver to PM QoS for latency constraints
Date: Wed, 21 Sep 2011 18:24:11 +0200
Message-ID: <1316622258-3892-2-git-send-email-j-pihet@ti.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
 <1316622258-3892-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f42.google.com ([209.85.215.42]:61336 "EHLO
	mail-ew0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab1IUQZu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 12:25:50 -0400
Received: by ewy1 with SMTP id 1so1809483ewy.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 09:25:48 -0700 (PDT)
In-Reply-To: <1316622258-3892-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
API to the new PM QoS API.
Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
class of PM QoS. The resulting MPU constraints are used by cpuidle to
decide the next power state of the MPU subsystem.

The I2C device latency timing is derived from the FIFO size and the
clock speed and so is applicable to all OMAP SoCs.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/i2c.c      |   20 --------------------
 drivers/i2c/busses/i2c-omap.c |   30 +++++++++++++++---------------
 include/linux/i2c-omap.h      |    1 -
 3 files changed, 15 insertions(+), 36 deletions(-)

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
index 1a766cf..95e5205 100644
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
@@ -648,8 +648,14 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (r < 0)
 		goto out;
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
+	/*
+	 * When waiting for completion of a i2c transfer, we need to
+	 * set a wake up latency constraint for the MPU. This is to
+	 * ensure quick enough wakeup from idle, when transfer
+	 * completes.
+	 */
+	pm_qos_add_request(&dev->pm_qos_request, PM_QOS_CPU_DMA_LATENCY,
+			   dev->latency);
 
 	for (i = 0; i < num; i++) {
 		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
@@ -657,8 +663,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
+	pm_qos_remove_request(&dev->pm_qos_request);
 
 	if (r == 0)
 		r = num;
@@ -1007,13 +1012,10 @@ omap_i2c_probe(struct platform_device *pdev)
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
@@ -1066,10 +1068,8 @@ omap_i2c_probe(struct platform_device *pdev)
 			dev->fifo_size = (dev->fifo_size / 2);
 			dev->b_hw = 1; /* Enable hardware fixes */
 		}
-		/* calculate wakeup latency constraint for MPU */
-		if (dev->set_mpu_wkup_lat != NULL)
-			dev->latency = (1000000 * dev->fifo_size) /
-				       (1000 * speed / 8);
+		/* calculate wakeup latency constraint */
+		dev->latency = (1000000 * dev->fifo_size) / (1000 * speed / 8);
 	}
 
 	/* reset ASAP, clearing any IRQs */
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 0aa0cbd..d06a8aa 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -32,7 +32,6 @@
 
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
-	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
 	int		(*device_enable) (struct platform_device *pdev);
 	int		(*device_shutdown) (struct platform_device *pdev);
 	int		(*device_idle) (struct platform_device *pdev);
-- 
1.7.4.1

