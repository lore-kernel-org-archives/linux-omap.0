From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/5] omap: Remove old omap3_has_ macros
Date: Thu, 8 Jul 2010 09:54:48 -0500
Message-ID: <4C35E6B8.9080300@ti.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com> <20100708093801.16352.93269.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39513 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241Ab0GHOyu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 10:54:50 -0400
In-Reply-To: <20100708093801.16352.93269.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren had written, on 07/08/2010 04:38 AM, the following:
> Remove old omap3_has_ macros. Please use omap_has_feature()
> instead.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/id.c              |   14 ++++----------
>  arch/arm/plat-omap/include/plat/cpu.h |   16 ----------------
>  2 files changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 11184cf..123ed1e 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -31,9 +31,6 @@ static struct omap_chip_id omap_chip;
>  static unsigned int omap_revision;
>  static u32 omap_features;
>  
> -/* REVISIT: Get rid of omap3_features */
> -u32 omap3_features;
> -
>  unsigned int omap_rev(void)
>  {
>  	return omap_revision;
> @@ -186,14 +183,14 @@ u32 omap3_has_feature(u32 feat_mask)
>  #define OMAP3_CHECK_FEATURE(status,feat)				\
>  	if (((status & OMAP3_ ##feat## _MASK) 				\
>  		>> OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat## _NONE) { 	\
> -		omap3_features |= OMAP3_HAS_ ##feat;			\
> +		omap_features |= OMAP3_HAS_ ##feat;			\
>  	}
>  
>  static void __init omap3_check_features(void)
>  {
>  	u32 status;
>  
> -	omap3_features = 0;
> +	omap_features = 0;
>  
>  	status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
>  
> @@ -203,18 +200,15 @@ static void __init omap3_check_features(void)
>  	OMAP3_CHECK_FEATURE(status, NEON);
>  	OMAP3_CHECK_FEATURE(status, ISP);
>  	if (cpu_is_omap3630())
> -		omap3_features |= OMAP3_HAS_192MHZ_CLK;
> +		omap_features |= OMAP3_HAS_192MHZ_CLK;
>  	if (!cpu_is_omap3505() && !cpu_is_omap3517())
> -		omap3_features |= OMAP3_HAS_IO_WAKEUP;
> +		omap_features |= OMAP3_HAS_IO_WAKEUP;
>  
>  	/*
>  	 * TODO: Get additional info (where applicable)
>  	 *       e.g. Size of L2 cache.
>  	 */
>  
> -	/* REVISIT: Get rid of omap3_features */
> -	omap_features = omap3_features;
> -
>  	omap_init_features(omap3_has_feature);
>  }
>  
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index efee323..96eac4d 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -439,8 +439,6 @@ void omap2_check_revision(void);
>  /*
>   * Runtime detection of OMAP3 features
>   */
> -extern u32 omap3_features;
> -
>  #define OMAP3_HAS_L2CACHE		BIT(0)
>  #define OMAP3_HAS_IVA			BIT(1)
>  #define OMAP3_HAS_SGX			BIT(2)
> @@ -449,18 +447,4 @@ extern u32 omap3_features;
>  #define OMAP3_HAS_192MHZ_CLK		BIT(5)
>  #define OMAP3_HAS_IO_WAKEUP		BIT(6)
>  
> -#define OMAP3_HAS_FEATURE(feat,flag)			\
> -static inline unsigned int omap3_has_ ##feat(void)	\
> -{							\
> -	return (omap3_features & OMAP3_HAS_ ##flag);	\
> -}							\
> -
> -OMAP3_HAS_FEATURE(l2cache, L2CACHE)
> -OMAP3_HAS_FEATURE(sgx, SGX)
> -OMAP3_HAS_FEATURE(iva, IVA)
> -OMAP3_HAS_FEATURE(neon, NEON)
> -OMAP3_HAS_FEATURE(isp, ISP)
> -OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> -OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
> -
>  #endif
> 
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
