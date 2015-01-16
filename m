From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Fri, 16 Jan 2015 14:52:44 -0800
Message-ID: <20150116225243.GN18552@atomide.com>
References: <20150114221407.GS2419@atomide.com>
 <20150115105035.GU11502@n2100.arm.linux.org.uk>
 <20150115152838.GB18552@atomide.com>
 <20150115171924.GV11502@n2100.arm.linux.org.uk>
 <20150116162119.GK18552@atomide.com>
 <20150116163019.GW11502@n2100.arm.linux.org.uk>
 <20150116164105.GL18552@atomide.com>
 <20150116172223.GX11502@n2100.arm.linux.org.uk>
 <20150116172905.GM18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33456 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbbAPW4Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 17:56:24 -0500
Content-Disposition: inline
In-Reply-To: <20150116172905.GM18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>

* Tony Lindgren <tony@atomide.com> [150116 09:36]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150116 09:25]:
> > On Fri, Jan 16, 2015 at 08:41:06AM -0800, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150116 08:33]:
> > > > I would still like to understand /why/ enabling preempt causes the error.
> > > > Changing the preempt configuration really should not change what happens
> > > > on the bus.  (Think about it.)  It's an indication that there is some
> > > > other error present.
> > > 
> > > We have a wrong irq number caused by $subject. And the wrong irq
> > > gets triggered before the dma hardware is configured during dma
> > > init. And then we get the invalid access error from omap_l3_noc.
> > 
> > ... which should happen whether or not preempt is enabled, which is
> > really my point.
> > 
> > We know tha the wrong IRQ gets requested by the driver - and that wrong
> > IRQ is requested whether or not we have preempt enabled.  Yet we get
> > the warning whether or not preempt is enabled.
> > 
> > The DMA handler is not registered as a threaded handler, so it's not
> > depending on a context switch to execute omap2_dma_irq_handler().
> > 
> > Another reason why I don't agree with your explanation is that by the
> > time setup_irq() is called, we have already poked at the DMA hardware
> > several times - omap_clear_dma() and omap2_disable_irq_lch() will have
> > been called for each DMA channel - and both will write to the hardware.
> > 
> > What's more is that the only things left after setup_irq() has been
> > called is to possibly reserve the first two DMA channels and print
> > the DMA message (via show_dma_caps).  So I see nothing after setup_irq()
> > which would "finish" any unfinished hardware initialisation.
> > 
> > The final reason I don't agree is that I've put a printk() in
> > omap2_dma_irq_handler(), and this does not trigger.
> 
> Oh, yes that blows my theory completely then.
>  
> > So, I think this has nothing to do with the DMA hardware /at all/,
> > but more to do with the GPIO code, and it suggests that the GPIO code
> > publishes IRQs before it is safe for those IRQs to be used.
> > 
> > Maybe it has to do with omap_gpio_irq_handler() being called... added
> > printk(), nope, that's not called either.  So it's not an IRQ which
> > gets triggered at all.
> > 
> > What is called are (in order):
> > 
> > omap_gpio_unmask_irq()
> > omap_set_gpio_irqenable()
> > omap_enable_gpio_irqbank()
> > 
> > and this reveals where the problem is, especially when you then add
> > instrumentation into the runtime PM functions - and this reveals that
> > when a GPIO IRQ is requested, these functions are called while the
> > GPIO is runtime suspended.
> > 
> > _That_ is where the *real* problem lies - requesting a GPIO interrupt
> > results in the kernel touching possibly runtime-suspended hardware.
> > 
> > The reason it happens with preempt is that preempt introduces scheduling
> > points during the kernel boot which would not otherwise be there (with
> > preempt disabled, you have to hit an explicit context switch due to
> > contention on some lock or a wait in order for some other thread to run.)
> 
> OK makes sense.
>  
> > So, the GPIO driver really needs fixing - and I'd suggest fixing it
> > first, before fixing the DMA problem, because the DMA problem allows
> > us to see the GPIO problem.
> 
> Yes we need to fix that.

Posted a minimal fix for that one as a separate thread:

[PATCH 1/1] gpio: omap: Fix bad device access with setup_irq()

Regards,

Tony
