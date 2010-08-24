From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH v2 03/11] OMAP2430: DMA: HWMOD: Add hwmod data
	structures
Date: Tue, 24 Aug 2010 14:30:54 +0300
Message-ID: <20100824113054.GG25559@gw.healthdatacare.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com> <1282647866-6918-4-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63214 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0HXLbB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 07:31:01 -0400
Received: by bwz11 with SMTP id 11so4701465bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 04:30:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282647866-6918-4-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi,

On Tue, Aug 24, 2010 at 04:34:18PM +0530, Manjunatha GK wrote:
> This patch adds OMAP2430 DMA hwmod structures.
> 
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   85 ++++++++++++++++++++++++++++
>  1 files changed, 85 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index 4526628..3d79a52 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -33,6 +33,7 @@ static struct omap_hwmod omap2430_mpu_hwmod;
>  static struct omap_hwmod omap2430_iva_hwmod;
>  static struct omap_hwmod omap2430_l3_main_hwmod;
>  static struct omap_hwmod omap2430_l4_core_hwmod;
> +static struct omap_hwmod omap2430_dma_system_hwmod;
>  
>  /* L3 -> L4_CORE interface */
>  static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
> @@ -165,12 +166,96 @@ static struct omap_hwmod omap2430_iva_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
>  };
>  
> +/* dma_system */
> +static struct omap_hwmod_class_sysconfig omap2430_dma_sysc = {
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
> +static struct omap_hwmod_class omap2430_dma_hwmod_class = {
> +	.name = "dma",
> +	.sysc = &omap2430_dma_sysc,
> +};
> +
> +/* dma attributes */
> +static struct omap_dma_dev_attr dma_dev_attr = {
> +	.dev_caps  = DMA_LINKED_LCH | GLOBAL_PRIORITY |
> +				IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORIY,
                                                          ^^^^^^^^^^^^^

Should this be IS_RW_PRIORITY? Same typo seems to be also in other patches which
add hwmod structures.

Regards,
MW


> +	.lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT,
> +};
> +
> +static struct omap_hwmod_irq_info omap2430_dma_system_irqs[] = {
> +	{ .name = "0", .irq = INT_24XX_SDMA_IRQ0 },
> +	{ .name = "1", .irq = INT_24XX_SDMA_IRQ1 },
> +	{ .name = "2", .irq = INT_24XX_SDMA_IRQ2 },
> +	{ .name = "3", .irq = INT_24XX_SDMA_IRQ3 },
> +};
> +
> +static struct omap_hwmod_addr_space omap2430_dma_system_addrs[] = {
> +	{
> +		.pa_start	= 0x48056000,
> +		.pa_end		= 0x4a0560ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* dma_system -> L3 */
> +static struct omap_hwmod_ocp_if omap2430_dma_system__l3 = {
> +	.master		= &omap2430_dma_system_hwmod,
> +	.slave		= &omap2430_l3_main_hwmod,
> +	.clk		= "l3_div_ck",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* dma_system master ports */
> +static struct omap_hwmod_ocp_if *omap2430_dma_system_masters[] = {
> +	&omap2430_dma_system__l3,
> +};
> +
> +/* l4_cfg -> dma_system */
> +static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system = {
> +	.master		= &omap2430_l4_core_hwmod,
> +	.slave		= &omap2430_dma_system_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap2430_dma_system_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2430_dma_system_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* dma_system slave ports */
> +static struct omap_hwmod_ocp_if *omap2430_dma_system_slaves[] = {
> +	&omap2430_l4_core__dma_system,
> +};
> +
> +static struct omap_hwmod omap2430_dma_system_hwmod = {
> +	.name		= "dma",
> +	.class		= &omap2430_dma_hwmod_class,
> +	.mpu_irqs	= omap2430_dma_system_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_dma_system_irqs),
> +	.main_clk	= "l3_div_ck",
> +	.slaves		= omap2430_dma_system_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2430_dma_system_slaves),
> +	.masters	= omap2430_dma_system_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap2430_dma_system_masters),
> +	.dev_attr	= &dma_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
> +	.flags		= HWMOD_NO_IDLEST,
> +};
> +
>  static __initdata struct omap_hwmod *omap2430_hwmods[] = {
>  	&omap2430_l3_main_hwmod,
>  	&omap2430_l4_core_hwmod,
>  	&omap2430_l4_wkup_hwmod,
>  	&omap2430_mpu_hwmod,
>  	&omap2430_iva_hwmod,
> +	&omap2430_dma_system_hwmod,
>  	NULL,
>  };
>  
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
