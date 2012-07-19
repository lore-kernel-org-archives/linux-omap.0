From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv5 17/18] i2c: omap: get rid of the "complete" label
Date: Thu, 19 Jul 2012 20:08:07 +0530
Message-ID: <1342708688-2342-18-git-send-email-shubhrajyoti@ti.com>
References: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42055 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab2GSOoq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 10:44:46 -0400
In-Reply-To: <1342708688-2342-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

we can ack stat and complete the command from
the errata handling itself.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 05edae3..2e48da9 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -772,6 +772,17 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
 		if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
+			if (stat & OMAP_I2C_STAT_NACK) {
+				dev->cmd_err |= OMAP_I2C_STAT_NACK;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			}
+
+			if (stat & OMAP_I2C_STAT_AL) {
+				dev_err(dev->dev, "Arbitration lost\n");
+				dev->cmd_err |= OMAP_I2C_STAT_AL;
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			}
+
 			return -EIO;
 		}
 
@@ -872,7 +883,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			goto out;
 		}
 
-complete:
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
@@ -935,7 +945,7 @@ complete:
 			ret = omap_i2c_transmit_data(dev, num_bytes, true);
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
-				goto complete;
+				goto out;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
 			continue;
@@ -951,7 +961,7 @@ complete:
 			ret = omap_i2c_transmit_data(dev, num_bytes, false);
 			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 			if (ret < 0)
-				goto complete;
+				goto out;
 
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XRDY);
 			continue;
-- 
1.7.5.4

