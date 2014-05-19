From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 01/11] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Mon, 19 May 2014 16:53:01 +0530
Message-ID: <5379E995.80604@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com> <1399636579-8062-2-git-send-email-tomi.valkeinen@ti.com> <5379CDD2.6080807@ti.com> <5379D8F5.9030008@ti.com> <5379DCCE.3050400@ti.com> <5379E6B1.5000409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34633 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbaESLZP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 07:25:15 -0400
In-Reply-To: <5379E6B1.5000409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, Sathya Prakash M R <sathyap@ti.com>

On Monday 19 May 2014 04:40 PM, Tomi Valkeinen wrote:
> On 19/05/14 13:28, Rajendra Nayak wrote:
> 
>> Yeah, thats what it looks like to me. l3_gclk is the 200Mhz clock derived from 
>> core-m4 post divider and l3s_gclk/l4ls_gclk are half of that at 100Mhz, derived
>> using a fixed divider of 2.
> 
> Here's an updated patch, with the sdma entry removed and the ocp clock
> changed to l3_gclk.
> 
> From bfaf0fafb21c698c86640764c1aa62d6fc73992a Mon Sep 17 00:00:00 2001
> From: Sathya Prakash M R <sathyap@ti.com>
> Date: Mon, 24 Mar 2014 16:31:53 +0530
> Subject: [PATCH] ARM: AM43xx: hwmod: add DSS hwmod data
> 
> Add DSS hwmod data for AM43xx.
> 
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Looks good to me, feel free to add
Acked-by: Rajendra Nayak <rnayak@ti.com>

> ---
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 98 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm43xx.h             |  1 +
>  2 files changed, 99 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> index 5c2cc8083fdd..d2a7b6dc36f2 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> @@ -19,6 +19,8 @@
>  #include "omap_hwmod.h"
>  #include "omap_hwmod_33xx_43xx_common_data.h"
>  #include "prcm43xx.h"
> +#include "omap_hwmod_common_data.h"
> +
>  
>  /* IP blocks */
>  static struct omap_hwmod am43xx_l4_hs_hwmod = {
> @@ -415,6 +417,70 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
>  	},
>  };
>  
> +/* Display sub system - DSS */
> +
> +struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr = {
> +	.manager_count		= 1,
> +	.has_framedonetv_irq	= 0
> +};
> +
> +
> +static struct omap_hwmod_class_sysconfig am43xx_dispc_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class am43xx_dispc_hwmod_class = {
> +	.name	= "dispc",
> +	.sysc	= &am43xx_dispc_sysc,
> +};
> +
> +static struct omap_hwmod am43xx_dss_core_hwmod = {
> +	.name		= "dss_core",
> +	.class		= &omap2_dss_hwmod_class,
> +	.clkdm_name	= "dss_clkdm",
> +	.main_clk	= "disp_clk",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +/* display controller -dispc*/
> +
> +static struct omap_hwmod am43xx_dss_dispc_hwmod = {
> +	.name		= "dss_dispc",
> +	.class		= &am43xx_dispc_hwmod_class,
> +	.clkdm_name	= "dss_clkdm",
> +	.main_clk	= "disp_clk",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
> +		},
> +	},
> +	.dev_attr	= &am43xx_dss_dispc_dev_attr,
> +};
> +
> +/*RFBI*/
> +
> +static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
> +	.name		= "dss_rfbi",
> +	.class		= &omap2_rfbi_hwmod_class,
> +	.clkdm_name	= "dss_clkdm",
> +	.main_clk	= "disp_clk",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
> +		},
> +	},
> +};
> +
>  /* Interfaces */
>  static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
>  	.master		= &am33xx_l3_main_hwmod,
> @@ -654,6 +720,34 @@ static struct omap_hwmod_ocp_if am43xx_l3_s__qspi = {
>  	.user           = OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +static struct omap_hwmod_ocp_if am43xx_dss__l3_main = {
> +	.master		= &am43xx_dss_core_hwmod,
> +	.slave		= &am33xx_l3_main_hwmod,
> +	.clk		= "l3_gclk",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__dss = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_dss_core_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_dispc = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_dss_dispc_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_rfbi = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_dss_rfbi_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
>  	&am33xx_l4_wkup__synctimer,
>  	&am43xx_l4_ls__timer8,
> @@ -748,6 +842,10 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
>  	&am43xx_l4_ls__ocp2scp1,
>  	&am43xx_l3_s__usbotgss0,
>  	&am43xx_l3_s__usbotgss1,
> +	&am43xx_dss__l3_main,
> +	&am43xx_l4_ls__dss,
> +	&am43xx_l4_ls__dss_dispc,
> +	&am43xx_l4_ls__dss_rfbi,
>  	NULL,
>  };
>  
> diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
> index 7785be984edd..ad7b3e9977f8 100644
> --- a/arch/arm/mach-omap2/prcm43xx.h
> +++ b/arch/arm/mach-omap2/prcm43xx.h
> @@ -142,5 +142,6 @@
>  #define AM43XX_CM_PER_USBPHYOCP2SCP0_CLKCTRL_OFFSET	0x05B8
>  #define AM43XX_CM_PER_USB_OTG_SS1_CLKCTRL_OFFSET        0x0268
>  #define AM43XX_CM_PER_USBPHYOCP2SCP1_CLKCTRL_OFFSET	0x05C0
> +#define AM43XX_CM_PER_DSS_CLKCTRL_OFFSET		0x0a20
>  
>  #endif
> 

