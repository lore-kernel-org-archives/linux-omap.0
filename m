From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM-0] OMAP3: I2C: Implement i2c save/restore
Date: Wed, 17 Sep 2008 12:45:27 +0300
Message-ID: <1221644727-13809-1-git-send-email-jouni.hogander@nokia.com>
References: <87r67kwg97.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21196 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbYIQJoN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 05:44:13 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8H9hmGG008605
	for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 12:44:10 +0300
In-Reply-To: <87r67kwg97.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Save and restore needed registers instead of re-init.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |   47 +++++++++++++++++++++++++++--------------
 1 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a661ed3..211d7b5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
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
@@ -209,16 +213,22 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 	if (dev->iclk != NULL)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
+
+	if (cpu_is_omap34xx()) {
+		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+	}
+
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
@@ -238,7 +248,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
-	u16 psc = 0, scll = 0, sclh = 0;
+	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
@@ -327,23 +337,30 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
+
+	if (cpu_is_omap34xx()) {
+		dev->pscstate = psc;
+		dev->scllstate = scll;
+		dev->sclhstate = sclh;
+		dev->bufstate = buf;
+	}
+
 	return 0;
 }
 
@@ -503,8 +520,6 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	omap_i2c_unidle(dev);
 
-	omap_i2c_init(dev);
-
 	if ((r = omap_i2c_wait_for_bb(dev)) < 0)
 		goto out;
 
-- 
1.5.5

