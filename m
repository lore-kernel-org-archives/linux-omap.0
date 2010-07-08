From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/5] omap: Implement common omap_has_feature
Date: Thu, 8 Jul 2010 09:52:32 -0500
Message-ID: <4C35E630.4070204@ti.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com> <20100708093755.16352.75290.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37760 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071Ab0GHOwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 10:52:35 -0400
In-Reply-To: <20100708093755.16352.75290.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren had written, on 07/08/2010 04:37 AM, the following:
> Implement common omap_has_feature.
> 
> Intended to replace omap3_has_ functions
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/id.c              |   32 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/common.c           |   15 +++++++++++++++
>  arch/arm/plat-omap/include/plat/cpu.h |    3 +++
>  3 files changed, 50 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index fd1904b..a2e5965 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -29,7 +29,9 @@
>  
>  static struct omap_chip_id omap_chip;
>  static unsigned int omap_revision;
> +static u32 omap_features;
>  
> +/* REVISIT: Get rid of omap3_features */
>  u32 omap3_features;
>  
>  unsigned int omap_rev(void)
> @@ -112,6 +114,12 @@ void omap_get_die_id(struct omap_die_id *odi)
>  	odi->id_3 = read_tap_reg(OMAP_TAP_DIE_ID_3);
>  }
>  
> +u32 omap2_has_feature(u32 feat_mask)
> +{
> +	/* REVISIT: Add necessary omap2 feature tests here */
> +	return ((feat_mask & omap_features) == feat_mask);
> +}
> +
I did consider this path initially,
a) Additional functional call overhead here. some of the calls to 
has_feature() will get called through pretty active paths, we would like 
it to be minimized to compile time optimized inline function as much as 
possible.(no reason why this cant me a inline macro in cpu.h?) -
the original series received a similar comment:
http://marc.info/?l=linux-omap&m=125018002127428&w=2

>  static void __init omap24xx_check_revision(void)
>  {
>  	int i, j;
> @@ -164,6 +172,15 @@ static void __init omap24xx_check_revision(void)
>  	if ((omap_rev() >> 8) & 0x0f)
>  		pr_info("ES%x", (omap_rev() >> 12) & 0xf);
>  	pr_info("\n");
> +
> +	omap_features = 0;
> +	omap_init_features(omap2_has_feature);
> +}
> +
> +u32 omap3_has_feature(u32 feat_mask)
> +{
> +	/* REVISIT: Add necessary omap3 feature tests here */
> +	return ((feat_mask & omap_features) == feat_mask);
>  }
>  
>  #define OMAP3_CHECK_FEATURE(status,feat)				\
> @@ -194,6 +211,11 @@ static void __init omap3_check_features(void)
>  	 * TODO: Get additional info (where applicable)
>  	 *       e.g. Size of L2 cache.
>  	 */
> +
> +	/* REVISIT: Get rid of omap3_features */
> +	omap_features = omap3_features;
> +
> +	omap_init_features(omap3_has_feature);
>  }
>  
>  static void __init omap3_check_revision(void)
> @@ -277,6 +299,12 @@ static void __init omap3_check_revision(void)
>  	}
>  }
>  
> +u32 omap4_has_feature(u32 feat_mask)
> +{
> +	/* REVISIT: Add necessary omap4 feature tests here */
> +	return ((feat_mask & omap_features) == feat_mask);
> +}
> +
>  static void __init omap4_check_revision(void)
>  {
>  	u32 idcode;
> @@ -297,6 +325,10 @@ static void __init omap4_check_revision(void)
>  		omap_revision = OMAP4430_REV_ES1_0;
>  		omap_chip.oc |= CHIP_IS_OMAP4430ES1;
>  		pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
> +
> +		omap_features = 0;
> +		omap_init_features(omap4_has_feature);
> +
>  		return;
>  	}
>  
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 893a53a..d00b242 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -89,6 +89,21 @@ void __init omap_reserve(void)
>  	omap_vram_reserve_sdram_lmb();
>  }
>  
> +static int (*_omap_check_feature)(u32 feat_mask);
> +
> +u32 omap_has_feature(u32 feat_mask)
> +{
> +	if (!_omap_check_feature)
> +		return 0;
> +
> +	return _omap_check_feature(feat_mask);
> +}
> +
> +void __init omap_init_features(u32 (*check_feature)(u32 feat))
> +{
> +	_omap_check_feature = check_feature;
> +}
> +
>  /*
>   * 32KHz clocksource ... always available, on pretty most chips except
>   * OMAP 730 and 1510.  Other timers could be used as clocksources, with
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index aa2f4f0..127df06 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -49,6 +49,9 @@ struct omap_chip_id {
>  	u8 type;
>  };
>  
> +u32 omap_has_feature(u32 feat_mask);
the above crib -> it is better as an static inline function instead of 
explicit function call.

> +void omap_init_features(u32 (*check_feature)(u32 feat));
> +
>  #define OMAP_CHIP_INIT(x)	{ .oc = x }
>  
>  /*
> 


-- 
Regards,
Nishanth Menon
