From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 10/17] i2c: omap: get rid of the "complete" label
Date: Thu, 14 Jun 2012 19:24:20 +0300
Message-ID: <1339691067-919-11-git-send-email-balbi@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:50435 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932143Ab2FNQ1J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 12:27:09 -0400
Received: by lbon10 with SMTP id n10so2241898lbo.41
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 09:27:02 -0700 (PDT)
In-Reply-To: <1339691067-919-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, w.sang@pengutronix.de, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Felipe Balbi <balbi@ti.com>

we can ack stat and complete the command from
the errata handling itself.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 83ae06a..7171ea1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -893,7 +893,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			return IRQ_HANDLED;
 		}
 
-complete:
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
@@ -957,10 +956,12 @@ complete:
 				num_bytes = dev->fifo_size;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0) {
 				err |= OMAP_I2C_STAT_XUDF;
-				goto complete;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF |
+						OMAP_I2C_STAT_XDR);
+				omap_i2c_complete_cmd(dev, err);
+				return IRQ_HANDLED;
 			}
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
@@ -975,10 +976,12 @@ complete:
 				num_bytes = dev->fifo_size;
 
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
-			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0) {
 				err |= OMAP_I2C_STAT_XUDF;
-				goto complete;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF |
+						OMAP_I2C_STAT_XRDY);
+				omap_i2c_complete_cmd(dev, err);
+				return IRQ_HANDLED;
 			}
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
-- 
1.7.10.4

