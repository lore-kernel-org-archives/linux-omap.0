From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 3/4] i2c: omap: don't reset controller if Arbitration Lost detected
Date: Fri, 21 Nov 2014 01:28:44 +0400
Message-ID: <1416518925-20679-4-git-send-email-al.kochet@gmail.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, al.kochet@gmail.com
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Arbitration Lost is a expected situation in a multimaster environment.
IP correctly detect it.

The only reason for reseting IP in the AL case is to be sure to
avoid advisory 1.94 (omap3) and errata i595 (omap4):
"I2C: After an Arbitration is Lost the Module Incorrectly Starts
the Next Transfer" with workaround: "The MST and STT bits inside
I2C_CON should be set to 1 at the same moment (avoid setting the
MST bit to 1 while STT = 0)."

The driver never writes MST and STT bits separately and doesn't
create condition for errata. So the reset is not necessary.

Tested on Beagleboard XM C.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 3ffb9c0..47103e7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -707,13 +707,17 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		return 0;
 
 	/* We have an error */
-	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
+	if (dev->cmd_err & (OMAP_I2C_STAT_ROVR |
 			    OMAP_I2C_STAT_XUDF)) {
 		omap_i2c_reset(dev);
 		__omap_i2c_init(dev);
 		return -EIO;
 	}
 
+	if (dev->cmd_err & OMAP_I2C_STAT_AL) {
+		return -EIO;
+	}
+
 	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
-- 
1.7.9.5
