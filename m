From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 14/17] omap4: cpuidle: Add MPUSS RET OFF states
Date: Wed, 02 Mar 2011 15:32:22 -0800
Message-ID: <87r5apyu7t.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-15-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:34524 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753982Ab1CBXc0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 18:32:26 -0500
Received: by pwi3 with SMTP id 3so159090pwi.37
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 15:32:25 -0800 (PST)
In-Reply-To: <1298112158-28469-15-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This patch adds MPUSS low power states in cpuidle.
>
> 	C1 - CPU0 ON + CPU1 ON/OFF + MPU ON + CORE ON
> 	C2 - CPU0 ON + CPU1 OFF + MPU ON + CORE ON
> 	C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON
> 	C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON
>
> MPU OSWR isn't supported yet. To support OSWR, power domain context
> registers needs to be managed which are not supported yet. A patch
> to address this was submitted but it's not ready for merge yet because
> it was not addressing all OMAP4 power domain context registers.
> More info on this issue:
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38667.html
>
> OMAP4 powerdomain INACTIVE support is also dropped because of inconsistency
> of it with OMAP3. More information  on this thread.
> 	http://www.spinics.net/lists/linux-omap/msg45370.html
>
> CORE low power states and associated latencies will be updated as part
> along with chip retention support.
>
> On OMAP4 because of hardware constraints, no low power states are
> targeted when both CPUs are online and in SMP mode. The low power
> states are attempted only when secondary CPU gets offline to OFF
> through hotplug infrastructure.
>
> Thanks to Nicole Chalhoub <n-chalhoub@ti.com> for doing exhaustive
> C-state latency profiling.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |  190 ++++++++++++++++++++++++++++++++++---
>  1 files changed, 176 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index 6c3c69d..aa1584e 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) 2011 Texas Instruments, Inc.
>   * Rajendra Nayak <rnayak@ti.com>
> + * Santosh Shilimkar <santosh.shilimkar@ti.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -17,12 +18,21 @@
>  #include <mach/omap4-common.h>
>  
>  #include "pm.h"
> +#include "prm.h"
>  
>  #ifdef CONFIG_CPU_IDLE
>  
> -#define OMAP4_MAX_STATES	1
> -/* C1 - CPUx wfi + MPU inactive + CORE inactive */
> +#define CPUIDLE_FLAG_CHECK_BM	0x10000	/* use omap4_enter_idle_bm() */
> +#define OMAP4_MAX_STATES	4
> +
> +/* C1 - CPU0 ON + CPU1 ON/OFF + MPU ON + CORE ON */
>  #define OMAP4_STATE_C1		0
> +/* C2 - CPU0 ON + CPU1 OFF + MPU ON + CORE ON */
> +#define OMAP4_STATE_C2		1
> +/* C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON */
> +#define OMAP4_STATE_C3		2
> +/* C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON */
> +#define OMAP4_STATE_C4		3
>  
>  struct omap4_processor_cx {
>  	u8 valid;
> @@ -32,19 +42,44 @@ struct omap4_processor_cx {
>  	u32 cpu0_state;
>  	u32 cpu1_state;
>  	u32 mpu_state;
> +	u32 mpu_logic_state;
>  	u32 core_state;
> +	u32 core_logic_state;
>  	u32 threshold;
>  	u32 flags;
> +	const char *desc;
>  };
>  
> -struct omap4_processor_cx omap4_power_states[OMAP4_MAX_STATES];
> -struct omap4_processor_cx current_cx_state;
> +static struct omap4_processor_cx omap4_power_states[OMAP4_MAX_STATES];
> +static struct powerdomain *mpu_pd, *cpu1_pd, *core_pd;
>  
> +/*
> + * FIXME: Full latenecy numbers needs to be updated as part of
> + * cpuidle CORE retention support.
> + * Currently only MPUSS latency numbers are added based on
> + * measurements done internally. The numbers for MPUSS are
> + * not board dependent and hence set directly here instead of
> + * passing it from board files.
> + */
>  static struct cpuidle_params cpuidle_params_table[] = {
> -	/* C1 */
> -	{1, 2, 2, 5},
> +	/* C1 - CPU0 WFI + CPU1 ON/OFF + MPU ON   + CORE ON */

Above comments say 'CPU0 ON' intead of WFI.  Make this consistent.

Also, according to the code, CPU1 is always programmed to OFF.
That being the case, what's the difference between C1 and C2?

> +	{1,	2,	2,	5},
> +	/* C2 - CPU0 ON + CPU1 OFF + MPU ON  + CORE ON */
> +	{1,	140,	160,	300},
> +	/* C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON */
> +	{1,	200,	300,	700},
> +	/* C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON */
> +	{1,	1400,	600,	5000},
>  };
>  
> +DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
> +
> +static int omap4_idle_bm_check(void)

The 'bm' terminology here is from legacy x86-based CPUidle code (for
bus-master.)  Let's just call this 'activity' check.

> +{
> +	/* FIXME: Populate this with CORE retention support */
> +	return 0;
> +}

How about just leaving this function out altogether until it's needed.
Also leave out the #define CPUIDLE_FLAG_CHECK_BM for now.

I think we may be able to do OMAP4 a little smarter than we've done
OMAP3 using the ->prepare hook of struct cpuidle_device, and get rid of
this 'bm' check.  More on that below...

>  /**
>   * omap4_enter_idle - Programs OMAP4 to enter the specified state
>   * @dev: cpuidle device
> @@ -57,7 +92,9 @@ static struct cpuidle_params cpuidle_params_table[] = {
>  static int omap4_enter_idle(struct cpuidle_device *dev,
>  			struct cpuidle_state *state)
>  {
> +	struct omap4_processor_cx *cx = cpuidle_get_statedata(state);
>  	struct timespec ts_preidle, ts_postidle, ts_idle;
> +	u32 cpu1_state;
>  
>  	/* Used to keep track of the total time in idle */
>  	getnstimeofday(&ts_preidle);
> @@ -65,28 +102,74 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
>  	local_irq_disable();
>  	local_fiq_disable();
>  
> -	cpu_do_idle();
> +	/*
> +	 * Special hardware/software considerations:
> +	 * 1. Do only WFI for secondary CPU(non-boot - CPU1).
> +	 *    Secondary cores are taken down only via hotplug path.

Then why even create a 'struct cpuidle_device' for the non-boot CPUs?

If you only create a cpuidle_device for the boot CPU, the non-boot CPUs
will just use the default pm_idle which should be WFI only, right?

> +	 * 2. Do only a WFI as long as in SMP mode.
> +	 * 3. Continue to do only WFI till CPU1 hits OFF state.
> +	 *    This is necessary to honour hardware recommondation
> +	 *    of triggeing all the possible low power modes once CPU1 is
> +	 *    out of coherency and in OFF mode.
> +	 * Update dev->last_state so that governor stats reflects right
> +	 * data.
> +	 */
> +	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
> +	if ((dev->cpu) || (num_online_cpus() > 1) ||
> +			(cpu1_state != PWRDM_POWER_OFF)) {
> +		dev->last_state = dev->safe_state;

We currently have 2 existing ways of doing some pre-transition
checking.  

1) through the ->prepare hook of 'struct cpuidle_device'
2) through the existing 'bm_check' mechanism

