From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v4 REPOST 18/20] gpio/omap: use pm-runtime framework
Date: Fri, 29 Jul 2011 16:15:23 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037C374A36@dbde02.ent.ti.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
 <1310804152-9243-19-git-send-email-tarun.kanti@ti.com>
 <20110716190734.GB990@google.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037C202D59@dbde02.ent.ti.com>
 <20110728074327.GA12916@google.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037C2030F7@dbde02.ent.ti.com>
 <20110728170029.GA9819@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34560 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755946Ab1G2Kpd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 06:45:33 -0400
In-Reply-To: <20110728170029.GA9819@google.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

[...]
> > > Looking at omap_gpio_mod_init() it seems like much of its processing
> > > could probably be done once at probe time (or at pm_runtime_get_sync
> > > time) as well, namely setting the IRQ enable masks.
> > This must be called at the beginning of bank access to get reset state.
> > Otherwise, it would contain settings related to previous bank access.
> 
> What state may have changed between the last time a pin was released
> from the bank and the next time a pin is requested in the bank?  Prior
> to this patch, omap_gpio_mod_init() is called once at probe time, and
> initializing irqenable masks etc. isn't reset at the beginning of bank
> access, if I understand correctly.
Call to *_gpio_mod_init() is overhead if a client driver request/release
same pin(s) and no other pins in the same bank are used by others.
This is just a special case. We normally expect multiple multiple clients
Access pins within the bank. Here *_mod_init() would be called just once.
If a bank was used temporarily just during boot it is fair to reset it
Using *_mod_init() by new client driver.

> 
> If it's not actually necessary to do this on each first request to the
> bank then it's not a large overhead or anything, but want to make sure
> the PM operations being performed are correct.  This patch is
> basically to runtime PM enable the GPIO bank when a pin is requested,
> and disable when no pin is requested.  If other actions beyond the
> runtime PM enable are needed, now that a runtime PM disable is added,
> then it calls into question whether the enable method is missing
> something.  More troubling are the PM actions performed in addition to
> pm_runtime_get_sync...
Your concern is valid.
But overhead is not likely from *_gpio_request/free() for reason explained.
We have inherent overhead in runtime callbacks. But as I said, we can avoid
Many of the operations when bank is accessed the first time.

> 
> > > Ungating the interface clock, enabling wakeup, setting smart idle for
> > > the module, and enabling the (old-style) system clock seem like either
> > > one-time actions at probe, or a part of the pm_runtime_get_sync
> > > callback.
> > Yes... sysconfig related settings are done by hwmod framework.
> > Debounce clocks are enabled in callback.
> >
> > >
> > > Or is there some other reason these power management actions should be
> > > taken each time a GPIO is requested in the block (when none were
> > > previously requested), after the runtime PM get_sync callback, but
> > > not as part of the get_sync callback?  If so, what caused
> > > the smart idle setting to be lost, or the interface clock gated, if
> > > not the pm_runtime_put_sync?
> > I am not sure which smart idle setting you are referring to.
> 
> That's part of what the magic constant in this statement is doing:
> 
>          __raw_writew(0x0014, bank->base
>                                  + OMAP1610_GPIO_SYSCONFIG);
Ok, now this is moved to init and is called only once.

> 
> > Most stuffs done in *_get_sync() callback can skip first time.
> > Omap_gpio_mod_init() does resetting irqenable settings to reset value.
> > This should not be part of callback.
> 
> To be clear, it seems like resetting irqenable settings should be a
> one-time action at probe time. The power management actions such as
> enabling debounce clocks, setting module PRCM idle protocol behavior,
> and ungating interface clocks seem like they should either be one-time
> probe actions, or a part of the runtime PM callbacks, or balanced with
> corresponding actions when the last pin in the bank is released.
> Else what caused the interface clock to gate, or the slave idle
> control to change, or the debounce clock to be cut?  The only thing
> added here that would do that is the pm_runtime_put_sync.  If it can
> cause those actions then do other calls to pm_runtime_get_sync need to
> fix these up?
Debounce clk enable/disable has to be associated with *_get/put_sync().
Idle mode setting and interface clock gating is a one time operation.
This is done during init. We can however look at optimization of the
Callbacks.

> 
> Anyhow, mainly wanted to point that out as a possible optimization.
> It's pretty unlikely there's an actual problem here.
Ok, thanks.
--
Tarun

> 
> 
> Todd
