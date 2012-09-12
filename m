From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 16/22] i2c: omap: resize fifos before each message
Date: Wed, 12 Sep 2012 16:28:10 +0530
Message-ID: <1347447496-16793-17-git-send-email-shubhrajyoti@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347447496-16793-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

This patch will try to avoid the usage of
draining feature by reconfiguring the FIFO
the start condition of each message based
on the message's size.

By doing that, we will be better utilizing
the FIFO when doing big transfers.

While at that also drop the now unneeded
check for dev->buf_len as we always know
the amount of data to be transmitted.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   83 +++++++++++++++++++++++++----------------
 1 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4af123f..f33bc5a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -193,6 +193,7 @@ struct omap_i2c_dev {
 	u8			*regs;
 	size_t			buf_len;
 	struct i2c_adapter	adapter;
+	u8			threshold;
 	u8			fifo_size;	/* use as flag and value
 						 * fifo_size==0 implies no fifo
 						 * if set, should be trsh+1
@@ -418,13 +419,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
 
@@ -462,6 +456,45 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
 	return 0;
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
@@ -478,6 +511,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (msg->len == 0)
 		return -EINVAL;
 
+	dev->receiver = !!(msg->flags & I2C_M_RD);
+	omap_i2c_resize_fifo(dev, msg->len, dev->receiver);
+
 	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);
 
 	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
@@ -493,7 +529,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->cmd_err = 0;
-	dev->receiver = !!(msg->flags & I2C_M_RD);
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
 
@@ -760,12 +795,6 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
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
@@ -775,10 +804,8 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
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
@@ -789,12 +816,6 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
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
 
@@ -803,10 +824,8 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
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
@@ -901,8 +920,8 @@ complete:
 		if (stat & OMAP_I2C_STAT_RRDY) {
 			u8 num_bytes = 1;
 
-			if (dev->fifo_size)
-				num_bytes = dev->fifo_size;
+			if (dev->threshold)
+				num_bytes = dev->threshold;
 
 			omap_i2c_receive_data(dev, num_bytes, false);
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RRDY);
@@ -929,8 +948,8 @@ complete:
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
