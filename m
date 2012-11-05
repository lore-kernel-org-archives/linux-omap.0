From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 7/8] i2c: omap: Restore i2c context always
Date: Mon, 5 Nov 2012 17:53:42 +0530
Message-ID: <1352118223-3796-8-git-send-email-shubhrajyoti@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently the restore is done based on the flag
OMAP_I2C_FLAG_RESET_REGS_POSTIDLE.

This helps the following
- The driver is always capable of restoring regardless
of the off mode support being there or not.

- While testing omap2430 it is found that in case of certain
error paths (timeout) a reset is done. However the restore
never happens as it is dependent on the POSTIDLE flag.
The other option would be to call a restore in the reset
case. As there are only a few registers to be restored
the penalty in the idle case should not be much.

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
Todo: the flag could be deleted if the patch is accepted.

 drivers/i2c/busses/i2c-omap.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 7393017..25f1564 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1316,8 +1316,7 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	if (!_dev->regs)
 		return 0;
 
-	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
-		__omap_i2c_init(_dev);
+	__omap_i2c_init(_dev);
 
 	return 0;
 }
-- 
1.7.5.4
