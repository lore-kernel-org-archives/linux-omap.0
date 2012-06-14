From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/17] i2c: omap: simplify omap_i2c_ack_stat()
Date: Thu, 14 Jun 2012 13:20:37 +0300
Message-ID: <1339669250-9183-5-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339669250-9183-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

stat & BIT(1) is the same as BIT(1), so let's
simplify things a bit by removing "stat &" from
all omap_i2c_ack_stat() calls.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
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
