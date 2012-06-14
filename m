From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 14/17] i2c: omap: simplify errata check
Date: Thu, 14 Jun 2012 19:24:24 +0300
Message-ID: <1339691067-919-15-git-send-email-balbi@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:54906 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932184Ab2FNQ1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 12:27:20 -0400
Received: by lboj14 with SMTP id j14so1921167lbo.7
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 09:27:16 -0700 (PDT)
In-Reply-To: <1339691067-919-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, w.sang@pengutronix.de, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Felipe Balbi <balbi@ti.com>

omap_i2c_dev is allocated with kzalloc(),
so we need not initialize b_hw to zero.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6a7395a..6e97d86 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1138,9 +1138,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 		dev->fifo_size = (dev->fifo_size / 2);
 
-		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430)
-			dev->b_hw = 0; /* Disable hardware fixes */
-		else
+		if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
 			dev->b_hw = 1; /* Enable hardware fixes */
 
 		/* calculate wakeup latency constraint for MPU */
-- 
1.7.10.4

