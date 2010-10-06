From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/7] [RFC] OMAP: MCBSP: hwmod database for 4xxx devices
Date: Wed, 6 Oct 2010 11:20:59 +0200
Message-ID: <4CAC3F7B.30700@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com> <1286296662-7639-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53661 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367Ab0JFJVD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 05:21:03 -0400
In-Reply-To: <1286296662-7639-3-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Hi Kishon,

On 10/5/2010 6:37 PM, ABRAHAM, KISHON VIJAY wrote:
> From: Benoit Cousson<b-cousson@ti.com>
>
> MCBSP hwmod data values are auto-generated. The order of omap44xx_mcbsp3_slaves
> contents are changed since the driver uses the base address of
> omap44xx_l4_abe__mcbsp3_dma.

You should not do that... in theory.
In your case I do understand why, but we should find a better way to 
handle that. Ideally you should not rely on the order to get the proper 
resource. For some reason the memory areas are not named today, but this 
can be fixed if needed.

The other concern or question is don't we have to use direct access 
whenever possible? The second mapping is only needed for the SDMA 
access, not for the registers accesses.

So in your case, you will have to use two base address, for previous 
OMAPs, both will be the same, but in the case of OMAP4, you will use the 
direct one for all the register settings and the DMA one for DMA access.

Benoit

