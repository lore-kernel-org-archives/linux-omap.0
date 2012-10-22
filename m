From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/8] i2c: omap: reorder exit path of omap_i2c_xfer_msg()
Date: Mon, 22 Oct 2012 12:46:52 +0300
Message-ID: <1350899218-13624-3-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52797 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329Ab2JVJw5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 05:52:57 -0400
In-Reply-To: <1350899218-13624-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, ben-linux@fluff.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

just a cleanup patch trying to make exit path
more straightforward. No changes otherwise.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c07d9c4..bea0277 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -505,6 +505,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
 	unsigned long timeout;
+	int ret;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
@@ -582,31 +583,38 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	dev->buf_len = 0;
 	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
-		omap_i2c_init(dev);
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+		goto err_i2c_init;
 	}
 
-	if (likely(!dev->cmd_err))
-		return 0;
-
 	/* We have an error */
 	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
 			    OMAP_I2C_STAT_XUDF)) {
-		omap_i2c_init(dev);
-		return -EIO;
+		ret = -EIO;
+		goto err_i2c_init;
 	}
 
 	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
+
 		if (stop) {
 			w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
 			w |= OMAP_I2C_CON_STP;
 			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 		}
-		return -EREMOTEIO;
+
+		ret = -EREMOTEIO;
+		goto err;
 	}
-	return -EIO;
+
+	return 0;
+
+err_i2c_init:
+	omap_i2c_init(dev);
+
+err:
+	return ret;
 }
 
 
-- 
1.8.0.rc0

