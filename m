From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv2] i2c: omap: Move the remove constraint
Date: Thu, 15 Nov 2012 13:04:43 +0530
Message-ID: <1352964883-9846-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33150 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992718Ab2KOHfT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 02:35:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

Currently we just queue the transfer and release the
qos constraints, however we donot wait for the transfer
to complete to release the constraint. Move the remove
constraint after the bus busy as we are sure that the
transfers are completed by then.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
v2: rebase to the for-next branch

 drivers/i2c/busses/i2c-omap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 482c63d..fabcbe1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -654,13 +654,14 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
-
 	if (r == 0)
 		r = num;
 
 	omap_i2c_wait_for_bb(dev);
+
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->set_mpu_wkup_lat(dev->dev, -1);
+
 out:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
1.7.5.4

