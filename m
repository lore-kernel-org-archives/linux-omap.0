From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/04] Fix cpuidle off-modes to be controlled via sysfs
Date: Wed, 29 Oct 2008 11:13:36 -0700
Message-ID: <871vxz9smn.fsf@deeprootsystems.com>
References: <1225279884-30668-1-git-send-email-tero.kristo@nokia.com>
	<1225279884-30668-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.158]:34790 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbYJ2SNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 14:13:41 -0400
Received: by po-out-1718.google.com with SMTP id y22so5382095pof.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 11:13:40 -0700 (PDT)
In-Reply-To: <1225279884-30668-2-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Wed\, 29 Oct 2008 13\:31\:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   21 ++++++++++++++++++---
>  arch/arm/mach-omap2/pm.c          |    4 ++--
>  2 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 235976e..f97c4d8 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -29,6 +29,8 @@
>  #include <mach/control.h>
>  #include <mach/common.h>
>  
> +#include "pm.h"
> +
>  #ifdef CONFIG_CPU_IDLE
>  
>  #define OMAP3_MAX_STATES 7
> @@ -77,6 +79,8 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  {
>  	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
>  	struct timespec ts_preidle, ts_postidle, ts_idle;
> +	int mpu_next_state;
> +	int core_next_state;
>  
>  	current_cx_state = *cx;
>  
> @@ -89,8 +93,19 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  	local_irq_disable();
>  	local_fiq_disable();
>  
> -	set_pwrdm_state(mpu_pd, cx->mpu_state);
> -	set_pwrdm_state(core_pd, cx->core_state);
> +	/* Dirty hack to enable / disable off-mode dynamically */
> +	mpu_next_state = cx->mpu_state;
> +	core_next_state = cx->core_state;
> +
> +	if (!enable_off_mode) {
> +		if (mpu_next_state == PWRDM_POWER_OFF)
> +			mpu_next_state = PWRDM_POWER_RET;
> +		if (core_next_state == PWRDM_POWER_OFF)
> +			core_next_state = PWRDM_POWER_RET;
> +	}
> +
> +	set_pwrdm_state(mpu_pd, mpu_next_state);
> +	set_pwrdm_state(core_pd, core_next_state);
>  
>  	if (omap_irq_pending())
>  		goto return_sleep_time;
> @@ -195,7 +210,7 @@ void omap_init_power_states(void)
>  				CPUIDLE_FLAG_CHECK_BM;
>  
>  	/* C6 . MPU OFF + Core OFF */
> -	omap3_power_states[OMAP3_STATE_C6].valid = 0;
> +	omap3_power_states[OMAP3_STATE_C6].valid = 1;
>  	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
>  	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 10000;
>  	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 30000;
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 136683b..9dbe7e2 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -87,9 +87,9 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	} else if (attr == &clocks_off_while_idle_attr) {
>  		clocks_off_while_idle = value;
>  	} else if (attr == &enable_off_mode_attr) {
> -		int enable = (value > 0) ? 1 : 0;
> +		enable_off_mode = (value > 0) ? 1 : 0;
>  
> -		omap3_pm_off_mode_enable(enable);
> +		omap3_pm_off_mode_enable(enable_off_mode);
>  	} else if (attr == &voltage_off_while_idle_attr) {
>  		voltage_off_while_idle = value;
>  		if (voltage_off_while_idle)

I already have similar version to this in the staging area for the
next PM branch[1] (which is not quite ready.)

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=shortlog;h=tmp/pm-next

