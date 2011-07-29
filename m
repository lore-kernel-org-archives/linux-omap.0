From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Fri, 29 Jul 2011 17:18:42 +0530
Message-ID: <1311940122-10681-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently for OMAP4 the I2C_WE is not programmed.
This patch enables the programming for OMAP4.

Reported-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
TODO:
Currently all the wakeup sources are enabled.
There is scope of optimising the same. Will revisit it.
Rebased on Kevin's wip/i2c branch
Tested on OMAP4430.

 drivers/i2c/busses/i2c-omap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d05efe7..18cc0af 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -313,9 +313,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		 * REVISIT: Some wakeup sources might not be needed.
 		 */
 		dev->westate = OMAP_I2C_WE_ALL;
-		if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-							dev->westate);
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
+						dev->westate);
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 
-- 
1.7.1
