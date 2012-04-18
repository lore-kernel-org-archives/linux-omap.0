From: jean.pihet@newoldbits.com
Subject: [PATCH 1/2] ARM: OMAP: convert I2C driver to PM QoS for latency constraints
Date: Wed, 18 Apr 2012 15:55:13 +0200
Message-ID: <1334757314-29325-2-git-send-email-j-pihet@ti.com>
References: <1334757314-29325-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37990 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab2DRNzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:55:31 -0400
Received: by wibhq7 with SMTP id hq7so720403wib.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:55:30 -0700 (PDT)
In-Reply-To: <1334757314-29325-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
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
 arch/arm/plat-omap/i2c.c      |   21 ---------------------
 drivers/i2c/busses/i2c-omap.c |   28 +++++++++++++++++-----------
 include/linux/i2c-omap.h      |    1 -
 3 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index db071bc..dba8338 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -26,7 +26,6 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/i2c-omap.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -34,7 +33,6 @@
 #include <mach/irqs.h>
 #include <plat/mux.h>
 #include <plat/i2c.h>
-#include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 
 #define OMAP_I2C_SIZE		0x3f
@@ -129,16 +127,6 @@ static inline int omap1_i2c_add_bus(int bus_id)
 
 
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
 static inline int omap2_i2c_add_bus(int bus_id)
 {
 	int l;
@@ -170,15 +158,6 @@ static inline int omap2_i2c_add_bus(int bus_id)
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
 	pdev = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			NULL, 0, 0);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 801df60..72d7076 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -43,6 +43,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -183,8 +184,7 @@ struct omap_i2c_dev {
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
-	void			(*set_mpu_wkup_lat)(struct device *dev,
-						    long latency);
+	struct pm_qos_request	pm_qos_request;
 	u32			speed;		/* Speed of bus in kHz */
 	u32			dtrev;		/* extra revision from DT */
 	u32			flags;
@@ -634,8 +634,16 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
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
+	if (dev->latency)
+		pm_qos_add_request(&dev->pm_qos_request,
+				   PM_QOS_CPU_DMA_LATENCY,
+				   dev->latency);
 
 	for (i = 0; i < num; i++) {
 		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
@@ -643,8 +651,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
+	if (dev->latency)
+		pm_qos_remove_request(&dev->pm_qos_request);
 
 	if (r == 0)
 		r = num;
@@ -1032,7 +1040,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	} else if (pdata != NULL) {
 		dev->speed = pdata->clkrate;
 		dev->flags = pdata->flags;
-		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
 		dev->dtrev = pdata->rev;
 	}
 
@@ -1081,10 +1088,9 @@ omap_i2c_probe(struct platform_device *pdev)
 		else
 			dev->b_hw = 1; /* Enable hardware fixes */
 
-		/* calculate wakeup latency constraint for MPU */
-		if (dev->set_mpu_wkup_lat != NULL)
-			dev->latency = (1000000 * dev->fifo_size) /
-				       (1000 * dev->speed / 8);
+		/* calculate wakeup latency constraint */
+		dev->latency = (1000000 * dev->fifo_size) /
+			       (1000 * dev->speed / 8);
 	}
 
 	/* reset ASAP, clearing any IRQs */
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 92a0dc7..df804ba 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -34,7 +34,6 @@ struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	u32		rev;
 	u32		flags;
-	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
 };
 
 #endif
-- 
1.7.7.6

