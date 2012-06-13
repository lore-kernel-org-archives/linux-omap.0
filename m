From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 12/22] i2c: omap: get rid of the "complete" label
Date: Wed, 13 Jun 2012 18:51:01 +0300
Message-ID: <1339602671-8431-13-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52930 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754174Ab2FMPxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:52 -0400
Received: by lags15 with SMTP id s15so590875lag.34
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:46 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

we can ack stat and complete the command from
the errata handling itself.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index dba174c..9dadfb1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -903,7 +903,7 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 		}
 
 		dev_dbg(dev->dev, "IRQ (ISR = 0x%04x)\n", stat);
-complete:
+
 		if (stat & OMAP_I2C_STAT_NACK) {
 			dev_err(dev->dev, "No Acknowledge\n");
 			err |= OMAP_I2C_STAT_NACK;
@@ -980,7 +980,9 @@ complete:
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0) {
 				err |= OMAP_I2C_STAT_XUDF;
-				goto complete;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF |
+						OMAP_I2C_STAT_XDR);
+				omap_i2c_complete_cmd(dev, err);
 			}
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
@@ -998,7 +1000,9 @@ complete:
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0) {
 				err |= OMAP_I2C_STAT_XUDF;
-				goto complete;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF |
+						OMAP_I2C_STAT_XRDY);
+				omap_i2c_complete_cmd(dev, err);
 			}
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
-- 
1.7.10.4

