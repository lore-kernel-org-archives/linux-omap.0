From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/2] I2C: OMAP: remove unneccesary use of pdev
Date: Tue, 17 May 2011 16:31:37 +0200
Message-ID: <1305642698-15338-2-git-send-email-khilman@ti.com>
References: <1305642698-15338-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:51789 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755076Ab1EQObr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 10:31:47 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so431577wwa.13
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 07:31:46 -0700 (PDT)
In-Reply-To: <1305642698-15338-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

A pointer to the struct device associated with the i2c device is
already kept in the struct omap_i2c_dev, so use omap_i2c_device to
find the pointer to struct device.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d53cd61..8633488 100644
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
@@ -822,11 +816,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
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
@@ -1048,7 +1040,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	else
 		dev->regs = (u8 *)reg_map_ip_v1;
 
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev->dev);
 	omap_i2c_unidle(dev);
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
-- 
1.7.3.4

