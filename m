From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/6] i2c: omap: get rid of b_hw flag
Date: Wed, 23 Jan 2013 12:23:08 +0200
Message-ID: <1358936588-16375-7-git-send-email-balbi@ti.com>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358936588-16375-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, aaro.koskinen-X3B1VOXEql0@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Now that we never set STP and STT together,
that flag has been rendered useless. Let's
completely drop it.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4e715c4..96cdfba 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -215,7 +215,6 @@ struct omap_i2c_dev {
 						 * if set, should be trsh+1
 						 */
 	u32			rev;
-	unsigned		b_hw:1;		/* bad h/w fixes */
 	unsigned		receiver:1;	/* true when we're in receiver mode */
 	u16			iestate;	/* Saved interrupt register */
 	u16			pscstate;
@@ -557,9 +556,6 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
 
 	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
 
-	if (dev->rev < OMAP_I2C_REV_ON_3630)
-		dev->b_hw = 1; /* Enable hardware fixes */
-
 	/* calculate wakeup latency constraint for MPU */
 	if (dev->set_mpu_wkup_lat != NULL)
 		dev->latency = (1000000 * dev->threshold) /
@@ -1215,9 +1211,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 		dev->fifo_size = (dev->fifo_size / 2);
 
-		if (dev->rev < OMAP_I2C_REV_ON_3630)
-			dev->b_hw = 1; /* Enable hardware fixes */
-
 		/* calculate wakeup latency constraint for MPU */
 		if (dev->set_mpu_wkup_lat != NULL)
 			dev->latency = (1000000 * dev->fifo_size) /
-- 
1.8.1.rc1.5.g7e0651a
