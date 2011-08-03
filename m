From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/2] I2C: OMAP: remove dev->idle, use usage counting provided by runtime PM
Date: Wed,  3 Aug 2011 11:09:20 -0700
Message-ID: <1312394960-21689-3-git-send-email-khilman@ti.com>
References: <1312394960-21689-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:38070 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755115Ab1HCSIw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Aug 2011 14:08:52 -0400
In-Reply-To: <1312394960-21689-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Current usage of runtime PM is not quite correct.  The actual
idle/unidle of the I2C hardware should not happen until the runtime PM
callbacks are called.  Therefore, change omap_i2c_[un]idle() functions
to only be called from the runtime PM callbacks (when usage count
transitions to/from zero.)

Also, the runtime PM core does usage counting and replaces
functionality currently managed by the dev->idle flag.  Remove usage
of dev->idle in favor of using runtime PM, and checking status using
pm_runtime_suspended().

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   58 ++++++++++++++++++++++++++--------------
 1 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 12d0cbc..1b5325b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -194,7 +194,6 @@ struct omap_i2c_dev {
 						 */
 	u8			rev;
 	unsigned		b_hw:1;		/* bad h/w fixes */
-	unsigned		idle:1;
 	u16			iestate;	/* Saved interrupt register */
 	u16			pscstate;
 	u16			scllstate;
@@ -269,12 +268,8 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
 	struct omap_i2c_bus_platform_data *pdata;
 
-	WARN_ON(!dev->idle);
-
 	pdata = dev->dev->platform_data;
 
-	pm_runtime_get_sync(dev->dev);
-
 	if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
@@ -285,7 +280,6 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 	}
-	dev->idle = 0;
 
 	/*
 	 * Don't write to this register if the IE state is 0 as it can
@@ -300,8 +294,6 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	struct omap_i2c_bus_platform_data *pdata;
 	u16 iv;
 
-	WARN_ON(dev->idle);
-
 	pdata = dev->dev->platform_data;
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
@@ -315,12 +307,9 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	} else {
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
 
-		/* Flush posted write before the dev->idle store occurs */
+		/* Flush posted write */
 		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	}
-	dev->idle = 1;
-
-	pm_runtime_put_sync(dev->dev);
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
@@ -644,7 +633,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	int i;
 	int r;
 
-	omap_i2c_unidle(dev);
+	pm_runtime_get_sync(dev->dev);
 
 	r = omap_i2c_wait_for_bb(dev);
 	if (r < 0)
@@ -667,7 +656,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	omap_i2c_wait_for_bb(dev);
 out:
-	omap_i2c_idle(dev);
+	pm_runtime_put_sync(dev->dev);
 	return r;
 }
 
@@ -727,7 +716,7 @@ omap_i2c_omap1_isr(int this_irq, void *dev_id)
 	struct omap_i2c_dev *dev = dev_id;
 	u16 iv, w;
 
-	if (dev->idle)
+	if (pm_runtime_suspended(dev->dev))
 		return IRQ_NONE;
 
 	iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
@@ -819,7 +808,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
 
 	pdata = dev->dev->platform_data;
 
-	if (dev->idle)
+	if (pm_runtime_suspended(dev->dev))
 		return IRQ_NONE;
 
 	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
@@ -1021,7 +1010,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	dev->speed = speed;
-	dev->idle = 1;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
 	dev->base = ioremap(mem->start, resource_size(mem));
@@ -1040,7 +1028,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(dev->dev);
-	omap_i2c_unidle(dev);
+	pm_runtime_get_sync(dev->dev);
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
@@ -1087,7 +1075,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
 		 pdata->rev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
 
-	omap_i2c_idle(dev);
+	pm_runtime_put_sync(dev->dev);
 
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
@@ -1111,7 +1099,7 @@ err_free_irq:
 	free_irq(dev->irq, dev);
 err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
-	omap_i2c_idle(dev);
+	pm_runtime_put_sync(dev->dev);
 	iounmap(dev->base);
 err_free_mem:
 	platform_set_drvdata(pdev, NULL);
@@ -1140,6 +1128,36 @@ omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int omap_i2c_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+
+	omap_i2c_idle(_dev);
+
+	return 0;
+}
+
+static int omap_i2c_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+
+	omap_i2c_unidle(_dev);
+
+	return 0;
+}
+
+static struct dev_pm_ops omap_i2c_pm_ops = {
+	.runtime_suspend = omap_i2c_runtime_suspend,
+	.runtime_resume = omap_i2c_runtime_resume,
+};
+#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
+#else
+#define OMAP_I2C_PM_OPS NULL
+#endif
+
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
 	.remove		= omap_i2c_remove,
-- 
1.7.6

