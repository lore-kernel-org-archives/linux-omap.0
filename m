From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 22/22] i2c: omap: sanitize exit path
Date: Wed, 12 Sep 2012 16:28:16 +0530
Message-ID: <1347447496-16793-23-git-send-email-shubhrajyoti@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57193 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221Ab2ILK7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 06:59:16 -0400
In-Reply-To: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

move the goto out label one line down, so that
it can be used when stat is read as zero. All
other exits, can be done with a break statement.

While at that, also break out as soon as we
complete draining IRQ, since at that time
we know we transferred everything there was
to be transferred.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
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

