From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv5 09/18] i2c: omap: switch over to do {} while loop
Date: Thu, 19 Jul 2012 20:07:59 +0530
Message-ID: <1342708688-2342-10-git-send-email-shubhrajyoti@ti.com>
References: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41982 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660Ab2GSOoL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 10:44:11 -0400
In-Reply-To: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

this will make sure that we execute at least once.
No functional changes otherwise.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 700f018..78fc274 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -824,20 +824,28 @@ omap_i2c_isr(int this_irq, void *dev_id)
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
@@ -937,7 +945,7 @@ complete:
 			dev_err(dev->dev, "Transmit underflow\n");
 			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
 		}
-	}
+	} while (stat);
 
 	return count ? IRQ_HANDLED : IRQ_NONE;
 }
-- 
1.7.5.4

