From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 08/17] i2c: omap: re-factor receive/transmit data loop
Date: Fri, 29 Jun 2012 15:43:28 +0530
Message-ID: <1340964817-8599-9-git-send-email-shubhrajyoti@ti.com>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340964817-8599-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

re-factor the common parts to a separate function,
so that code is easier to read and understand.

No functional changes.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |  204 ++++++++++++++++------------------------
 1 files changed, 82 insertions(+), 122 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 870452d..d57b75d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -771,12 +771,81 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
 	return 0;
 }
 
+static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
+		bool is_rdr)
+{
+	u16		w;
+
+	while (num_bytes--) {
+		if (!dev->buf_len) {
+			dev_err(dev->dev, "%s without data",
+					is_rdr ? "RDR" : "RRDY");
+			break;
+		}
+
+		w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
+		*dev->buf++ = w;
+		dev->buf_len--;
+
+		/*
+		 * Data reg in 2430, omap3 and
+		 * omap4 is 8 bit wide
+		 */
+		if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
+			if (dev->buf_len) {
+				*dev->buf++ = w >> 8;
+				dev->buf_len--;
+			}
+		}
+	}
+}
+
+static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
+		bool is_xdr)
+{
+	u16		w;
+
+	while (num_bytes--) {
+		if (!dev->buf_len) {
+			dev_err(dev->dev, "%s without data",
+					is_xdr ? "XDR" : "XRDY");
+			break;
+		}
+
+		w = *dev->buf++;
+		dev->buf_len--;
+
+		/*
+		 * Data reg in 2430, omap3 and
+		 * omap4 is 8 bit wide
+		 */
+		if (dev->flags & OMAP_I2C_FLAG_16BIT_DATA_REG) {
+			if (dev->buf_len) {
+				w |= *dev->buf++ << 8;
+				dev->buf_len--;
+			}
+		}
+
+		if (dev->errata & I2C_OMAP_ERRATA_I462) {
+			int ret;
+
+			ret = errata_omap3_i462(dev);
+			if (ret < 0)
+				return ret;
+		}
+
+		omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
+	}
+
+	return 0;
+}
+
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
 {
 	struct omap_i2c_dev *dev = dev_id;
 	u16 bits;
-	u16 stat, w;
+	u16 stat;
 	int err, count = 0;
 
 	if (pm_runtime_suspended(dev->dev))
@@ -831,30 +900,7 @@ complete:
 						OMAP_I2C_BUFSTAT_REG) >> 8)
 						& 0x3F;
 
-			while (num_bytes--) {
-				if (!dev->buf_len) {
-					dev_err(dev->dev,
-							"RDR IRQ while no data"
-							" requested\n");
-					break;
-				}
-
-				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
-				*dev->buf++ = w;
-				dev->buf_len--;
-
-				/*
-				 * Data reg in 2430, omap3 and
-				 * omap4 is 8 bit wide
-				 */
-				if (dev->flags &
-						OMAP_I2C_FLAG_16BIT_DATA_REG) {
-					if (dev->buf_len) {
-						*dev->buf++ = w >> 8;
-						dev->buf_len--;
-					}
-				}
-			}
+			omap_i2c_receive_data(dev, num_bytes, true);
 
 			if (dev->errata & I2C_OMAP_ERRATA_I207)
 				i2c_omap_errata_i207(dev, stat);
@@ -869,79 +915,24 @@ complete:
 			if (dev->fifo_size)
 				num_bytes = dev->fifo_size;
 
-			while (num_bytes--) {
-				if (!dev->buf_len) {
-					dev_err(dev->dev,
-							"RRDY IRQ while no data"
-							" requested\n");
-					break;
-				}
-
-				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
-				*dev->buf++ = w;
-				dev->buf_len--;
-
-				/*
-				 * Data reg in 2430, omap3 and
-				 * omap4 is 8 bit wide
-				 */
-				if (dev->flags &
-						OMAP_I2C_FLAG_16BIT_DATA_REG) {
-					if (dev->buf_len) {
-						*dev->buf++ = w >> 8;
-						dev->buf_len--;
-					}
-				}
-			}
-
+			omap_i2c_receive_data(dev, num_bytes, false);
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RRDY);
 			continue;
 		}
 
 		if (stat & OMAP_I2C_STAT_XDR) {
 			u8 num_bytes = 1;
+			int ret;
 
 			if (dev->fifo_size)
 				num_bytes = omap_i2c_read_reg(dev,
 							OMAP_I2C_BUFSTAT_REG)
 							& 0x3F;
 
-			while (num_bytes--) {
-				if (!dev->buf_len) {
-					dev_err(dev->dev,
-							"XDR IRQ while no "
-							"data to send\n");
-					break;
-				}
-
-				w = *dev->buf++;
-				dev->buf_len--;
-
-				/*
-				 * Data reg in 2430, omap3 and
-				 * omap4 is 8 bit wide
-				 */
-				if (dev->flags &
-						OMAP_I2C_FLAG_16BIT_DATA_REG) {
-					if (dev->buf_len) {
-						w |= *dev->buf++ << 8;
-						dev->buf_len--;
-					}
-				}
-
-				if (dev->errata & I2C_OMAP_ERRATA_I462) {
-					int ret;
-
-					ret = errata_omap3_i462(dev);
-					stat = omap_i2c_read_reg(dev,
-							OMAP_I2C_STAT_REG);
-
-					if (ret < 0)
-						goto complete;
-				}
-
-				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
-			}
+			ret = omap_i2c_transmit_data(dev, num_bytes, true);
+			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+			if (ret < 0)
+				goto complete;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
 			continue;
@@ -949,46 +940,15 @@ complete:
 
 		if (stat & OMAP_I2C_STAT_XRDY) {
 			u8 num_bytes = 1;
+			int ret;
 
 			if (dev->fifo_size)
 				num_bytes = dev->fifo_size;
 
-			while (num_bytes--) {
-				if (!dev->buf_len) {
-					dev_err(dev->dev,
-							"XRDY IRQ while no "
-							"data to send\n");
-					break;
-				}
-
-				w = *dev->buf++;
-				dev->buf_len--;
-
-				/*
-				 * Data reg in 2430, omap3 and
-				 * omap4 is 8 bit wide
-				 */
-				if (dev->flags &
-						OMAP_I2C_FLAG_16BIT_DATA_REG) {
-					if (dev->buf_len) {
-						w |= *dev->buf++ << 8;
-						dev->buf_len--;
-					}
-				}
-
-				if (dev->errata & I2C_OMAP_ERRATA_I462) {
-					int ret;
-
-					ret = errata_omap3_i462(dev);
-					stat = omap_i2c_read_reg(dev,
-							OMAP_I2C_STAT_REG);
-
-					if (ret < 0)
-						goto complete;
-				}
-
-				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
-			}
+			ret = omap_i2c_transmit_data(dev, num_bytes, false);
+			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+			if (ret < 0)
+				goto complete;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
 			continue;
-- 
1.7.5.4
