From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 3/5] OMAP4: hwmod: add I2C hwmods for OMAP4430
Date: Tue, 28 Sep 2010 10:13:08 -0700
Message-ID: <878w2leqqj.fsf@deeprootsystems.com>
References: <1284734229-16281-1-git-send-email-rnayak@ti.com>
	<1284734229-16281-2-git-send-email-rnayak@ti.com>
	<1284734229-16281-3-git-send-email-rnayak@ti.com>
	<1284734229-16281-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45386 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756935Ab0I1RNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 13:13:13 -0400
Received: by iwn5 with SMTP id 5so6205964iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 10:13:12 -0700 (PDT)
In-Reply-To: <1284734229-16281-4-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Fri, 17 Sep 2010 20:07:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Rajendra Nayak <rnayak@ti.com> writes:

> Add hwmod structures for I2C controllers on OMAP4430.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
> This patch is extracted from the below patch
> OMAP4: hwmod: Add initial data for OMAP4430 ES1 & ES2
> https://patchwork.kernel.org/patch/117347/

minor note: I will change the authorship to Benoit for this patch.

Thanks,

Kevin

>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  237 ++++++++++++++++++++++++++++
>  1 files changed, 237 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index e20b0ee..2cb63fc 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -383,6 +383,238 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
>  };
>  
>  /*
> + * 'i2c' class
> + * multimaster high-speed i2c controller
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0090,
> +	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
> +			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SOFTRESET |
> +			   SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
> +	.name = "i2c",
> +	.sysc = &omap44xx_i2c_sysc,
> +};
> +
> +/* i2c1 */
> +static struct omap_hwmod omap44xx_i2c1_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
> +	{ .irq = 56 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_i2c1_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 26 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 27 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_i2c1_addrs[] = {
> +	{
> +		.pa_start	= 0x48070000,
> +		.pa_end		= 0x480700ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> i2c1 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c1 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_i2c1_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_i2c1_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_i2c1_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* i2c1 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
> +	&omap44xx_l4_per__i2c1,
> +};
> +
> +static struct omap_hwmod omap44xx_i2c1_hwmod = {
> +	.name		= "i2c1",
> +	.class		= &omap44xx_i2c_hwmod_class,
> +	.flags		= HWMOD_INIT_NO_RESET,
> +	.mpu_irqs	= omap44xx_i2c1_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_irqs),
> +	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_sdma_reqs),
> +	.main_clk	= "i2c1_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_I2C1_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_i2c1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* i2c2 */
> +static struct omap_hwmod omap44xx_i2c2_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_i2c2_irqs[] = {
> +	{ .irq = 57 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_i2c2_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 28 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 29 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_i2c2_addrs[] = {
> +	{
> +		.pa_start	= 0x48072000,
> +		.pa_end		= 0x480720ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> i2c2 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c2 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_i2c2_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_i2c2_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_i2c2_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* i2c2 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
> +	&omap44xx_l4_per__i2c2,
> +};
> +
> +static struct omap_hwmod omap44xx_i2c2_hwmod = {
> +	.name		= "i2c2",
> +	.class		= &omap44xx_i2c_hwmod_class,
> +	.flags		= HWMOD_INIT_NO_RESET,
> +	.mpu_irqs	= omap44xx_i2c2_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_irqs),
> +	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_sdma_reqs),
> +	.main_clk	= "i2c2_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_I2C2_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_i2c2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* i2c3 */
> +static struct omap_hwmod omap44xx_i2c3_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_i2c3_irqs[] = {
> +	{ .irq = 61 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_i2c3_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 24 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 25 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_i2c3_addrs[] = {
> +	{
> +		.pa_start	= 0x48060000,
> +		.pa_end		= 0x480600ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> i2c3 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c3 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_i2c3_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_i2c3_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_i2c3_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* i2c3 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
> +	&omap44xx_l4_per__i2c3,
> +};
> +
> +static struct omap_hwmod omap44xx_i2c3_hwmod = {
> +	.name		= "i2c3",
> +	.class		= &omap44xx_i2c_hwmod_class,
> +	.flags		= HWMOD_INIT_NO_RESET,
> +	.mpu_irqs	= omap44xx_i2c3_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_irqs),
> +	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_sdma_reqs),
> +	.main_clk	= "i2c3_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_I2C3_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_i2c3_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* i2c4 */
> +static struct omap_hwmod omap44xx_i2c4_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_i2c4_irqs[] = {
> +	{ .irq = 62 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_i2c4_sdma_reqs[] = {
> +	{ .name = "tx", .dma_req = 123 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx", .dma_req = 124 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_i2c4_addrs[] = {
> +	{
> +		.pa_start	= 0x48350000,
> +		.pa_end		= 0x483500ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> i2c4 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c4 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_i2c4_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_i2c4_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_i2c4_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* i2c4 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
> +	&omap44xx_l4_per__i2c4,
> +};
> +
> +static struct omap_hwmod omap44xx_i2c4_hwmod = {
> +	.name		= "i2c4",
> +	.class		= &omap44xx_i2c_hwmod_class,
> +	.flags		= HWMOD_INIT_NO_RESET,
> +	.mpu_irqs	= omap44xx_i2c4_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_irqs),
> +	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_sdma_reqs),
> +	.main_clk	= "i2c4_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_I2C4_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_i2c4_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/*
>   * 'mpu_bus' class
>   * instance(s): mpu_private
>   */
> @@ -467,6 +699,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>  	&omap44xx_l4_cfg_hwmod,
>  	&omap44xx_l4_per_hwmod,
>  	&omap44xx_l4_wkup_hwmod,
> +	/* i2c class */
> +	&omap44xx_i2c1_hwmod,
> +	&omap44xx_i2c2_hwmod,
> +	&omap44xx_i2c3_hwmod,
> +	&omap44xx_i2c4_hwmod,
>  	/* mpu_bus class */
>  	&omap44xx_mpu_private_hwmod,
