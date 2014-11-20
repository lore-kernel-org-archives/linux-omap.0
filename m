From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH] ARM: DRA: hwmod: RTC: Add reset function for RTC
Date: Thu, 20 Nov 2014 15:02:03 +0530
Message-ID: <546DB513.6000104@ti.com>
References: <1416199402-3865-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39792 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756576AbaKTJdo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2014 04:33:44 -0500
In-Reply-To: <1416199402-3865-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com

Hi Paul,
On Monday 17 November 2014 10:13 AM, Lokesh Vutla wrote:
> RTC IP have kicker feature which prevents spurious writes to its registers.
> In order to write into any of the RTC registers, KICK values has te be
> written to KICK registers. Currently hwmod is updating the IDLEMODE in rtc
> sysconfig register without writing into any kick register which is a noop.
> When autoidle is allowed for rtc, interruts are not received until IDLEMODE
> is set to SIDLE_SMART_WKUP.
> Adding a reset function to unlock RTC registers so that IDLEMODE is
> updated.
Ping..!!
Is this patch acceptable?

Thanks and regards,
Lokesh
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.h          |  1 +
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  1 +
>  arch/arm/mach-omap2/omap_hwmod_reset.c    | 23 +++++++++++++++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
> index 512f809..3703f99 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.h
> +++ b/arch/arm/mach-omap2/omap_hwmod.h
> @@ -744,6 +744,7 @@ const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
>   */
>  
>  extern int omap_hwmod_aess_preprogram(struct omap_hwmod *oh);
> +int omap_hwmod_rtc_unlock(struct omap_hwmod *oh);
>  
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be converted
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 5684f11..90e1df4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1584,6 +1584,7 @@ static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
>  static struct omap_hwmod_class dra7xx_rtcss_hwmod_class = {
>  	.name	= "rtcss",
>  	.sysc	= &dra7xx_rtcss_sysc,
> +	.reset	= &omap_hwmod_rtc_unlock,
>  };
>  
>  /* rtcss */
> diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2/omap_hwmod_reset.c
> index 65e186c..b825a28 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_reset.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
> @@ -30,6 +30,12 @@
>  
>  #include "omap_hwmod.h"
>  
> +#define RTC_KICK0_REG_OFFSET	0x6c
> +#define RTC_KICK1_REG_OFFSET	0x70
> +
> +#define RTC_KICK0_VALUE		0x83E70B13
> +#define RTC_KICK1_VALUE		0x95A4F1E0
> +
>  /**
>   * omap_hwmod_aess_preprogram - enable AESS internal autogating
>   * @oh: struct omap_hwmod *
> @@ -51,3 +57,20 @@ int omap_hwmod_aess_preprogram(struct omap_hwmod *oh)
>  
>  	return 0;
>  }
> +
> +/**
> + * omap_hwmod_rtc_unlock - Reset and unlock the Kicker mechanism.
> + * @oh: struct omap_hwmod *
> + *
> + * RTC IP have kicker feature.  This prevents spurious writes to its registers.
> + * In order to write into any of the RTC registers, KICK values has te be
> + * written in respective KICK registers. This is needed for hwmod to write into
> + * sysconfig register.
> + */
> +int omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
> +{
> +	omap_hwmod_write(RTC_KICK0_VALUE, oh, RTC_KICK0_REG_OFFSET);
> +	omap_hwmod_write(RTC_KICK1_VALUE, oh, RTC_KICK1_REG_OFFSET);
> +
> +	return 0;
> +}
> 

