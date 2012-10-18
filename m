From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Fri, 19 Oct 2012 02:18:24 +0530
Message-ID: <50806B18.1010502@ti.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59411 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab2JRUsj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 16:48:39 -0400
In-Reply-To: <20121017181354.GA2412@netboy.at.omicron.at>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 10/17/2012 11:43 PM, Richard Cochran wrote:
> Paul,
> 
> Would you please take this bugfix for 3.7-rc2? The suggestion to mail
> you came from Toni Lindgren. The context where it came from is here:
> 
> http://lists.arm.linux.org.uk/lurker/message/20121015.191630.bdae3c50.en.html
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

Hey Richard,

I feel you have picked up this patch in premature state, I didn't like
this NO_RESET and NO_IDLE flag to be set for MDIO.

Couple of reasons,

1. These flags were added for validation, so I expect cpsw driver
should work without these flags set. I tested it mounting NFS as rootFS
and it works for me.

2. There is HW bug as far as idle (in turn ocp reset) is concerned, and
needs special handling for this. I already have patch for this, which I
will submit it to the list.

http://arago-project.org/git/projects/?p=linux-am33x.git;a=commitdiff;h=a28da2ac98f173f97dbbb46be1ce0a3879f21a11


Note: Sorry for long commit description, it was screwed up by someone
while git push.


I have pushed the tested branch to (linux-omap/master + CPSW patches) -
https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging

Thanks,
Vaibhav
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
> 
