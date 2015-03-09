From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper
 functions
Date: Mon, 9 Mar 2015 11:42:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1503091134240.1472-100000@iolanthe.rowland.org>
References: <20150309150908.GC5264@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150309150908.GC5264@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 9 Mar 2015, Tony Lindgren wrote:

> > > > > Considering the above, should we add a new function something like
> > > > > pm_resume_complete() that does not need irq_safe set but does
> > > > > not return until the device has completed resume?
> > > > 
> > > > That doesn't make sense.  You're asking for a routine that is allowed
> > > > to sleep but can safely be called in interrupt context.
> > > 
> > > Oh it naturally would not work in irq context, it's for the bottom
> > > half again.
> > 
> > In other words, you're suggesting we add a function that runs in 
> > process context and doesn't return until the device is fully resumed?  
> > That's exactly what pm_runtime_resume does right now.
> 
> But doesn't it only wait for completion if the driver is marked with
> pm_runtime_irq_safe()?

Put it this way: pm_runtime_resume invokes a ->runtime_resume
callback routine (the subsystem's or the driver's or whichever), and it
assumes that if the routine returns 0 then the device has been resumed.  
It doesn't really _wait_ for anything; it just calls the callback
routine.

It behaves this way whether or not the irq_safe flag is set.  The only
difference is that if irq_safe is set then the callback routine is
invoked with interrupts disabled (and in this case pm_runtime_resume
may be called in interrupt context -- normally it can be called only in
process context).

Alan Stern
