From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper
 functions
Date: Fri, 6 Mar 2015 08:19:20 -0800
Message-ID: <20150306161920.GM13520@atomide.com>
References: <1425602049-2674-1-git-send-email-tony@atomide.com>
 <1425602049-2674-2-git-send-email-tony@atomide.com>
 <1805134.DQxHJSAxE3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery5.ore.mailhop.org ([54.148.219.64]:39366 "EHLO
	pmta1.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751616AbbCFQYq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 11:24:46 -0500
Content-Disposition: inline
In-Reply-To: <1805134.DQxHJSAxE3@vostro.rjw.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

Hi,

* Rafael J. Wysocki <rjw@rjwysocki.net> [150305 17:38]:
> Please always CC linux-pm on CC patches.

Sure will do for the next rev, sorry forgot to add that.
 
> On Thursday, March 05, 2015 04:34:06 PM Tony Lindgren wrote:
> > +/**
> > + * handle_dedicated_wakeirq - Handler for device wake-up interrupts
> > + * @wakeirq: Separate wake-up interrupt for a device different
> > + * @_wirq: Wake-up interrupt data
> > + *
> > + * Some devices have a separate wake-up interrupt in addition to the
> > + * regular device interrupt. The wake-up interrupts signal that the
> > + * device should be woken up from a deeper idle state. This handler
> > + * uses device specific pm_runtime functions to wake-up the device
> > + * and then it's up to the device to do whatever it needs to. Note
> > + * as the device may need to restore context and start up regulators,
> > + * this is not a fast path.
> > + *
> > + * Note that we are not resending the lost device interrupts. We assume
> > + * that the wake-up interrupt just needs to wake-up the device, and
> > + * the device pm_runtime_resume() can deal with the situation.
> > + */
> > +static irqreturn_t handle_dedicated_wakeirq(int wakeirq, void *_wirq)
> > +{
> > +	struct wakeirq_source *wirq = _wirq;
> > +	irqreturn_t ret = IRQ_NONE;
> > +
> > +	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
> > +	if (pm_runtime_suspended(wirq->dev)) {
> 
> What if the device is resumed on a different CPU right here?

Good point, sounds like we need to do this in some pm_runtime
function directly for the locking.
 
> > +		pm_runtime_mark_last_busy(wirq->dev);
> > +		pm_runtime_resume(wirq->dev);
> 
> Calling this with disabled interrupts is a bad idea in general.
> Is the device guaranteed to have power.irq_safe set?

Well right now it's using threaded irq, and I'd like to get rid of
the pm_runtime calls in the regular driver interrupts completely.
We need to ensure the device runtime_resume is completed before
returning IRQ_HANDLED here.
 
> I guess what you want to call here is pm_request_resume() and
> I wouldn't say that calling pm_runtime_mark_last_busy() on a
> suspended device was valid.

I'll verify again, but I believe the issue was that without doing
mark_last_busy here the device falls back asleep right away.
That probably should be fixed in pm_runtime in general if that's
the case.

Considering the above, should we add a new function something like
pm_resume_complete() that does not need irq_safe set but does
not return until the device has completed resume?

I think that would be pretty much probably just pm_request_resume
+ pm_runtime_barrier.

> > +/**
> > + * dev_pm_wakeirq_arm_for_suspend - Configure device wake-up
> > + * @wirq: Device wake-up interrupt
> > + *
> > + * Called from the bus code or the device driver for
> > + * device suspend(). Just sets up the wake-up event
> > + * conditionally based on the device_may_wake(). The
> > + * rest is handled automatically by the generic suspend()
> > + * code and runtime_suspend().
> > + */
> > +void dev_pm_wakeirq_arm_for_suspend(struct wakeirq_source *wirq)
> > +{
> > +	if (is_invalid_wakeirq(wirq))
> > +		return;
> > +
> > +	irq_set_irq_wake(wirq->wakeirq,
> > +			 device_may_wakeup(wirq->dev));
> 
> You want to do
> 
> 	if (device_may_wakeup(wirq->dev))
> 		enable_irq_wake(wirq->wakeirq);
> 
> here or strange things may happen if two devices share a wakeup IRQ.

OK sure.
 
> Also instead of doing it this way, I'd prefer to hook system wakeup
> interrupts into the wakeup source objects pointed to by the power.wakeup
> fields in struct device.
> 
> Then we could just walk the list of wakeup sources and do enable_irq_wake()
> automatically for the wakeup interrupts hooked up to them at the
> suspend_device_irqs() time without the need to do anything from drivers
> at suspend time.

OK that's a good idea. Then we can drop dev_pm_wakeirq_arm_for_suspend()
and make that part automatic.

Then for runtime_pm, we could make the toggling of the wakeirq handling
automatic too. Or do you see a problem with that?

> > +struct wakeirq_source {
> > +	struct device *dev;
> > +	int wakeirq;
> > +	bool initialized;
> > +	bool enabled;
> > +	irq_handler_t handler;
> > +	void *data;
> > +};
> 
> Well, so now we have struct wakeup_source already and here we get struct wakeirq_source
> and they mean different things ...

Well I was trying to keep it out of the way for most drivers not needing
to use wakeirqs. I'll take a look at making it a pointer in the struct
wakeup_source.

Regards,

Tony
