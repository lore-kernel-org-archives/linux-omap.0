From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH REPOST] gpio: omap: use raw locks for locking
Date: Tue, 30 Jun 2015 18:36:50 +0200
Message-ID: <5592C5A2.5050809@linutronix.de>
References: <20150619170654.GA4937@linutronix.de> <5584547B.9040203@oracle.com> <CABxcv==5Fo-x9CdSu6BYNfBpAS7rp63fHA319J_KvWZZG9q=ng@mail.gmail.com> <20150622070821.GB4156@atomide.com> <559275B9.3040909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <559275B9.3040909@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On 06/30/2015 12:55 PM, Grygorii Strashko wrote:
> Hi Sebastian, All,
Hi Grygorii,

> The problem here is that OMAPs code implemented using PM runtime based
> approach and PM runtime is used everywhere. We don't see warnings form
> other drivers just because their HW IRQ handlers forced to be threaded, but
> that's not the case for OMAP GPIO :(

Only for the case where it is used as an interrupt controller. So the
primary interrupt controller is not using RPM then (or else you would
have the same problem).

> PM runtime for OMAP GPIO is implemented in irq_safe manner and it works for
> non-RT case, but the main question here - How can we proceed for -RT case?
> 
> May be you have some thought?

If I remember it properly, you must not sleep but you do so on wakeup.
At least you take spinlocks (spinlocks not raw_spinlocks). One question
is why do you need (or why is it okay) to put a device to sleep (via
RPM) if the device is used as an interrupt controller? From what I
understand, if the GPIO controller is really sleeping you won't receive
any interrupts.

So I think you shouldn't put a GPIO controller to sleep if it is
active. If you avoid this, there should be nothing calling you from
IRQ-context on -RT.

>>From my side what I've tried or thought about:
> 1) OMAP HW IRQ handler can be transformed to threaded IRQ on -RT.
>    Can it be acceptable?

It could. In theory. It would work, too. Not sure you really want this.
You lose the cascaded handler that you have now. The obvious change
would be that you see another IRQ used in /proc/interrupts. This is
harmless :) However each time an IRQ (on the GPIO side) arrives you
have a hardirq which is defered into thread context. Then it wakes
another thread (the GPIO-IRQ-handler). So this adds a little of
overhead on your call path. Since you won't have IRQF_NO_THREAD flag on
any user, this should remain the only price you pay.

Also I try not grow the -RT queue. I sent patches upstream where
possible. That means for this I would like to have this addressed
upstream as there is no joy carrying this patch (that means please
don't do a -RT only fix).

> 2) I've tried to use irq_chip->irq_bus_lock/irq_bus_sync_unlock() callbacks.
>    It helps a bit, but there are two problems:
>    - These callbacks are not expected to fail;
>    - PM runtime calls are still present in omap_gpio_irq_handler().
>    Hypothetically, they can be removed, but we'd need to ensure that OMAP GPIO HW
>    is powered and ready to process IRQs all the time while GPIO bank IRQ is in use.
>    Not trivial thing to do taking into account multi-SoC support, suspend, cpuidle :(

What I still don't understand how can a GPIO create an interrupt if it
is sleeping? I know CAN and a few others peripherals can do such
things. Is this also the case for the GPIO?

Or is the problem more that the CPU can't properly enter suspend/
cpuidle if the GPIO bank remains active?

>   [code provided just to illustrate idea]
>   static void omap_gpio_irq_bus_lock(struct irq_data *data)
>   {
>        struct gpio_bank *bank = irq_data_get_irq_chip_data(data);
> 
>        if (!BANK_USED(bank))
>                pm_runtime_get_sync(bank->dev);
>   }

I don't really like the !BANK_USED(bank) check because it is either in
use or not. Things like that may hide the pm_runtime_get_sync() call and
explode with debug-off.

> I would be appreciated for any comments on this (1 or 2 or ..), thanks. 

Another way would be to turn the lock into a raw lock so it won't block
on -RT. However each time you hold the lock in process context you
block a possible -RT task from becoming run-able. Also this could
include larger hacker across the RPM code depending on how this lock
issue is solved.
Either way: the longer you hold the lock the longer you block the -RT
task and the important part is the worst-case scenario.

Sebastian
