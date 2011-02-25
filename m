From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 3/3] omap2plus: cpufreq: Add SMP support to cater
 OMAP4430
Date: Fri, 25 Feb 2011 13:40:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A095CED@dbde02.ent.ti.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
 <1298614239-32196-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56548 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab1BYIKV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 03:10:21 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1P8AIeG032301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 02:10:20 -0600
In-Reply-To: <1298614239-32196-4-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Friday, February 25, 2011 11:41 AM
> To: linux-omap@vger.kernel.org
> Cc: Hilman, Kevin; Sripathy, Vishwanath; Shilimkar, Santosh
> Subject: [PATCH 3/3] omap2plus: cpufreq: Add SMP support to cater OMAP4430
> 
> On OMAP SMP configuartion, both processors share the voltage
> and clock. So both CPUs needs to be scaled together and hence
> needs software co-ordination.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> cc: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/omap2plus-cpufreq.c |   71
> ++++++++++++++++++++++++++----
>  1 files changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-
> omap2/omap2plus-cpufreq.c
> index 48da867..8c903c1 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -26,9 +26,11 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/opp.h>
> +#include <linux/cpu.h>
> 
>  #include <asm/system.h>
>  #include <asm/smp_plat.h>
> +#include <asm/cpu.h>
> 
>  #include <plat/clock.h>
>  #include <plat/omap-pm.h>
> @@ -63,7 +65,7 @@ static unsigned int omap_getspeed(unsigned int cpu)
>  {
>  	unsigned long rate;
> 
> -	if (cpu)
> +	if (cpu >= NR_CPUS)
>  		return 0;
> 
>  	rate = clk_get_rate(mpu_clk) / 1000;
> @@ -74,9 +76,13 @@ static int omap_target(struct cpufreq_policy *policy,
>  		       unsigned int target_freq,
>  		       unsigned int relation)
>  {
> -	int ret = 0;
> +	int i, ret = 0;
>  	struct cpufreq_freqs freqs;
> 
> +	/* Wait untill all CPU's are initialized */
Typo: until

> +	if (is_smp() && (num_online_cpus() < NR_CPUS))
> +		return ret;
Does it make sense to add pr_info() or pr_warning() before returning?
> +
>  	/* Ensure desired rate is within allowed range.  Some govenors
>  	 * (ondemand) will just pass target_freq=0 to get the minimum. */
>  	if (target_freq < policy->min)
> @@ -84,15 +90,25 @@ static int omap_target(struct cpufreq_policy *policy,
>  	if (target_freq > policy->max)
>  		target_freq = policy->max;
> 
> -	freqs.old = omap_getspeed(0);
> +	freqs.old = omap_getspeed(policy->cpu);
>  	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
> -	freqs.cpu = 0;
> +	freqs.cpu = policy->cpu;
> 
>  	if (freqs.old == freqs.new)
>  		return ret;
> 
> -	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +	if (!is_smp()) {
> +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +		goto set_freq;
> +	}
> +
> +	/* notifiers */
> +	for_each_cpu(i, policy->cpus) {
> +		freqs.cpu = i;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +	}
> 
> +set_freq:
>  #ifdef CONFIG_CPU_FREQ_DEBUG
>  	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old,
> freqs.new);
>  #endif
> @@ -100,6 +116,7 @@ static int omap_target(struct cpufreq_policy *policy,
>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>  	if (ret)
>  		return ret;
> +	freqs.new = omap_getspeed(policy->cpu);
> 
>  	/*
>  	 * Generic CPUFREQ driver jiffy update is under !SMP. So jiffies
> @@ -107,12 +124,32 @@ static int omap_target(struct cpufreq_policy
> *policy,
>  	 * CONFIG_SMP enabled. Below code is added only to manage that
>  	 * scenario
>  	 */
> -	if (!is_smp())
> +	if (!is_smp()) {
>  		loops_per_jiffy =
>  			 cpufreq_scale(loops_per_jiffy, freqs.old, freqs.new);
> +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +		goto skip_lpj;
> +	}
> 
> -	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +#ifdef CONFIG_SMP
> +	/*
> +	 * Note that loops_per_jiffy is not updated on SMP systems in
> +	 * cpufreq driver. So, update the per-CPU loops_per_jiffy value
> +	 * on frequency transition. We need to update all dependent cpus
CPUs.
> +	 */
> +	for_each_cpu(i, policy->cpus)
> +		per_cpu(cpu_data, i).loops_per_jiffy =
> +			cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
> +					freqs.old, freqs.new);
> +#endif
> +
> +	/* notifiers */
> +	for_each_cpu(i, policy->cpus) {
> +		freqs.cpu = i;
> +		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +	}
> 
> +skip_lpj:
>  	return ret;
>  }
> 
> @@ -120,15 +157,16 @@ static int __init omap_cpu_init(struct
> cpufreq_policy *policy)
>  {
>  	int result = 0;
>  	struct device *mpu_dev;
> +	static cpumask_var_t cpumask;
> 
>  	mpu_clk = clk_get(NULL, "cpu_ck");
>  	if (IS_ERR(mpu_clk))
>  		return PTR_ERR(mpu_clk);
> 
> -	if (policy->cpu != 0)
> +	if (policy->cpu >= NR_CPUS)
>  		return -EINVAL;
> 
> -	policy->cur = policy->min = policy->max = omap_getspeed(0);
> +	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
> 
>  	mpu_dev = omap2_get_mpuss_device();
>  	if (!mpu_dev) {
> @@ -150,7 +188,20 @@ static int __init omap_cpu_init(struct cpufreq_policy
> *policy)
> 
>  	policy->min = policy->cpuinfo.min_freq;
>  	policy->max = policy->cpuinfo.max_freq;
> -	policy->cur = omap_getspeed(0);
> +	policy->cur = omap_getspeed(policy->cpu);
> +
> +	/*
> +	 * On OMAP SMP configuartion, both processors share the voltage
> +	 * and clock. So both CPUs needs to be scaled together and hence
> +	 * needs software co-ordination. Use cpufreq affected_cpus
> +	 * interface to handle this scenario. Additional is_smp() check
> +	 * is to keep SMP_ON_UP builf working.
Typo: build
> +	 */
> +	if (is_smp()) {
> +		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> +		cpumask_or(cpumask, cpumask_of(policy->cpu), cpumask);
> +		cpumask_copy(policy->cpus, cpumask);
> +	}
> 
>  	/* FIXME: what's the actual transition time? */
>  	policy->cpuinfo.transition_latency = 300 * 1000;
> --
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
