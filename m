From: Tony Lindgren <tony@atomide.com>
Subject: Re: Infinite looping in omap2430.c USB driver
Date: Mon, 9 Jul 2012 01:32:33 -0700
Message-ID: <20120709083233.GY1122@atomide.com>
References: <20120707083949.2cf91eeb@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120707083949.2cf91eeb@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* NeilBrown <neilb@suse.de> [120706 15:44]:
> 
> Hello `./scripts/get_maintainer.pl -f drivers/usb/musb/omap2430.c`
> 
> omap2430_musb_set_vbus in omap2430.c contains:
> 
> 			while (musb_readb(musb->mregs, MUSB_DEVCTL) & 0x80) {
> 
> 				cpu_relax();
> 
> 				if (time_after(jiffies, timeout)) {
> 					dev_err(musb->controller,
> 					"configured as A device timeout");
> 					ret = -EINVAL;
> 					break;
> 				}
> 			}
> 
> having set
> 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> 
> so it can busy-loop for up to 1 second.  Probably not ideal, but if it works
> I wouldn't complain.
> 
> The
> 	if (int_usb & MUSB_INTR_SESSREQ) {
> branch of musb_stage0_irq() called from musb_interrupt (from
> generic_interrupt) calls this:
> 
> 	if (musb->int_usb)
> 		retval |= musb_stage0_irq(musb, musb->int_usb,
> 				devctl, power);
> 
> so the busy loop can happen in an interrupt handler (not a threaded interrupt
> handler), which is probably less ideal.
> 
> However this can be called with interrupt disabled, as happens at least
> during resume when resume_irqs() calls:
> 
> 		raw_spin_lock_irqsave(&desc->lock, flags);
> 		__enable_irq(desc, irq, true);
> 		raw_spin_unlock_irqrestore(&desc->lock, flags);
> 
> and an interrupt is found to be IRQS_PENDING.
> 
> In this case interrupts are disabled so 'jiffies' never changes so this loop
> can continue forever.
> 
> This happens on my (GTA04) phone fairly regularly - between 1 in 10 and 1 in
> 30 resumes. The musb-hdrc interrupt is pending and reports
> 
> [ 4957.624176] musb-hdrc musb-hdrc: ** IRQ peripheral usb0040 tx0000 rx0000
> 
> 'usb0040' is MUSB_INTR_SESSREQ.  I think this is triggered by detecting a
> voltage change on the USB ID pin - is that right?  A short-to-earth would be
> a request to switch to host mode, which is why it tries to enable VBUS.
> Maybe there is some electrical noise which is being picked up?

I guess that could happen if the transceiver pins are floating during suspend?
 
> In any case I get the interrupt despite nothing being plugged in, and the 0x80
> bit of MUSB_DEVCTL never gets cleared.

As far as I remember, musb tries to be smart about changing to host mode,
and tries to do the session and vbus detection on it's own.. AFAIK, there's
nothing you can do until musb is done and detects the VBUS is not rising and
gives up. There are all kind of interrupt flag combinations trying to deal
with that mess, maybe you need to add yet another one?
 
> I've added a simple loop counter which aborts the loop after 1000 loops -
> this takes about 5 seconds, but includes some printks which probably slow it
> down.
> 
> In 2 out of 2 cases, subsequent messages show that the hsmmc driver for the
> uSD card that holds my root filesystem is messed up.  It seems to be waiting
> for a request that is never going to complete.
> So maybe the hsmmc is causing the noise that triggers the musb issue.
> 
> I can send a patch which add a loop count if you like, but I suspect you can
> come up with a much better approach.

Sounds like that loop should be fixed.

Regards,

Tony
