From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Tue, 5 Jul 2011 12:41:10 +0530
Message-ID: <1309849870-25660-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently the fifo depth is set to zero for OMAP4 which disables
the FIFO usage. This patch enables the FIFO usage for I2C transactions
on OMAP4 also.

Tested on omap4430 and 3430.

Reported-By: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
Rebased on top of the series by Andy Green
http://www.spinics.net/lists/linux-i2c/msg05632.html

 drivers/i2c/busses/i2c-omap.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d53cd61..8f87a37 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1068,13 +1068,14 @@ omap_i2c_probe(struct platform_device *pdev)
 		 * size. This is to ensure that we can handle the status on int
 		 * call back latencies.
 		 */
-		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430) {
-			dev->fifo_size = 0;
+
+		dev->fifo_size = (dev->fifo_size / 2);
+
+		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430)
 			dev->b_hw = 0; /* Disable hardware fixes */
-		} else {
-			dev->fifo_size = (dev->fifo_size / 2);
+		else
 			dev->b_hw = 1; /* Enable hardware fixes */
-		}
+
 		/* calculate wakeup latency constraint for MPU */
 		if (dev->set_mpu_wkup_lat != NULL)
 			dev->latency = (1000000 * dev->fifo_size) /
-- 
1.7.1
