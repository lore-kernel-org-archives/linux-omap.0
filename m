From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Tue, 19 May 2015 08:15:05 -0700
Message-ID: <20150519151505.GQ10274@atomide.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <20150518220459.GJ10274@atomide.com>
 <20150518234400.GN10274@atomide.com>
 <3554198.gIGuGWK14O@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3554198.gIGuGWK14O@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Felipe Balbi <balbi@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [150519 06:40]:
> On Monday, May 18, 2015 04:44:01 PM Tony Lindgren wrote:
> > +/**
> > + * handle_threaded_wake_irq - Handler for dedicated wake-up interrupts
> > + * @irq: Device dedicated wake-up interrupt
> > + * @_wirq: Wake IRQ data
> > + *
> > + * Some devices have a separate wake-up interrupt in addition to the
> > + * device IO interrupt. The wake-up interrupts signal that the device
> > + * should be woken up from a idle state. This handler uses device
> > + * specific pm_runtime functions to wake the device and then it's
> > + * up to the device to do whatever it needs to. Note as the device
> > + * may need to restore context and start up regulators, we use a
> > + * threaded IRQ.
> > + *
> > + * Also note that we are not resending the lost device interrupts.
> > + * We assume that the wake-up interrupt just needs to wake-up the
> > + * device, and the device pm_runtime_resume() can deal with the
> > + * situation.
> > + */
> > +static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
> > +{
> > +	struct wake_irq *wirq = _wirq;
> > +
> > +	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
> > +	return pm_runtime_resume(wirq->dev) ? IRQ_NONE : IRQ_HANDLED;
> 
> There are various reasons why pm_runtime_resume() may return error codes and
> some of them don't mean that the interrupt was not legitimate.
> 
> Moreover, it returns 1 if the device is already active, in which case the above
> check won't do any good to us.

OK yeah that check won't work then.
 
> Why not to return IRQ_HANDLED unconditionally from here?

OK

Regards,

Tony
