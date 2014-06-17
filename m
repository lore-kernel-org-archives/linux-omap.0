From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Tue, 17 Jun 2014 01:58:47 -0700
Message-ID: <20140617085846.GO17845@atomide.com>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57174 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932652AbaFQI6u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 04:58:50 -0400
Content-Disposition: inline
In-Reply-To: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, Sathya Prakash M R <sathyap@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140617 01:39]:
> From: Sathya Prakash M R <sathyap@ti.com>
> 
> Add DSS hwmod data for AM43xx.
> 
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> [tomi.valkeinen@ti.com: added missing dispc flags]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Acked-by: Rajendra Nayak <rnayak@ti.com>
> ---
> Changes to v1:
> 
> * added missing dispc .sysc_flags and .idlemodes
> * reordered entries, as the dss and dispc were a bit mixed together
> 
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 100 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm43xx.h             |   1 +
>  2 files changed, 101 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> index 5c2cc8083fdd..fea01aa3ef42 100644
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
> @@ -415,6 +417,72 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
>  	},
>  };
>  
> +/* dss */
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
> +/* dispc */
> +
> +struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr = {
> +	.manager_count		= 1,
> +	.has_framedonetv_irq	= 0
> +};
> +
> +static struct omap_hwmod_class_sysconfig am43xx_dispc_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SOFTRESET |
> +			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
> +			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_MIDLEMODE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> +			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class am43xx_dispc_hwmod_class = {
> +	.name	= "dispc",
> +	.sysc	= &am43xx_dispc_sysc,
> +};
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
> +/* rfbi */

I think we're still missing am43x_rfbi_sysc entry though?

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
> @@ -654,6 +722,34 @@ static struct omap_hwmod_ocp_if am43xx_l3_s__qspi = {
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
> @@ -748,6 +844,10 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
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
> -- 
> 1.9.1
> 
