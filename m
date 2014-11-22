From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 3/4] i2c: omap: don't reset controller if Arbitration Lost detected
Date: Sat, 22 Nov 2014 23:47:13 +0400
Message-ID: <1416685634-5864-4-git-send-email-al.kochet@gmail.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416685634-5864-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Arbitration Lost is an expected situation in a multimaster
environment. I2C controller (IP) correctly detect and report AL.

The only one visible reason for reseting IP in the AL case is
to avoid advisory 1.94 (omap3) and errata i595 (omap4): "I2C:
After an Arbitration is Lost the Module Incorrectly Starts
the Next Transfer".

Errata workaround states: "The MST and STT bits inside I2C_CON
should be set to 1 at the same moment (avoid setting the MST bit
to 1 while STT = 0)." The driver never set MST and STT bits
separately and doesn't create condition for errata. So the reset
is not necessary.

Also corrected return value for AL to -EAGAIN.

Tested on Beagleboard XM C.
Tested on BBB and AM437x Starter Kit by Felipe Balbi.

Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a238a1d..e67b7d0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -703,13 +703,15 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		return 0;
 
 	/* We have an error */
-	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
-			    OMAP_I2C_STAT_XUDF)) {
+	if (dev->cmd_err & (OMAP_I2C_STAT_ROVR | OMAP_I2C_STAT_XUDF)) {
 		omap_i2c_reset(dev);
 		__omap_i2c_init(dev);
 		return -EIO;
 	}
 
+	if (dev->cmd_err & OMAP_I2C_STAT_AL)
+		return -EAGAIN;
+
 	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
-- 
1.7.9.5
