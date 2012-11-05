From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
Date: Mon, 5 Nov 2012 17:53:43 +0530
Message-ID: <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently after the reset the sysc is written with hardcoded values.
The patch reads the sysc register and writes back the same value
after reset.

- Some unnecessary rev checks can be optimised.
- Also due to whatever reason the hwmod flags are changed
we will not reset the values.
- In some of the cases the minor values of the 2430 register
is different(0x37) in that case the autoidle setting may be missed.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 25f1564..a09acdc 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -302,7 +302,11 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
 static int omap_i2c_reset(struct omap_i2c_dev *dev)
 {
 	unsigned long timeout;
+	u16 sysc;
+
 	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
+		sysc = omap_i2c_read_reg(dev, OMAP_I2C_SYSC_REG);
+
 		/* Disable I2C controller before soft reset */
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
 			omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
@@ -324,22 +328,8 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
 		}
 
 		/* SYSC register is cleared by the reset; rewrite it */
-		if (dev->rev == OMAP_I2C_REV_ON_2430) {
-
-			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
-					   SYSC_AUTOIDLE_MASK);
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, sysc);
 
-		} else if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
-			dev->syscstate = SYSC_AUTOIDLE_MASK;
-			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
-			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
-			      __ffs(SYSC_SIDLEMODE_MASK));
-			dev->syscstate |= (SYSC_CLOCKACTIVITY_FCLK <<
-			      __ffs(SYSC_CLOCKACTIVITY_MASK));
-
-			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
-							dev->syscstate);
-		}
 	}
 	return 0;
 }
-- 
1.7.5.4
