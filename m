From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper
 functions
Date: Fri, 6 Mar 2015 15:05:40 -0800
Message-ID: <20150306230539.GA2651@atomide.com>
References: <20150306161920.GM13520@atomide.com>
 <Pine.LNX.4.44L0.1503061358260.1407-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:35374 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbbCFXQ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 18:16:26 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1503061358260.1407-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

* Alan Stern <stern@rowland.harvard.edu> [150306 11:05]:
> On Fri, 6 Mar 2015, Tony Lindgren wrote:
> 
> > > > +	struct wakeirq_source *wirq = _wirq;
> > > > +	irqreturn_t ret = IRQ_NONE;
> > > > +
> > > > +	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
> > > > +	if (pm_runtime_suspended(wirq->dev)) {
> > > 
> > > What if the device is resumed on a different CPU right here?
> > 
> > Good point, sounds like we need to do this in some pm_runtime
> > function directly for the locking.
> >  
> > > > +		pm_runtime_mark_last_busy(wirq->dev);
> > > > +		pm_runtime_resume(wirq->dev);
> > > 
> > > Calling this with disabled interrupts is a bad idea in general.
> > > Is the device guaranteed to have power.irq_safe set?
> > 
> > Well right now it's using threaded irq, and I'd like to get rid of
> > the pm_runtime calls in the regular driver interrupts completely.
> > We need to ensure the device runtime_resume is completed before
> > returning IRQ_HANDLED here.
> 
> In general, runtime_resume methods are allowed to sleep.  They can't be
> used in an interrupt handler top half unless the driver has
> specifically promised they are IRQ-safe.  That's what Rafael was
> getting at.

Yes I understand, otherwise things certainly would not work :)

> Of course, if this routine is a threaded-irq bottom half then there's 
> no problem.

Right this is threaded-irq bottom half because the devices may
need to restore state and start regulators.
 
> > > I guess what you want to call here is pm_request_resume() and
> > > I wouldn't say that calling pm_runtime_mark_last_busy() on a
> > > suspended device was valid.
> > 
> > I'll verify again, but I believe the issue was that without doing
> > mark_last_busy here the device falls back asleep right away.
> > That probably should be fixed in pm_runtime in general if that's
> > the case.
> 
> It's up to the subsystem to handle this.  For example, the USB 
> subsystem's runtime-resume routine calls pm_runtime_mark_last_busy.

Hmm.. OK thanks this probably explains why pm_request_resume() did
not work.

For omaps, I could call this from the interconnect related code,
but then how dow we deal with the subsystems that don't call it?

> > Considering the above, should we add a new function something like
> > pm_resume_complete() that does not need irq_safe set but does
> > not return until the device has completed resume?
> 
> That doesn't make sense.  You're asking for a routine that is allowed
> to sleep but can safely be called in interrupt context.

Oh it naturally would not work in irq context, it's for the bottom
half again. But I'll take a look if we can just call
pm_request_resume() and disable_irq() on the wakeirq in without
waiting for the device driver runtime_suspend to disable the wakeirq.
That would minimize the interface to just dev_pm_request_wakeirq()
and dev_pm_free_wakeirq().

Regards,

Tony
