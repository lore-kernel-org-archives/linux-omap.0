From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/19] ARM: OMAP4 device off support
Date: Fri, 20 Apr 2012 06:55:20 -0700
Message-ID: <87vckupkxj.fsf@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	<CANrkHUa5q10FFxsZfgtMqKbzKKFHCcf3yYsaOK+hG8CJiME2TA@mail.gmail.com>
	<1334926721.2149.40.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:49272 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752108Ab2DTNzX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 09:55:23 -0400
Received: by dajr28 with SMTP id r28so14686967daj.26
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 06:55:20 -0700 (PDT)
In-Reply-To: <1334926721.2149.40.camel@sokoban> (Tero Kristo's message of
	"Fri, 20 Apr 2012 15:58:40 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

[...]

>> I tried your branch on gp/emu devices but could not reproduce this issue.
>> My observation is that while resuming, omap_hsmmc.1 eMMC is
>> trying to turn on phoenix vaux1 regulator via i2c which fails due
>> to controller timeout.
>> Note: eMMC is present only on sdp/blaze
>
> Did you try this with off-mode enabled and did you check the device
> actually goes to off? (see pm_debug/count and verify core off count is
> increasing.) And as said, I was only able to see this problem on a blaze
> device, panda works fine. But yes, you are probably right and it is not
> an MMC driver issue but I2C.

Can you try the patch below?  It sounds like the same problem.

Kevin


>From 999f34629140f436099050eb7aac514bfd2a2235 Mon Sep 17 00:00:00 2001
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

