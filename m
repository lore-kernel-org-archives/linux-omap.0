From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 11/22] i2c: omap: get rid of "count" variable
Date: Wed, 13 Jun 2012 18:51:00 +0300
Message-ID: <1339602671-8431-12-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53429 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754174Ab2FMPxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:46 -0400
Received: by lbon10 with SMTP id n10so1692413lbo.13
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:43 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

now that we're running on a thread, there's
no problem in doing lots of work as IRQs won't
be disabled anymore.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6e0b406..dba174c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -886,7 +886,7 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 	struct omap_i2c_dev *dev = dev_id;
 	u16 bits;
 	u16 stat;
-	int err = 0, count = 0;
+	int err = 0;
 
 	if (pm_runtime_suspended(dev->dev))
 		return IRQ_NONE;
@@ -903,12 +903,6 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 		}
 
 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
-		if (count++ == 100) {
-			dev_warn(dev->dev, "Too much work in one IRQ\n");
-			omap_i2c_complete_cmd(dev, err);
-			return IRQ_HANDLED;
-		}
-
 complete:
 		if (stat & OMAP_I2C_STAT_NACK) {
 			dev_err(dev->dev, "No Acknowledge\n");
@@ -1028,7 +1022,7 @@ complete:
 		}
 	} while (stat);
 
-	return count ? IRQ_HANDLED : IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static const struct i2c_algorithm omap_i2c_algo = {
-- 
1.7.10.4

