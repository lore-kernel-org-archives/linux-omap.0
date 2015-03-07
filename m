From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] PM / Wakeirq: Add minimal device wakeirq helper
 functions
Date: Fri, 6 Mar 2015 17:09:59 -0800
Message-ID: <20150307010959.GB5264@atomide.com>
References: <20150306161920.GM13520@atomide.com>
 <Pine.LNX.4.44L0.1503061358260.1407-100000@iolanthe.rowland.org>
 <20150306230539.GA2651@atomide.com>
 <142581656.cLu1yoPyFQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <142581656.cLu1yoPyFQ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [150306 16:19]:
> On Friday, March 06, 2015 03:05:40 PM Tony Lindgren wrote:
> > 
> > Oh it naturally would not work in irq context, it's for the bottom
> > half again. But I'll take a look if we can just call
> > pm_request_resume() and disable_irq() on the wakeirq in without
> > waiting for the device driver runtime_suspend to disable the wakeirq.
> > That would minimize the interface to just dev_pm_request_wakeirq()
> > and dev_pm_free_wakeirq().
> 
> But this is part of a bigger picture.  Namely, if a separete wakeup interrupt
> is required for a device, the device's power.can_wakeup flag cannot be set
> until that interrupt has been successfully requested.  Also for devices that
> can signal wakeup via their own IO interrupts, it would make sense to allow
> those interrupts to be registered somehow as "wakeup interrupts".

It sure would be nice to provide at least some automated handling
for those too, even if it was just to deal with if device_may_wake()
irq_set_irq_wake().

At least in the cases I've seen, the IO interrupt is capable of waking
up too, but not from any deeper idle states. The wakeirq is always
capable of waking up the system, so if wakeirq was configured we
could just ignore the wake configureation for the IO interrupt.

And it seems some devices have a single wakeirq dealing with a group
of IO interrupts (GPIOs), see commit 97d86e07b716 ("Input: gpio_keys -
allow separating gpio and irq in device tree"). Not sure if that
interrupt is wake-up capable, but that would certainly make sense
considering it's for gpio-keys.

So it seems as long as we have one wakeirq entry per device, we
should be covered, even if a single wakeirq needs to wake up multiple
devices.

> So I wonder if we can define a new struct along the lines of your
> struct wakeirq_source, but call it struct wake_irq and make it look
> something like this:
> 
> struct wake_irq {
>        struct device *dev;
>        int irq;
>        irq_handler_t handler;
> };
> 
> Then, add a struct wake_irq pointer to struct dev_pm_info *and* to
> struct wakeup_source.  Next, make dev_pm_request_wake_irq() allocate the
> structure and request the interrupt and only set the pointer to it from
> struct dev_pm_info *along* *with* power.can_wakeup if all that was
> successful.
> 
> For devices that use their own IO IRQ for wakeup, we can add something
> like dev_pm_set_wake_irq() that will work analogously, but without requesting
> the interrupt.  It will just set the dev and irq members of struct wake_irq
> and point struct dev_pm_info to it and set its power.can_wakeup flag.

OK
 
> Then, device_wakeup_enable() will be able to see that the device has a
> wakeup IRQ and it may then point its own struct wake_irq pointer to that.
> The core may then use that pointer to trigger enable_irq_wake() for the
> IRQ in question and it will cover the devices that don't need separate
> wakeup interrupts too.

Are you thinking we could do more than automate irq_set_irq_wake()
for the devices with just wake-up capable IO IRQ?
 
> Does that make sense to you?

Sure, at least for the irq_set_irq_wake() case.

Regards,

Tony
