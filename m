From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Wed, 17 Oct 2012 23:38:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47506 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701Ab2JQXiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 19:38:06 -0400
In-Reply-To: <20121017181354.GA2412@netboy.at.omicron.at>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mugunthan V N <mugunthanvnm@ti.com>, tony@atomide.com

Hi Richard

On Wed, 17 Oct 2012, Richard Cochran wrote:

> Would you please take this bugfix for 3.7-rc2? The suggestion to mail
> you came from Toni Lindgren. The context where it came from is here:
> 
> http://lists.arm.linux.org.uk/lurker/message/20121015.191630.bdae3c50.en.html

This patch appears to add a new feature, correct?  I don't think the CPSW 
could have worked in the past without this data present.  So it looks to 
me like this is 3.8 material, unless Tony would like it to go in sooner?


- Paul

> 
> Thanks,
> Richard
> 
> ----- Forwarded message from Richard Cochran <richardcochran@gmail.com> -----
> 
> Date: Mon, 15 Oct 2012 21:16:32 +0200
> From: Richard Cochran <richardcochran@gmail.com>
> To: netdev@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
> 	David Miller <davem@davemloft.net>,
> 	Russell King <linux@arm.linux.org.uk>,
> 	Mugunthan V N <mugunthanvnm@ti.com>
> Subject: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for davinci_mdio
> X-Mailer: git-send-email 1.7.2.5
> 
> From: Mugunthan V N <mugunthanvnm@ti.com>
> 
> This patch adds minimal hwmod support for davinci mdio driver. This patch
> requires rework on parent child relation between cpsw and davinci mdio
> hwmod data to support runtime PM.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   34 ++++++++++++++++++++++++++-
>  1 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 59d5c1c..f96bbc0 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -650,8 +650,7 @@ static struct omap_hwmod_class_sysconfig am33xx_cpgmac_sysc = {
>  	.rev_offs	= 0x0,
>  	.sysc_offs	= 0x8,
>  	.syss_offs	= 0x4,
> -	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
> -			   SYSS_HAS_RESET_STATUS),
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
>  	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | MSTANDBY_FORCE |
>  			   MSTANDBY_NO),
>  	.sysc_fields	= &omap_hwmod_sysc_type3,
> @@ -682,6 +681,8 @@ static struct omap_hwmod am33xx_cpgmac0_hwmod = {
>  			.modulemode	= MODULEMODE_SWCTRL,
>  		},
>  	},
> +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
> +			   HWMOD_INIT_NO_RESET | HWMOD_INIT_NO_IDLE),
>  };
>  
>  /*
> @@ -2510,6 +2511,34 @@ static struct omap_hwmod_addr_space am33xx_elm_addr_space[] = {
>  	{ }
>  };
>  
> +/* mdio class */
> +static struct omap_hwmod_class am33xx_mdio_hwmod_class = {
> +	.name		= "davinci_mdio",
> +};
> +
> +struct omap_hwmod_addr_space am33xx_mdio_addr_space[] = {
> +	{
> +		.pa_start	= 0x4A101000,
> +		.pa_end		= 0x4A101000 + SZ_256 - 1,
> +		.flags		= ADDR_MAP_ON_INIT,
> +	},
> +	{ }
> +};
> +
> +static struct omap_hwmod am33xx_mdio_hwmod = {
> +	.name		= "davinci_mdio",
> +	.class		= &am33xx_mdio_hwmod_class,
> +	.clkdm_name	= "cpsw_125mhz_clkdm",
> +	.main_clk	= "cpsw_125mhz_gclk",
> +};
> +
> +struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio = {
> +	.master		= &am33xx_cpgmac0_hwmod,
> +	.slave		= &am33xx_mdio_hwmod,
> +	.addr		= am33xx_mdio_addr_space,
> +	.user		= OCP_USER_MPU,
> +};
> +
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__elm = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_elm_hwmod,
> @@ -3371,6 +3400,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
>  	&am33xx_l3_main__tptc2,
>  	&am33xx_l3_s__usbss,
>  	&am33xx_l4_hs__cpgmac0,
> +	&am33xx_cpgmac0__mdio,
>  	NULL,
>  };
>  
> -- 
> 1.7.2.5
> 
> 
> ----- End forwarded message -----
> 


- Paul
