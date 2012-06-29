From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 10/17] i2c: omap: ack IRQ in parts
Date: Fri, 29 Jun 2012 15:43:30 +0530
Message-ID: <1340964817-8599-11-git-send-email-shubhrajyoti@ti.com>
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

According to flow diagrams on OMAP TRMs,
we should ACK the IRQ as they happen.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e4b83af..6e4c2be 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -869,21 +869,19 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		}
 
 complete:
-		/*
-		 * Ack the stat in one go, but [R/X]DR and [R/X]RDY should be
-		 * acked after the data operation is complete.
-		 * Ref: TRM SWPU114Q Figure 18-31
-		 */
-		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat &
-				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
-				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-
-		if (stat & OMAP_I2C_STAT_NACK)
+		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
+		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 
 		/*
@@ -964,12 +962,18 @@ complete:
 
 		if (stat & OMAP_I2C_STAT_ROVR) {
 			dev_err(dev->dev, "Receive overrun\n");
-			dev->cmd_err |= OMAP_I2C_STAT_ROVR;
+			err |= OMAP_I2C_STAT_ROVR;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ROVR);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 
 		if (stat & OMAP_I2C_STAT_XUDF) {
 			dev_err(dev->dev, "Transmit underflow\n");
-			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
+			err |= OMAP_I2C_STAT_XUDF;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 	} while (stat);
 
-- 
1.7.5.4
