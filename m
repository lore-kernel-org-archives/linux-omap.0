From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH REBASE 6/6] i2c: omap: get rid of b_hw flag
Date: Fri, 14 Dec 2012 18:34:09 +0200
Message-ID: <1355502849-9289-7-git-send-email-balbi@ti.com>
References: <1355502849-9289-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36929 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756692Ab2LNQlk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 11:41:40 -0500
In-Reply-To: <1355502849-9289-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

Now that we never set STP and STT together,
that flag has been rendered useless. Let's
completely drop it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4d90f08..510506d 100644
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

