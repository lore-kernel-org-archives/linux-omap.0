From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/6] ARM: OMAP4: hwmod data: add mmu hwmod for ipu and
 dsp
Date: Tue, 19 Jun 2012 14:36:56 +0200
Message-ID: <4FE07268.7040606@ti.com>
References: <1339811764-5337-1-git-send-email-omar.luna@linaro.org> <1339811764-5337-4-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54038 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865Ab2FSMhQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 08:37:16 -0400
In-Reply-To: <1339811764-5337-4-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org

Hi Omar,

On 6/16/2012 3:56 AM, Omar Ramirez Luna wrote:
> Add mmu hwmod data for ipu and dsp.
> 
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  136 +++++++++++++++++++++++++++-
>   1 files changed, 134 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index ebf9657..3879e9c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -30,6 +30,7 @@
>   #include <plat/mmc.h>
>   #include <plat/dmtimer.h>
>   #include <plat/common.h>
> +#include <plat/iommu.h>
>   
>   #include "omap_hwmod_common_data.h"
>   
> @@ -614,7 +615,6 @@ static struct omap_hwmod_irq_info omap44xx_dsp_irqs[] = {
>   
>   static struct omap_hwmod_rst_info omap44xx_dsp_resets[] = {
>   	{ .name = "dsp", .rst_shift = 0 },
> -	{ .name = "mmu_cache", .rst_shift = 1 },
>   };
>   
>   static struct omap_hwmod omap44xx_dsp_hwmod = {
> @@ -1629,7 +1629,6 @@ static struct omap_hwmod_irq_info omap44xx_ipu_irqs[] = {
>   static struct omap_hwmod_rst_info omap44xx_ipu_resets[] = {
>   	{ .name = "cpu0", .rst_shift = 0 },
>   	{ .name = "cpu1", .rst_shift = 1 },
> -	{ .name = "mmu_cache", .rst_shift = 2 },
>   };
>   
>   static struct omap_hwmod omap44xx_ipu_hwmod = {
> @@ -2436,6 +2435,137 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
>   };
>   
>   /*
> + * 'mmu' class
> + * The memory management unit performs virtual to physical address translation
> + * for its requestors.
> + */
> +
> +static struct omap_hwmod_class_sysconfig mmu_sysc = {
> +	.rev_offs	= 0x000,
> +	.sysc_offs	= 0x010,
> +	.syss_offs	= 0x014,
> +	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
> +			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
> +	.name = "mmu",
> +	.sysc = &mmu_sysc,
> +};
> +
> +/* ipu mmu */
> +
> +static struct omap_mmu_dev_attr ipu_mmu_dev_attr = {
> +	.da_start = 0x0,
> +	.da_end = 0xfffff000,
> +	.nr_tlb_entries = 32,
> +};
> +
> +static struct omap_hwmod omap44xx_ipu_mmu_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_ipu_mmu_irqs[] = {
> +	{ .irq = 100 + OMAP44XX_IRQ_GIC_START, },
> +	{ .irq = -1 }
> +};
> +
> +static struct omap_hwmod_rst_info omap44xx_ipu_mmu_resets[] = {
> +	{ .name = "mmu_cache", .rst_shift = 2 },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_ipu_mmu_addrs[] = {
> +	{
> +		.pa_start	= 0x55082000,
> +		.pa_end		= 0x550820ff,
> +		.flags		= ADDR_TYPE_RT,
> +	},
> +	{ }
> +};
> +
> +/* l3_main_2 -> ipu_mmu */
> +static struct omap_hwmod_ocp_if omap44xx_l3_main_2__ipu_mmu = {
> +	.master		= &omap44xx_l3_main_2_hwmod,
> +	.slave		= &omap44xx_ipu_mmu_hwmod,
> +	.clk		= "l3_div_ck",
> +	.addr		= omap44xx_ipu_mmu_addrs,
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod omap44xx_ipu_mmu_hwmod = {
> +	.name		= "ipu_mmu",
> +	.class		= &omap44xx_mmu_hwmod_class,
> +	.clkdm_name	= "ducati_clkdm",
> +	.mpu_irqs	= omap44xx_ipu_mmu_irqs,
> +	.rst_lines	= omap44xx_ipu_mmu_resets,
> +	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_mmu_resets),
> +	.main_clk	= "ipu_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
> +			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
> +			.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
> +			.modulemode   = MODULEMODE_HWCTRL,
> +		},
> +	},
> +	.dev_attr	= &ipu_mmu_dev_attr,
> +};

In fact, the MMU_IPU hwmod is now almost the same one than the previous IPU one...
If we do that we should maybe just rename the IPU -> MMU_IPU and DSP -> MMU_DSP.

But by doing that we will assume that the MMU does represent the subsystem, which is not necessarily super nice.

I guess that a much better representation will be to keep the subsystem (IPU) to handle the PRCM part:

+	.main_clk	= "ipu_fck",
+	.prcm = {
+		.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
+		.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
+		.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
+		.modulemode   = MODULEMODE_HWCTRL,


And then the MMU_IPU will handle the configuration registers part and the reset + irq.

But then, you will have to create a parent child dependency between your devices to ensure that the IPU subsystem device will be enabled before trying to access the MMU_IPU.

This is what the DSS is about to do to handle the same kind of power dependency. The DSS device is the parent of all the DSS IPs (DISPC, HDMI...) and thus pm_runtime will ensure that the parent is enabled before trying to enable the children.

In term of DT, just to illustrate the situation, it will be something like that:

ipu {
	compatible = "simple-bus";
	ti,hwmods = "ipu";

	ipu_mmu: mmu@4a066000 {
		compatible = "omap-mmu";
		ti,hwmods = "mmu_ipu";
		reg...;
		irqs...;
	}	
}

Is it something you can handle with your current framework?

Regards,
Benoit

