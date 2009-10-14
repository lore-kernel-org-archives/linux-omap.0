From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: Export functions from OMAP NOOP PM interface
Date: Wed, 14 Oct 2009 15:16:47 -0700
Message-ID: <87tyy1ei40.fsf@deeprootsystems.com>
References: <1253634858-7883-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:33458 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759548AbZJNWR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 18:17:26 -0400
Received: by pwj1 with SMTP id 1so102094pwj.21
        for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 15:16:50 -0700 (PDT)
In-Reply-To: <1253634858-7883-1-git-send-email-ameya.palande@nokia.com> (Ameya Palande's message of "Tue\, 22 Sep 2009 18\:54\:18 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Ameya Palande <ameya.palande@nokia.com> writes:

> Without this patch, a driver which uses these symbols will break when user
> selects NOOP PM interface.
>
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>

I initially pulled this into the PM branch but will now be dropping
it.

Drivers should not be calling these functions directly, but rather using
hooks in pdata as described in Documentation/arm/OMAP/omap_pm.

Kevin

> ---
>  arch/arm/plat-omap/omap-pm-noop.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
> index 3b075de..10463a4 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -157,6 +157,7 @@ const struct omap_opp *omap_pm_dsp_get_opp_table(void)
>  
>  	return NULL;
>  }
> +EXPORT_SYMBOL(omap_pm_dsp_get_opp_table);
>  
>  void omap_pm_dsp_set_min_opp(u8 opp_id)
>  {
> @@ -181,7 +182,7 @@ void omap_pm_dsp_set_min_opp(u8 opp_id)
>  	 *
>  	 */
>  }
> -
> +EXPORT_SYMBOL(omap_pm_dsp_set_min_opp);
>  
>  u8 omap_pm_dsp_get_opp(void)
>  {
> @@ -197,6 +198,7 @@ u8 omap_pm_dsp_get_opp(void)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(omap_pm_dsp_get_opp);
>  
>  u8 omap_pm_vdd1_get_opp(void)
>  {
> @@ -208,6 +210,7 @@ u8 omap_pm_vdd1_get_opp(void)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(omap_pm_vdd1_get_opp);
>  
>  u8 omap_pm_vdd2_get_opp(void)
>  {
> @@ -219,6 +222,7 @@ u8 omap_pm_vdd2_get_opp(void)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(omap_pm_vdd2_get_opp);
>  
>  /*
>   * CPUFreq-originated constraint
> @@ -259,6 +263,7 @@ void omap_pm_cpu_set_freq(unsigned long f)
>  	 * CDP should just be able to set the VDD1 OPP clock rate here.
>  	 */
>  }
> +EXPORT_SYMBOL(omap_pm_cpu_set_freq);
>  
>  unsigned long omap_pm_cpu_get_freq(void)
>  {
> @@ -270,6 +275,7 @@ unsigned long omap_pm_cpu_get_freq(void)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(omap_pm_cpu_get_freq);
>  
>  /*
>   * Device context loss tracking
> -- 
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
