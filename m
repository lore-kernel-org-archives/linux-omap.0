From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Tue, 19 May 2015 16:26:37 +0200
Message-ID: <3371662.LPKmgz3rb9@vostro.rjw.lan>
References: <1431560196-5722-1-git-send-email-tony@atomide.com> <20150518234400.GN10274@atomide.com> <3554198.gIGuGWK14O@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3554198.gIGuGWK14O@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday, May 19, 2015 04:04:43 PM Rafael J. Wysocki wrote:
> On Monday, May 18, 2015 04:44:01 PM Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [150518 15:06]:
> > > +/**
> > > + * dev_pm_set_wake_irq - Attach device IO interrupt as wake IRQ
> > > + * @dev: Device entry
> > > + * @irq: Device IO interrupt
> > > + *
> > > + * Attach a device IO interrupt as a wake IRQ. The wake IRQ gets
> > > + * automatically configured for wake-up from suspend  based
> > > +void dev_pm_clear_wake_irq(struct device *dev)
> > > +{
> > > +	struct wake_irq *wirq = dev->power.wakeirq;
> > > +	unsigned long flags;
> > > +
> > > +	if (!wirq)
> > > +		return;
> > > +
> > > +	device_wakeup_detach_irq(dev);
> > > +
> > > +	spin_lock_irqsave(&dev->power.lock, flags);
> > > +	if (wirq->manage_irq) {
> > > +		free_irq(wirq->irq, wirq);
> > > +		wirq->manage_irq = false;
> > > +	}
> > > +	dev->power.wakeirq = NULL;
> > > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > > +
> > > +	wirq->irq = -EINVAL;
> > > +	kfree(wirq);
> > > +}
> > 
> > I just noticed most of the dev_pm_clear_wake_irq is no longer needed.
> > We're now freeing it anyways. so it can be just:
> > 
> > void dev_pm_clear_wake_irq(struct device *dev)
> > {
> > 	struct wake_irq *wirq = dev->power.wakeirq;
> > 	unsigned long flags;
> > 
> > 	if (!wirq)
> > 		return;
> > 
> > 	spin_lock_irqsave(&dev->power.lock, flags);
> > 	dev->power.wakeirq = NULL;
> > 	spin_unlock_irqrestore(&dev->power.lock, flags);
> > 
> > 	device_wakeup_detach_irq(dev);
> > 	if (wirq->manage_irq)
> > 		free_irq(wirq->irq, wirq);
> > 	kfree(wirq);
> > }
> > 
> > 
> > Regards,
> > 
> > Tony
> > 
> > 8< ---------------------
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Mon, 18 May 2015 15:40:29 -0700
> > Subject: [PATCH] PM / Wakeirq: Add automated device wake IRQ handling
> > 
> > Turns out we can automate the handling for the device_may_wakeup()
> > quite a bit by using the kernel wakeup source list.
> > 
> > And as some hardware has separate dedicated wake-up interrupt
> > in addition to the IO interrupt, we can automate the handling by
> > adding a generic threaded interrupt handler that just calls the
> > device PM runtime to wake up the device.
> > 
> > This allows dropping code from device drivers as we currently
> > are doing it in multiple ways, and often wrong.
> > 
> > For most drivers, we should be able to drop the following
> > boilerplate code from runtime_suspend and runtime_resume
> > functions:
> > 
> > 	...
> > 	device_init_wakeup(dev, true);
> > 	...
> > 	if (device_may_wakeup(dev)
> > 		enable_irq_wake(irq);
> > 	...
> > 	if (device_may_wakeup(dev)
> > 		enable_irq_wake(irq);
> 
> Closing parens are missin in the above two if () statements.
> 
> Also, should the second one be disable_irq_wake(irq)?
> 
> > 	...
> > 	device_init_wakeup(dev, false);
> > 	...
> > 
> > We can replace it with just the following init and exit
> > time code:
> > 
> > 	...
> > 	device_init_wakeup(dev, true);
> > 	dev_pm_set_wake_irq(dev, irq);
> > 	...
> > 	dev_pm_clear_wake_irq(dev);
> > 	device_init_wakeup(dev, false);
> > 	...
> > 
> > And for hardware with dedicated wake-up interrupts:
> > 
> > 	...
> > 	device_init_wakeup(dev, true);
> > 	dev_pm_set_dedicated_wake_irq(dev, irq);
> > 	...
> > 	dev_pm_clear_wake_irq(dev);
> > 	device_init_wakeup(dev, false);
> > 	...
> > 
> > For now, let's only enable it for select PM_WAKEIRQ.
> 
> Why?  What would be wrong with doing that unconditionally?

I mean, what about making it depend on CONFIG_PM directly?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
