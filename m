From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv4 08/18] i2c: omap: re-factor receive/transmit data loop
Date: Tue, 3 Jul 2012 20:07:46 +0530
Message-ID: <1341326276-25434-9-git-send-email-shubhrajyoti@ti.com>
References: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40931 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756593Ab2GCOlG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 10:41:06 -0400
In-Reply-To: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

re-factor the common parts to a separate function,
so that code is easier to read and understand.

No functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |  204 ++++++++++++++++------------------------
 1 files changed, 82 insertions(+), 122 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1715c35..dca6d3e 100644
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
@@ -829,30 +898,7 @@ complete:
 			if (dev->fifo_size)
 				num_bytes = dev->buf_len;
 
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
@@ -867,77 +913,22 @@ complete:
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
 				num_bytes = dev->buf_len;
 
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
@@ -945,46 +936,15 @@ complete:
 
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

