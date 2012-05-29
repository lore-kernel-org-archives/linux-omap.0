From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv10 11/11] OMAP/I2C - Fix timeout problem during suspend.
Date: Tue, 29 May 2012 16:26:23 +0530
Message-ID: <1338288983-15026-12-git-send-email-shubhrajyoti@ti.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51688 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487Ab2E2K51 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 06:57:27 -0400
In-Reply-To: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Neil Brown <neilb@suse.de>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Neil Brown <neilb@suse.de>

On a board with OMAP3 processor and TWL4030 Power management,
we need to talk to the TWL4030 during late suspend but cannot
because the I2C interrupt is disabled (as late suspend disables
interrupt).

e.g. I get messages like:

[   62.161102] musb-omap2430 musb-omap2430: LATE power domain suspend
[   63.167205] omap_i2c omap_i2c.1: controller timed out
[   63.183044] twl: i2c_read failed to transfer all messages
[   64.182861] omap_i2c omap_i2c.1: controller timed out
[   64.198455] twl: i2c_write failed to transfer all messages
[   65.198455] omap_i2c omap_i2c.1: controller timed out
[   65.203765] twl: i2c_write failed to transfer all messages

The stack shows omap2430_runtime_suspend calling twl4030_set_suspend
which tries to power-down the USB PHY (twl4030_phy_suspend ->
twl4030_phy_power -> __twl4030_phy_power which as a nice WARN_ON
that helps).

Then we get the same in resume:

[   69.603912] musb-omap2430 musb-omap2430: EARLY power domain resume
[   70.610473] omap_i2c omap_i2c.1: controller timed out
[   70.626129] twl: i2c_write failed to transfer all messages
etc.

So don't disable interrupts for I2C.

Acked-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index dc3bd40..9895fa7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1053,7 +1053,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	isr = (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
 								   omap_i2c_isr;
-	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
+	r = request_irq(dev->irq, isr, IRQF_NO_SUSPEND, pdev->name, dev);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
-- 
1.7.5.4

