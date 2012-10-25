From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/7] i2c: omap: reorder exit path of omap_i2c_xfer_msg()
Date: Thu, 25 Oct 2012 15:25:10 +0300
Message-ID: <1351167915-15079-3-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351167915-15079-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

just a cleanup patch trying to make exit path
more straightforward. No changes otherwise.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
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
1.8.0
