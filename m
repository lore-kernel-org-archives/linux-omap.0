From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 4/8] OMAP2+: cpufreq: dont support
 !freq_table
Date: Wed, 25 May 2011 17:51:05 -0700
Message-ID: <20110526005105.GA21212@google.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
 <1306366733-8439-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:30354 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab1EZAvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 May 2011 20:51:21 -0400
Content-Disposition: inline
In-Reply-To: <1306366733-8439-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@ti.com>

On Wed, May 25, 2011 at 04:38:49PM -0700, Nishanth Menon wrote:
> OMAP2+ all have frequency tables, hence the hacks we had for older
> silicon do not need to be carried forward. As part of this change,
> use cpufreq_frequency_table_target to find the best match for
> frequency requested.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
...
> @@ -79,22 +66,35 @@ static int omap_target(struct cpufreq_policy *policy,
>  		       unsigned int target_freq,
>  		       unsigned int relation)
>  {
> -	int i, ret = 0;
> +	unsigned int i;
> +	int ret = 0;
>  	struct cpufreq_freqs freqs;
>  
>  	/* Changes not allowed until all CPUs are online */
>  	if (is_smp() && (num_online_cpus() < NR_CPUS))
>  		return ret;
>  
> -	/* Ensure desired rate is within allowed range.  Some govenors
> -	 * (ondemand) will just pass target_freq=0 to get the minimum. */
> -	if (target_freq < policy->min)
> -		target_freq = policy->min;
> -	if (target_freq > policy->max)
> -		target_freq = policy->max;
> +	if (!freq_table) {
> +		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
> +				policy->cpu);

Just a minor comment: suggest dev_dbg() or WARN_ONCE() for some of
these conditions that may be frequently evaluated and probably won't
be cleared up after being hit once.

...

Todd
