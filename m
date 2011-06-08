From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH pm_wip/cpufreq] OMAP2+: cpufreq: Enable all CPUs in shared
 policy mask
Date: Wed, 08 Jun 2011 11:31:37 +0530
Message-ID: <4DEF1041.9020109@ti.com>
References: <20110607205752.GA11299@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46916 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898Ab1FHGBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 02:01:46 -0400
Received: by mail-yi0-f48.google.com with SMTP id 12so81133yib.21
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 23:01:43 -0700 (PDT)
In-Reply-To: <20110607205752.GA11299@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>, Mike Turquette <mturquette@ti.com>, linux-omap@vger.kernel.org

On 6/8/2011 2:27 AM, Todd Poynor wrote:
> Enable all CPUs in the shared policy in the CPU init callback.
> Otherwise, the governor CPUFREQ_GOV_START event is invoked with
> a policy that only includes the first CPU, leaving other CPUs
> uninitialized by the governor.
>
> Signed-off-by: Todd Poynor<toddpoynor@google.com>

Looks good to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>   arch/arm/mach-omap2/omap2plus-cpufreq.c |    4 +---
>   1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 77efcb0..0fe4edb 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -166,7 +166,6 @@ static inline void freq_table_free(void)
>   static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int result = 0;
> -	static cpumask_var_t cpumask;
>
>   	mpu_clk = clk_get(NULL, mpu_clk_name);
>   	if (IS_ERR(mpu_clk))
> @@ -207,8 +206,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>   	 */
>   	if (is_smp()) {
>   		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> -		cpumask_or(cpumask, cpumask_of(policy->cpu), cpumask);
> -		cpumask_copy(policy->cpus, cpumask);
> +		cpumask_setall(policy->cpus);
>   	}
>
>   	/* FIXME: what's the actual transition time? */

