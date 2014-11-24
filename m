From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] omap: i2c: don't check bus state IP rev3.3 and earlier
Date: Tue, 25 Nov 2014 02:20:55 +0400
Message-ID: <1416867655-22232-1-git-send-email-al.kochet@gmail.com>
References: <20141124210809.GG2817@atomide.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141124210809.GG2817-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Commit 903c3859f77f9b0aace551da03267ef7a211dbc4 ("i2c: omap: implement
workaround for handling invalid BB-bit values") introduce the error result
in boot test fault on OMAP3530 boards

The patch fix the error (disable i2c bus test for OMAP3530).

Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Fixes: 903c3859f77f9b0aace551da03267ef7a211dbc4
Reported-by: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

---
 drivers/i2c/busses/i2c-omap.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5d92d0e..4563200 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -344,8 +344,10 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
 		/* SYSC register is cleared by the reset; rewrite it */
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, sysc);
 
-		/* Schedule I2C-bus monitoring on the next transfer */
-		dev->bb_valid = 0;
+		if (dev->rev > OMAP_I2C_REV_ON_3430_3530) {
+			/* Schedule I2C-bus monitoring on the next transfer */
+			dev->bb_valid = 0;
+		}
 	}
 
 	return 0;
@@ -460,7 +462,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	dev->scllstate = scll;
 	dev->sclhstate = sclh;
 
-	if (dev->rev < OMAP_I2C_OMAP1_REV_2) {
+	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530) {
 		/* Not implemented */
 		dev->bb_valid = 1;
 	}
-- 
1.7.9.5
