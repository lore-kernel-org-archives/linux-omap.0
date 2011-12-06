From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] I2C: OMAP: fix FIFO usage for OMAP4
Date: Tue,  6 Dec 2011 10:25:58 -0800
Message-ID: <1323195958-17982-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55987 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934Ab1LFSZp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Dec 2011 13:25:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Shubhrajyoti D <shubhrajyoti@ti.com>

Currently the fifo depth is set to zero for OMAP4 which disables
the FIFO usage. This patch enables the FIFO usage for I2C transactions
on OMAP4 also.

Tested on omap4430 and 3430.

Tested-and-Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Ben, can you queue this fix for v3.2-rc?
Patch applies to v3.2-rc4.

 drivers/i2c/busses/i2c-omap.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a43d002..fa23faa 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1047,13 +1047,14 @@ omap_i2c_probe(struct platform_device *pdev)
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
1.7.6

