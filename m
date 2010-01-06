From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: OMAP3: PM: cpuidle and debounced GPIOs
Date: Wed, 06 Jan 2010 14:16:08 +0000
Message-ID: <WC20100106141608.0400A6@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.keele.netcentral.co.uk ([212.57.235.196]:33433 "EHLO
	smtp2.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755516Ab0AFOQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 09:16:18 -0500
Received: from terrafix.co.uk (host217-36-85-41.in-addr.btopenworld.com [217.36.85.41])
	by smtp2.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id o06EN6gk013612
	for <linux-omap@vger.kernel.org>; Wed, 6 Jan 2010 14:23:07 GMT
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v10.1.2)
	with ESMTP id md50001671796.msg
	for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 14:16:14 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am reasonably new to OMAP Linux so feel free to point me to the
correct mailing list/documentation...

Is it possible to use cpuidle for OMAP3530 when using GPIO with
debouncing enabled?

Some background:

I have an LogicPD SOM-LV 3530 evaluation kit. This has an OMAP3530
connected to a touchscreen controller (tsc2004) via GPIO153.

This GPIO requires debouncing:
  omap_set_gpio_debounce(153, 1);
  omap_set_gpio_debounce_time(153, 0xa);

This GPIO is also set as a wake source (as described in the comment in
arch/arm/plat-omap/gpio.c:gpio_wake_enable()): 
  enable_irq_wake(OMAP_GPIO_IRQ(153));

When using the PM-branch (the latest copy as of 17-Dec-09) I notice that
this can cause problems if cpuidle is enabled.

According to my understanding the following is happening:
  - When cpuidle is enabled the kernel attempts to idle.
  - This causes the OMAP3530 to attempt to enter PWRDM_POWER_RET.
  - This causes the GPIO driver to disable the debounce clock (otherwise
    per_pwrdm cannot enter retention).
  - The system enters retention.
  - Some time later the GPIO is toggled by a touch on the screen and the
    system wakes, but this GPIO is not debounced (as the debounce clock
    is not yet running).

This is a problem as I then get false "clicks" on the touchscreen. This
happens for *every* click because as soon as processing of one click has
finished cpuidle places the chip back in to retention.

This is less of a problem if I do not use cpuidle, and only enter
retention when I choose (echo "mem" > /sys/power/state). I still get
false clicks when waking but can mitigate this as I know they will
happen.
 
So, in general:

- Is it not possible to have a GPIO which requires debouncing as
  a wake source?
- Are hardware debounced GPIOs generally a bad idea when using cpuidle?
- And a more general question, does the kernel provide features to
  debounce a GPIO in software (rather than using the hardware)?

Cheers,
Joe Woodward


