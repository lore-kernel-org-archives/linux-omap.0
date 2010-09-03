From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 04/11] OMAP3: DMA: HWMOD: Add hwmod data structures
Date: Fri, 03 Sep 2010 13:51:57 -0700
Message-ID: <871v9awnwy.fsf@deeprootsystems.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64993 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757461Ab0ICUwB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 16:52:01 -0400
Received: by ywh1 with SMTP id 1so953031ywh.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 13:52:00 -0700 (PDT)
In-Reply-To: <1282647866-6918-5-git-send-email-manjugk@ti.com> (Manjunatha
	GK's message of "Tue, 24 Aug 2010 16:34:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

> This patch adds OMAP3 DMA hwmod structures.

Subject should be something like: OMAP3: hwmod data: add system DMA

> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   85 ++++++++++++++++++++++++++++
>  1 files changed, 85 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 5d8eb58..0979c51 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -36,6 +36,7 @@ static struct omap_hwmod omap3xxx_iva_hwmod;
>  static struct omap_hwmod omap3xxx_l3_main_hwmod;
>  static struct omap_hwmod omap3xxx_l4_core_hwmod;
>  static struct omap_hwmod omap3xxx_l4_per_hwmod;
> +static struct omap_hwmod omap3xxx_dma_system_hwmod;
>  
>  /* L3 -> L4_CORE interface */
>  static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
> @@ -197,6 +198,89 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
>  };
>  
> +/* dma_system -> L3 */
> +static struct omap_hwmod_ocp_if omap3xxx_dma_system__l3 = {
> +	.master		= &omap3xxx_dma_system_hwmod,
> +	.slave		= &omap3xxx_l3_main_hwmod,
> +	.clk		= "l3_div_ck",

This clock dosn't exist in l-o, which I see due to the boot message:

    omap_hwmod: dma: cannot clk_get main_clk l3_div_ck  

I think you mean core_l3_ick here.

> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* dma attributes */
> +static struct omap_dma_dev_attr dma_dev_attr = {
> +	.dev_caps  = DMA_LINKED_LCH | GLOBAL_PRIORITY |
> +				IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORIY,
> +	.lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap3xxx_dma_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x002c,
> +	.syss_offs	= 0x0028,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> +			   SYSC_HAS_MIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> +			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> +			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap3xxx_dma_hwmod_class = {
> +	.name = "dma",
> +	.sysc = &omap3xxx_dma_sysc,
> +};
> +
> +/* dma_system */
> +static struct omap_hwmod_irq_info omap3xxx_dma_system_irqs[] = {
> +	{ .name = "0", .irq = INT_24XX_SDMA_IRQ0 },
> +	{ .name = "1", .irq = INT_24XX_SDMA_IRQ1 },
> +	{ .name = "2", .irq = INT_24XX_SDMA_IRQ2 },
> +	{ .name = "3", .irq = INT_24XX_SDMA_IRQ3 },
> +};
> +
> +static struct omap_hwmod_addr_space omap3xxx_dma_system_addrs[] = {
> +	{
> +		.pa_start	= 0x48056000,
> +		.pa_end		= 0x4a0560ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* dma_system master ports */
> +static struct omap_hwmod_ocp_if *omap3xxx_dma_system_masters[] = {
> +	&omap3xxx_dma_system__l3,
> +};
> +
> +/* l4_cfg -> dma_system */
> +static struct omap_hwmod_ocp_if omap3xxx_l4_core__dma_system = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &omap3xxx_dma_system_hwmod,
> +	.clk		= "l4_div_ck",

This clock doesn't exist in l-o, resulting in the boot message:

   omap_hwmod: dma: cannot clk_get interface_clk l4_div_ck   

I think you meant "core_l4_ick" here.

> +	.addr		= omap3xxx_dma_system_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_dma_system_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* dma_system slave ports */
> +static struct omap_hwmod_ocp_if *omap3xxx_dma_system_slaves[] = {
> +	&omap3xxx_l4_core__dma_system,
> +};
> +
> +static struct omap_hwmod omap3xxx_dma_system_hwmod = {
> +	.name		= "dma",
> +	.class		= &omap3xxx_dma_hwmod_class,
> +	.mpu_irqs	= omap3xxx_dma_system_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dma_system_irqs),
> +	.main_clk	= "l3_div_ck",
> +	.slaves		= omap3xxx_dma_system_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dma_system_slaves),
> +	.masters	= omap3xxx_dma_system_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap3xxx_dma_system_masters),
> +	.dev_attr	= &dma_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.flags		= HWMOD_NO_IDLEST,

hmm, I see an ST_DMA bit in CM_IDLEST1_CORE for DMA.

Having this also masks the fact that you haven't filled out the
.prcm.omap2 fields of the hwmod, at least the idlest ones are needed
here.

Kevin

> +};
> +
>  static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>  	&omap3xxx_l3_main_hwmod,
>  	&omap3xxx_l4_core_hwmod,
> @@ -204,6 +288,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>  	&omap3xxx_l4_wkup_hwmod,
>  	&omap3xxx_mpu_hwmod,
>  	&omap3xxx_iva_hwmod,
> +	&omap3xxx_dma_system_hwmod,
>  	NULL,
>  };


