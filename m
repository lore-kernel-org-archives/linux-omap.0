From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper functions
Date: Mon, 09 Mar 2015 15:09:47 +0100
Message-ID: <2082077.4FTyl2Ufa0@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1503081142270.3638-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55295 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752983AbbCINqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2015 09:46:09 -0400
In-Reply-To: <Pine.LNX.4.44L0.1503081142270.3638-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Sunday, March 08, 2015 11:43:34 AM Alan Stern wrote:
> On Sat, 7 Mar 2015, Rafael J. Wysocki wrote:
> 
> > But this is part of a bigger picture.  Namely, if a separete wakeup interrupt
> > is required for a device, the device's power.can_wakeup flag cannot be set
> > until that interrupt has been successfully requested.  Also for devices that
> > can signal wakeup via their own IO interrupts, it would make sense to allow
> > those interrupts to be registered somehow as "wakeup interrupts".
> > 
> > So I wonder if we can define a new struct along the lines of your
> > struct wakeirq_source, but call it struct wake_irq and make it look
> > something like this:
> > 
> > struct wake_irq {
> >        struct device *dev;
> >        int irq;
> >        irq_handler_t handler;
> > };
> > 
> > Then, add a struct wake_irq pointer to struct dev_pm_info *and* to
> > struct wakeup_source.  Next, make dev_pm_request_wake_irq() allocate the
> > structure and request the interrupt and only set the pointer to it from
> > struct dev_pm_info *along* *with* power.can_wakeup if all that was
> > successful.
> > 
> > For devices that use their own IO IRQ for wakeup, we can add something
> > like dev_pm_set_wake_irq() that will work analogously, but without requesting
> > the interrupt.  It will just set the dev and irq members of struct wake_irq
> > and point struct dev_pm_info to it and set its power.can_wakeup flag.
> > 
> > Then, device_wakeup_enable() will be able to see that the device has a
> > wakeup IRQ and it may then point its own struct wake_irq pointer to that.
> > The core may then use that pointer to trigger enable_irq_wake() for the
> > IRQ in question and it will cover the devices that don't need separate
> > wakeup interrupts too.
> > 
> > Does that make sense to you?
> 
> Can we back up a little?  What is the basic problem the two of you are 
> trying to solve?

Essentially, code duplication between drivers that all need to do the same
thing which can be moved to the core quite easily.

Rafael

