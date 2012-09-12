From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 05/22] i2c: omap: simplify omap_i2c_ack_stat()
Date: Wed, 12 Sep 2012 16:27:59 +0530
Message-ID: <1347447496-16793-6-git-send-email-shubhrajyoti@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49305 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757473Ab2ILK6x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 06:58:53 -0400
In-Reply-To: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

stat & BIT(1) is the same as BIT(1), so let's
simplify things a bit by removing "stat &" from
all omap_i2c_ack_stat() calls.

Code snippet (extremely simplified):

if (stat & NACK) {
        ...
        omap_i2c_ack_stat(dev, stat & NACK);
}

if (stat & RDR) {
        ...
        omap_i2c_ack_stat(dev, stat & RDR);
}

and so on. The tricky place is only WRT errata handling, for example:

if (*stat & (NACK | AL)) {
        omap_i2c_ack_stat(dev, *stat & (XRDY | XDR));
        ...
}

but in this case, the errata says we must clear XRDY and XDR if that
errata triggers, so if they just got enabled or not, it doesn't matter.

Another tricky place is RDR | RRDY (likewise for XDR | XRDY):

if (stat & (RDR | RRDY)) {
        ...
        omap_i2c_ack_stat(dev, stat & (RDR | RRDY));
}

again here there will be no issues because those IRQs never fire
simultaneously and one will only after after we have handled the
previous, that's because the same FIFO is used anyway and we won't shift
data into FIFO until we tell the IP "hey, I'm done with the FIFO, you
can shift more data"

Signed-off-by: Felipe Balbi <balbi@ti.com>
Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
[Added the explaination from the discurssion to the commit logs]
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 30ea63c..f24eae9 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -731,7 +731,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev, u16 *stat, int *err)
 
 	while (--timeout && !(*stat & OMAP_I2C_STAT_XUDF)) {
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
-			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
+			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
 			return -ETIMEDOUT;
 		}
@@ -792,10 +792,11 @@ complete:
 		 */
 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
 					OMAP_I2C_STAT_AL)) {
-			omap_i2c_ack_stat(dev, stat &
-				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
-				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
-				OMAP_I2C_STAT_ARDY));
+			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
+						OMAP_I2C_STAT_RDR |
+						OMAP_I2C_STAT_XRDY |
+						OMAP_I2C_STAT_XDR |
+						OMAP_I2C_STAT_ARDY));
 			omap_i2c_complete_cmd(dev, err);
 			return IRQ_HANDLED;
 		}
@@ -842,8 +843,8 @@ complete:
 					}
 				}
 			}
-			omap_i2c_ack_stat(dev,
-				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
+			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
+						OMAP_I2C_STAT_RDR));
 			continue;
 		}
 
@@ -890,8 +891,8 @@ complete:
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
-			omap_i2c_ack_stat(dev,
-				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
+			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
+						OMAP_I2C_STAT_XDR));
 			continue;
 		}
 
-- 
1.7.5.4

