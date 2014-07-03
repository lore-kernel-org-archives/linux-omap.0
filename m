From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: DRA7: hwmod: add entry for RTCSS
Date: Thu, 3 Jul 2014 15:52:36 +0530
Message-ID: <53B52EEC.2030800@ti.com>
References: <f99196358a3cc28b0bd451459badcfc286533845.1399638849.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030187AbaGCKZd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2014 06:25:33 -0400
In-Reply-To: <f99196358a3cc28b0bd451459badcfc286533845.1399638849.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>

On Friday 09 May 2014 06:07 PM, Sekhar Nori wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> RTCSS on DRA7 provides a precise real-time clock.
> Add hwmod entry for this IP.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Reviewed-by: Rajendra Nayak <rnayak@ti.com>

> ---
> Applies to linux-next of 5th May.

Might need a repost with rebase on the latest mainline.

> 
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 810c205..402ffc7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1249,6 +1249,38 @@ static struct omap_hwmod dra7xx_qspi_hwmod = {
>  };
>  
>  /*
> + * 'rtcss' class
> + *
> + */
> +static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
> +	.sysc_offs	= 0x0078,
> +	.sysc_flags	= SYSC_HAS_SIDLEMODE,
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> +			   SIDLE_SMART_WKUP),
> +	.sysc_fields	= &omap_hwmod_sysc_type3,
> +};
> +
> +static struct omap_hwmod_class dra7xx_rtcss_hwmod_class = {
> +	.name	= "rtcss",
> +	.sysc	= &dra7xx_rtcss_sysc,
> +};
> +
> +/* rtcss */
> +static struct omap_hwmod dra7xx_rtcss_hwmod = {
> +	.name		= "rtcss",
> +	.class		= &dra7xx_rtcss_hwmod_class,
> +	.clkdm_name	= "rtc_clkdm",
> +	.main_clk	= "sys_32k_ck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = DRA7XX_CM_RTC_RTCSS_CLKCTRL_OFFSET,
> +			.context_offs = DRA7XX_RM_RTC_RTCSS_CONTEXT_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +/*
>   * 'sata' class
>   *
>   */
> @@ -2354,6 +2386,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__qspi = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +/* l4_per3 -> rtcss */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per3__rtcss = {
> +	.master		= &dra7xx_l4_per3_hwmod,
> +	.slave		= &dra7xx_rtcss_hwmod,
> +	.clk		= "l4_root_clk_div",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  static struct omap_hwmod_addr_space dra7xx_sata_addrs[] = {
>  	{
>  		.name		= "sysc",
> @@ -2683,6 +2723,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
>  	&dra7xx_l4_cfg__mpu,
>  	&dra7xx_l4_cfg__ocp2scp1,
>  	&dra7xx_l3_main_1__qspi,
> +	&dra7xx_l4_per3__rtcss,
>  	&dra7xx_l4_cfg__sata,
>  	&dra7xx_l4_cfg__smartreflex_core,
>  	&dra7xx_l4_cfg__smartreflex_mpu,
> 

