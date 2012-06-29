From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv3 16/17] i2c: omap: resize fifos before each message
Date: Fri, 29 Jun 2012 15:43:36 +0530
Message-ID: <1340964817-8599-17-git-send-email-shubhrajyoti@ti.com>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42595 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab2F2KOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 06:14:39 -0400
In-Reply-To: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

This patch will try to avoid the usage of
draining feature by reconfiguring the FIFO
the start condition of each message based
on the message's size.

By doing that, we will be better utilizing
the FIFO when doing big transfers.

While at that also drop the now uneeded
check for dev->buf_len as we always know
the amount of data to be transmitted.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   83 +++++++++++++++++++++++++----------------
 1 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1196417..ac3bdae 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -190,6 +190,7 @@ struct omap_i2c_dev {
 	u8			*regs;
 	size_t			buf_len;
 	struct i2c_adapter	adapter;
+	u8			threshold;
 	u8			fifo_size;	/* use as flag and value
 						 * fifo_size==0 implies no fifo
 						 * if set, should be trsh+1
@@ -415,13 +416,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
 
-	if (dev->fifo_size) {
-		/* Note: setup required fifo size - 1. RTRSH and XTRSH */
-		buf = (dev->fifo_size - 1) << 8 | OMAP_I2C_BUF_RXFIF_CLR |
-			(dev->fifo_size - 1) | OMAP_I2C_BUF_TXFIF_CLR;
-		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
-	}
-
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 
@@ -482,6 +476,45 @@ static int omap_i2c_bus_clear(struct omap_i2c_dev *dev)
 	return omap_i2c_wait_for_bb(dev);
 }
 
+static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
+{
+	u16		buf;
+
+	if (dev->flags & OMAP_I2C_FLAG_NO_FIFO)
+		return;
+
+	/*
+	 * Set up notification threshold based on message size. We're doing
+	 * this to try and avoid draining feature as much as possible. Whenever
+	 * we have big messages to transfer (bigger than our total fifo size)
+	 * then we might use draining feature to transfer the remaining bytes.
+	 */
+
+	dev->threshold = clamp(size, (u8) 1, dev->fifo_size);
+
+	buf = omap_i2c_read_reg(dev, OMAP_I2C_BUF_REG);
+
+	if (is_rx) {
+		/* Clear RX Threshold */
+		buf &= ~(0x3f << 8);
+		buf |= ((dev->threshold - 1) << 8) | OMAP_I2C_BUF_RXFIF_CLR;
+	} else {
+		/* Clear TX Threshold */
+		buf &= ~0x3f;
+		buf |= (dev->threshold - 1) | OMAP_I2C_BUF_TXFIF_CLR;
+	}
+
+	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
+
+	if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
+		dev->b_hw = 1; /* Enable hardware fixes */
+
+	/* calculate wakeup latency constraint for MPU */
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->latency = (1000000 * dev->threshold) /
+			(1000 * dev->speed / 8);
+}
+
 /*
  * Low level master read/write transaction.
  */
@@ -498,6 +531,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (msg->len == 0)
 		return -EINVAL;
 
+	dev->receiver = !!(msg->flags & I2C_M_RD);
+	omap_i2c_resize_fifo(dev, msg->len, dev->receiver);
+
 	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);
 
 	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
@@ -513,7 +549,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->cmd_err = 0;
-	dev->receiver = !!(msg->flags & I2C_M_RD);
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
 
@@ -779,12 +814,6 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
 	u16		w;
 
 	while (num_bytes--) {
-		if (!dev->buf_len) {
-			dev_err(dev->dev, "%s without data",
-					is_rdr ? "RDR" : "RRDY");
-			break;
-		}
-
 		w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
 		*dev->buf++ = w;
 		dev->buf_len--;
@@ -794,10 +823,8 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
 		 * omap4 is 8 bit wide
 		 */
 		if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
-			if (dev->buf_len) {
-				*dev->buf++ = w >> 8;
-				dev->buf_len--;
-			}
+			*dev->buf++ = w >> 8;
+			dev->buf_len--;
 		}
 	}
 }
@@ -808,12 +835,6 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 	u16		w;
 
 	while (num_bytes--) {
-		if (!dev->buf_len) {
-			dev_err(dev->dev, "%s without data",
-					is_xdr ? "XDR" : "XRDY");
-			break;
-		}
-
 		w = *dev->buf++;
 		dev->buf_len--;
 
@@ -822,10 +843,8 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 		 * omap4 is 8 bit wide
 		 */
 		if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
-			if (dev->buf_len) {
-				w |= *dev->buf++ << 8;
-				dev->buf_len--;
-			}
+			w |= *dev->buf++ << 8;
+			dev->buf_len--;
 		}
 
 		if (dev->errata & I2C_OMAP_ERRATA_I462) {
@@ -923,8 +942,8 @@ complete:
 		if (stat & OMAP_I2C_STAT_RRDY) {
 			u8 num_bytes = 1;
 
-			if (dev->fifo_size)
-				num_bytes = dev->fifo_size;
+			if (dev->threshold)
+				num_bytes = dev->threshold;
 
 			omap_i2c_receive_data(dev, num_bytes, false);
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RRDY);
@@ -953,8 +972,8 @@ complete:
 			u8 num_bytes = 1;
 			int ret;
 
-			if (dev->fifo_size)
-				num_bytes = dev->fifo_size;
+			if (dev->threshold)
+				num_bytes = dev->threshold;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
-- 
1.7.5.4