Here you're adding yet another one, and I don't really like it.

Also, The 'safe state' is C1, but you're not doing the same thing as a
"normal" C1. 

What's wrong with just updating 'cx' and falling through so you actually
do the same thing as the C-state you're reporting.

That being said, I think it might be better to use the ->prepare hook
for this.   Here's what I propose.

By default, all C-states except C1 have the CPUIDLE_FLAG_IGNORE flag set
(meaning they will be ignored by the governor.)  Only on CPU1 hot-unplug
is the ignore flag removed from the other states, and conversly when
CPU1 is hot-plugged, the ignore flag is added back.

Doing this shifts the burden up to the governor and will prevent all of
this logic from happening for every idle transition.

> +		cpu_do_idle();
> +		goto return_sleep_time;
> +	}
>  
> +	pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
> +	omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
> +	pwrdm_set_logic_retst(core_pd, cx->core_logic_state);
> +	omap_set_pwrdm_state(core_pd, cx->core_state);
> +
> +	omap4_enter_lowpower(dev->cpu, cx->cpu0_state);
> +
> +return_sleep_time:
>  	getnstimeofday(&ts_postidle);
>  	ts_idle = timespec_sub(ts_postidle, ts_preidle);
>  
>  	local_irq_enable();
>  	local_fiq_enable();
>  
> +
>  	return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
>  }

[...]

Kevin
