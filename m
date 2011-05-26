From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 6/8] OMAP2+: cpufreq: fix freq_table
 leak
Date: Wed, 25 May 2011 18:25:08 -0700
Message-ID: <20110526012508.GC21212@google.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
 <1306366733-8439-7-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:26439 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab1EZBZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 May 2011 21:25:12 -0400
Content-Disposition: inline
In-Reply-To: <1306366733-8439-7-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@ti.com>

On Wed, May 25, 2011 at 04:38:51PM -0700, Nishanth Menon wrote:
> Since we have multiple CPUs, the cpuinit call for CPU1 causes
> freq_table of CPU0 to be overwritten. Instead, we maintain
> a counter to keep track of cpus who use the cpufreq table
> allocate it once(one freq table for all CPUs) and free them
> once the last user is done with it. We also need to protect
> freq_table and this new counter from updates from multiple
> contexts to be on a safe side.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
...
>  static int freq_table_alloc(void)
>  {
> -	if (use_opp)
> -		return opp_init_cpufreq_table(mpu_dev, &freq_table);
> +	int ret = 0;
>  
> -	clk_init_cpufreq_table(&freq_table);
> -	if (!freq_table)
> -		return -ENOMEM;
> +	mutex_lock(&freq_table_lock);
>  
> -	return 0;
> +	freq_table_users++;
> +	/* Did we allocate previously? */
> +	if (freq_table_users - 1)
> +		goto out;
> +
> +	/* no, so we allocate */
> +	if (use_opp) {
> +		ret = opp_init_cpufreq_table(mpu_dev, &freq_table);
> +	} else {
> +		clk_init_cpufreq_table(&freq_table);
> +		if (!freq_table)
> +			ret = -ENOMEM;
> +	}
> +	/* if we did not allocate cleanly.. reduce user count */
> +	if (!ret)
> +		freq_table_users--;

"if (ret)" intended?  ret == 0 means allocated OK.


Todd
