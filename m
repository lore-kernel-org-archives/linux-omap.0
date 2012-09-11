From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv7 23/23] i2c: omap: sanitize exit path
Date: Tue, 11 Sep 2012 15:12:18 +0530
Message-ID: <1347356538-23835-24-git-send-email-shubhrajyoti@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347356538-23835-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

move the goto out label one line down, so that
it can be used when stat is read as zero. All
other exits, can be done with a break statement.

While at that, also break out as soon as we
complete draining IRQ, since at that time
we know we transferred everything there was
to be transferred.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 122f517..b149e32 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -901,27 +901,26 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
 		if (!stat) {
 			/* my work here is done */
-			spin_unlock_irqrestore(&dev->lock, flags);
-			return IRQ_HANDLED;
+			goto out;
 		}
 
 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
 		if (count++ == 100) {
 			dev_warn(dev->dev, "Too much work in one IRQ\n");
-			goto out;
+			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
-			goto out;
+			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
-			goto out;
+			break;
 		}
 
 		/*
@@ -934,7 +933,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 						OMAP_I2C_STAT_XRDY |
 						OMAP_I2C_STAT_XDR |
 						OMAP_I2C_STAT_ARDY));
-			goto out;
+			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_RDR) {
@@ -949,7 +948,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 				i2c_omap_errata_i207(dev, stat);
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
-			continue;
+			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_RRDY) {
@@ -972,10 +971,10 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
 			if (ret < 0)
-				goto out;
+				break;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
-			continue;
+			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_XRDY) {
@@ -987,7 +986,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
 			if (ret < 0)
-				goto out;
+				break;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
 			continue;
@@ -997,19 +996,20 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 			dev_err(dev->dev, "Receive overrun\n");
 			err |= OMAP_I2C_STAT_ROVR;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ROVR);
-			goto out;
+			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_XUDF) {
 			dev_err(dev->dev, "Transmit underflow\n");
 			err |= OMAP_I2C_STAT_XUDF;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF);
-			goto out;
+			break;
 		}
 	} while (stat);
 
-out:
 	omap_i2c_complete_cmd(dev, err);
+
+out:
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	return IRQ_HANDLED;
-- 
1.7.5.4
