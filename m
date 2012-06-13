From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 04/22] i2c: omap: simplify omap_i2c_ack_stat()
Date: Wed, 13 Jun 2012 18:50:53 +0300
Message-ID: <1339602671-8431-5-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:60263 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753939Ab2FMPx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:27 -0400
Received: by lbol5 with SMTP id l5so1527946lbo.34
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:24 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

stat & BIT(1) is the same as BIT(1), so let's
simplify things a bit by removing "stat &" from
all omap_i2c_ack_stat() calls.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 07ae391..fa9ddb6 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -774,8 +774,8 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 
 	while (--timeout && !(*stat & OMAP_I2C_STAT_XUDF)) {
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
-			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
-							OMAP_I2C_STAT_XDR));
+			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
+					OMAP_I2C_STAT_XDR));
 			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
@@ -835,10 +835,11 @@ complete:
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
@@ -885,8 +886,8 @@ complete:
 					}
 				}
 			}
-			omap_i2c_ack_stat(dev,
-				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
+			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
+						OMAP_I2C_STAT_RDR));
 			continue;
 		}
 
@@ -933,8 +934,8 @@ complete:
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
-			omap_i2c_ack_stat(dev,
-				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
+			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
+						OMAP_I2C_STAT_XDR));
 			continue;
 		}
 
-- 
1.7.10.4

