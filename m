From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH] i2c: busses: i2c-omap: Increase timeout for i2c interrupt
Date: Fri, 10 Jul 2015 10:39:54 +0530
Message-ID: <1436504994-31137-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

When system is under load and there is an i2c transaction running
following warning appears on the console:

[  730.003617] omap_i2c 48070000.i2c: controller timed out
[  731.023643] omap_i2c 48070000.i2c: controller timed out

This is because, the completion() call, which is done in bottom half of
the interrupt handler, happens after the timeout period(1s) has elapsed
for the wait_for_completion_timeout() in omap_i2c_xfer_msg(). The
interrupt is raised within a second but due to system load (or other
interrupts), the bottom half does not get scheduled within a second.
Hence even though the interrupt has happened within required time frame,
due to delayed scheduling of bottom half, spurious timeout errors are
reported on the console and i2c controller is reset.

i2c timeout is a rare condition, hence increase timeout to 60s in order
to avoid reporting false timeout events under load.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---

I reproduced this while running i2cdump in a loop and reading from flash
using dd command.

 drivers/i2c/busses/i2c-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d1c22e3fdd14..fa7758f0302c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -50,7 +50,7 @@
 #define OMAP_I2C_REV_ON_4430_PLUS	0x50400002
 
 /* timeout waiting for the controller to respond */
-#define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
+#define OMAP_I2C_TIMEOUT (msecs_to_jiffies(60 * 1000))
 
 /* timeout for pm runtime autosuspend */
 #define OMAP_I2C_PM_TIMEOUT		1000	/* ms */
-- 
2.4.5
