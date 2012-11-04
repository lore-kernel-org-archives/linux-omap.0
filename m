From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv2 5/7] i2c: omap: re-factor omap_i2c_init function
Date: Sun, 4 Nov 2012 16:14:31 +0530
Message-ID: <1352025873-27492-6-git-send-email-shubhrajyoti@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36161 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2KDKpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 05:45:09 -0500
In-Reply-To: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

re-factor omap_i2c_init() so that we can re-use it for resume.
While at it also remove the bufstate variable as we write it
in omap_i2c_resize_fifo for every transfer.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   75 +++++++++++++++++++----------------------
 1 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8a54efc..a87c20a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -209,7 +209,6 @@ struct omap_i2c_dev {
 	u16			pscstate;
 	u16			scllstate;
 	u16			sclhstate;
-	u16			bufstate;
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
@@ -275,9 +274,34 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
+static void __omap_i2c_init(struct omap_i2c_dev *dev)
+{
+
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+
+	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
+	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+
+	/* SCL low and high time values */
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+	if (dev->rev >= OMAP_I2C_REV_ON_3430_3530)
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+
+	/* Take the I2C module out of reset: */
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+
+	/*
+	 * Don't write to this register if the IE state is 0 as it can
+	 * cause deadlock.
+	 */
+	if (dev->iestate)
+		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+}
+
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
-	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
+	u16 psc = 0, scll = 0, sclh = 0;
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
@@ -327,11 +351,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
 			dev->westate = OMAP_I2C_WE_ALL;
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-							dev->westate);
 		}
 	}
-	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 
 	if (dev->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
 		/*
@@ -416,28 +437,17 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		sclh = fclk_rate / (dev->speed * 2) - 7 + psc;
 	}
 
-	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
-	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, psc);
-
-	/* SCL low and high time values */
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
-	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
-
-	/* Take the I2C module out of reset: */
-	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
-
-	/* Enable interrupts */
 	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
 			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
 				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
-	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
-	if (dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
-		dev->pscstate = psc;
-		dev->scllstate = scll;
-		dev->sclhstate = sclh;
-		dev->bufstate = buf;
-	}
+
+	dev->pscstate = psc;
+	dev->scllstate = scll;
+	dev->sclhstate = sclh;
+
+	__omap_i2c_init(dev);
+
 	return 0;
 }
 
@@ -1297,23 +1307,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	if (!_dev->regs)
 		return 0;
 
-	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
-		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
-		omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_SCLL_REG, _dev->scllstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_SCLH_REG, _dev->sclhstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_BUF_REG, _dev->bufstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_SYSC_REG, _dev->syscstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_WE_REG, _dev->westate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
-	}
-
-	/*
-	 * Don't write to this register if the IE state is 0 as it can
-	 * cause deadlock.
-	 */
-	if (_dev->iestate)
-		omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, _dev->iestate);
+	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
+		__omap_i2c_init(_dev);
 
 	return 0;
 }
-- 
1.7.5.4

