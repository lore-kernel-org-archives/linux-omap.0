From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper
 functions
Date: Mon, 9 Mar 2015 08:09:09 -0700
Message-ID: <20150309150908.GC5264@atomide.com>
References: <20150306230539.GA2651@atomide.com>
 <Pine.LNX.4.44L0.1503081134310.3638-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1503081134310.3638-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [150308 08:41]:
> On Fri, 6 Mar 2015, Tony Lindgren wrote:
> 
> > > > I'll verify again, but I believe the issue was that without doing
> > > > mark_last_busy here the device falls back asleep right away.
> 
> As it should.  If you don't increment the usage counter (for example, 
> by calling pm_runtime_get instead of pm_request_resume) and you don't 
> update last_busy then you are telling the PM core that the device 
> currently isn't busy and it hasn't been in use since the last time it 
> was suspended.  Under those circumstances, the PM core is _supposed_ to 
> suspend the device right away.

OK so it's a feature then.
 
> > > > That probably should be fixed in pm_runtime in general if that's
> > > > the case.
> > > 
> > > It's up to the subsystem to handle this.  For example, the USB 
> > > subsystem's runtime-resume routine calls pm_runtime_mark_last_busy.
> > 
> > Hmm.. OK thanks this probably explains why pm_request_resume() did
> > not work.
> > 
> > For omaps, I could call this from the interconnect related code,
> > but then how dow we deal with the subsystems that don't call it?
> 
> Start by determining _why_ they don't call it.  Maybe they have a good 
> reason.  If they don't then fix them.

Yes I'll check, it's just probably because the drivers have been
calling it instead.
 
> > > > Considering the above, should we add a new function something like
> > > > pm_resume_complete() that does not need irq_safe set but does
> > > > not return until the device has completed resume?
> > > 
> > > That doesn't make sense.  You're asking for a routine that is allowed
> > > to sleep but can safely be called in interrupt context.
> > 
> > Oh it naturally would not work in irq context, it's for the bottom
> > half again.
> 
> In other words, you're suggesting we add a function that runs in 
> process context and doesn't return until the device is fully resumed?  
> That's exactly what pm_runtime_resume does right now.

But doesn't it only wait for completion if the driver is marked with
pm_runtime_irq_safe()?
 
> >  But I'll take a look if we can just call
> > pm_request_resume() and disable_irq() on the wakeirq in without
> > waiting for the device driver runtime_suspend to disable the wakeirq.
> > That would minimize the interface to just dev_pm_request_wakeirq()
> > and dev_pm_free_wakeirq().
> 
> Will that be acceptable in systems with shared IRQ lines?

Not without us keeping track of when the wakeirq is enabled or
disabled :)

Regards,

Tony
