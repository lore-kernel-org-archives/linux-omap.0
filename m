From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] omap2+: pm: Use if...else instead of goto
Date: Fri, 24 Jun 2011 18:18:19 +0530
Message-ID: <4E048793.1020505@ti.com>
References: <1308911742-27394-1-git-send-email-premi@ti.com> <1308911742-27394-2-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:39482 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094Ab1FXMsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 08:48:23 -0400
Received: by mail-gw0-f47.google.com with SMTP id 11so1155156gwb.6
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 05:48:22 -0700 (PDT)
In-Reply-To: <1308911742-27394-2-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 6/24/2011 4:05 PM, Sanjeev Premi wrote:
> This patch replaces the use of goto with simple
> if...else syntax. No change in functionality.
>
> This also means that the comment describing the
> dependency between CONFIG_SMP and calculation
> of loops_per_jiffy can be unified.
>
> Signed-off-by: Sanjeev Premi<premi@ti.com>
> ---
Don't see need of this patch as well considering your second patch.
So NAK.

>   arch/arm/mach-omap2/omap2plus-cpufreq.c |   59 +++++++++++++-----------------
>   1 files changed, 26 insertions(+), 33 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 1f3b2e1..ce9d534 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -96,57 +96,50 @@ static int omap_target(struct cpufreq_policy *policy,
>   	if (freqs.old == freqs.new&&  policy->cur == freqs.new)
>   		return ret;
>
> -	if (!is_smp()) {
> -		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> -		goto set_freq;
> -	}
> -
> -	/* notifiers */
> -	for_each_cpu(i, policy->cpus) {
> -		freqs.cpu = i;
> +	/* Notify transitions */
> +	if (is_smp()) {
> +		for_each_cpu(i, policy->cpus) {
> +			freqs.cpu = i;
> +			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +		}
> +	} else {
>   		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>   	}
>
> -set_freq:
>   #ifdef CONFIG_CPU_FREQ_DEBUG
>   	pr_info("cpufreq-omap: transition: %u -->  %u\n", freqs.old, freqs.new);
>   #endif
>
>   	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>
> -	/*
> -	 * Generic CPUFREQ driver jiffy update is under !SMP. So jiffies
> -	 * won't get updated when UP machine cpufreq build with
> -	 * CONFIG_SMP enabled. Below code is added only to manage that
> -	 * scenario
> -	 */
>   	freqs.new = omap_getspeed(policy->cpu);
> -	if (!is_smp()) {
> -		loops_per_jiffy =
> -			 cpufreq_scale(loops_per_jiffy, freqs.old, freqs.new);
> -		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> -		goto skip_lpj;
> -	}
>
> -#ifdef CONFIG_SMP
>   	/*
> -	 * Note that loops_per_jiffy is not updated on SMP systems in
> -	 * cpufreq driver. So, update the per-CPU loops_per_jiffy value
> -	 * on frequency transition. We need to update all dependent CPUs.
> +	 * In the generic cpufreq driver jiffies are updated only for
> +	 * non-SMP cases. Ensure that jiffies are bing updated for both
> +	 * SMP systems and UP systems built with CONFIG_SMP enabled.
>   	 */
> -	for_each_cpu(i, policy->cpus)
> -		per_cpu(cpu_data, i).loops_per_jiffy =
> -			cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
> -					freqs.old, freqs.new);
> +	if (is_smp()) {
> +#ifdef CONFIG_SMP
> +		for_each_cpu(i, policy->cpus)
> +			per_cpu(cpu_data, i).loops_per_jiffy =
> +				cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
> +						freqs.old,
> +						freqs.new);
>   #endif
> +		/* Notify transitions */
> +		for_each_cpu(i, policy->cpus) {
> +			freqs.cpu = i;
> +			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +		}
> +	} else {
> +		loops_per_jiffy = cpufreq_scale(loops_per_jiffy,
> +					freqs.old, freqs.new);
>
> -	/* notifiers */
> -	for_each_cpu(i, policy->cpus) {
> -		freqs.cpu = i;
> +		/* Notify transitions */
>   		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>   	}
>
> -skip_lpj:
>   	return ret;
>   }
>

