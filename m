From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/3] omap2plus: cpufreq: Add SMP support to cater OMAP4430
Date: Thu, 10 Mar 2011 14:27:48 -0800
Message-ID: <87pqpyhaqj.fsf@ti.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
	<1298614239-32196-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54154 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751158Ab1CJW1w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 17:27:52 -0500
Received: by pzk2 with SMTP id 2so147364pzk.9
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 14:27:51 -0800 (PST)
In-Reply-To: <1298614239-32196-4-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 25 Feb 2011 11:40:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, vishwanath.bs@ti.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On OMAP SMP configuartion, both processors share the voltage
> and clock. So both CPUs needs to be scaled together and hence
> needs software co-ordination.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> cc: Vishwanath BS <vishwanath.bs@ti.com>

[...]

> @@ -74,9 +76,13 @@ static int omap_target(struct cpufreq_policy *policy,
>  		       unsigned int target_freq,
>  		       unsigned int relation)
>  {
> -	int ret = 0;
> +	int i, ret = 0;
>  	struct cpufreq_freqs freqs;
>  
> +	/* Wait untill all CPU's are initialized */
> +	if (is_smp() && (num_online_cpus() < NR_CPUS))
> +		return ret;
> +

Minor: the 'Wait' in the comment is a bit misleading.  It should
rather say something like "Changes not allowed until all CPUs are online"

Kevin
