From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/4] OMAP3: I2C: Convert i2c driver to use omap_device/omap_hwmod
Date: Mon, 14 Dec 2009 14:42:39 +0530
Message-ID: <1260781959-28050-4-git-send-email-rnayak@ti.com>
References: <1260781959-28050-1-git-send-email-rnayak@ti.com>
 <1260781959-28050-2-git-send-email-rnayak@ti.com>
 <1260781959-28050-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52686 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865AbZLNJMo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Dec 2009 04:12:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBE9CfQm015997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 03:12:44 -0600
In-Reply-To: <1260781959-28050-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch converts the i2c driver to use omap_device/omap_hwmod.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   83 ++++++++++++++++-------------------------
 1 files changed, 32 insertions(+), 51 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index bbea8a0..0334225 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -2,7 +2,7 @@
  * TI OMAP I2C master mode driver
  *
  * Copyright (C) 2003 MontaVista Software, Inc.
- * Copyright (C) 2005 Nokia Corporation
+ * Copyright (C) 2005, 2009 Nokia Corporation
  * Copyright (C) 2004 - 2007 Texas Instruments.
  *
  * Originally written by MontaVista Software, Inc.
@@ -26,6 +26,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * To do:
+ * - Add DMA for transfers longer than the FIFO
+ *
  */
 
 #include <linux/module.h>
@@ -39,6 +43,8 @@
 #include <linux/io.h>
 #include <linux/i2c-omap.h>
 
+#include <plat/i2c.h>
+
 /* I2C controller revisions */
 #define OMAP_I2C_REV_2			0x20
 
@@ -162,8 +168,6 @@ struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
-	struct clk		*iclk;		/* Interface clock */
-	struct clk		*fclk;		/* Functional clock */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
@@ -201,45 +205,19 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
 
-static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
+static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
-	int ret;
-
-	dev->iclk = clk_get(dev->dev, "ick");
-	if (IS_ERR(dev->iclk)) {
-		ret = PTR_ERR(dev->iclk);
-		dev->iclk = NULL;
-		return ret;
-	}
+	struct platform_device *pdev;
+	struct omap_i2c_platform_data *pdata;
 
-	dev->fclk = clk_get(dev->dev, "fck");
-	if (IS_ERR(dev->fclk)) {
-		ret = PTR_ERR(dev->fclk);
-		if (dev->iclk != NULL) {
-			clk_put(dev->iclk);
-			dev->iclk = NULL;
-		}
-		dev->fclk = NULL;
-		return ret;
-	}
-
-	return 0;
-}
+	WARN_ON(!dev->idle);
 
-static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
-{
-	clk_put(dev->fclk);
-	dev->fclk = NULL;
-	clk_put(dev->iclk);
-	dev->iclk = NULL;
-}
+	pdev = container_of(dev->dev, struct platform_device, dev);
+	pdata = pdev->dev.platform_data;
 
-static void omap_i2c_unidle(struct omap_i2c_dev *dev)
-{
-	WARN_ON(!dev->idle);
+	if (pdata->device_enable)
+		pdata->device_enable(pdev);
 
-	clk_enable(dev->iclk);
-	clk_enable(dev->fclk);
 	if (cpu_is_omap34xx()) {
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
@@ -256,10 +234,15 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 
 static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
+	struct platform_device *pdev;
+	struct omap_i2c_platform_data *pdata;
 	u16 iv;
 
 	WARN_ON(dev->idle);
 
+	pdev = container_of(dev->dev, struct platform_device, dev);
+	pdata = pdev->dev.platform_data;
+
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev < OMAP_I2C_REV_2) {
@@ -271,8 +254,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	}
 	dev->idle = 1;
-	clk_disable(dev->fclk);
-	clk_disable(dev->iclk);
+	if (pdata->device_idle)
+		pdata->device_idle(pdev);
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
@@ -282,6 +265,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
 	unsigned long internal_clk = 0;
+	struct clk *fclk;
 
 	if (dev->rev >= OMAP_I2C_REV_2) {
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
@@ -333,7 +317,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		 * always returns 12MHz for the functional clock, we can
 		 * do this bit unconditionally.
 		 */
-		fclk_rate = clk_get_rate(dev->fclk);
+		fclk = clk_get(dev->dev, "fck");
+		fclk_rate = clk_get_rate(fclk);
 
 		/* TRM for 5912 says the I2C clock must be prescaled to be
 		 * between 7 - 12 MHz. The XOR input clock is typically
@@ -349,7 +334,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	}
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
-
 		/*
 		 * HSI2C controller internal clk rate should be 19.2 Mhz for
 		 * HS and for all modes on 2430. On 34xx we can use lower rate
@@ -362,7 +346,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			internal_clk = 9600;
 		else
 			internal_clk = 4000;
-		fclk_rate = clk_get_rate(dev->fclk) / 1000;
+		fclk = clk_get(dev->dev, "fck");
+		fclk_rate = clk_get_rate(fclk) / 1000;
 
 		/* Compute prescaler divisor */
 		psc = fclk_rate / internal_clk;
@@ -852,10 +837,10 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
-	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	irq_handler_t isr;
 	int r;
 	u32 speed = 0;
+	struct omap_i2c_platform_data *pdata;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -882,8 +867,10 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
-	if (pdata != NULL) {
-		speed = pdata->clkrate;
+	pdata = pdev->dev.platform_data;
+
+	if (pdata->rate) {
+		speed = pdata->rate;
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
 	} else {
 		speed = 100;	/* Default speed */
@@ -902,9 +889,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
-	if ((r = omap_i2c_get_clocks(dev)) != 0)
-		goto err_iounmap;
-
 	omap_i2c_unidle(dev);
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
@@ -969,8 +953,6 @@ err_free_irq:
 err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	omap_i2c_idle(dev);
-	omap_i2c_put_clocks(dev);
-err_iounmap:
 	iounmap(dev->base);
 err_free_mem:
 	platform_set_drvdata(pdev, NULL);
@@ -992,7 +974,6 @@ omap_i2c_remove(struct platform_device *pdev)
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
-	omap_i2c_put_clocks(dev);
 	iounmap(dev->base);
 	kfree(dev);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.5.4.7

