From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] Revert "ARM: OMAP: convert I2C driver to PM QoS for MPU
 latency constraints"
Date: Tue, 6 Nov 2012 16:31:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211061619461.20573@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42970 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab2KFQbd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 11:31:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org, ben-linux@fluff.org, w.sang@pengutronix.de
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>


This reverts commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc.
This commit causes I2C timeouts to appear on several OMAP3430/3530-based
boards:

  http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2
  http://marc.info/?l=linux-arm-kernel&m=135067558415214&w=2
  http://marc.info/?l=linux-arm-kernel&m=135216013608196&w=2

and appears to have been sent for merging before one of its prerequisites
was merged:

  http://marc.info/?l=linux-arm-kernel&m=135219411617621&w=2

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>
---

Intended for 3.7-rc.

 arch/arm/plat-omap/i2c.c      |   21 +++++++++++++++++++++
 drivers/i2c/busses/i2c-omap.c |   32 ++++++++++++++------------------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a5683a8..6013831 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -26,12 +26,14 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/i2c-omap.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 
 #include <mach/irqs.h>
 #include <plat/i2c.h>
+#include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 
 #define OMAP_I2C_SIZE		0x3f
@@ -127,6 +129,16 @@ static inline int omap1_i2c_add_bus(int bus_id)
 
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
+/*
+ * XXX This function is a temporary compatibility wrapper - only
+ * needed until the I2C driver can be converted to call
+ * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
+ */
+static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
+{
+	omap_pm_set_max_mpu_wakeup_lat(dev, t);
+}
+
 static inline int omap2_i2c_add_bus(int bus_id)
 {
 	int l;
@@ -158,6 +170,15 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
 	pdata->flags = dev_attr->flags;
 
+	/*
+	 * When waiting for completion of a i2c transfer, we need to
+	 * set a wake up latency constraint for the MPU. This is to
+	 * ensure quick enough wakeup from idle, when transfer
+	 * completes.
+	 * Only omap3 has support for constraints
+	 */
+	if (cpu_is_omap34xx())
+		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
 	pdev = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			NULL, 0, 0);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..0b02543 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -43,7 +43,6 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
-#include <linux/pm_qos.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -187,8 +186,9 @@ struct omap_i2c_dev {
 	int			reg_shift;      /* bit shift for I2C register addresses */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
-	u32			latency;	/* maximum MPU wkup latency */
-	struct pm_qos_request	pm_qos_request;
+	u32			latency;	/* maximum mpu wkup latency */
+	void			(*set_mpu_wkup_lat)(struct device *dev,
+						    long latency);
 	u32			speed;		/* Speed of bus in kHz */
 	u32			dtrev;		/* extra revision from DT */
 	u32			flags;
@@ -494,7 +494,9 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
 		dev->b_hw = 1; /* Enable hardware fixes */
 
 	/* calculate wakeup latency constraint for MPU */
-	dev->latency = (1000000 * dev->threshold) / (1000 * dev->speed / 8);
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->latency = (1000000 * dev->threshold) /
+			(1000 * dev->speed / 8);
 }
 
 /*
@@ -629,16 +631,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (r < 0)
 		goto out;
 
-	/*
-	 * When waiting for completion of a i2c transfer, we need to
-	 * set a wake up latency constraint for the MPU. This is to
-	 * ensure quick enough wakeup from idle, when transfer
-	 * completes.
-	 */
-	if (dev->latency)
-		pm_qos_add_request(&dev->pm_qos_request,
-				   PM_QOS_CPU_DMA_LATENCY,
-				   dev->latency);
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
 
 	for (i = 0; i < num; i++) {
 		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
@@ -646,8 +640,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->latency)
-		pm_qos_remove_request(&dev->pm_qos_request);
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->set_mpu_wkup_lat(dev->dev, -1);
 
 	if (r == 0)
 		r = num;
@@ -1104,6 +1098,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	} else if (pdata != NULL) {
 		dev->speed = pdata->clkrate;
 		dev->flags = pdata->flags;
+		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
 		dev->dtrev = pdata->rev;
 	}
 
@@ -1159,8 +1154,9 @@ omap_i2c_probe(struct platform_device *pdev)
 			dev->b_hw = 1; /* Enable hardware fixes */
 
 		/* calculate wakeup latency constraint for MPU */
-		dev->latency = (1000000 * dev->fifo_size) /
-			       (1000 * dev->speed / 8);
+		if (dev->set_mpu_wkup_lat != NULL)
+			dev->latency = (1000000 * dev->fifo_size) /
+				       (1000 * dev->speed / 8);
 	}
 
 	/* reset ASAP, clearing any IRQs */
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index df804ba..92a0dc7 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -34,6 +34,7 @@ struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	u32		rev;
 	u32		flags;
+	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
 };
 
 #endif
-- 
1.7.10.4
