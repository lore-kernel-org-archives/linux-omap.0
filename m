From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] I2C: OMAP: fix the clearing of interrupts
Date: Wed, 16 Nov 2011 12:16:32 +0530
Message-ID: <1321425992-6189-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The register IRQENABLE_CLR is a bit map of interrupt events.
All the bits have to be cleared to clear the interrupts.

Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2dfb631..c7c6bb2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -309,7 +309,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	if (dev->rev >= OMAP_I2C_REV_ON_4430)
-		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
+		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 0x6FFF);
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 
-- 
1.7.1
