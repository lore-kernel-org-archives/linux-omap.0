From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 01/11] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Mon, 19 May 2014 14:54:34 +0530
Message-ID: <5379CDD2.6080807@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com> <1399636579-8062-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35689 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbaESJ0u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 05:26:50 -0400
In-Reply-To: <1399636579-8062-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Sathya Prakash M R <sathyap@ti.com>

On Friday 09 May 2014 05:26 PM, Tomi Valkeinen wrote:
> From: Sathya Prakash M R <sathyap@ti.com>
> 
> Add DSS hwmod data for AM43xx.
> 
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 104 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm43xx.h             |   1 +
>  2 files changed, 105 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> index 5c2cc8083fdd..8c14db2e1e47 100644
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
> @@ -415,6 +417,76 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
>  	},
>  };
>  
> +/* Display sub system - DSS */
> +
> +static struct omap_hwmod_dma_info am43xx_dss_sdma_chs[] = {
> +	{ .name = "dispc", .dma_req = 5 },
> +	{ .dma_req = -1 },
> +};

the dma info needs to come in from DT. Besides these are edma
request lines and not sdma.

> +
> +struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr = {
> +	.manager_count		= 1,
> +	.has_framedonetv_irq	= 0
> +};
> +
> +
[]..

> +
>  /* Interfaces */
>  static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
>  	.master		= &am33xx_l3_main_hwmod,
> @@ -654,6 +726,34 @@ static struct omap_hwmod_ocp_if am43xx_l3_s__qspi = {
>  	.user           = OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +static struct omap_hwmod_ocp_if am43xx_dss__l3_main = {
> +	.master		= &am43xx_dss_core_hwmod,
> +	.slave		= &am33xx_l3_main_hwmod,
> +	.clk		= "disp_clk",

Isn't l3_gclk that clocks the l3 OCP master port?

regards,
Rajendra

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
> @@ -748,6 +848,10 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
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

