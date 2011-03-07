From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 2/4] OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Mon, 7 Mar 2011 13:55:21 +0100
Message-ID: <4D74D5B9.2070907@ti.com>
References: <1299484388-16205-1-git-send-email-omar.ramirez@ti.com> <1299484388-16205-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56298 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753810Ab1CGMzf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 07:55:35 -0500
In-Reply-To: <1299484388-16205-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@eeprootsystems.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Omar,

I have some concern about the introduction of a hwmod that does not 
match the actual HW capability. MMU does exist, but there is no SW 
control for it. In fact the only control available is for mmu + cache + 
logic, and that's why the MMU is handle today under the main DSP/IPU hwmod.

Here you are just duplicating dsp_hwmod and ipu_hwmod with dsp_mmu_hwmod 
/ ipu_mmu_hwmod and adding some memory space for the mmu part.

In that case, you can still use the previous name and add the missing 
entries in it.

The only advantage I can see is the usage of a common class that will 
allow you to handle both DSP and IPU using the same "MMU" driver.

So, what are you going to do with the remaining entries for dsp_hwmod 
and ipu_hwmod?

If these two become useless and only the mmu part is useful, we can 
potentially rename them like you did, but without keeping the original.

On 3/7/2011 8:53 AM, Ramirez Luna, Omar wrote:
> Add mmu hwmod data for ipu and dsp.
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  156 +++++++++++++++++++++++++--
>   1 files changed, 144 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7dbcdf7..149d694 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -27,6 +27,7 @@
>   #include<plat/mcspi.h>
>   #include<plat/mcbsp.h>
>   #include<plat/mmc.h>
> +#include<plat/iommu.h>
>
>   #include "omap_hwmod_common_data.h"
>
> @@ -990,10 +991,6 @@ static struct omap_hwmod_irq_info omap44xx_dsp_irqs[] = {
>   	{ .irq = 28 + OMAP44XX_IRQ_GIC_START },
>   };
>
> -static struct omap_hwmod_rst_info omap44xx_dsp_resets[] = {
> -	{ .name = "mmu_cache", .rst_shift = 1 },
> -};
> -
>   static struct omap_hwmod_rst_info omap44xx_dsp_c0_resets[] = {
>   	{ .name = "dsp", .rst_shift = 0 },
>   };
> @@ -1045,8 +1042,6 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
>   	.class		=&omap44xx_dsp_hwmod_class,
>   	.mpu_irqs	= omap44xx_dsp_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dsp_irqs),
> -	.rst_lines	= omap44xx_dsp_resets,
> -	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
>   	.main_clk	= "dsp_fck",
>   	.prcm = {
>   		.omap4 = {
> @@ -2323,10 +2318,6 @@ static struct omap_hwmod_rst_info omap44xx_ipu_c1_resets[] = {
>   	{ .name = "cpu1", .rst_shift = 1 },
>   };
>
> -static struct omap_hwmod_rst_info omap44xx_ipu_resets[] = {
> -	{ .name = "mmu_cache", .rst_shift = 2 },
> -};
> -
>   /* ipu master ports */
>   static struct omap_hwmod_ocp_if *omap44xx_ipu_masters[] = {
>   	&omap44xx_ipu__l3_main_2,
> @@ -2380,8 +2371,6 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
>   	.class		=&omap44xx_ipu_hwmod_class,
>   	.mpu_irqs	= omap44xx_ipu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_ipu_irqs),
> -	.rst_lines	= omap44xx_ipu_resets,
> -	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_resets),
>   	.main_clk	= "ipu_fck",
>   	.prcm		= {
>   		.omap4 = {
> @@ -3711,6 +3700,145 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
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
> +	.sysc_fields	=&omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
> +	.name = "mmu",
> +	.sysc =&mmu_sysc,
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

Minor comment, but if we want to focus on the MMU as the main class, 
then ipu and dsp will become just instance qualifiers, and thus the name 
should be mmu_ipu and mmu_dsp.

Regards,
Benoit
