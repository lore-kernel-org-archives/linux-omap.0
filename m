From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH/RFT 2/2] OMAP4: fix temporary hacks that break
 multi-omap PM
Date: Wed, 10 Mar 2010 12:18:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C46F0F9C@dbde02.ent.ti.com>
References: <1268154241-24788-1-git-send-email-khilman@deeprootsystems.com>
 <1268154241-24788-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59865 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab0CJGsF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 01:48:05 -0500
In-Reply-To: <1268154241-24788-3-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
> Hilman
> Sent: Tuesday, March 09, 2010 10:34 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH/RFT 2/2] OMAP4: fix temporary hacks that break multi-omap PM
> 
> When building for multi-omap, and OMAP4 is enabled, CONFIG_ARCH_OMAP4
> will be true and prevent included code from building/running for
> OMAP2/3 as well.
> 
> This problem exists in io.c where some hwmod/PM/SDRC init code is
> prevented from running even on OMAP2/3 when OMAP4 is included in a
> multi-OMAP build.
> 
> A quick glance suggests that this #ifndef is no longer needed in most
> of the cases.  In the remaining cases, the function is wrapped with
> "if (cpu_is_omap24xx() || cpu_is_omap34xx())" which will be optimized
> out for OMAP4-only builds.
> 
> Note that this is only a short-term fix.  Longer-term, OMAP4
> needs to create init functions for SDRC and hwmod late-init.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/io.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 402e8f0..f33409c 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -309,7 +309,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>  {
>  	pwrdm_init(powerdomains_omap);
>  	clkdm_init(clockdomains_omap, clkdm_autodeps);
> -#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
>  	if (cpu_is_omap242x())
>  		omap2420_hwmod_init();
>  	else if (cpu_is_omap243x())
> @@ -319,7 +318,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>  	omap2_mux_init();
>  	/* The OPP tables have to be registered before a clk init */
>  	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
> -#endif
> 
>  	if (cpu_is_omap2420())
>  		omap2420_clk_init();
> @@ -333,11 +331,12 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>  		pr_err("Could not init clock framework - unknown CPU\n");
> 
>  	omap_serial_early_init();
> -#ifndef CONFIG_ARCH_OMAP4
> -	omap_hwmod_late_init();
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
This is in pipeline with ongoing hwmod work.
> +		omap_hwmod_late_init();
>  	omap_pm_if_init();
> -	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
> -	_omap2_init_reprogram_sdrc();
> -#endif
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx()) { /* FIXME: OMAP4 */
This FIXME should be removed because there no SDRC on OMAP4.
> +		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
> +		_omap2_init_reprogram_sdrc();
> +	}
>  	gpmc_init();
>  }
> --
> 1.7.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
