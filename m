From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP3: PM: cpuidle and debounced GPIOs
Date: Tue, 12 Jan 2010 11:41:27 -0800
Message-ID: <877hrn861k.fsf@deeprootsystems.com>
References: <WC20100106141608.0400A6@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:43937 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab0ALTla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 14:41:30 -0500
Received: by yxe17 with SMTP id 17so21722221yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 11:41:30 -0800 (PST)
In-Reply-To: <WC20100106141608.0400A6@terrafix.co.uk> (Joe Woodward's message of "Wed\, 06 Jan 2010 14\:16\:08 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: linux-omap@vger.kernel.org

"Joe Woodward" <jw@terrafix.co.uk> writes:

> I am reasonably new to OMAP Linux so feel free to point me to the
> correct mailing list/documentation...
>
> Is it possible to use cpuidle for OMAP3530 when using GPIO with
> debouncing enabled?
>
> Some background:
>
> I have an LogicPD SOM-LV 3530 evaluation kit. This has an OMAP3530
> connected to a touchscreen controller (tsc2004) via GPIO153.
>
> This GPIO requires debouncing:
>   omap_set_gpio_debounce(153, 1);
>   omap_set_gpio_debounce_time(153, 0xa);
>
> This GPIO is also set as a wake source (as described in the comment in
> arch/arm/plat-omap/gpio.c:gpio_wake_enable()): 
>   enable_irq_wake(OMAP_GPIO_IRQ(153));
>
> When using the PM-branch (the latest copy as of 17-Dec-09) I notice that
> this can cause problems if cpuidle is enabled.
>
> According to my understanding the following is happening:
>   - When cpuidle is enabled the kernel attempts to idle.
>   - This causes the OMAP3530 to attempt to enter PWRDM_POWER_RET.
>   - This causes the GPIO driver to disable the debounce clock (otherwise
>     per_pwrdm cannot enter retention).
>   - The system enters retention.
>   - Some time later the GPIO is toggled by a touch on the screen and the
>     system wakes, but this GPIO is not debounced (as the debounce clock
>     is not yet running).
>
x> This is a problem as I then get false "clicks" on the touchscreen. This
> happens for *every* click because as soon as processing of one click has
> finished cpuidle places the chip back in to retention.
>
> This is less of a problem if I do not use cpuidle, and only enter
> retention when I choose (echo "mem" > /sys/power/state). I still get
> false clicks when waking but can mitigate this as I know they will
> happen.
>
> So, in general:
>
> - Is it not possible to have a GPIO which requires debouncing as
>   a wake source?
> - Are hardware debounced GPIOs generally a bad idea when using cpuidle?
> - And a more general question, does the kernel provide features to
>   debounce a GPIO in software (rather than using the hardware)?

Hi Joe,

Thanks for the very thorough description of the problem you're having.
You've correctly analyzed and diagnosed the problem with the debounce
clocks being disabled.

It sounds like we're being too aggressive in disabling the debounce
clocks.  We probably need some type of inactivity timer in the
touchscreen drivers to indicate when it's OK to cut clocks.

While not related to debounce, we do this in the serial driver as well
to prevent the UARTs to go idle between keystrokes on the console.

I think the right solution is to move the debounce clock init and
managment into the touchscreen driver.

What probably needs to happen is that rather than the platform init
code and PM idle code setting up and idling the debounce clocks, the
touchscreen driver itself should be managing these clocks.  The driver
is the place that these kinds of decision should be made.  It could
then use an inactivity timer to cut the clocks to allow full idle
and cut the clocks before suspending.

This would require extending the platform_data for the touchscreen
drivers to have some additional hooks to call platform code for
pre-idle, post-idle activity where the clocks could be managed.

Doing it this way, only when the driver is ready to allow idle will
it actually happen.

Kevin


