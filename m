From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] gpio: omap: Fix bad device access with setup_irq()
Date: Fri, 16 Jan 2015 17:00:03 -0800
Message-ID: <20150117010003.GP18552@atomide.com>
References: <1421448650-15904-1-git-send-email-tony@atomide.com>
 <54B9AA9D.7080300@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15215 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752466AbbAQBDm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 20:03:42 -0500
Content-Disposition: inline
In-Reply-To: <54B9AA9D.7080300@oracle.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>

* santosh shilimkar <santosh.shilimkar@oracle.com> [150116 16:23]:
> On 1/16/2015 2:50 PM, Tony Lindgren wrote:
> >Similar to omap_gpio_irq_type() let's make sure that the GPIO
> >is usable as an interrupt if the platform init code did not
> >call gpio_request(). Otherwise we can get invalid device access
> >after setup_irq():
> >
> I let Linus W comment on it but IIRC we chewed this issue last
> time and the conclusion was the gpio_request() must have to be called
> directly or indirectly in case of irq line.

This is a corner case where the error is triggered by a wrong,
non-GPIO IRQ so gpio_request() will never be called before setup_irq()
unlike for any legacy platform code.

The legacy and DT cases we're already handling in the gpio-omap.c
driver a while back with:

2f56e0a57ff1 ("gpio/omap: use gpiolib API to mark a GPIO used as an IRQ")
fac7fa162a19 ("gpio/omap: auto-setup a GPIO when used as an IRQ")
fa365e4d7290 ("gpio/omap: maintain GPIO and IRQ usage separately")

And most of that the bank specific hacks we can get rid of by making
the driver multple instances as that allows replacing BANK_USED
with just runtime PM.
 
> One old thread on possibly similar issue is here[1]
> 
> 
> >WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
> >44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Idle): Data Access in Supervisor mode during Functional access
> >...
> >[<c05f21e4>] (__irq_svc) from [<c05f1974>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> >[<c05f1974>] (_raw_spin_unlock_irqrestore) from [<c00914a8>] (__setup_irq+0x244/0x530)
> >[<c00914a8>] (__setup_irq) from [<c00917d4>] (setup_irq+0x40/0x8c)
> >[<c00917d4>] (setup_irq) from [<c0039c8c>] (omap_system_dma_probe+0x1d4/0x2b4)
> >[<c0039c8c>] (omap_system_dma_probe) from [<c03b2200>] (platform_drv_probe+0x44/0xa4)
> >...
> >
> >We can fix this the same way omap_gpio_irq_type() is handling it.
> >
> >Note that the long term solution is to change the gpio-omap driver
> >to handle the banks as separate driver instances. This will allow
> >us to rely on just runtime PM for tracking the bank specific state.
> >
> >Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >Cc: Felipe Balbi <balbi@ti.com>
> >Cc: Javier Martinez Canillas <javier@dowhile0.org>
> >Cc: Kevin Hilman <khilman@kernel.org>
> >Cc: Linus Walleij <linus.walleij@linaro.org>
> >Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> >Cc: Santosh Shilimkar <ssantosh@kernel.org>
> >Signed-off-by: Tony Lindgren <tony@atomide.com>
> >---
> >  drivers/gpio/gpio-omap.c | 39 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 33 insertions(+), 6 deletions(-)
> >
> Is it really OMAP specific issue ? On OMAP, clocks needs to enabled for
> GPIO's to work which is what the init is doing but I believe the same
> should apply to other GPIO controllers as well.

In the long run it should be handled by the generic GPIO code IMO.

I doubt that's doable for the -rc series though. Probably only a
few platforms have hit PM related issues like this. And actually
the omap specific hacks become really minimal if we make the driver
have a separate instance for each GPIO bank.

Regards,

Tony
 
> [1] https://lkml.org/lkml/2013/8/27/509
> 
