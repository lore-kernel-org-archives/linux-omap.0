From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper functions
Date: Sat, 07 Mar 2015 01:43:22 +0100
Message-ID: <142581656.cLu1yoPyFQ@vostro.rjw.lan>
References: <20150306161920.GM13520@atomide.com> <Pine.LNX.4.44L0.1503061358260.1407-100000@iolanthe.rowland.org> <20150306230539.GA2651@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150306230539.GA2651@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Friday, March 06, 2015 03:05:40 PM Tony Lindgren wrote:
> * Alan Stern <stern@rowland.harvard.edu> [150306 11:05]:
> > On Fri, 6 Mar 2015, Tony Lindgren wrote:
> > 
> > > > > +	struct wakeirq_source *wirq = _wirq;
> > > > > +	irqreturn_t ret = IRQ_NONE;
> > > > > +
> > > > > +	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
> > > > > +	if (pm_runtime_suspended(wirq->dev)) {
> > > > 
> > > > What if the device is resumed on a different CPU right here?
> > > 
> > > Good point, sounds like we need to do this in some pm_runtime
> > > function directly for the locking.
> > >  
> > > > > +		pm_runtime_mark_last_busy(wirq->dev);
> > > > > +		pm_runtime_resume(wirq->dev);
> > > > 
> > > > Calling this with disabled interrupts is a bad idea in general.
> > > > Is the device guaranteed to have power.irq_safe set?
> > > 
> > > Well right now it's using threaded irq, and I'd like to get rid of
> > > the pm_runtime calls in the regular driver interrupts completely.
> > > We need to ensure the device runtime_resume is completed before
> > > returning IRQ_HANDLED here.
> > 
> > In general, runtime_resume methods are allowed to sleep.  They can't be
> > used in an interrupt handler top half unless the driver has
> > specifically promised they are IRQ-safe.  That's what Rafael was
> > getting at.
> 
> Yes I understand, otherwise things certainly would not work :)
> 
> > Of course, if this routine is a threaded-irq bottom half then there's 
> > no problem.
> 
> Right this is threaded-irq bottom half because the devices may
> need to restore state and start regulators.
>  
> > > > I guess what you want to call here is pm_request_resume() and
> > > > I wouldn't say that calling pm_runtime_mark_last_busy() on a
> > > > suspended device was valid.
> > > 
> > > I'll verify again, but I believe the issue was that without doing
> > > mark_last_busy here the device falls back asleep right away.
> > > That probably should be fixed in pm_runtime in general if that's
> > > the case.
> > 
> > It's up to the subsystem to handle this.  For example, the USB 
> > subsystem's runtime-resume routine calls pm_runtime_mark_last_busy.
> 
> Hmm.. OK thanks this probably explains why pm_request_resume() did
> not work.
> 
> For omaps, I could call this from the interconnect related code,
> but then how dow we deal with the subsystems that don't call it?

Good question. :-)

> > > Considering the above, should we add a new function something like
> > > pm_resume_complete() that does not need irq_safe set but does
> > > not return until the device has completed resume?
> > 
> > That doesn't make sense.  You're asking for a routine that is allowed
> > to sleep but can safely be called in interrupt context.
> 
> Oh it naturally would not work in irq context, it's for the bottom
> half again. But I'll take a look if we can just call
> pm_request_resume() and disable_irq() on the wakeirq in without
> waiting for the device driver runtime_suspend to disable the wakeirq.
> That would minimize the interface to just dev_pm_request_wakeirq()
> and dev_pm_free_wakeirq().

But this is part of a bigger picture.  Namely, if a separete wakeup interrupt
is required for a device, the device's power.can_wakeup flag cannot be set
until that interrupt has been successfully requested.  Also for devices that
can signal wakeup via their own IO interrupts, it would make sense to allow
those interrupts to be registered somehow as "wakeup interrupts".

So I wonder if we can define a new struct along the lines of your
struct wakeirq_source, but call it struct wake_irq and make it look
something like this:

struct wake_irq {
       struct device *dev;
       int irq;
       irq_handler_t handler;
};

Then, add a struct wake_irq pointer to struct dev_pm_info *and* to
struct wakeup_source.  Next, make dev_pm_request_wake_irq() allocate the
structure and request the interrupt and only set the pointer to it from
struct dev_pm_info *along* *with* power.can_wakeup if all that was
successful.

For devices that use their own IO IRQ for wakeup, we can add something
like dev_pm_set_wake_irq() that will work analogously, but without requesting
the interrupt.  It will just set the dev and irq members of struct wake_irq
and point struct dev_pm_info to it and set its power.can_wakeup flag.

Then, device_wakeup_enable() will be able to see that the device has a
wakeup IRQ and it may then point its own struct wake_irq pointer to that.
The core may then use that pointer to trigger enable_irq_wake() for the
IRQ in question and it will cover the devices that don't need separate
wakeup interrupts too.

Does that make sense to you?

Rafael
