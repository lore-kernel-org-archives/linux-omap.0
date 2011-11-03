From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Thu, 3 Nov 2011 20:47:08 +0530
Message-ID: <1320333428-23532-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36765 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932995Ab1KCPRU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Nov 2011 11:17:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

Currently the fifo depth is set to zero for OMAP4 which disables
the FIFO usage. This patch enables the FIFO usage for I2C transactions
on OMAP4 also.

Tested on omap4430 and 3430.

Tested-and-Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
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
1.7.1

