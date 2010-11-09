From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 04/13] OMAP2420: DMA: hwmod: add system DMA
Date: Tue, 09 Nov 2010 15:13:38 -0800
Message-ID: <87mxpihyzh.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62024 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab0KIXNm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 18:13:42 -0500
Received: by pva4 with SMTP id 4so1112pva.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 15:13:41 -0800 (PST)
In-Reply-To: <1288099513-1854-5-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 26 Oct 2010 18:55:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Add OMAP2420 DMA hwmod structures.

s/structures/data/

Also, as pointed out in many other hwmod reviews, when adding hwmod
data, subject should be something like: 

      OMAP2420: hwmod_data: add system DMA

Kevin


> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   85 ++++++++++++++++++++++++++++
>  1 files changed, 85 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index a1a3dd6..3a51392 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -38,6 +38,7 @@ static struct omap_hwmod omap2420_iva_hwmod;
>  static struct omap_hwmod omap2420_l3_main_hwmod;
>  static struct omap_hwmod omap2420_l4_core_hwmod;
>  static struct omap_hwmod omap2420_wd_timer2_hwmod;
> +static struct omap_hwmod omap2420_dma_system_hwmod;
>  
>  /* L3 -> L4_CORE interface */
>  static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
> @@ -557,6 +558,89 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
>  	.flags		= HWMOD_16BIT_REG,
>  };
>  
> +/* system dma */
> +static struct omap_hwmod_class_sysconfig omap2420_dma_sysc = {
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
> +static struct omap_hwmod_class omap2420_dma_hwmod_class = {
> +	.name = "dma",
> +	.sysc = &omap2420_dma_sysc,
> +};
> +
> +/* dma attributes */
> +static struct omap_dma_dev_attr dma_dev_attr = {
> +	.dev_caps  = DMA_LINKED_LCH | GLOBAL_PRIORITY |
> +				IS_CSSA_32 | IS_CDSA_32,
> +	.lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT,
> +};
> +
> +static struct omap_hwmod_irq_info omap2420_dma_system_irqs[] = {
> +	{ .name = "0", .irq = INT_24XX_SDMA_IRQ0 },
> +	{ .name = "1", .irq = INT_24XX_SDMA_IRQ1 },
> +	{ .name = "2", .irq = INT_24XX_SDMA_IRQ2 },
> +	{ .name = "3", .irq = INT_24XX_SDMA_IRQ3 },
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] = {
> +	{
> +		.pa_start	= 0x48056000,
> +		.pa_end		= 0x4a0560ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* dma_system -> L3 */
> +static struct omap_hwmod_ocp_if omap2420_dma_system__l3 = {
> +	.master		= &omap2420_dma_system_hwmod,
> +	.slave		= &omap2420_l3_main_hwmod,
> +	.clk		= "l3_div_ck",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* dma_system master ports */
> +static struct omap_hwmod_ocp_if *omap2420_dma_system_masters[] = {
> +	&omap2420_dma_system__l3,
> +};
> +
> +/* l4_cfg -> dma_system */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_dma_system_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap2420_dma_system_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_dma_system_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* dma_system slave ports */
> +static struct omap_hwmod_ocp_if *omap2420_dma_system_slaves[] = {
> +	&omap2420_l4_core__dma_system,
> +};
> +
> +static struct omap_hwmod omap2420_dma_system_hwmod = {
> +	.name		= "dma",
> +	.class		= &omap2420_dma_hwmod_class,
> +	.mpu_irqs	= omap2420_dma_system_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_dma_system_irqs),
> +	.main_clk	= "l3_div_ck",
> +	.slaves		= omap2420_dma_system_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_dma_system_slaves),
> +	.masters	= omap2420_dma_system_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap2420_dma_system_masters),
> +	.dev_attr	= &dma_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +	.flags		= HWMOD_NO_IDLEST,
> +};
> +
>  static __initdata struct omap_hwmod *omap2420_hwmods[] = {
>  	&omap2420_l3_main_hwmod,
>  	&omap2420_l4_core_hwmod,
> @@ -569,6 +653,7 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
>  	&omap2420_uart3_hwmod,
>  	&omap2420_i2c1_hwmod,
>  	&omap2420_i2c2_hwmod,
> +	&omap2420_dma_system_hwmod,
>  	NULL,
>  };