>
> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> Cc: Partha Basak<p-basak2@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  293 ++++++++++++++++++++++++++++
>   1 files changed, 293 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7274db4..1467840 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -811,6 +811,294 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
> +/*
> + * 'mcbsp' class
> + * multi channel buffered serial port controller
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_mcbsp_sysc = {
> +	.sysc_offs	= 0x008c,
> +	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_ENAWAKEUP |
> +			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	=&omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
> +	.name = "mcbsp",
> +	.sysc =&omap44xx_mcbsp_sysc,
> +};
> +
> +/* mcbsp1 */
> +static struct omap_hwmod omap44xx_mcbsp1_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_mcbsp1_irqs[] = {
> +	{ .name = "tx", .irq = 17 + OMAP44XX_IRQ_GIC_START },
> +	{ .name = "rx", .irq = 0 },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 32 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 33 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcbsp1_addrs[] = {
> +	{
> +		.pa_start	= 0x40122000,
> +		.pa_end		= 0x401220ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_abe ->  mcbsp1 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1 = {
> +	.master		=&omap44xx_l4_abe_hwmod,
> +	.slave		=&omap44xx_mcbsp1_hwmod,
> +	.clk		= "ocp_abe_iclk",
> +	.addr		= omap44xx_mcbsp1_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_addrs),
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcbsp1_dma_addrs[] = {
> +	{
> +		.pa_start	= 0x49022000,
> +		.pa_end		= 0x490220ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_abe ->  mcbsp1 (dma) */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1_dma = {
> +	.master		=&omap44xx_l4_abe_hwmod,
> +	.slave		=&omap44xx_mcbsp1_hwmod,
> +	.clk		= "ocp_abe_iclk",
> +	.addr		= omap44xx_mcbsp1_dma_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_dma_addrs),
> +	.user		= OCP_USER_SDMA,
> +};
> +
> +/* mcbsp1 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_mcbsp1_slaves[] = {
> +	&omap44xx_l4_abe__mcbsp1_dma,
> +	&omap44xx_l4_abe__mcbsp1,
> +};
> +
> +static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
> +	.name		= "mcbsp1",
> +	.class		=&omap44xx_mcbsp_hwmod_class,
> +	.mpu_irqs	= omap44xx_mcbsp1_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_irqs),
> +	.sdma_reqs	= omap44xx_mcbsp1_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_sdma_reqs),
> +	.main_clk	= "mcbsp1_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_mcbsp1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* mcbsp2 */
> +static struct omap_hwmod omap44xx_mcbsp2_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_mcbsp2_irqs[] = {
> +	{ .name = "tx", .irq = 22 + OMAP44XX_IRQ_GIC_START },
> +	{ .name = "rx", .irq = 0 },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 16 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 17 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcbsp2_addrs[] = {
> +	{
> +		.pa_start	= 0x40124000,
> +		.pa_end		= 0x401240ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_abe ->  mcbsp2 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2 = {
> +	.master		=&omap44xx_l4_abe_hwmod,
> +	.slave		=&omap44xx_mcbsp2_hwmod,
> +	.clk		= "ocp_abe_iclk",
> +	.addr		= omap44xx_mcbsp2_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_addrs),
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcbsp2_dma_addrs[] = {
> +	{
> +		.pa_start	= 0x49024000,
> +		.pa_end		= 0x490240ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_abe ->  mcbsp2 (dma) */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2_dma = {
> +	.master		=&omap44xx_l4_abe_hwmod,
> +	.slave		=&omap44xx_mcbsp2_hwmod,
> +	.clk		= "ocp_abe_iclk",
> +	.addr		= omap44xx_mcbsp2_dma_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_dma_addrs),
> +	.user		= OCP_USER_SDMA,
> +};
> +
> +/* mcbsp2 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_mcbsp2_slaves[] = {
> +	&omap44xx_l4_abe__mcbsp2_dma,
> +	&omap44xx_l4_abe__mcbsp2,
> +};
> +
> +static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
> +	.name		= "mcbsp2",
> +	.class		=&omap44xx_mcbsp_hwmod_class,
> +	.mpu_irqs	= omap44xx_mcbsp2_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_irqs),
> +	.sdma_reqs	= omap44xx_mcbsp2_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_sdma_reqs),
> +	.main_clk	= "mcbsp2_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_mcbsp2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* mcbsp3 */
> +static struct omap_hwmod omap44xx_mcbsp3_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_mcbsp3_irqs[] = {
> +	{ .name = "tx", .irq = 23 + OMAP44XX_IRQ_GIC_START },
> +	{ .name = "rx", .irq = 0 },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 18 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 19 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcbsp3_addrs[] = {
> +	{
> +		.pa_start	= 0x40126000,
> +		.pa_end		= 0x401260ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_abe ->  mcbsp3 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3 = {
> +	.master		=&omap44xx_l4_abe_hwmod,
> +	.slave		=&omap44xx_mcbsp3_hwmod,
> +	.clk		= "ocp_abe_iclk",
> +	.addr		= omap44xx_mcbsp3_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_addrs),
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcbsp3_dma_addrs[] = {
> +	{
> +		.pa_start	= 0x49026000,
> +		.pa_end		= 0x490260ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_abe ->  mcbsp3 (dma) */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3_dma = {
> +	.master		=&omap44xx_l4_abe_hwmod,
> +	.slave		=&omap44xx_mcbsp3_hwmod,
> +	.clk		= "ocp_abe_iclk",
> +	.addr		= omap44xx_mcbsp3_dma_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_dma_addrs),
> +	.user		= OCP_USER_SDMA,
> +};
> +
> +/* mcbsp3 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_mcbsp3_slaves[] = {
> +	&omap44xx_l4_abe__mcbsp3_dma,
> +	&omap44xx_l4_abe__mcbsp3,
> +};
> +
> +static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
> +	.name		= "mcbsp3",
> +	.class		=&omap44xx_mcbsp_hwmod_class,
> +	.mpu_irqs	= omap44xx_mcbsp3_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_irqs),
> +	.sdma_reqs	= omap44xx_mcbsp3_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_sdma_reqs),
> +	.main_clk	= "mcbsp3_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_mcbsp3_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* mcbsp4 */
> +static struct omap_hwmod omap44xx_mcbsp4_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_mcbsp4_irqs[] = {
> +	{ .name = "tx", .irq = 16 + OMAP44XX_IRQ_GIC_START },
> +	{ .name = "rx", .irq = 0 },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_mcbsp4_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 30 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 31 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcbsp4_addrs[] = {
> +	{
> +		.pa_start	= 0x48096000,
> +		.pa_end		= 0x480960ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per ->  mcbsp4 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__mcbsp4 = {
> +	.master		=&omap44xx_l4_per_hwmod,
> +	.slave		=&omap44xx_mcbsp4_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_mcbsp4_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcbsp4 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_mcbsp4_slaves[] = {
> +	&omap44xx_l4_per__mcbsp4,
> +};
> +
> +static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
> +	.name		= "mcbsp4",
> +	.class		=&omap44xx_mcbsp_hwmod_class,
> +	.mpu_irqs	= omap44xx_mcbsp4_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_irqs),
> +	.sdma_reqs	= omap44xx_mcbsp4_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_sdma_reqs),
> +	.main_clk	= "mcbsp4_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_mcbsp4_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +
>   static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	/* dmm class */
>   	&omap44xx_dmm_hwmod,
> @@ -840,6 +1128,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	&omap44xx_uart2_hwmod,
>   	&omap44xx_uart3_hwmod,
>   	&omap44xx_uart4_hwmod,
> +	/* mcbsp class */
> +	&omap44xx_mcbsp1_hwmod,
> +	&omap44xx_mcbsp2_hwmod,
> +	&omap44xx_mcbsp3_hwmod,
> +	&omap44xx_mcbsp4_hwmod,
>   	NULL,
>   };
>

