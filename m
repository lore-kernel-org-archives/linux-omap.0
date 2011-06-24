From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix loops_per_jiffy
	calculation
Date: Fri, 24 Jun 2011 11:43:31 +0100
Message-ID: <20110624104331.GK9449@n2100.arm.linux.org.uk>
References: <1308911742-27394-1-git-send-email-premi@ti.com> <1308911742-27394-3-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54283 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab1FXKnm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 06:43:42 -0400
Content-Disposition: inline
In-Reply-To: <1308911742-27394-3-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jun 24, 2011 at 04:05:42PM +0530, Sanjeev Premi wrote:
> Currently, loops_per_jiffy is being calculated before calling
> cpufreq_notify_transition().
> 
> However, generic cpufreq driver adjusts the jiffies as well.
> Double adjustment leads to incorrect value being assigned to
> loops_per_jiffy.

Are you sure the generic cpufreq driver adjusts the per-cpu loops_per_jiffy
values?  I don't believe it does.

> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index ce9d534..346519e 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -114,29 +114,13 @@ static int omap_target(struct cpufreq_policy *policy,
>  
>  	freqs.new = omap_getspeed(policy->cpu);
>  
> -	/*
> -	 * In the generic cpufreq driver jiffies are updated only for
> -	 * non-SMP cases. Ensure that jiffies are bing updated for both
> -	 * SMP systems and UP systems built with CONFIG_SMP enabled.
> -	 */
> +	/* Notify transitions */
>  	if (is_smp()) {
> -#ifdef CONFIG_SMP
> -		for_each_cpu(i, policy->cpus)
> -			per_cpu(cpu_data, i).loops_per_jiffy =
> -				cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
> -						freqs.old,
> -						freqs.new);
> -#endif
> -		/* Notify transitions */

So this is a NAK.  What's also missing is a scaling of loops_per_jiffy
itself here, because with SMP=y the core won't do this for you.

>  		for_each_cpu(i, policy->cpus) {
>  			freqs.cpu = i;
>  			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>  		}
>  	} else {
> -		loops_per_jiffy = cpufreq_scale(loops_per_jiffy,
> -					freqs.old, freqs.new);
> -
> -		/* Notify transitions */

This is almost right - the core cpufreq code looks after this when
CONFIG_SMP is not selected.  However, if you're running a kernel built
for SMP on UP, then loops_per_jiffy won't be scaled, so something
needs to be done to cover that case.

Note also that you should scale the loops_per_jiffy against a reference
value, otherwise you'll get an increasing error each time you scale.

So, if we want to do this then we need to store the boot-time lpj and
frequency as the baseline reference, and scale according to that,
much like the core cpufreq code does for loops_per_jiffy for the !SMP
case.
