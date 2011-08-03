From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] I2C: OMAP: remove unneccesary use of pdev
Date: Wed,  3 Aug 2011 11:09:19 -0700
Message-ID: <1312394960-21689-2-git-send-email-khilman@ti.com>
References: <1312394960-21689-1-git-send-email-khilman@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312394960-21689-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

A pointer to the struct device associated with the i2c device is
already kept in the struct omap_i2c_dev, so use omap_i2c_device to
find the pointer to struct device.

Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e854be0..12d0cbc 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -267,15 +267,13 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
-	struct platform_device *pdev;
 	struct omap_i2c_bus_platform_data *pdata;
 
 	WARN_ON(!dev->idle);
 
-	pdev = to_platform_device(dev->dev);
-	pdata = pdev->dev.platform_data;
+	pdata = dev->dev->platform_data;
 
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(dev->dev);
 
 	if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
@@ -299,14 +297,12 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 
 static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
-	struct platform_device *pdev;
 	struct omap_i2c_bus_platform_data *pdata;
 	u16 iv;
 
 	WARN_ON(dev->idle);
 
-	pdev = to_platform_device(dev->dev);
-	pdata = pdev->dev.platform_data;
+	pdata = dev->dev->platform_data;
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	if (pdata->rev == OMAP_I2C_IP_VERSION_2)
@@ -324,7 +320,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	}
 	dev->idle = 1;
 
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync(dev->dev);
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
@@ -335,11 +331,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long timeout;
 	unsigned long internal_clk = 0;
 	struct clk *fclk;
-	struct platform_device *pdev;
 	struct omap_i2c_bus_platform_data *pdata;
 
-	pdev = to_platform_device(dev->dev);
-	pdata = pdev->dev.platform_data;
+	pdata = dev->dev->platform_data;
 
 	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
 		/* Disable I2C controller before soft reset */
@@ -821,11 +815,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	u16 bits;
 	u16 stat, w;
 	int err, count = 0;
-	struct platform_device *pdev;
 	struct omap_i2c_bus_platform_data *pdata;
 
-	pdev = to_platform_device(dev->dev);
-	pdata = pdev->dev.platform_data;
+	pdata = dev->dev->platform_data;
 
 	if (dev->idle)
 		return IRQ_NONE;
@@ -1047,7 +1039,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	else
 		dev->regs = (u8 *)reg_map_ip_v1;
 
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev->dev);
 	omap_i2c_unidle(dev);
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
-- 
1.7.6
