From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [RFC 2/5] i2c: omap: simplify i462 errata handling for NACK and AL cases
Date: Wed,  3 Dec 2014 18:33:59 +0400
Message-ID: <1417617242-16869-3-git-send-email-al.kochet@gmail.com>
References: <1417617242-16869-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417617242-16869-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Alexander Kochetkov <al.kochet@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Carry out NACK and AL handling to main event loop as it should be.

The change affects omap3530 and early boards.
Tested and simulated on omap3730 (Beagleboard XM C).

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c |   39 ++++++---------------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 53b4234..8591c0c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -907,22 +907,8 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
 		if (stat & OMAP_I2C_STAT_XUDF)
 			break;
 
-		if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
-			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
-							OMAP_I2C_STAT_XDR));
-			if (stat & OMAP_I2C_STAT_NACK) {
-				dev->cmd_err |= OMAP_I2C_STAT_NACK;
-				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
-			}
-
-			if (stat & OMAP_I2C_STAT_AL) {
-				dev_err(dev->dev, "Arbitration lost\n");
-				dev->cmd_err |= OMAP_I2C_STAT_AL;
-				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
-			}
-
+		if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL))
 			return -EIO;
-		}
 
 		cpu_relax();
 	} while (--timeout);
@@ -956,7 +942,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *dev, u8 num_bytes,
 	}
 }
 
-static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
+static void omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 		bool is_xdr)
 {
 	u16		w;
@@ -975,17 +961,12 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 		}
 
 		if (dev->errata & I2C_OMAP_ERRATA_I462) {
-			int ret;
-
-			ret = errata_omap3_i462(dev);
-			if (ret < 0)
-				return ret;
+			if (errata_omap3_i462(dev))
+				break;
 		}
 
 		omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 	}
-
-	return 0;
 }
 
 static irqreturn_t
@@ -1101,30 +1082,22 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
 		if (stat & OMAP_I2C_STAT_XDR) {
 			u8 num_bytes = 1;
-			int ret;
 
 			if (dev->fifo_size)
 				num_bytes = dev->buf_len;
 
-			ret = omap_i2c_transmit_data(dev, num_bytes, true);
-			if (ret < 0)
-				break;
-
+			omap_i2c_transmit_data(dev, num_bytes, true);
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
 			continue;
 		}
 
 		if (stat & OMAP_I2C_STAT_XRDY) {
 			u8 num_bytes = 1;
-			int ret;
 
 			if (dev->threshold)
 				num_bytes = dev->threshold;
 
-			ret = omap_i2c_transmit_data(dev, num_bytes, false);
-			if (ret < 0)
-				break;
-
+			omap_i2c_transmit_data(dev, num_bytes, false);
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
 			continue;
 		}
-- 
1.7.9.5
