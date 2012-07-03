From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv4 09/18] i2c: omap: switch over to do {} while loop
Date: Tue, 3 Jul 2012 20:07:47 +0530
Message-ID: <1341326276-25434-10-git-send-email-shubhrajyoti@ti.com>
References: <1341326276-25434-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341326276-25434-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

this will make sure that we execute at least once.
No functional changes otherwise.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index dca6d3e..6c8f135 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -846,20 +846,28 @@ omap_i2c_isr(int this_irq, void *dev_id)
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
@@ -959,7 +967,7 @@ complete:
 			dev_err(dev->dev, "Transmit underflow\n");
 			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
 		}
-	}
+	} while (stat);
 
 	return count ? IRQ_HANDLED : IRQ_NONE;
 }
-- 
1.7.5.4
