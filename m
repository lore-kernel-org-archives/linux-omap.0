From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 01/11] Basic cpuidle driver
Date: Wed, 02 Jul 2008 14:22:06 +0300
Message-ID: <87od5gsf8h.fsf@trdhcp146196.ntc.nokia.com>
References: <003e01c8db85$01641a50$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26008 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbYGBLWc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 07:22:32 -0400
In-Reply-To: <003e01c8db85$01641a50$68bf18ac@ent.ti.com> (ext Rajendra Nayak's
	message of "Tue, 1 Jul 2008 19:46:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

General comment on this patch using top posting. There is no irq
disabling at all in cpuidle loop now. That might cause problems. If
you don't want to add that global irq disable you can still add it to
omap3 enter function. Do you think this is not needed?

"ext Rajendra Nayak" <rnayak@ti.com> writes:

> OMAP3 Basic cpuidle=20
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> ---
>  arch/arm/mach-omap2/Makefile      |    2=20
>  arch/arm/mach-omap2/cpuidle34xx.c |  245 +++++++++++++++++++++++++++=
+++++++++++
>  arch/arm/mach-omap2/cpuidle34xx.h |   56 ++++++++
>  arch/arm/mach-omap2/pm34xx.c      |    5=20
>  4 files changed, 306 insertions(+), 2 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-07-01 11:28=
:39.600854345 +0530
> @@ -0,0 +1,245 @@
> +/*
> + * linux/arch/arm/mach-omap2/cpuidle34xx.c
> + *
> + * OMAP3 CPU IDLE Routines
> + *
> + * Copyright (C) 2007-2008 Texas Instruments, Inc.
> + * Rajendra Nayak <rnayak@ti.com>
> + *
> + * Copyright (C) 2007 Texas Instruments, Inc.
> + * Karthik Dasu <karthik-dp@ti.com>
> + *
> + * Copyright (C) 2006 Nokia Corporation
> + * Tony Lindgren <tony@atomide.com>
> + *
> + * Copyright (C) 2005 Texas Instruments, Inc.
> + * Richard Woodruff <r-woodruff2@ti.com>
> + *
> + * Based on pm.c for omap2
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <asm/arch/pm.h>
> +#include <asm/arch/prcm.h>
> +#include <asm/arch/powerdomain.h>
> +#include "cpuidle34xx.h"
> +
> +#ifdef CONFIG_CPU_IDLE
> +
> +struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
> +struct omap3_processor_cx current_cx_state;
> +
> +static int omap3_idle_bm_check(void)
> +{
> +	return 0;
> +}
> +
> +/* omap3_enter_idle - Programs OMAP3 to enter the specified state.
> + * returns the total time during which the system was idle.
> + */
> +static int omap3_enter_idle(struct cpuidle_device *dev,
> +			struct cpuidle_state *state)
> +{
> +	struct omap3_processor_cx *cx =3D cpuidle_get_statedata(state);
> +	struct timespec ts_preidle, ts_postidle, ts_idle;
> +	struct powerdomain *mpu_pd;
> +
> +	current_cx_state =3D *cx;
> +
> +	/* Used to keep track of the total time in idle */
> +	getnstimeofday(&ts_preidle);
> +
> +
> +	if (cx->type =3D=3D OMAP3_STATE_C0) {
> +		/* Do nothing for C0, not even a wfi */
> +		return 0;
> +	}
> +
> +	mpu_pd =3D pwrdm_lookup("mpu_pwrdm");
> +	/* Program MPU to target state */
> +	if (cx->mpu_state < PWRDM_POWER_ON)
> +		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
> +
> +	/* Execute ARM wfi */
> +	omap_sram_idle();
> +
> +	/* Program MPU to ON */
> +	if (cx->mpu_state < PWRDM_POWER_ON)
> +		pwrdm_set_next_pwrst(mpu_pd, PWRDM_POWER_ON);
> +
> +	getnstimeofday(&ts_postidle);
> +	ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
> +	return timespec_to_ns(&ts_idle);
> +}
> +
> +static int omap3_enter_idle_bm(struct cpuidle_device *dev,
> +			       struct cpuidle_state *state)
> +{
> +	struct cpuidle_state *new_state =3D NULL;
> +	int i, j;
> +
> +	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()=
) {
> +
> +		/* Find current state in list */
> +		for (i =3D 0; i < OMAP3_MAX_STATES; i++)
> +			if (state =3D=3D &dev->states[i])
> +				break;
> +		BUG_ON(i =3D=3D OMAP3_MAX_STATES);
> +
> +		/* Back up to non 'CHECK_BM' state */
> +		for (j =3D i - 1;  j > 0; j--) {
> +			struct cpuidle_state *s =3D &dev->states[j];
> +
> +			if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
> +				new_state =3D s;
> +				break;
> +			}
> +		}
> +
> +		pr_debug("%s: Bus activity: Entering %s (instead of %s)\n",
> +			__FUNCTION__, new_state->name, state->name);
> +	}
> +
> +	return omap3_enter_idle(dev, new_state ? : state);
> +}
> +
> +DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> +
> +/* omap3_init_power_states - Initialises the OMAP3 specific C states=
=2E
> + * Below is the desciption of each C state.
> + *
> +	C0 . System executing code
> +	C1 . MPU WFI + Core active
> +	C2 . MPU CSWR + Core active
> +	C3 . MPU OFF + Core active
> +	C4 . MPU CSWR + Core CSWR
> +	C5 . MPU OFF + Core CSWR
> +	C6 . MPU OFF + Core OFF
> + */
> +void omap_init_power_states(void)
> +{
> +	/* C0 . System executing code */
> +	omap3_power_states[0].valid =3D 1;
> +	omap3_power_states[0].type =3D OMAP3_STATE_C0;
> +	omap3_power_states[0].sleep_latency =3D 0;
> +	omap3_power_states[0].wakeup_latency =3D 0;
> +	omap3_power_states[0].threshold =3D 0;
> +	omap3_power_states[0].mpu_state =3D PWRDM_POWER_ON;
> +	omap3_power_states[0].core_state =3D PWRDM_POWER_ON;
> +	omap3_power_states[0].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +
> +	/* C1 . MPU WFI + Core active */
> +	omap3_power_states[1].valid =3D 1;
> +	omap3_power_states[1].type =3D OMAP3_STATE_C1;
> +	omap3_power_states[1].sleep_latency =3D 10;
> +	omap3_power_states[1].wakeup_latency =3D 10;
> +	omap3_power_states[1].threshold =3D 30;
> +	omap3_power_states[1].mpu_state =3D PWRDM_POWER_ON;
> +	omap3_power_states[1].core_state =3D PWRDM_POWER_ON;
> +	omap3_power_states[1].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +
> +	/* C2 . MPU CSWR + Core active */
> +	omap3_power_states[2].valid =3D 1;
> +	omap3_power_states[2].type =3D OMAP3_STATE_C2;
> +	omap3_power_states[2].sleep_latency =3D 50;
> +	omap3_power_states[2].wakeup_latency =3D 50;
> +	omap3_power_states[2].threshold =3D 300;
> +	omap3_power_states[2].mpu_state =3D PWRDM_POWER_RET;
> +	omap3_power_states[2].core_state =3D PWRDM_POWER_ON;
> +	omap3_power_states[2].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +
> +	/* C3 . MPU OFF + Core active */
> +	omap3_power_states[3].valid =3D 0;
> +	omap3_power_states[3].type =3D OMAP3_STATE_C3;
> +	omap3_power_states[3].sleep_latency =3D 1500;
> +	omap3_power_states[3].wakeup_latency =3D 1800;
> +	omap3_power_states[3].threshold =3D 4000;
> +	omap3_power_states[3].mpu_state =3D PWRDM_POWER_OFF;
> +	omap3_power_states[3].core_state =3D PWRDM_POWER_RET;
> +	omap3_power_states[3].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +
> +	/* C4 . MPU CSWR + Core CSWR*/
> +	omap3_power_states[4].valid =3D 0;
> +	omap3_power_states[4].type =3D OMAP3_STATE_C4;
> +	omap3_power_states[4].sleep_latency =3D 2500;
> +	omap3_power_states[4].wakeup_latency =3D 7500;
> +	omap3_power_states[4].threshold =3D 12000;
> +	omap3_power_states[4].mpu_state =3D PWRDM_POWER_RET;
> +	omap3_power_states[4].core_state =3D PWRDM_POWER_RET;
> +	omap3_power_states[4].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +
> +	/* C5 . MPU OFF + Core CSWR */
> +	omap3_power_states[5].valid =3D 0;
> +	omap3_power_states[5].type =3D OMAP3_STATE_C5;
> +	omap3_power_states[5].sleep_latency =3D 3000;
> +	omap3_power_states[5].wakeup_latency =3D 8500;
> +	omap3_power_states[5].threshold =3D 15000;
> +	omap3_power_states[5].mpu_state =3D PWRDM_POWER_OFF;
> +	omap3_power_states[5].core_state =3D PWRDM_POWER_RET;
> +	omap3_power_states[5].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +
> +	/* C6 . MPU OFF + Core OFF */
> +	omap3_power_states[6].valid =3D 0;
> +	omap3_power_states[6].type =3D OMAP3_STATE_C6;
> +	omap3_power_states[6].sleep_latency =3D 10000;
> +	omap3_power_states[6].wakeup_latency =3D 30000;
> +	omap3_power_states[6].threshold =3D 300000;
> +	omap3_power_states[6].mpu_state =3D PWRDM_POWER_OFF;
> +	omap3_power_states[6].core_state =3D PWRDM_POWER_OFF;
> +	omap3_power_states[6].flags =3D CPUIDLE_FLAG_TIME_VALID;
> +}
> +
> +struct cpuidle_driver omap3_idle_driver =3D {
> +	.name =3D 	"omap3_idle",
> +	.owner =3D 	THIS_MODULE,
> +};
> +/*
> + * omap3_idle_init - Init routine for OMAP3 idle. Registers the OMAP=
3 specific
> + * cpuidle driver with the cpuidle f/w with the valid set of states.
> + */
> +int omap3_idle_init(void)
> +{
> +	int i, count =3D 0;
> +	struct omap3_processor_cx *cx;
> +	struct cpuidle_state *state;
> +	struct cpuidle_device *dev;
> +
> +	omap_init_power_states();
> +	cpuidle_register_driver(&omap3_idle_driver);
> +
> +	dev =3D &per_cpu(omap3_idle_dev, smp_processor_id());
> +
> +	for (i =3D 0; i < OMAP3_MAX_STATES; i++) {
> +		cx =3D &omap3_power_states[i];
> +		state =3D &dev->states[count];
> +
> +		if (!cx->valid)
> +			continue;
> +		cpuidle_set_statedata(state, cx);
> +		state->exit_latency =3D cx->sleep_latency + cx->wakeup_latency;
> +		state->target_residency =3D cx->threshold;
> +		state->flags =3D cx->flags;
> +		state->enter =3D (state->flags & CPUIDLE_FLAG_CHECK_BM) ?
> +			omap3_enter_idle_bm : omap3_enter_idle;
> +		sprintf(state->name, "C%d", count+1);
> +		count++;
> +	}
> +
> +	if (!count)
> +		return -EINVAL;
> +	dev->state_count =3D count;
> +
> +	if (cpuidle_register_device(dev)) {
> +		printk(KERN_ERR "%s: CPUidle register device failed\n",
> +		       __FUNCTION__);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +__initcall(omap3_idle_init);
> +#endif /* CONFIG_CPU_IDLE */
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h	2008-07-01 11:18=
:53.084916741 +0530
> @@ -0,0 +1,56 @@
> +/*
> + * linux/arch/arm/mach-omap2/cpuidle34xx.h
> + *
> + * OMAP3 cpuidle structure definitions
> + *
> + * Copyright (C) 2007-2008 Texas Instruments, Inc.
> + * Written by Rajendra Nayak <rnayak@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOS=
E.
> + *
> + * History:
> + *
> + */
> +
> +#ifndef ARCH_ARM_MACH_OMAP2_CPUIDLE_34XX
> +#define ARCH_ARM_MACH_OMAP2_CPUIDLE_34XX
> +
> +#define OMAP3_MAX_STATES 7
> +#define OMAP3_STATE_C0 0 /* C0 - System executing code */
> +#define OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core active */
> +#define OMAP3_STATE_C2 2 /* C2 - MPU CSWR + Core active */
> +#define OMAP3_STATE_C3 3 /* C3 - MPU OFF + Core active */
> +#define OMAP3_STATE_C4 4 /* C4 - MPU RET + Core RET */
> +#define OMAP3_STATE_C5 5 /* C5 - MPU OFF + Core RET */
> +#define OMAP3_STATE_C6 6 /* C6 - MPU OFF + Core OFF */
> +
> +/* Currently, we support only upto C2 */
> +#define MAX_SUPPORTED_STATES 3
> +
> +extern void omap_sram_idle(void);
> +extern int omap3_irq_pending(void);
> +extern void per_gpio_clk_enable(void);
> +extern void per_gpio_clk_disable(void);
> +
> +struct omap3_processor_cx {
> +	u8 valid;
> +	u8 type;
> +	u32 sleep_latency;
> +	u32 wakeup_latency;
> +	u32 mpu_state;
> +	u32 core_state;
> +	u32 threshold;
> +	u32 flags;
> +};
> +
> +void omap_init_power_states(void);
> +int omap3_idle_init(void);
> +
> +#endif /* ARCH_ARM_MACH_OMAP2_CPUIDLE_34XX */
> +
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-07-01 11:18=
:50.901988087 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-07-01 11:30:12.2=
40859096 +0530
> @@ -176,7 +176,7 @@ static irqreturn_t prcm_interrupt_handle
>  	return IRQ_HANDLED;
>  }
> =20
> -static void omap_sram_idle(void)
> +void omap_sram_idle(void)
>  {
>  	/* Variable to tell what needs to be saved and restored
>  	 * in omap_sram_idle*/
> @@ -191,6 +191,7 @@ static void omap_sram_idle(void)
> =20
>  	mpu_next_state =3D pwrdm_read_next_pwrst(mpu_pwrdm);
>  	switch (mpu_next_state) {
> +	case PWRDM_POWER_ON:
>  	case PWRDM_POWER_RET:
>  		/* No need to save context */
>  		save_state =3D 0;
> @@ -623,7 +624,9 @@ int __init omap3_pm_init(void)
> =20
>  	suspend_set_ops(&omap_pm_ops);
> =20
> +#ifndef CONFIG_CPU_IDLE
>  	pm_idle =3D omap3_pm_idle;
> +#endif
> =20
>  	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
>  	 * handles fcks correctly */
> Index: linux-omap-2.6/arch/arm/mach-omap2/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/Makefile	2008-07-01 11:18=
:50.901988087 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/Makefile	2008-07-01 11:18:53.0=
84916741 +0530
> @@ -20,7 +20,7 @@ obj-y					+=3D pm.o
>  obj-$(CONFIG_ARCH_OMAP2)		+=3D pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2420)		+=3D sleep242x.o
>  obj-$(CONFIG_ARCH_OMAP2430)		+=3D sleep243x.o
> -obj-$(CONFIG_ARCH_OMAP3)		+=3D pm34xx.o sleep34xx.o
> +obj-$(CONFIG_ARCH_OMAP3)		+=3D pm34xx.o sleep34xx.o cpuidle34xx.o
>  obj-$(CONFIG_PM_DEBUG)			+=3D pm-debug.o
>  endif
> =20
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
