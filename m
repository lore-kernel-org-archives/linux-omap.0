From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: hwmod data: Add SSI data for omap36xx
Date: Wed, 27 Jan 2016 00:07:38 +0200
Message-ID: <20160126220738.GG15550@darkstar.musicnaut.iki.fi>
References: <1453045749-22642-1-git-send-email-sre@kernel.org>
 <1453045749-22642-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453045749-22642-2-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jan 17, 2016 at 04:49:05PM +0100, Sebastian Reichel wrote:
> This patch enables Synchronous Serial Interface (SSI)
> hwmod support for OMAP36xx SoCs (used by Nokia N950/N9).
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index aff78d5198d2..ed972029dce1 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -3625,14 +3625,14 @@ static struct omap_hwmod_class_sysconfig omap34xx_ssi_sysc = {
>  	.sysc_fields	= &omap_hwmod_sysc_type1,
>  };
>  
> -static struct omap_hwmod_class omap34xx_ssi_hwmod_class = {
> +static struct omap_hwmod_class omap3xxx_ssi_hwmod_class = {
>  	.name	= "ssi",
>  	.sysc	= &omap34xx_ssi_sysc,
>  };
>  
> -static struct omap_hwmod omap34xx_ssi_hwmod = {
> +static struct omap_hwmod omap3xxx_ssi_hwmod = {
>  	.name		= "ssi",
> -	.class		= &omap34xx_ssi_hwmod_class,
> +	.class		= &omap3xxx_ssi_hwmod_class,
>  	.clkdm_name	= "core_l4_clkdm",
>  	.main_clk	= "ssi_ssr_fck",
>  	.prcm		= {
> @@ -3647,9 +3647,9 @@ static struct omap_hwmod omap34xx_ssi_hwmod = {
>  };
>  
>  /* L4 CORE -> SSI */
> -static struct omap_hwmod_ocp_if omap34xx_l4_core__ssi = {
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__ssi = {
>  	.master		= &omap3xxx_l4_core_hwmod,
> -	.slave		= &omap34xx_ssi_hwmod,
> +	.slave		= &omap3xxx_ssi_hwmod,
>  	.clk		= "ssi_ick",
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> @@ -3802,7 +3802,7 @@ static struct omap_hwmod_ocp_if *omap34xx_hwmod_ocp_ifs[] __initdata = {
>  	&omap3xxx_sad2d__l3,
>  	&omap3xxx_l4_core__mmu_isp,
>  	&omap3xxx_l3_main__mmu_iva,
> -	&omap34xx_l4_core__ssi,
> +	&omap3xxx_l4_core__ssi,
>  	NULL
>  };
>  
> @@ -3826,6 +3826,7 @@ static struct omap_hwmod_ocp_if *omap36xx_hwmod_ocp_ifs[] __initdata = {
>  	&omap3xxx_sad2d__l3,
>  	&omap3xxx_l4_core__mmu_isp,
>  	&omap3xxx_l3_main__mmu_iva,
> +	&omap3xxx_l4_core__ssi,
>  	NULL
>  };
>  
> -- 
> 2.7.0.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
