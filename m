From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] i2c-omap: Double clear of ARDY status in IRQ handler
Date: Wed, 16 Feb 2011 10:24:16 +0530
Message-ID: <1297832056-28142-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>

This errata occurs when the ARDY interrupt generation is enabled.
At the begining of every new transaction the ARDY interrupt is cleared.

On continuous i2c transactions where after clearing the ARDY bit from
I2C_STAT register (clearing the interrupt), the IRQ line is reasserted and the
I2C_STAT[ARDY] bit set again on 1. In fact, the ARDY status bit is not cleared
at the write access to I2C_STAT[ARDY] and only the IRQ line is deasserted and
then reasserted. This is not captured in the usual errata documents.

The workaround is to have a double clear of ARDY status in irq handler.

Signed-off-by: Richard woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b605ff3..5b35cf4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -847,11 +847,15 @@ complete:
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
 		}
+		/* 
+		 * ProDB0017052: Clear ARDY bit twice
+		 */ 
 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
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
