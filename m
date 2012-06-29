From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 05/17] i2c: omap: simplify omap_i2c_ack_stat()
Date: Fri, 29 Jun 2012 15:43:25 +0530
Message-ID: <1340964817-8599-6-git-send-email-shubhrajyoti@ti.com>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340964817-8599-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

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

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Reviewed-by : Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---

- Added the explaination from the discurssion to the commit logs
as per Wolfram's suggestion.

 drivers/i2c/busses/i2c-omap.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 7be661e..359ee08 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -750,7 +750,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev, u16 *stat, int *err)
 
 	while (--timeout && !(*stat & OMAP_I2C_STAT_XUDF)) {
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
-			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
+			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
 			return -ETIMEDOUT;
 		}
@@ -811,10 +811,11 @@ complete:
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
@@ -861,8 +862,8 @@ complete:
 					}
 				}
 			}
-			omap_i2c_ack_stat(dev,
-				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
+			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
+						OMAP_I2C_STAT_RDR));
 			continue;
 		}
 
@@ -909,8 +910,8 @@ complete:
 
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
