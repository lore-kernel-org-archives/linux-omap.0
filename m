From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 03/10] I2C: OMAP: Fix the interrupt clearing in OMAP4
Date: Thu, 19 Apr 2012 18:58:14 +0530
Message-ID: <1334842101-20670-4-git-send-email-shubhrajyoti@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334842101-20670-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On OMAP4 we were writing 1 to IRQENABLE_CLR which cleared only
the arbitration lost interrupt. The patch intends to fix the same by writing 0
to the IE register clearing all interrupts.

This is based on the work done by Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>.

The  changes from the original patch ...
-  Does not use the IRQENABLE_CLR register to clear as it is not mentioned
  to be legacy register IRQENABLE_CLR helps in  atomically
  setting/clearing specific interrupts, instead use the OMAP_I2C_IE_REG as we
  are clearing all interrupts.

Cc: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c851672..bf07ffd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1127,10 +1127,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 	u16 iv;
 
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
1.7.5.4
