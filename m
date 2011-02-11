From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Fri, 11 Feb 2011 12:15:18 +0530
Message-ID: <1297406718-24147-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>

ProDB00017052 - ARDY interrupt reasserted after being cleared.
This errata caused intermittent i2c instabilty(1 error per 3 hours) on several
customer platforms. After applying the workaround the intermittent errors were
not seen. This is not captured in the usual errata documents.

The workaround is to have a double clear of ARDY status in
irq handler.

Signed-off-by: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 445de08..9bcefae 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -851,7 +851,8 @@ complete:
 					OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, stat &
 				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
-				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
+				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
+				OMAP_I2C_STAT_ARDY));
 			omap_i2c_complete_cmd(dev, err);
 			return IRQ_HANDLED;
 		}
-- 
1.7.0.4
