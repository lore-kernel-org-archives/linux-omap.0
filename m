From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq and _od_resume_noirq
Date: Thu, 18 Oct 2012 11:42:33 -0700
Message-ID: <87vce77hba.fsf@deeprootsystems.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
	<1350488043-5053-2-git-send-email-balbi@ti.com>
	<871ugvivso.fsf@deeprootsystems.com>
	<20121018165525.GA6385@arwen.pp.htv.fi>
	<87ipa7d6cy.fsf@deeprootsystems.com>
	<20121018175027.GA7917@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62318 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2JRSmS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 14:42:18 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so8608515pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 11:42:18 -0700 (PDT)
In-Reply-To: <20121018175027.GA7917@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Thu, 18 Oct 2012 20:50:27 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Thu, Oct 18, 2012 at 10:42:37AM -0700, Kevin Hilman wrote:
>> Felipe Balbi <balbi@ti.com> writes:
>> 
>> > Hi,
>> >
>> > On Thu, Oct 18, 2012 at 09:34:15AM -0700, Kevin Hilman wrote:
>> >> Felipe Balbi <balbi@ti.com> writes:
>> >> 
>> >> > current implementation doesn't take care about
>> >> > drivers which don't provide *_noirq methods 
>> >> 
>> >> The generic ops handle this.  See below.
>> >> 
>> >> > and we could fall into a situation where we would suspend/resume
>> >> > devices even though they haven't asked for it.
>> >> 
>> >> The following explanation doesn't explain this, so I dont' follow
>> >> the "even though they haven't asked for it" part.
>> >> 
>> >> > One such case happened with the I2C driver which
>> >> > was getting suspended during suspend_noirq() just
>> >> > to be resume right after by any other device doing
>> >> > an I2C transfer on its suspend method.
>> >> 
>> >> In order to be I2C to be runtime resumed after its noirq method has been
>> >> called, that means the other device is doing an I2C xfer in its noirq
>> >> method.  That is a bug.
>> >> 
>> >> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> >> > ---
>> >> >  arch/arm/plat-omap/omap_device.c | 8 ++++++++
>> >> >  1 file changed, 8 insertions(+)
>> >> >
>> >> > diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>> >> > index 7a7d1f2..935f416 100644
>> >> > --- a/arch/arm/plat-omap/omap_device.c
>> >> > +++ b/arch/arm/plat-omap/omap_device.c
>> >> > @@ -804,8 +804,12 @@ static int _od_suspend_noirq(struct device *dev)
>> >> >  {
>> >> >  	struct platform_device *pdev = to_platform_device(dev);
>> >> >  	struct omap_device *od = to_omap_device(pdev);
>> >> > +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> >> >  	int ret;
>> >> >  
>> >> > +	if (!pm || !pm->suspend_noirq)
>> >> > +		return 0;
>> >> > +
>> >> 
>> >> you just re implemented pm_generic_suspend_noirq() (c.f. drivers/base/power/generic_ops.c)
>> >> 
>> >> >  	/* Don't attempt late suspend on a driver that is not bound */
>> >> >  	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
>> >> >  		return 0;
>> >> > @@ -827,6 +831,10 @@ static int _od_resume_noirq(struct device *dev)
>> >> >  {
>> >> >  	struct platform_device *pdev = to_platform_device(dev);
>> >> >  	struct omap_device *od = to_omap_device(pdev);
>> >> > +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> >> > +
>> >> > +	if (!pm || !pm->resume_noirq)
>> >> > +		return 0;
>> >> 
>> >> and this is basically pm_generic_resume_noirq()
>> >
>> > not true, there is a slight different. Note that you only call
>> > pm_generic_resume_noirq() after calling pm_runtime_resume()ing the
>> > device:
>> 
>> >> static int _od_resume_noirq(struct device *dev)
>> >> {
>> >> 	struct platform_device *pdev = to_platform_device(dev);
>> >> 	struct omap_device *od = to_omap_device(pdev);
>> >> 
>> >> 	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
>> >> 	    !pm_runtime_status_suspended(dev)) {
>> >> 		od->flags &= ~OMAP_DEVICE_SUSPENDED;
>> >> 		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
>> >> 			omap_device_enable(pdev);
>> >> 		pm_generic_runtime_resume(dev);
>> >
>> > right here. IMHO this is a bug, if the define doesn't implement
>> > resume_noirq, it's telling you that it has nothing to do at that time,
>> 
>> This is where the misunderstanding is.  I suggest you have a look
>> at commit c03f007a8bf0e092caeb6856a5c8a850df10b974 where this feature
>> was added, but I'll try to summarize:
>> 
>> The goal is simply this:
>> 
>> If, by the time .suspend_noirq has run, the driver is not already
>> runtime suspended, then forcefully runtime suspend it.
>> 
>> That's it.
>
> Yes, I got the intention, but to me it looks wrong.
>
>> Again, this is required because system suspend disables runtime PM
>> transitions at a certain point, if the device is used after that point,
>> there is *no other way* for the driver to properly manage the idle
>> transition (or, if there is, please explain it to me.)
>
> Can you please let me know of any situation where e.g. I2C/SPI would be
> needed after all its children are suspended ?

There lots of I2C users who are not children of the I2C bus device.  Any
users of regulators on the I2C-connected PMIC for example (MMC comes to
mind, and is not a child of the I2C bus.).  Also, enable/disable of GPIO
IRQ lines on I2C GPIO expanders.  The devices using those GPIO IRQs are
not children of the I2C bus. 

Stated differently, I2C devices themselves (PMIC, GPIO expanders, etc.)
are children of the I2C bus device.  But *users* of those devices will
be other drivers who have no parent/child relationship with the I2C bus
device in the driver model.

>> > so you shouldn't forcefully resume the device.
>> 
>> Note it's only forcefully resumed *if* it was forcefully suspended by
>> suspend_noirq.
>
> likewise, you shouldn't forcefully runtime suspend a device. The device
> driver needs to be required to provide suspend/resume functions if it
> cares.

I don't think you've fully understood the problem being solved here.

This is for devices who designed for use throughout the suspend process
(IOW, *after* their suspend callbacks have been called.)

>> > If the device dies, then it means that it needs to implement
>> > resume_noirq. What you have here, is a "workaround" for badly written
>> > device drivers IMHO. 
>> 
>> That's one way of looking at it.  The other way of looking at it is that
>> by handling this at the PM domain level, the drivers can be much simpler,
>> and thus less likely to get wrong.
>
> You're still bypassing what the PM framework wants us to do, no ? What
> if Rafael decides to drastically change the way system and runtime PM is
> done and it ends up breaking what we have on OMAP ? If we stick to the
> standard, the it's less likely to brea.

What I have done on OMAP was done in direct collaboration with the PM
core mantainers, and designed specifically for limitations in the PM
core.  If those assumptions change, I will have to change.  I have no
problems dealing with that if/when the time comes.

>> But even then, with your proposed changes, I don't think the device will
>> be properly idled (including the omap_device_idle) in these important cases:
>> 
>> 1) I2C is used by some other device *after* its ->suspend method has
>>    been called.
>
> how can that happen ? I2C's ->suspend method will only be called after
> all its children are suspended.

Unfortunately, drivers which use I2C are not all children of the I2C bus
device in the driver model (see above.)

This gets to a much bigger problem with the linux driver model today.
There are *many* power relationships/dependencies between devices that 
are not modeled by driver model device hierarchy.

>> 2) I2C runtime PM is disabled from userspace
>>    (echo off > /sys/devices/.../power/control)
>
> that should not make a difference if you omap_device_idle() is written
> as it should. Maybe what you need is a refactor to provide
> omap_device_idle() and omap_device_runtime_idle(), the latter taking
> care of the case where runtime pm can be disabled from userspace while
> the former idling whenever it's called.

No thanks.

>> but I'll take this up in the I2C driver patch itself.
>
> sure :-)
>
>> > Note also, that you could runtime resume devices which don't implement
>> > resume_noirq().
>> 
>> Again, this is by design.
>
> a very weird design IMHO. Either that or I'm really missing something
> here.

