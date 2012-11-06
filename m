From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] i2c: omap: Move the remove constraint
Date: Tue, 6 Nov 2012 15:24:33 +0530
Message-ID: <1352195673-31559-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58107 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935Ab2KFJzH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 04:55:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

Currently we just queue the transfer and release the
qos constraints, however we donot wait for the transfer
to complete to release the constraint. Move the remove
constraint after the bus busy as we are sure that the
transfers are completed by then.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 94ff685..8b079d7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -655,13 +655,13 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->latency)
-		pm_qos_remove_request(&dev->pm_qos_request);
-
 	if (r == 0)
 		r = num;
 
 	omap_i2c_wait_for_bb(dev);
+
+	if (dev->latency)
+		pm_qos_remove_request(&dev->pm_qos_request);
 out:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
1.7.5.4

