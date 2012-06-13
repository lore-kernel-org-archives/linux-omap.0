From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 08/22] i2c: omap: switch over to do {} while loop
Date: Wed, 13 Jun 2012 18:50:57 +0300
Message-ID: <1339602671-8431-9-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:59555 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754146Ab2FMPxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:38 -0400
Received: by lban1 with SMTP id n1so1255002lba.38
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:36 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

this will make sure that we execute at least once.
No functional changes otherwise.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 3d714a0c..cf13a3e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -870,20 +870,29 @@ omap_i2c_isr(int this_irq, void *dev_id)
 	struct omap_i2c_dev *dev = dev_id;
 	u16 bits;
 	u16 stat;
-	int err, count = 0;
+	int err = 0, count = 0;
 
 	if (pm_runtime_suspended(dev->dev))
 		return IRQ_NONE;
 
-	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	while ((stat = (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG))) & bits) {
+	do {
+		bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
+		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+		stat &= bits;
+
+		if (!stat) {
+			/* my work here is done */
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
+		}
+
 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
 		if (count++ == 100) {
 			dev_warn(dev->dev, "Too much work in one IRQ\n");
-			break;
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 
-		err = 0;
 complete:
 		/*
 		 * Ack the stat in one go, but [R/X]DR and [R/X]RDY should be
@@ -996,7 +1005,7 @@ complete:
 			dev_err(dev->dev, "Transmit underflow\n");
 			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
 		}
-	}
+	} while (stat);
 
 	return count ? IRQ_HANDLED : IRQ_NONE;
 }
-- 
1.7.10.4

