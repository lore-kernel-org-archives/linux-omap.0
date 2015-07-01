From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH REPOST] gpio: omap: use raw locks for locking
Date: Wed, 1 Jul 2015 00:32:06 -0700
Message-ID: <20150701073205.GT4156@atomide.com>
References: <20150619170654.GA4937@linutronix.de>
 <5584547B.9040203@oracle.com>
 <CABxcv==5Fo-x9CdSu6BYNfBpAS7rp63fHA319J_KvWZZG9q=ng@mail.gmail.com>
 <20150622070821.GB4156@atomide.com>
 <559275B9.3040909@ti.com>
 <5592C5A2.5050809@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5592C5A2.5050809@linutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Javier Martinez Canillas <javier@dowhile0.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [150630 09:39]:
> On 06/30/2015 12:55 PM, Grygorii Strashko wrote:
> > 
> > May be you have some thought?
> 
> If I remember it properly, you must not sleep but you do so on wakeup.
> At least you take spinlocks (spinlocks not raw_spinlocks). One question
> is why do you need (or why is it okay) to put a device to sleep (via
> RPM) if the device is used as an interrupt controller? From what I
> understand, if the GPIO controller is really sleeping you won't receive
> any interrupts.

Not quite so. In many cases the GPIO interrupt just provides a wake-up
event for a device that's in deeper idle state. Such as a touch screen
interrupt. And the interrupt works just fine, just it's latency can
be really bad :)

The first GPIO bank is always on, the others need to use dedicated
IO chain wake-up interrupts with pinctrl-single.
 
> So I think you shouldn't put a GPIO controller to sleep if it is
> active. If you avoid this, there should be nothing calling you from
> IRQ-context on -RT.

That seems like a workaround though.. It seems we're better off
making things work with threaded IRQ (and removing runtime PM from
the IRQ path). For the GPIO banks requiring the use of a dedicated
wakeirq, his is mostly already done with recent commit 4990d4fe327b
("PM / Wakeirq: Add automated device wake IRQ handling") where the
wakeirq handling is a completely separate threaded IRQ handler.

The obvious solution seems to make GPIO interrupt handling all
happen in a bottom half. That should allow removing the
pm_runtime_irq_safe, which is not good to have in general.

> >>From my side what I've tried or thought about:
> > 1) OMAP HW IRQ handler can be transformed to threaded IRQ on -RT.
> >    Can it be acceptable?
> 
> It could. In theory. It would work, too. Not sure you really want this.
> You lose the cascaded handler that you have now. The obvious change
> would be that you see another IRQ used in /proc/interrupts. This is
> harmless :) However each time an IRQ (on the GPIO side) arrives you
> have a hardirq which is defered into thread context. Then it wakes
> another thread (the GPIO-IRQ-handler). So this adds a little of
> overhead on your call path. Since you won't have IRQF_NO_THREAD flag on
> any user, this should remain the only price you pay.

This should be OK for most cases as the GPIO interrupt devices are
typically on some external bus like I2C or GPMC. The hurting case
would be bitbanging GPIO devices, like the CBUS I2C driver.

If something faster is needed, we could allow configuring GPIO banks
in a different way where the non-threaded banks don't allow idling
the bank?

Regards,

Tony
