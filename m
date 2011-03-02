From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 13/17] omap4: cpuidle: Basic CPUidle support
Date: Wed, 02 Mar 2011 14:55:03 -0800
Message-ID: <874o7l2kvs.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-14-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56545 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756065Ab1CBWzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 17:55:14 -0500
Received: by mail-yx0-f176.google.com with SMTP id 5so168797yxd.21
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 14:55:13 -0800 (PST)
In-Reply-To: <1298112158-28469-14-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:34 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> The patch adds a basic CPUidle driver for OMAP4. Just
> one C state is registered for both CPU cores which
> does a wfi.

s/wfi/WFI/

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Mostly minor nits below...

> ---
>  arch/arm/mach-omap2/Makefile      |    3 +-
>  arch/arm/mach-omap2/cpuidle44xx.c |  165 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h          |    1 +
>  arch/arm/mach-omap2/pm44xx.c      |    2 +
>  4 files changed, 170 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 5d94f7e..2b4fe44 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -64,7 +64,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o voltage.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
>  					   cpuidle34xx.o pm_bus.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o pm_bus.o \
> -					   omap4-mpuss-lowpower.o sleep44xx.o
> +					   omap4-mpuss-lowpower.o sleep44xx.o \
> +					   cpuidle44xx.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> new file mode 100644
> index 0000000..6c3c69d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -0,0 +1,165 @@
> +/*
> + * OMAP4 CPU IDLE Routines

s/IDLE/idle/

> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + * Rajendra Nayak <rnayak@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/cpuidle.h>
> +
> +#include <asm/proc-fns.h>
> +
> +#include <mach/omap4-common.h>
> +
> +#include "pm.h"
> +
> +#ifdef CONFIG_CPU_IDLE
> +
> +#define OMAP4_MAX_STATES	1
> +/* C1 - CPUx wfi + MPU inactive + CORE inactive */

s/wfi/WFI/

> +#define OMAP4_STATE_C1		0
> +
> +struct omap4_processor_cx {
> +	u8 valid;
> +	u8 type;
> +	u32 sleep_latency;
> +	u32 wakeup_latency;
> +	u32 cpu0_state;
> +	u32 cpu1_state;
> +	u32 mpu_state;
> +	u32 core_state;
> +	u32 threshold;
> +	u32 flags;
> +};
> +
> +struct omap4_processor_cx omap4_power_states[OMAP4_MAX_STATES];
> +struct omap4_processor_cx current_cx_state;
> +
> +static struct cpuidle_params cpuidle_params_table[] = {
> +	/* C1 */
> +	{1, 2, 2, 5},
> +};
> +
> +/**
> + * omap4_enter_idle - Programs OMAP4 to enter the specified state
> + * @dev: cpuidle device
> + * @state: The target state to be programmed
> + *
> + * Called from the CPUidle framework to program the device to the
> + * specified low power state selected by the governor.
> + * Returns the amount of time spent in the low power state.
> + */
> +static int omap4_enter_idle(struct cpuidle_device *dev,
> +			struct cpuidle_state *state)
> +{
> +	struct timespec ts_preidle, ts_postidle, ts_idle;
> +
> +	/* Used to keep track of the total time in idle */
> +	getnstimeofday(&ts_preidle);
> +
> +	local_irq_disable();
> +	local_fiq_disable();
> +
> +	cpu_do_idle();
> +
> +	getnstimeofday(&ts_postidle);
> +	ts_idle = timespec_sub(ts_postidle, ts_preidle);
> +
> +	local_irq_enable();
> +	local_fiq_enable();
> +
> +	return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
> +}
> +
> +DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
> +
> +/**
> + * omap4_init_power_states - Initialises the OMAP4 specific C states.
> + *
> + * Below is the desciption of each C state.
> + * C1 : CPUx wfi + MPU inative + Core inactive
> + */
> +void omap_init_power_states(void)
> +{
> +	/* C1 . CPUx wfi + MPU inactive + Core inactive */
> +	omap4_power_states[OMAP4_STATE_C1].valid =
> +			cpuidle_params_table[OMAP4_STATE_C1].valid;
> +	omap4_power_states[OMAP4_STATE_C1].type = OMAP4_STATE_C1;
> +	omap4_power_states[OMAP4_STATE_C1].sleep_latency =
> +			cpuidle_params_table[OMAP4_STATE_C1].sleep_latency;
> +	omap4_power_states[OMAP4_STATE_C1].wakeup_latency =
> +			cpuidle_params_table[OMAP4_STATE_C1].wake_latency;
> +	omap4_power_states[OMAP4_STATE_C1].threshold =
> +			cpuidle_params_table[OMAP4_STATE_C1].threshold;
> +	omap4_power_states[OMAP4_STATE_C1].mpu_state = PWRDM_POWER_ON;
> +	omap4_power_states[OMAP4_STATE_C1].core_state = PWRDM_POWER_ON;
> +	omap4_power_states[OMAP4_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
> +
> +}
> +
> +struct cpuidle_driver omap4_idle_driver = {
> +	.name =		"omap4_idle",
> +	.owner =	THIS_MODULE,
> +};
> +
> +/**
> + * omap4_idle_init - Init routine for OMAP4 idle
> + *
> + * Registers the OMAP4 specific cpuidle driver with the cpuidle
> + * framework with the valid set of states.
> + */
> +int __init omap4_idle_init(void)
> +{
> +	int cpu_id, i, count = 0;
> +	struct omap4_processor_cx *cx;
> +	struct cpuidle_state *state;
> +	struct cpuidle_device *dev;
> +
> +	omap_init_power_states();
> +	cpuidle_register_driver(&omap4_idle_driver);
> +
> +	for_each_cpu(cpu_id, cpu_online_mask) {
> +		pr_err("CPUidle for CPU%d registered\n", cpu_id);

stray debug print?

> +		dev = &per_cpu(omap4_idle_dev, cpu_id);
> +		dev->cpu = cpu_id;
> +		count = 0;
> +		for (i = OMAP4_STATE_C1; i < OMAP4_MAX_STATES; i++) {
> +			cx = &omap4_power_states[i];
> +			state = &dev->states[count];
> +
> +			if (!cx->valid)
> +				continue;
> +			cpuidle_set_statedata(state, cx);
> +			state->exit_latency = cx->sleep_latency +
> +							cx->wakeup_latency;
> +			state->target_residency = cx->threshold;
> +			state->flags = cx->flags;
> +			state->enter = omap4_enter_idle;
> +			sprintf(state->name, "C%d", count+1);
> +			count++;
> +		}
> +
> +		if (!count)
> +			return -EINVAL;
> +		dev->state_count = count;
> +
> +		if (cpuidle_register_device(dev)) {
> +			pr_err("%s: CPUidle register device failed\n",
> +				__func__);
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +#else
> +int __init omap4_idle_init(void)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_CPU_IDLE */
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index f557407..ce848b0 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -22,6 +22,7 @@ extern void omap_sram_idle(void);
>  extern int omap3_can_sleep(void);
>  extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap3_idle_init(void);
> +extern int omap4_idle_init(void);
>  
>  #if defined(CONFIG_PM_OPP)
>  extern int omap3_opp_init(void);
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 8e57b42..628242d 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -230,6 +230,8 @@ static int __init omap4_pm_init(void)
>  	suspend_set_ops(&omap_pm_ops);
>  #endif /* CONFIG_SUSPEND */
>  
> +	omap4_idle_init();
> +
>  err2:
>  	return ret;
>  }
