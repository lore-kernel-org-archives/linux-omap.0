From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 3/8] OMAP2+: cpufreq: use opp/clk_*cpufreq_table based on silicon
Date: Thu, 26 May 2011 10:38:56 -0700
Message-ID: <87pqn5e4zz.fsf@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
	<1306366733-8439-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:37279 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758005Ab1EZRjC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 13:39:02 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so444139pzk.30
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 10:38:58 -0700 (PDT)
In-Reply-To: <1306366733-8439-4-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 25 May 2011 16:38:48 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> OMAP2 is the only family using clk_[init|exit]_cpufreq_table, while
> OMAP3+ use OPP table to generate and release the cpufreq tables.
>
> Hence use a flag to mark which API to use for allocating and freeing
> the tables.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

I'd prefer to see this even cleaner by dropping the clk_* versions all
together.  Then, for those who want OMAP2 support (currently not working
or validated anyways), all that's needed is to add a function simlilar
to clk_init_cpufreq_table() which registers OPPs.

Kevin

> ---
>  arch/arm/mach-omap2/omap2plus-cpufreq.c |   20 +++++++++++++++-----
>  1 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 2d4e9d7..dbbf8b2 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -44,6 +44,7 @@ static struct cpufreq_frequency_table *freq_table;
>  static struct clk *mpu_clk;
>  static char *mpu_clk_name;
>  static struct device *mpu_dev;
> +static bool use_opp;
>  
>  static int omap_verify_speed(struct cpufreq_policy *policy)
>  {
> @@ -166,7 +167,10 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  		return -EINVAL;
>  
>  	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
> -	opp_init_cpufreq_table(mpu_dev, &freq_table);
> +	if (use_opp)
> +		opp_init_cpufreq_table(mpu_dev, &freq_table);
> +	else
> +		clk_init_cpufreq_table(&freq_table);
>  
>  	if (freq_table) {
>  		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
> @@ -204,7 +208,10 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  
>  static int omap_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	clk_exit_cpufreq_table(&freq_table);
> +	if (use_opp)
> +		opp_free_cpufreq_table(mpu_dev, &freq_table);
> +	else
> +		clk_exit_cpufreq_table(&freq_table);
>  	clk_put(mpu_clk);
>  	return 0;
>  }
> @@ -227,12 +234,15 @@ static struct cpufreq_driver omap_driver = {
>  
>  static int __init omap_cpufreq_init(void)
>  {
> -	if (cpu_is_omap24xx())
> +	use_opp = true;
> +	if (cpu_is_omap24xx()) {
>  		mpu_clk_name = "virt_prcm_set";
> -	else if (cpu_is_omap34xx())
> +		use_opp = false;
> +	} else if (cpu_is_omap34xx()) {
>  		mpu_clk_name = "dpll1_ck";
> -	else if (cpu_is_omap44xx())
> +	} else if (cpu_is_omap44xx()) {
>  		mpu_clk_name = "dpll_mpu_ck";
> +	}
>  
>  	if (!mpu_clk_name) {
>  		pr_err("%s: unsupported Silicon?\n", __func__);
