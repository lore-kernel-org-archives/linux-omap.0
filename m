From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 05/16] OMAP3: I2C context save/restore
Date: Fri, 26 Sep 2008 17:48:07 +0530
Message-ID: <01f601c91fd1$ef53c400$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52921 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbYIZMSR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:18:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch does i2c init/re-init for every transfer.
Avoids a i2c controller reset every time

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   41 +++++++++++++++++++++++++++--------------
 1 files changed, 27 insertions(+), 14 deletions(-)

Index: linux-omap-2.6/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c	2008-09-25 16:26:40.000000000 +0530
+++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c	2008-09-25 16:27:14.000000000 +0530
@@ -147,6 +147,10 @@ struct omap_i2c_dev {
 	unsigned		b_hw:1;		/* bad h/w fixes */
 	unsigned		idle:1;
 	u16			iestate;	/* Saved interrupt register */
+	u16			pscstate;
+	u16			scllstate;
+	u16			sclhstate;
+	u16			bufstate;
 };
 
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -209,16 +213,20 @@ static void omap_i2c_unidle(struct omap_
 	if (dev->iclk != NULL)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
+	if (cpu_is_omap34xx()) {
+		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+	}
 	dev->idle = 0;
-	if (dev->iestate)
-		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 }
 
 static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
 	u16 iv;
 
-	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1)
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);
@@ -238,7 +246,7 @@ static void omap_i2c_idle(struct omap_i2
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
-	u16 psc = 0, scll = 0, sclh = 0;
+	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
@@ -327,23 +335,28 @@ static int omap_i2c_init(struct omap_i2c
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
 
-	if (dev->fifo_size)
-		/* Note: setup required fifo size - 1 */
-		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
-					(dev->fifo_size - 1) << 8 | /* RTRSH */
-					OMAP_I2C_BUF_RXFIF_CLR |
-					(dev->fifo_size - 1) | /* XTRSH */
-					OMAP_I2C_BUF_TXFIF_CLR);
+	if (dev->fifo_size) {
+		/* Note: setup required fifo size - 1. RTRSH and XTRSH */
+		buf = (dev->fifo_size - 1) << 8 | OMAP_I2C_BUF_RXFIF_CLR |
+			(dev->fifo_size - 1) | OMAP_I2C_BUF_TXFIF_CLR;
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
+	}
 
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 
 	/* Enable interrupts */
-	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
-			(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
 			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
-				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0));
+				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	if (cpu_is_omap34xx()) {
+		dev->pscstate = psc;
+		dev->scllstate = scll;
+		dev->sclhstate = sclh;
+		dev->bufstate = buf;
+	}
 	return 0;
 }
 

