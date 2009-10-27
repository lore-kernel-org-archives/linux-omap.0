From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP PM: Remove symbol exports
Date: Tue, 27 Oct 2009 14:04:05 -0700
Message-ID: <873a54a6re.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.0910271348370.10228@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:64677 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbZJ0VED (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 17:04:03 -0400
Received: by pxi10 with SMTP id 10so91699pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2009 14:04:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0910271348370.10228@utopia.booyaka.com> (Paul Walmsley's message of "Tue\, 27 Oct 2009 13\:49\:46 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, ameya.palande@nokia.com

Paul Walmsley <paul@pwsan.com> writes:

> This patch applies against the PM branch.
>
> Commit b32960d2fd88085d6270c4f3a2f708e7ce42cd7b exported many of the
> functions from the OMAP PM layer, presumably to allow device drivers
> to call them directly.  This ties the device drivers to the OMAP
> platform; they will not compile or work on other platforms, e.g.,
> DaVinci.  Device driver code should be platform-independent.  This
> patch removes the EXPORT_SYMBOL() lines.
>
> Rather than relying on exported symbols, device drivers should instead
> pass pointers to these functions via function pointers in struct
> platform_device.platform_data.  Then the device driver code should use
> an idiom similar to:
>
>        if (pdata->function_name)
>               pdata->function_name(arg1, arg2, ...);
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Ameya Palande <ameya.palande@nokia.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, pushing to PM branch.  On the next rebase, I'll just drop the
commit(s) that added the exports.

Kevin

> ---
>  arch/arm/plat-omap/omap-pm-noop.c |    7 -------
>  arch/arm/plat-omap/omap-pm-srf.c  |    7 -------
>  2 files changed, 0 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
> index d3c7279..cab105f 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -157,7 +157,6 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void)
>  
>  	return NULL;
>  }
> -EXPORT_SYMBOL(omap_pm_dsp_get_opp_table);
>  
>  void omap_pm_dsp_set_min_opp(u8 opp_id)
>  {
> @@ -182,7 +181,6 @@ void omap_pm_dsp_set_min_opp(u8 opp_id)
>  	 *
>  	 */
>  }
> -EXPORT_SYMBOL(omap_pm_dsp_set_min_opp);
>  
>  u8 omap_pm_dsp_get_opp(void)
>  {
> @@ -198,7 +196,6 @@ u8 omap_pm_dsp_get_opp(void)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(omap_pm_dsp_get_opp);
>  
>  u8 omap_pm_vdd1_get_opp(void)
>  {
> @@ -210,7 +207,6 @@ u8 omap_pm_vdd1_get_opp(void)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(omap_pm_vdd1_get_opp);
>  
>  u8 omap_pm_vdd2_get_opp(void)
>  {
> @@ -222,7 +218,6 @@ u8 omap_pm_vdd2_get_opp(void)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(omap_pm_vdd2_get_opp);
>  
>  /*
>   * CPUFreq-originated constraint
> @@ -263,7 +258,6 @@ void omap_pm_cpu_set_freq(unsigned long f)
>  	 * CDP should just be able to set the VDD1 OPP clock rate here.
>  	 */
>  }
> -EXPORT_SYMBOL(omap_pm_cpu_set_freq);
>  
>  unsigned long omap_pm_cpu_get_freq(void)
>  {
> @@ -275,7 +269,6 @@ unsigned long omap_pm_cpu_get_freq(void)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(omap_pm_cpu_get_freq);
>  
>  /*
>   * Device context loss tracking
> diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
> index a28945b..d769b90 100644
> --- a/arch/arm/plat-omap/omap-pm-srf.c
> +++ b/arch/arm/plat-omap/omap-pm-srf.c
> @@ -185,7 +185,6 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void)
>  
>  	return NULL;
>  }
> -EXPORT_SYMBOL(omap_pm_dsp_get_opp_table);
>  
>  void omap_pm_dsp_set_min_opp(u8 opp_id)
>  {
> @@ -203,28 +202,24 @@ void omap_pm_dsp_set_min_opp(u8 opp_id)
>  	resource_request("vdd1_opp", &dummy_dsp_dev, opp_id);
>  	return;
>  }
> -EXPORT_SYMBOL(omap_pm_dsp_set_min_opp);
>  
>  u8 omap_pm_dsp_get_opp(void)
>  {
>  	pr_debug("OMAP PM: DSP requests current DSP OPP ID\n");
>  	return resource_get_level("vdd1_opp");
>  }
> -EXPORT_SYMBOL(omap_pm_dsp_get_opp);
>  
>  u8 omap_pm_vdd1_get_opp(void)
>  {
>  	pr_debug("OMAP PM: User requests current VDD1 OPP\n");
>  	return resource_get_level("vdd1_opp");
>  }
> -EXPORT_SYMBOL(omap_pm_vdd1_get_opp);
>  
>  u8 omap_pm_vdd2_get_opp(void)
>  {
>  	pr_debug("OMAP PM: User requests current VDD2 OPP\n");
>  	return resource_get_level("vdd2_opp");
>  }
> -EXPORT_SYMBOL(omap_pm_vdd2_get_opp);
>  
>  /*
>   * CPUFreq-originated constraint
> @@ -261,14 +256,12 @@ void omap_pm_cpu_set_freq(unsigned long f)
>  	resource_request("mpu_freq", &dummy_cpufreq_dev, f);
>  	return;
>  }
> -EXPORT_SYMBOL(omap_pm_cpu_set_freq);
>  
>  unsigned long omap_pm_cpu_get_freq(void)
>  {
>  	pr_debug("OMAP PM: CPUFreq requests current CPU frequency\n");
>  	return resource_get_level("mpu_freq");
>  }
> -EXPORT_SYMBOL(omap_pm_cpu_get_freq);
>  
>  /*
>   * Device context loss tracking
> -- 
> 1.6.5.GIT
