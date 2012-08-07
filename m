From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] i2c: omap: sanitize exit path
Date: Tue,  7 Aug 2012 08:51:29 +0300
Message-ID: <1344318689-24522-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:40704 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608Ab2HGFzE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 01:55:04 -0400
Received: by lbbgk8 with SMTP id gk8so1014386lbb.41
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 22:55:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>

move the goto out label one line down, so that
it can be used when stat is read as zero. All
other exits, can be done with a break statement.

While at that, also break out as soon as we
complete draining IRQ, since at that time
we know we transferred everything there was
to be transferred.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 22efaba..57c2824 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -898,27 +898,26 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
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
@@ -931,7 +930,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 						OMAP_I2C_STAT_XRDY |
 						OMAP_I2C_STAT_XDR |
 						OMAP_I2C_STAT_ARDY));
-			goto out;
+			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_RDR) {
@@ -946,7 +945,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 				i2c_omap_errata_i207(dev, stat);
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
-			continue;
+			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_RRDY) {
@@ -969,10 +968,10 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
 			if (ret < 0)
-				goto out;
+				break;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
-			continue;
+			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_XRDY) {
@@ -984,7 +983,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
 			if (ret < 0)
-				goto out;
+				break;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
 			continue;
@@ -994,19 +993,20 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
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
1.7.12.rc0

