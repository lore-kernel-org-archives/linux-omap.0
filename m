From: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] OMAP3: I2C: Errata i207: Clear wrong RDR interrupt
Date: Thu,  1 Apr 2010 17:50:27 +0530
Message-ID: <1270124427-11208-1-git-send-email-manjugk@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Under certain rare conditions, I2C_STAT[13].RDR bit may be set
and the corresponding interrupt fire, even there is no data in
the receive FIFO, or the I2C data transfer is still ongoing.
These spurious RDR events must be ignored by the software.

This patch handles and ignores RDR spurious interrupts.

Reviewed-by: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f2019d2..acf4076 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -796,6 +796,19 @@ complete:
 		}
 		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
 			u8 num_bytes = 1;
+
+			/*
+			 * OMAP3 I2C Errata ID: i207
+			 * Under certain rare conditions, RDR could be set again
+			 * when the bus is busy, then clear and ignore the interrupt
+			 */
+			if (!(stat & OMAP_I2C_STAT_RRDY) && (stat &
+						OMAP_I2C_STAT_BB)) {
+				/* clear RDR */
+				omap_i2c_ack_stat(dev, stat & OMAP_I2C_STAT_RDR);
+				dev_err(dev->dev, "I2C: RDR when bus is busy.\n");
+				return IRQ_HANDLED;
+			}
 			if (dev->fifo_size) {
 				if (stat & OMAP_I2C_STAT_RRDY)
 					num_bytes = dev->fifo_size;
-- 
1.6.0.4
