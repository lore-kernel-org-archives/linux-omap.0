From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Mon, 18 May 2009 10:00:44 -0700
Message-ID: <87my9a8hxf.fsf@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
	<20090518133241.GH3067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:46081 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbZERRAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 13:00:46 -0400
Received: by pxi29 with SMTP id 29so2034904pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 10:00:47 -0700 (PDT)
In-Reply-To: <20090518133241.GH3067@n2100.arm.linux.org.uk> (Russell King's message of "Mon\, 18 May 2009 14\:32\:41 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Richard Woodruff <r-woodruff2@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, May 15, 2009 at 11:40:41AM -0700, Kevin Hilman wrote:
>> This patch is to sync the core linux-omap PM code with mainline.  This
>> code has evolved and been used for a while the linux-omap tree, but
>> the attempt here is to finally get this into mainline.
>> 
>> Following this will be a series of patches from the 'PM branch' of the
>> linux-omap tree to add full PM hardware support from the linux-omap
>> tree.
>> 
>> Much of this PM core code was written by Jouni Hogander with
>> significant contributions from Paul Walmsley as well as many others
>> from Nokia, Texas Instruments and linux-omap community.
>
> Overall comment, I think we need to rework the idle support code so
> that enable_hlt/disable_hlt can be used even when pm_idle has been
> overridden, rather than OMAP going off and inventing its own mechanisms.

Would adding:

	if (hlt_counter)
		cpu_relax();

to the beginning of omap*_pm_idle functions be sufficient?  That will
at least allow the hlt stuff to behave as expected.

The only thing the OMAP /sys/power/sleep_while_idle hook adds to this
functionality is the ability to control this from sysfs.

Any objections to /sys/power/enable_hlt?

>> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
>> new file mode 100644
>> index 0000000..2a2d1a3
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/pm24xx.c
>> @@ -0,0 +1,557 @@
>> +/*
>> + * OMAP2 Power Management Routines
>> + *
>> + * Copyright (C) 2005 Texas Instruments, Inc.
>> + * Copyright (C) 2006-2008 Nokia Corporation
>> + *
>> + * Written by:
>> + * Richard Woodruff <r-woodruff2@ti.com>
>> + * Tony Lindgren
>> + * Juha Yrjola
>> + * Amit Kucheria <amit.kucheria@nokia.com>
>> + * Igor Stoppa <igor.stoppa@nokia.com>
>> + *
>> + * Based on pm.c for omap1
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/suspend.h>
>> +#include <linux/sched.h>
>> +#include <linux/proc_fs.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/time.h>
>> +
>> +#include <asm/mach/time.h>
>> +#include <asm/mach/irq.h>
>> +#include <asm/mach-types.h>
>> +
>> +#include <mach/irqs.h>
>> +#include <mach/clock.h>
>> +#include <mach/sram.h>
>> +#include <mach/control.h>
>> +#include <mach/gpio.h>
>
> Should be linux/gpio.h

Ack

>> +/*
>> + * Note that you can use clock_event_device->min_delta_ns if you want to
>> + * avoid reprogramming timer too often when using CONFIG_NO_HZ.
>> + */
>> +static void omap2_pm_idle(void)
>> +{
>> +	local_irq_disable();
>> +	local_fiq_disable();
>> +
>> +	if (!omap2_can_sleep()) {
>> +		if (!atomic_read(&sleep_block) && omap2_irq_pending())
>> +			goto out;
>> +		omap2_enter_mpu_retention();
>> +		goto out;
>> +	}
>> +
>> +	if (omap2_irq_pending())
>> +		goto out;
>> +
>> +	omap2_enter_full_retention();
>> +
>> +out:
>> +	local_fiq_enable();
>> +	local_irq_enable();
>> +}
>
> It's totally unclear what the comment above the function has to do with
> the function itself.

Indeed.  Will be removed.

>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> new file mode 100644
>> index 0000000..0fb6bec
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -0,0 +1,607 @@
>> +/*
>> + * OMAP3 Power Management Routines
>> + *
>> + * Copyright (C) 2006-2008 Nokia Corporation
>> + * Tony Lindgren <tony@atomide.com>
>> + * Jouni Hogander
>> + *
>> + * Copyright (C) 2005 Texas Instruments, Inc.
>> + * Richard Woodruff <r-woodruff2@ti.com>
>> + *
>> + * Based on pm.c for omap1
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/pm.h>
>> +#include <linux/suspend.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/list.h>
>> +#include <linux/err.h>
>> +
>> +#include <mach/gpio.h>
>
> Should be linux/gpio.h

Ack

>> +static void omap3_pm_idle(void)
>> +{
>> +	local_irq_disable();
>> +	local_fiq_disable();
>> +
>> +	if (!omap3_can_sleep())
>> +		goto out;
>> +
>> +	if (omap_irq_pending())
>> +		goto out;
>
> So what happens if an IRQ becomes pending at this precise point?

Then it gets missed this time, and will be triggered upon wakeup.  If
it's a wakeup-capable interrupt, then it will wake the system
immediately.

In subsequent series of the PM branch, this will be going away in
favor of using the [enable|disable]_irq_wake() and the lazy IRQ
disabling features.

>> +
>> +	omap_sram_idle();
>> +
>> +out:
>> +	local_fiq_enable();
>> +	local_irq_enable();
>> +}
>> +	/* IRQ mode */
>> +	bic    r0, r7, #0x1F
>> +	orr    r0, r0, #0x12
>> +	msr    cpsr, r0	/*go into IRQ mode*/
>> +	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM*/
>> +	mov    sp, r4	/*update the SP */
>> +	mov    lr, r5	/*update the LR */
>> +	msr    spsr, r6	/*update the SPSR */
>> +
>> +	/* ABORT mode */
>> +	bic    r0, r7, #0x1F
>> +	orr    r0, r0, #0x17
>> +	msr    cpsr, r0	/* go into ABORT mode */
>> +	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM */
>> +	mov    sp, r4		/*update the SP */
>> +	mov    lr, r5		/*update the LR */
>> +	msr    spsr, r6		/*update the SPSR */
>> +
>> +	/* UNDEEF mode */
>> +	bic    r0, r7, #0x1F
>> +	orr    r0, r0, #0x1B
>> +	msr    cpsr, r0		/*go into UNDEF mode */
>> +	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM */
>> +	mov    sp, r4		/*update the SP*/
>> +	mov    lr, r5		/*update the LR*/
>> +	msr    spsr, r6		/*update the SPSR*/
>> +
>> +	/* SYSTEM (USER) mode */
>> +	bic    r0, r7, #0x1F
>> +	orr    r0, r0, #0x1F
>> +	msr    cpsr, r0		/*go into USR mode */
>> +	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM*/
>> +	mov    sp, r4		/*update the SP */
>> +	mov    lr, r5		/*update the LR */
>> +	msr    spsr, r6		/*update the SPSR */
>> +	msr    cpsr, r7		/*back to original mode*/
>
> There is a function which re-initializes the abort mode registers already -
> cpu_init().  Please use that if possible instead.

OK, will investigate.

Kevin
