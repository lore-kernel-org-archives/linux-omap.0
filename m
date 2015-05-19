From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Tue, 19 May 2015 08:09:27 -0700
Message-ID: <20150519150926.GP10274@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <20150518234400.GN10274@atomide.com>
 <3554198.gIGuGWK14O@vostro.rjw.lan>
 <3371662.LPKmgz3rb9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3371662.LPKmgz3rb9@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Felipe Balbi <balbi@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [150519 07:02]:
> On Tuesday, May 19, 2015 04:04:43 PM Rafael J. Wysocki wrote:
> > On Monday, May 18, 2015 04:44:01 PM Tony Lindgren wrote:
> > > 
> > > For most drivers, we should be able to drop the following
> > > boilerplate code from runtime_suspend and runtime_resume
> > > functions:
> > > 
> > > 	...
> > > 	device_init_wakeup(dev, true);
> > > 	...
> > > 	if (device_may_wakeup(dev)
> > > 		enable_irq_wake(irq);
> > > 	...
> > > 	if (device_may_wakeup(dev)
> > > 		enable_irq_wake(irq);
> > 
> > Closing parens are missin in the above two if () statements.
> > 
> > Also, should the second one be disable_irq_wake(irq)?

Thanks yeah it should disable_irq_wake :) Will fix.

> > > 	...
> > > 	device_init_wakeup(dev, false);
> > > 	...
> > > 
> > > We can replace it with just the following init and exit
> > > time code:
> > > 
> > > 	...
> > > 	device_init_wakeup(dev, true);
> > > 	dev_pm_set_wake_irq(dev, irq);
> > > 	...
> > > 	dev_pm_clear_wake_irq(dev);
> > > 	device_init_wakeup(dev, false);
> > > 	...
> > > 
> > > And for hardware with dedicated wake-up interrupts:
> > > 
> > > 	...
> > > 	device_init_wakeup(dev, true);
> > > 	dev_pm_set_dedicated_wake_irq(dev, irq);
> > > 	...
> > > 	dev_pm_clear_wake_irq(dev);
> > > 	device_init_wakeup(dev, false);
> > > 	...
> > > 
> > > For now, let's only enable it for select PM_WAKEIRQ.
> > 
> > Why?  What would be wrong with doing that unconditionally?

No reason to make it conditional any longer. it's there from
the earlier version that only handled the dedicated wake IRQS.
 
> I mean, what about making it depend on CONFIG_PM directly?

OK let's do that.

Regards,

Tony
