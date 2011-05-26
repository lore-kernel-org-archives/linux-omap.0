From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 5/8] OMAP2+: cpufreq: fix invalid
 cpufreq table with central alloc/free
Date: Wed, 25 May 2011 18:09:04 -0700
Message-ID: <20110526010904.GB21212@google.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
 <1306366733-8439-6-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:17643 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab1EZBJL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 May 2011 21:09:11 -0400
Content-Disposition: inline
In-Reply-To: <1306366733-8439-6-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@ti.com>

On Wed, May 25, 2011 at 04:38:50PM -0700, Nishanth Menon wrote:
> By creating freq_table_[alloc|free] we can handle the differences
> between OMAP2 and OMAP3+ systems and we have a centralized allocation
> and cleanup strategy. We use this to cleanup the freq_table when
> cpufreq_frequency_table_cpuinfo fails.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
...
>  static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int result = 0;
> @@ -167,21 +187,22 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  		return -EINVAL;
>  
>  	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
> -	if (use_opp)
> -		opp_init_cpufreq_table(mpu_dev, &freq_table);
> -	else
> -		clk_init_cpufreq_table(&freq_table);
>  
> -	if (!freq_table) {
> -		dev_err(mpu_dev, "%s: cpu%d: unable to allocate freq table\n",
> -				__func__, policy->cpu);
> -		return -ENOMEM;
> +	result = freq_table_alloc();
> +	if (result || !freq_table) {
> +		dev_err(mpu_dev, "%s: cpu%d: unable to get freq table [%d]\n",
> +			__func__, policy->cpu, result);
> +		return result;

The "|| !freq_table" isn't needed, and technically allows the code to
return zero for an error return if the subexpression does evaluate
true.


Todd
