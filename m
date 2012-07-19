From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv5 10/18] i2c: omap: ack IRQ in parts
Date: Thu, 19 Jul 2012 20:08:00 +0530
Message-ID: <1342708688-2342-11-git-send-email-shubhrajyoti@ti.com>
References: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35936 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab2GSOm2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 10:42:28 -0400
In-Reply-To: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

According to flow diagrams on OMAP TRMs,
we should ACK the IRQ as they happen.

Signed-off-by: Felipe Balbi <balbi@ti.com>
[ack the stat OMAP_I2C_STAT_AL in case of arbitration lost]
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
v5 - ack the OMAP_I2C_STAT_AL.

 drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 78fc274..62ad126 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -847,21 +847,19 @@ omap_i2c_isr(int this_irq, void *dev_id)
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
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 
 		/*
@@ -938,12 +936,18 @@ complete:
 
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

