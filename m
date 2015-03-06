From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper functions
Date: Sat, 07 Mar 2015 00:30:25 +0100
Message-ID: <1638656.aLmbYYvRI6@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1503061358260.1407-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1503061358260.1407-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Friday, March 06, 2015 02:05:43 PM Alan Stern wrote:
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
> 
> Of course, if this routine is a threaded-irq bottom half then there's 
> no problem.

Yup.  I overlooked the threaded part.

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

I'm wondering, though, if there's any reason for us to avoid updating
power.last_busy in rpm_resume().

If I was a driver writer, I'd expect the core to do that for me quite frankly.

Rafael

