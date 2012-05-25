From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv9 00/10] I2C fixes
Date: Fri, 25 May 2012 16:40:47 -0700
Message-ID: <87obpbhls0.fsf@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:60687 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758740Ab2EYXkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 May 2012 19:40:47 -0400
Received: by dadg9 with SMTP id g9so2149945dad.40
        for <linux-omap@vger.kernel.org>; Fri, 25 May 2012 16:40:46 -0700 (PDT)
In-Reply-To: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Wed, 2 May 2012 20:02:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, NeilBrown <neilb@suse.de>

+Neil Brown

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> The patch series does the following
>
> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> - In case of i2c remove register access was done without any
>  get_sync fix the same.
> - Folds a patch from Tasslehoff to prevent any merge conflicts.
> - Prevents the XDUF flag to be set if the underflow condition is not met.
> - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
>  use the unique id instead as the section number in the recent errata
>  docs has changed.
>

Shubhrajyoti,

Can you add one more patch to this series.

The patch below from Neil Brown has been circulating for awhile, and
I've been using it locally for awhile now too.  It would help if it got
into this series and got some broader testing.

Thanks,

Kevin


>From 0c6effd8356e6273c294490a576551ef37ae6799 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Fri, 30 Dec 2011 12:40:30 +1100
Subject: [PATCH] OMAP/I2C - Fix timeout problem during suspend.

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
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 801df60..e024c50 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1092,7 +1092,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	isr = (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
 								   omap_i2c_isr;
-	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
+	r = request_irq(dev->irq, isr, IRQF_NO_SUSPEND, pdev->name, dev);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
-- 
1.7.9.2