I agree it's wierd.  Unfortunately, it's necessary.

>> It doesn't matter if the driver has noirq methods.  If it is not yet
>> runtime suspended, it is forceably runtime suspended.   The generic
>
> if it's not yet runtime suspended, you need to call the driver's
> ->suspend_* method (depending on the suspend phase you are right now),

You're confusing system suspend and runtime suspend, and forgetting that
we might want to use runtime PM *during* system suspend/resume.

Again, the reason a device may not yet runtime suspended is because it
was in use during suspend, and runtime PM has been disabled by the PM
core during system PM.  If the PM core did not disable runtime PM, the
drivers runtime PM methods would be called, and we would not need to
implement this in the PM domain layer.

> but "reusing" the runtime_suspend method sounds to me like another
> "special OMAP requirement".

There's nothing special about OMAP here.  Any devices that want to use
runtime PM *throughout* the suspend path has this requirment, and the
implementation used in our PM domain layer was implemented based on the
recommendation of Rafael.

>> noirq calls are just there in case the driver has noirq callbacks.
>
> I get that, but why would you suspend a device which doesn't want to be
> suspended in suspend_noirq(), but using its runtime_suspend method ?

What do you mean "doesn't want to be suspended"?  If a device doesn't
want to be suspended, it needs to return an error from one of its
suspend methods.   Barring that, the system *will* suspend, and in order
to hit low power states, we have to properly idle each device.

The underlying assumption is that by the time the noirq phase runs, the
device should already be runtime suspended.  If it is not, then one of
the following ha happened:

- device was used during suspend, but after runtime PM was disabled by
  the PM core (during system suspend)

- runtime PM disabled from userspace

In both cases, *somebody* has to properly idle the device and "finish"
the runtime suspend late in the suspend phase.  As recommended by
Rafael, we handle this at the PM domain level.

> If I2C dies on a suspend/resume transition, it's a bug in the I2C
> driver, no ?

Sure, but this has nothing to do with I2C dying.

Kevin

