From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/10] OMAP: I2C: Fix the interrupt clearing in OMAP4
Date: Fri, 10 Feb 2012 19:30:00 +0530
Message-ID: <1328882405-15284-6-git-send-email-shubhrajyoti@ti.com>
References: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328882405-15284-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On OMAP4 we were writing 1 to IRQENABLE_CLR which cleared only
the arbitration lost interrupt. The patch intends to fix the same by writing 0
to the IE register clearing all interrupts.

This is based on the work done by Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>.

The  changes from the original patch ...
-  Does not use the IRQENABLE_CLR register to clear as it is not mentioned
  to be legacy register IRQENABLE_CLR helps in  atomically
  setting/clearing specific interrupts, instead use the OMAP_I2C_IE_REG as we are
  clearing all interrupts.

Cc: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
Original patch can be found here:
http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=41049d62e146e0fafe2fac0a31be566b3bbc9149

 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c07e3e4..c3ca7d9 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1169,10 +1169,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 	_dev->dev_lost_count = omap_device_get_context_loss_count(pdev);
 
 	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
-	if (_dev->dtrev == OMAP_I2C_IP_VERSION_2)
-		omap_i2c_write_reg(_dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
-	else
-		omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
+
+	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
 
 	if (_dev->rev < OMAP_I2C_OMAP1_REV_2) {
 		iv = omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
-- 
1.7.1
