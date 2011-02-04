From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS support
Date: Fri, 04 Feb 2011 08:09:22 -0800
Message-ID: <87pqr7srwt.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-9-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40920 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753107Ab1BDQJ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 11:09:26 -0500
Received: by mail-gw0-f45.google.com with SMTP id a12so1192319gwa.18
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 08:09:25 -0800 (PST)
In-Reply-To: <1295618465-15234-9-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 21 Jan 2011 19:31:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> Changes in the omap cpufreq driver for DVFS support.

Missing descriptive changelog.

Should describe what, why, etc.

Kevin

> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/cpu-omap.c |   35 ++++++++++++++++++++++++++++++++---
>  1 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index 1c1b80b..d965220 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -30,10 +30,12 @@
>  #include <mach/hardware.h>
>  #include <plat/clock.h>
>  #include <asm/system.h>
> +#include <asm/cpu.h>
>  
>  #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
>  #include <plat/omap-pm.h>
>  #include <plat/common.h>
> +#include <plat/dvfs.h>
>  #endif
>  
>  #define VERY_HI_RATE	900000000
> @@ -85,11 +87,11 @@ static int omap_target(struct cpufreq_policy *policy,
>  		       unsigned int target_freq,
>  		       unsigned int relation)
>  {
> -#ifdef CONFIG_ARCH_OMAP1
>  	struct cpufreq_freqs freqs;
> -#endif
>  #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
>  	unsigned long freq;
> +	int i;
> +	struct cpufreq_freqs freqs_notify;
>  	struct device *mpu_dev = omap2_get_mpuss_device();
>  #endif
>  	int ret = 0;
> @@ -116,9 +118,36 @@ static int omap_target(struct cpufreq_policy *policy,
>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>  	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>  #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
> +	freqs.old = omap_getspeed(policy->cpu);;
> +	freqs_notify.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
> +	freqs.cpu = policy->cpu;
> +
> +	if (freqs.old == freqs.new)
> +		return ret;
> +
> +	/* pre notifiers */
> +	for_each_cpu(i, policy->cpus) {
> +		freqs.cpu = i;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +	}
> +
> +	/* scale the frequency */
>  	freq = target_freq * 1000;
>  	if (opp_find_freq_ceil(mpu_dev, &freq))
> -		omap_pm_cpu_set_freq(freq);
> +		omap_device_scale(mpu_dev, mpu_dev, freq);
> +
> +	/* Update loops per jiffy */
> +	freqs.new = omap_getspeed(policy->cpu);
> +	for_each_cpu(i, policy->cpus)
> +		per_cpu(cpu_data, i).loops_per_jiffy =
> +		cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
> +				freqs.old, freqs.new);
> +
> +	/* post notifiers */
> +	for_each_cpu(i, policy->cpus) {
> +		freqs.cpu = i;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +	}
>  #endif
>  	return ret;
>  }
