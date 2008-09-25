From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] i2c-omap: Add high-speed support to omap-i2c
Date: Thu, 25 Sep 2008 10:53:49 +0300
Message-ID: <1222329234-31473-4-git-send-email-tony@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com>
 <1222329234-31473-2-git-send-email-tony@atomide.com>
 <1222329234-31473-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60887 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYIYHyL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:54:11 -0400
In-Reply-To: <1222329234-31473-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c@lm-sensors.org
Cc: linux-omap@vger.kernel.org, Syed Mohammed Khasim <x0khasim@ti.com>, Tony Lindgren <tony@atomide.com>

From: Syed Mohammed Khasim <x0khasim@ti.com>

Omap2430 has additional support for high-speed I2C.

This patch moves I2C speed parameter (from module) to platform data.
Also added basic High Speed support based on I2C bus speed.

This patch is tested for high speed I2C (with TWL4030 Keypad) and works as
expected.

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |  111 +++++++++++++++++++++++++++++-----------
 1 files changed, 80 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a06ad42..0d30790 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -83,6 +83,7 @@
 /* I2C Configuration Register (OMAP_I2C_CON): */
 #define OMAP_I2C_CON_EN		(1 << 15)	/* I2C module enable */
 #define OMAP_I2C_CON_BE		(1 << 14)	/* Big endian mode */
+#define OMAP_I2C_CON_OPMODE	(1 << 12)	/* High Speed support */
 #define OMAP_I2C_CON_STB	(1 << 11)	/* Start byte mode (master) */
 #define OMAP_I2C_CON_MST	(1 << 10)	/* Master/slave mode */
 #define OMAP_I2C_CON_TRX	(1 << 9)	/* TX/RX mode (master only) */
@@ -91,6 +92,10 @@
 #define OMAP_I2C_CON_STP	(1 << 1)	/* Stop cond (master only) */
 #define OMAP_I2C_CON_STT	(1 << 0)	/* Start condition (master) */
 
+/* I2C SCL time value when Master */
+#define OMAP_I2C_SCLL_HSSCLL	8
+#define OMAP_I2C_SCLH_HSSCLH	8
+
 /* I2C System Test Register (OMAP_I2C_SYSTEST): */
 #ifdef DEBUG
 #define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
@@ -109,12 +114,6 @@
 /* I2C System Configuration Register (OMAP_I2C_SYSC): */
 #define OMAP_I2C_SYSC_SRST		(1 << 1)	/* Soft Reset */
 
-/* REVISIT: Use platform_data instead of module parameters */
-/* Fast Mode = 400 kHz, Standard = 100 kHz */
-static int clock = 100; /* Default: 100 kHz */
-module_param(clock, int, 0);
-MODULE_PARM_DESC(clock, "Set I2C clock in kHz: 400=fast mode (default == 100)");
-
 struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
@@ -123,6 +122,7 @@ struct omap_i2c_dev {
 	struct clk		*fclk;		/* Functional clock */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
+	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
 	size_t			buf_len;
@@ -152,17 +152,28 @@ static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 			return -ENODEV;
 		}
 	}
-
-	dev->fclk = clk_get(dev->dev, "i2c_fck");
-	if (IS_ERR(dev->fclk)) {
-		if (dev->iclk != NULL) {
-			clk_put(dev->iclk);
-			dev->iclk = NULL;
+	/* For I2C operations on 2430 we need 96Mhz clock */
+	if (cpu_is_omap2430()) {
+		dev->fclk = clk_get(dev->dev, "i2chs_fck");
+		if (IS_ERR(dev->fclk)) {
+			if (dev->iclk != NULL) {
+				clk_put(dev->iclk);
+				dev->iclk = NULL;
+			}
+			dev->fclk = NULL;
+			return -ENODEV;
+		}
+	} else {
+		dev->fclk = clk_get(dev->dev, "i2c_fck");
+		if (IS_ERR(dev->fclk)) {
+			if (dev->iclk != NULL) {
+				clk_put(dev->iclk);
+				dev->iclk = NULL;
+			}
+			dev->fclk = NULL;
+			return -ENODEV;
 		}
-		dev->fclk = NULL;
-		return -ENODEV;
 	}
-
 	return 0;
 }
 
@@ -210,9 +221,11 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
-	u16 psc = 0;
+	u16 psc = 0, scll = 0, sclh = 0;
+	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
+	unsigned long internal_clk = 0;
 
 	if (!dev->rev1) {
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
@@ -255,18 +268,47 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			psc = fclk_rate / 12000000;
 	}
 
+	if (cpu_is_omap2430()) {
+
+		/* HSI2C controller internal clk rate should be 19.2 Mhz */
+		internal_clk = 19200;
+		fclk_rate = clk_get_rate(dev->fclk) / 1000;
+
+		/* Compute prescaler divisor */
+		psc = fclk_rate / internal_clk;
+		psc = psc - 1;
+
+		/* If configured for High Speed */
+		if (dev->speed > 400) {
+			/* For first phase of HS mode */
+			fsscll = internal_clk / (400 * 2) - 6;
+			fssclh = internal_clk / (400 * 2) - 6;
+
+			/* For second phase of HS mode */
+			hsscll = fclk_rate / (dev->speed * 2) - 6;
+			hssclh = fclk_rate / (dev->speed * 2) - 6;
+		} else {
+			/* To handle F/S modes */
+			fsscll = internal_clk / (dev->speed * 2) - 6;
+			fssclh = internal_clk / (dev->speed * 2) - 6;
+		}
+		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
+		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
+	} else {
+		/* Program desired operating rate */
+		fclk_rate /= (psc + 1) * 1000;
+		if (psc > 2)
+			psc = 2;
+		scll = fclk_rate / (dev->speed * 2) - 7 + psc;
+		sclh = fclk_rate / (dev->speed * 2) - 7 + psc;
+	}
+
 	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
 	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, psc);
 
-	/* Program desired operating rate */
-	fclk_rate /= (psc + 1) * 1000;
-	if (psc > 2)
-		psc = 2;
-
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG,
-			   fclk_rate / (clock * 2) - 7 + psc);
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG,
-			   fclk_rate / (clock * 2) - 7 + psc);
+	/* SCL low and high time values */
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
 
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
@@ -326,6 +368,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	dev->cmd_err = 0;
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
+
+	/* High speed configuration */
+	if (dev->speed > 400)
+		w |= OMAP_I2C_CON_OPMODE;
+
 	if (msg->flags & I2C_M_TEN)
 		w |= OMAP_I2C_CON_XA;
 	if (!(msg->flags & I2C_M_RD))
@@ -562,6 +609,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
 	int r;
+	u32 *speed = NULL;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -582,17 +630,18 @@ omap_i2c_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	if (clock > 200)
-		clock = 400;	/* Fast mode */
-	else
-		clock = 100;	/* Standard mode */
-
 	dev = kzalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		r = -ENOMEM;
 		goto err_release_region;
 	}
 
+	if (pdev->dev.platform_data != NULL)
+		speed = (u32 *) pdev->dev.platform_data;
+	else
+		*speed = 100; /* Defualt speed */
+
+	dev->speed = *speed;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
 	dev->base = (void __iomem *) IO_ADDRESS(mem->start);
@@ -618,7 +667,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 	r = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
-		 pdev->id, r >> 4, r & 0xf, clock);
+		 pdev->id, r >> 4, r & 0xf, dev->speed);
 
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
-- 
1.5.6.rc3.21.g8c6b5

