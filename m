From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/05] ARM: OMAP2: Add minimal omap3430 support
Date: Sun, 5 Oct 2008 08:01:03 +0000
Message-ID: <20081005080103.GA12446@muru.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <1223035779-26306-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:57808 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbYJEIBL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 Oct 2008 04:01:11 -0400
Content-Disposition: inline
In-Reply-To: <1223035779-26306-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Syed Mohammed Khasim <x0khasim@ti.com>, Karthik Dasu <karthik-dp@ti.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>

On Fri, Oct 03, 2008 at 03:09:35PM +0300, Tony Lindgren wrote:
> Add minimal omap3430 support based on earlier patches from
> Syed Mohammed Khasim. Also merge in omap34xx SRAM support
> from Karthik Dasu and use consistent naming for sram init
> functions.
> 
> Also do following changes that make 34xx support usable:
> 
> - Rename IRQ_SIR_IRQ to INTCPS_SIR_IRQ and define it locally
>   in entry-macro.S
> 
> - Update mach-omap2/io.c to support 2420, 2430, and 34xx
> 
> - Also merge in 34xx GPMC changes to add fields wr_access and
>   wr_data_mux_bus from Adrian Hunter
> 
> - Remove memory initialization call omap2_init_memory() until
>   until more generic memory initialization patches are posted.
>   It's OK to rely on bootloader initialization until then.
> 
> Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>
> Signed-off-by: Karthik Dasu<karthik-dp@ti.com>
> Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

<snip>

> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -271,7 +271,7 @@ int __init omap1_sram_init(void)
>  #define omap1_sram_init()	do {} while (0)
>  #endif
>  
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2)
>  
>  static void (*_omap2_sram_ddr_init)(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
>  			      u32 base_cs, u32 force_unlock);
> @@ -352,60 +352,41 @@ static inline int omap243x_sram_init(void)
>  
>  #ifdef CONFIG_ARCH_OMAP3
>  
> -static u32 (*_omap2_sram_reprogram_gpmc)(u32 perf_level);
> -u32 omap2_sram_reprogram_gpmc(u32 perf_level)
> -{
> -	if (!_omap2_sram_reprogram_gpmc)
> +static u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
> +					      u32 sdrc_actim_ctrla,
> +					      u32 sdrc_actim_ctrlb,
> +					      u32 m2);
> +u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
> +			      u32 sdrc_actim_ctrlb, u32 m2)
> + {
> +	if (!_omap3_sram_configure_core_dpll)
>  		omap_sram_error();
>  
> -	return _omap2_sram_reprogram_gpmc(perf_level);
> -}
> -
> -static u32 (*_omap2_sram_configure_core_dpll)(u32 m, u32 n,
> -						u32 freqsel, u32 m2);
> -u32 omap2_sram_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2)
> -{
> -	if (!_omap2_sram_configure_core_dpll)
> -		omap_sram_error();
> -
> -	return _omap2_sram_configure_core_dpll(m, n, freqsel, m2);
> -}
> +	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
> +					       sdrc_actim_ctrla,
> +					       sdrc_actim_ctrlb, m2);
> + }

Looks like there are at least some formatting issues with the sram code
above. Will check and repost this patch on Monday.

Tony

