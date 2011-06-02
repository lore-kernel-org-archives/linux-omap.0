From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH v4 2/4] OMAP2+: cpufreq: use OPP library
Date: Thu, 02 Jun 2011 15:10:13 -0700
Message-ID: <87tyc7rika.fsf@ti.com>
References: <1306463960-27340-1-git-send-email-nm@ti.com>
	<1306463960-27340-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47513 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754880Ab1FBWKR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 18:10:17 -0400
Received: by mail-pv0-f178.google.com with SMTP id 7so599575pvg.9
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 15:10:16 -0700 (PDT)
In-Reply-To: <1306463960-27340-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 26 May 2011 19:39:18 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> OMAP2 is the only family using clk_[init|exit]_cpufreq_table, however,
> the cpufreq code has does not use clk_init_cpufreq_table. As a result,
> it is unusuable for OMAP2 and only usable only on platforms using OPP
> library.
>
> So move the compilation for cpufreq only if OPP is available for the
> architecture and deny OMAP2 in multi-OMAP builds until OMAP2 is fixed.

Let's not prevent the build, just print a failure warning when the
freq_table is empty because there were no OPPs found.  We need this also
for any new platforms that are added but don't yet have OPPs available.

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile            |    4 ++--
>  arch/arm/mach-omap2/omap2plus-cpufreq.c |   12 +++++++-----
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index dcf5200..70c9fc7 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -54,10 +54,10 @@ ifeq ($(CONFIG_PM_OPP),y)
>  obj-y					+= opp.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
> -endif
> -
>  # CPUFREQ driver
>  obj-$(CONFIG_CPU_FREQ)			+= omap2plus-cpufreq.o
> +endif
> +
>  
>  # Power Management
>  ifeq ($(CONFIG_PM),y)
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index acf18e8..e10fcf8 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -1,7 +1,7 @@
>  /*
>   *  OMAP2PLUS cpufreq driver
>   *
> - *  CPU frequency scaling for OMAP
> + *  CPU frequency scaling for OMAP using OPP information
>   *
>   *  Copyright (C) 2005 Nokia Corporation
>   *  Written by Tony Lindgren <tony@atomide.com>
> @@ -203,7 +203,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  
>  static int omap_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	clk_exit_cpufreq_table(&freq_table);
>  	clk_put(mpu_clk);
>  	return 0;
>  }
> @@ -226,12 +225,15 @@ static struct cpufreq_driver omap_driver = {
>  
>  static int __init omap_cpufreq_init(void)
>  {
> -	if (cpu_is_omap24xx())
> +	if (cpu_is_omap24xx()) {
>  		mpu_clk_name = "virt_prcm_set";
> -	else if (cpu_is_omap34xx())
> +		pr_warning("%s: omap2 cpufreq needs fixing\n", __func__);

Rather than the warning here, just have it fail with a warning when/if
the freq_table creation fails because of no OPPs.

Kevin

> +		return -EINVAL;
> +	} else if (cpu_is_omap34xx()) {
>  		mpu_clk_name = "dpll1_ck";
> -	else if (cpu_is_omap44xx())
> +	} else if (cpu_is_omap44xx()) {
>  		mpu_clk_name = "dpll_mpu_ck";
> +	}
>  
>  	if (!mpu_clk_name) {
>  		pr_err("%s: unsupported Silicon?\n", __func__);
