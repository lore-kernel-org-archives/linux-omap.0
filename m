From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: Re: Subject: [PATCH 06/10] [PM-WIP-UART] OMAP4 hwmod : Adding
     hwmod      data for UART
Date: Sat, 21 Aug 2010 01:45:08 +0530 (IST)
Message-ID: <16663.10.24.255.18.1282335308.squirrel@dbdmail.itg.ti.com>
References: <16142.10.24.255.18.1282335058.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34735 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab0HTUPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 16:15:13 -0400
In-Reply-To: <16142.10.24.255.18.1282335058.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com, b-cousson@ti.com


Please ignore , will send with proper subject

Regards,
Kishore
> From: Benoit Cousson <b-cousson@ti.com>
> Adding HWMOD data for UART on OMAP4
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  234 ++++++++++++++++++++++++++++
>  1 files changed, 234 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index db62b84..8266b5c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -778,6 +778,235 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  };
>
> +/*
> + * 'uart' class
> + * universal asynchronous receiver/transmitter (uart)
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_uart_sysc = {
> +	.rev_offs	= 0x0050,
> +	.sysc_offs	= 0x0054,
> +	.syss_offs	= 0x0058,
> +	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
> +			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_uart_hwmod_class = {
> +	.name = "uart",
> +	.sysc = &omap44xx_uart_sysc,
> +};
> +
> +/* uart1 */
> +static struct omap_hwmod omap44xx_uart1_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_uart1_irqs[] = {
> +	{ .irq = 72 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_uart1_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 48 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 49 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_uart1_addrs[] = {
> +	{
> +		.pa_start	= 0x4806a000,
> +		.pa_end		= 0x4806a0ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> uart1 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__uart1 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_uart1_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_uart1_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_uart1_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* uart1 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_uart1_slaves[] = {
> +	&omap44xx_l4_per__uart1,
> +};
> +
> +static struct omap_hwmod omap44xx_uart1_hwmod = {
> +	.name		= "uart1",
> +	.class		= &omap44xx_uart_hwmod_class,
> +	.mpu_irqs	= omap44xx_uart1_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_uart1_irqs),
> +	.sdma_reqs	= omap44xx_uart1_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_uart1_sdma_reqs),
> +	.main_clk	= "uart1_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_UART1_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_uart1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart1_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* uart2 */
> +static struct omap_hwmod omap44xx_uart2_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_uart2_irqs[] = {
> +	{ .irq = 73 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_uart2_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 50 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 51 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_uart2_addrs[] = {
> +	{
> +		.pa_start	= 0x4806c000,
> +		.pa_end		= 0x4806c0ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> uart2 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__uart2 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_uart2_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_uart2_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_uart2_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* uart2 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_uart2_slaves[] = {
> +	&omap44xx_l4_per__uart2,
> +};
> +
> +static struct omap_hwmod omap44xx_uart2_hwmod = {
> +	.name		= "uart2",
> +	.class		= &omap44xx_uart_hwmod_class,
> +	.mpu_irqs	= omap44xx_uart2_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_uart2_irqs),
> +	.sdma_reqs	= omap44xx_uart2_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_uart2_sdma_reqs),
> +	.main_clk	= "uart2_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_UART2_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_uart2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart2_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* uart3 */
> +static struct omap_hwmod omap44xx_uart3_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_uart3_irqs[] = {
> +	{ .irq = 74 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_uart3_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 52 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 53 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_uart3_addrs[] = {
> +	{
> +		.pa_start	= 0x48020000,
> +		.pa_end		= 0x480200ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> uart3 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__uart3 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_uart3_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_uart3_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_uart3_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* uart3 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_uart3_slaves[] = {
> +	&omap44xx_l4_per__uart3,
> +};
> +
> +static struct omap_hwmod omap44xx_uart3_hwmod = {
> +	.name		= "uart3",
> +	.class		= &omap44xx_uart_hwmod_class,
> +	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> +	.mpu_irqs	= omap44xx_uart3_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_uart3_irqs),
> +	.sdma_reqs	= omap44xx_uart3_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_uart3_sdma_reqs),
> +	.main_clk	= "uart3_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_UART3_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_uart3_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart3_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* uart4 */
> +static struct omap_hwmod omap44xx_uart4_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_uart4_irqs[] = {
> +	{ .irq = 70 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_uart4_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 54 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 55 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_uart4_addrs[] = {
> +	{
> +		.pa_start	= 0x4806e000,
> +		.pa_end		= 0x4806e0ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> uart4 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__uart4 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_uart4_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_uart4_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_uart4_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* uart4 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_uart4_slaves[] = {
> +	&omap44xx_l4_per__uart4,
> +};
> +
> +static struct omap_hwmod omap44xx_uart4_hwmod = {
> +	.name		= "uart4",
> +	.class		= &omap44xx_uart_hwmod_class,
> +	.mpu_irqs	= omap44xx_uart4_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_uart4_irqs),
> +	.sdma_reqs	= omap44xx_uart4_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_uart4_sdma_reqs),
> +	.main_clk	= "uart4_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_UART4_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_uart4_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_uart4_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
>  static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>  	/* dmm class */
>  	&omap44xx_dmm_hwmod,
> @@ -801,6 +1030,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>  	&omap44xx_mmc3_hwmod,
>  	&omap44xx_mmc4_hwmod,
>  	&omap44xx_mmc5_hwmod,
> +	/* uart class */
> +	&omap44xx_uart1_hwmod,
> +	&omap44xx_uart2_hwmod,
> +	&omap44xx_uart3_hwmod,
> +	&omap44xx_uart4_hwmod,
>  	/* mpu class */
>  	&omap44xx_mpu_hwmod,
>  	NULL,
> --
> 1.7.0.4
>


