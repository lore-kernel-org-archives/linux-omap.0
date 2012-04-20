From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/19] ARM: OMAP4 device off support
Date: Fri, 20 Apr 2012 17:43:22 +0300
Message-ID: <1334933002.2149.44.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	 <CANrkHUa5q10FFxsZfgtMqKbzKKFHCcf3yYsaOK+hG8CJiME2TA@mail.gmail.com>
	 <1334926721.2149.40.camel@sokoban>  <87vckupkxj.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37979 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756805Ab2DTOn2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 10:43:28 -0400
In-Reply-To: <87vckupkxj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Fri, 2012-04-20 at 06:55 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> [...]
> 
> >> I tried your branch on gp/emu devices but could not reproduce this issue.
> >> My observation is that while resuming, omap_hsmmc.1 eMMC is
> >> trying to turn on phoenix vaux1 regulator via i2c which fails due
> >> to controller timeout.
> >> Note: eMMC is present only on sdp/blaze
> >
> > Did you try this with off-mode enabled and did you check the device
> > actually goes to off? (see pm_debug/count and verify core off count is
> > increasing.) And as said, I was only able to see this problem on a blaze
> > device, panda works fine. But yes, you are probably right and it is not
> > an MMC driver issue but I2C.
> 
> Can you try the patch below?  It sounds like the same problem.

Doesn't help with this one. I guess I2C loses context during device off
and it is not restored properly.

-Tero

> 
> Kevin
> 
> 
> From 999f34629140f436099050eb7aac514bfd2a2235 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Fri, 30 Dec 2011 12:40:30 +1100
> Subject: [PATCH] OMAP/I2C - Fix timeout problem during suspend.
> 
> On a board with OMAP3 processor and TWL4030 Power management,
> we need to talk to the TWL4030 during late suspend but cannot
> because the I2C interrupt is disabled (as late suspend disables
> interrupt).
> 
> e.g. I get messages like:
> 
> [   62.161102] musb-omap2430 musb-omap2430: LATE power domain suspend
> [   63.167205] omap_i2c omap_i2c.1: controller timed out
> [   63.183044] twl: i2c_read failed to transfer all messages
> [   64.182861] omap_i2c omap_i2c.1: controller timed out
> [   64.198455] twl: i2c_write failed to transfer all messages
> [   65.198455] omap_i2c omap_i2c.1: controller timed out
> [   65.203765] twl: i2c_write failed to transfer all messages
> 
> The stack shows omap2430_runtime_suspend calling twl4030_set_suspend
> which tries to power-down the USB PHY (twl4030_phy_suspend ->
> twl4030_phy_power -> __twl4030_phy_power which as a nice WARN_ON
> that helps).
> 
> Then we get the same in resume:
> 
> [   69.603912] musb-omap2430 musb-omap2430: EARLY power domain resume
> [   70.610473] omap_i2c omap_i2c.1: controller timed out
> [   70.626129] twl: i2c_write failed to transfer all messages
> etc.
> 
> So don't disable interrupts for I2C.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 801df60..e024c50 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1092,7 +1092,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  	isr = (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
>  								   omap_i2c_isr;
> -	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
> +	r = request_irq(dev->irq, isr, IRQF_NO_SUSPEND, pdev->name, dev);
>  
>  	if (r) {
>  		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);


