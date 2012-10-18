From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq and _od_resume_noirq
Date: Thu, 18 Oct 2012 10:42:37 -0700
Message-ID: <87ipa7d6cy.fsf@deeprootsystems.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
	<1350488043-5053-2-git-send-email-balbi@ti.com>
	<871ugvivso.fsf@deeprootsystems.com>
	<20121018165525.GA6385@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43606 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437Ab2JRRmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 13:42:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so8565149pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 10:42:22 -0700 (PDT)
In-Reply-To: <20121018165525.GA6385@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Thu, 18 Oct 2012 19:55:25 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Thu, Oct 18, 2012 at 09:34:15AM -0700, Kevin Hilman wrote:
>> Felipe Balbi <balbi@ti.com> writes:
>> 
>> > current implementation doesn't take care about
>> > drivers which don't provide *_noirq methods 
>> 
>> The generic ops handle this.  See below.
>> 
>> > and we could fall into a situation where we would suspend/resume
>> > devices even though they haven't asked for it.
>> 
>> The following explanation doesn't explain this, so I dont' follow
>> the "even though they haven't asked for it" part.
>> 
>> > One such case happened with the I2C driver which
>> > was getting suspended during suspend_noirq() just
>> > to be resume right after by any other device doing
>> > an I2C transfer on its suspend method.
>> 
>> In order to be I2C to be runtime resumed after its noirq method has been
>> called, that means the other device is doing an I2C xfer in its noirq
>> method.  That is a bug.
>> 
>> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > ---
>> >  arch/arm/plat-omap/omap_device.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>> > index 7a7d1f2..935f416 100644
>> > --- a/arch/arm/plat-omap/omap_device.c
>> > +++ b/arch/arm/plat-omap/omap_device.c
>> > @@ -804,8 +804,12 @@ static int _od_suspend_noirq(struct device *dev)
>> >  {
>> >  	struct platform_device *pdev = to_platform_device(dev);
>> >  	struct omap_device *od = to_omap_device(pdev);
>> > +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> >  	int ret;
>> >  
>> > +	if (!pm || !pm->suspend_noirq)
>> > +		return 0;
>> > +
>> 
>> you just re implemented pm_generic_suspend_noirq() (c.f. drivers/base/power/generic_ops.c)
>> 
>> >  	/* Don't attempt late suspend on a driver that is not bound */
>> >  	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
>> >  		return 0;
>> > @@ -827,6 +831,10 @@ static int _od_resume_noirq(struct device *dev)
>> >  {
>> >  	struct platform_device *pdev = to_platform_device(dev);
>> >  	struct omap_device *od = to_omap_device(pdev);
>> > +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> > +
>> > +	if (!pm || !pm->resume_noirq)
>> > +		return 0;
>> 
>> and this is basically pm_generic_resume_noirq()
>
> not true, there is a slight different. Note that you only call
> pm_generic_resume_noirq() after calling pm_runtime_resume()ing the
> device:

>> static int _od_resume_noirq(struct device *dev)
>> {
>> 	struct platform_device *pdev = to_platform_device(dev);
>> 	struct omap_device *od = to_omap_device(pdev);
>> 
>> 	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
>> 	    !pm_runtime_status_suspended(dev)) {
>> 		od->flags &= ~OMAP_DEVICE_SUSPENDED;
>> 		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
>> 			omap_device_enable(pdev);
>> 		pm_generic_runtime_resume(dev);
>
> right here. IMHO this is a bug, if the define doesn't implement
> resume_noirq, it's telling you that it has nothing to do at that time,

This is where the misunderstanding is.  I suggest you have a look
at commit c03f007a8bf0e092caeb6856a5c8a850df10b974 where this feature
was added, but I'll try to summarize:

The goal is simply this:

If, by the time .suspend_noirq has run, the driver is not already
runtime suspended, then forcefully runtime suspend it.

That's it.

Again, this is required because system suspend disables runtime PM
transitions at a certain point, if the device is used after that point,
there is *no other way* for the driver to properly manage the idle
transition (or, if there is, please explain it to me.)

> so you shouldn't forcefully resume the device.

Note it's only forcefully resumed *if* it was forcefully suspended by
suspend_noirq.

> If the device dies, then it means that it needs to implement
> resume_noirq. What you have here, is a "workaround" for badly written
> device drivers IMHO. 

That's one way of looking at it.  The other way of looking at it is that
by handling this at the PM domain level, the drivers can be much simpler,
and thus less likely to get wrong.

But even then, with your proposed changes, I don't think the device will
be properly idled (including the omap_device_idle) in these important cases:

1) I2C is used by some other device *after* its ->suspend method has
   been called.
2) I2C runtime PM is disabled from userspace
   (echo off > /sys/devices/.../power/control)

but I'll take this up in the I2C driver patch itself.

> Note also, that you could runtime resume devices which don't implement
> resume_noirq().

Again, this is by design.  

It doesn't matter if the driver has noirq methods.  If it is not yet
runtime suspended, it is forceably runtime suspended.   The generic
noirq calls are just there in case the driver has noirq callbacks.

Kevin

> the same is valid for suspend_noirq.
>
>> 	}
>> 
>> 	return pm_generic_resume_noirq(dev);
>> }
