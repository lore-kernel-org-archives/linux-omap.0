From: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] i2c-omap: Fix I2C status ACK
Date: Thu, 20 Aug 2009 11:21:14 -0500
Message-ID: <1250785276-31713-2-git-send-email-m-sonasath@ti.com>
References: <1250785276-31713-1-git-send-email-m-sonasath@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250785276-31713-1-git-send-email-m-sonasath-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

I2C status ack for [RX]RDR and [RX]RDY could
cause race conditions of clearing the event
twice and a violation of the programing
sequence as defined in TRM This patch fixes
the same.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d258b02..94639d0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -674,7 +674,14 @@ omap_i2c_isr(int this_irq, void *dev_id)
 
 		err = 0;
 complete:
-		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
+		/*
+		 * Ack the stat in one go, but [R/X]DR and [R/X]RDY should be
+		 * acked after the data operation is complete.
+		 * Ref: TRM SWPU114Q Figure 18-31
+		 */
+		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat &
+				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
+				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
 
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
-- 
1.5.6.3
