From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 4/6] OMAP4: hwmod data: Add McSPI
Date: Mon, 17 Jan 2011 08:29:31 -0800
Message-ID: <87wrm35w9g.fsf@ti.com>
References: <32203.10.24.255.18.1295274218.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46235 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751955Ab1AQQ3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 11:29:36 -0500
Received: by mail-gy0-f176.google.com with SMTP id 1so2580848gyf.7
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 08:29:36 -0800 (PST)
In-Reply-To: <32203.10.24.255.18.1295274218.squirrel@dbdmail.itg.ti.com>
	(Govindraj R.'s message of "Mon, 17 Jan 2011 19:53:38 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Charulatha V <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Update omap4 hwmod file with McSPI info.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Shouldn't Benoit be the author of this patch?

Kevin

> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  266 ++++++++++++++++++++++++++++
>  1 files changed, 266 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index c2806bd..d4cd695 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -24,6 +24,7 @@
>  #include <plat/cpu.h>
>  #include <plat/gpio.h>
>  #include <plat/dma.h>
> +#include <plat/mcspi.h>
>
>  #include "omap_hwmod_common_data.h"
>
> @@ -2001,6 +2002,265 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  };
>
> +/*
> + * 'mcspi' class
> + * multichannel serial port interface (mcspi) / master/slave synchronous serial
> + * bus
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_mcspi_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
> +			   SYSC_HAS_SOFTRESET | SYSC_HAS_RESET_STATUS),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type2,
> +};
> +
> +static struct omap_hwmod_class omap44xx_mcspi_hwmod_class = {
> +	.name = "mcspi",
> +	.sysc = &omap44xx_mcspi_sysc,
> +	.rev = OMAP4_MCSPI_REV,
> +};
> +
> +/* mcspi1 */
> +static struct omap_hwmod omap44xx_mcspi1_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_mcspi1_irqs[] = {
> +	{ .irq = 65 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] = {
> +	{ .name = "tx0", .dma_req = 34 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx0", .dma_req = 35 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "tx1", .dma_req = 36 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx1", .dma_req = 37 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "tx2", .dma_req = 38 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx2", .dma_req = 39 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "tx3", .dma_req = 40 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx3", .dma_req = 41 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcspi1_addrs[] = {
> +	{
> +		.pa_start	= 0x48098000,
> +		.pa_end		= 0x480981ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> mcspi1 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi1 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_mcspi1_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_mcspi1_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi1_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcspi1 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_mcspi1_slaves[] = {
> +	&omap44xx_l4_per__mcspi1,
> +};
> +
> +static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
> +	.num_chipselect = 4,
> +};
> +
> +static struct omap_hwmod omap44xx_mcspi1_hwmod = {
> +	.name		= "mcspi1",
> +	.class		= &omap44xx_mcspi_hwmod_class,
> +	.mpu_irqs	= omap44xx_mcspi1_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi1_irqs),
> +	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi1_sdma_reqs),
> +	.main_clk	= "mcspi1_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_mcspi1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi1_slaves),
> +	.dev_attr       = &omap_mcspi1_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* mcspi2 */
> +static struct omap_hwmod omap44xx_mcspi2_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_mcspi2_irqs[] = {
> +	{ .irq = 66 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] = {
> +	{ .name = "tx0", .dma_req = 42 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx0", .dma_req = 43 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "tx1", .dma_req = 44 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx1", .dma_req = 45 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcspi2_addrs[] = {
> +	{
> +		.pa_start	= 0x4809a000,
> +		.pa_end		= 0x4809a1ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> mcspi2 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi2 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_mcspi2_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_mcspi2_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi2_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcspi2 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_mcspi2_slaves[] = {
> +	&omap44xx_l4_per__mcspi2,
> +};
> +
> +static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
> +	.num_chipselect = 2,
> +};
> +
> +static struct omap_hwmod omap44xx_mcspi2_hwmod = {
> +	.name		= "mcspi2",
> +	.class		= &omap44xx_mcspi_hwmod_class,
> +	.mpu_irqs	= omap44xx_mcspi2_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi2_irqs),
> +	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi2_sdma_reqs),
> +	.main_clk	= "mcspi2_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_mcspi2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi2_slaves),
> +	.dev_attr       = &omap_mcspi2_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* mcspi3 */
> +static struct omap_hwmod omap44xx_mcspi3_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_mcspi3_irqs[] = {
> +	{ .irq = 91 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] = {
> +	{ .name = "tx0", .dma_req = 14 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx0", .dma_req = 15 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "tx1", .dma_req = 22 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx1", .dma_req = 23 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcspi3_addrs[] = {
> +	{
> +		.pa_start	= 0x480b8000,
> +		.pa_end		= 0x480b81ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> mcspi3 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi3 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_mcspi3_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_mcspi3_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi3_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcspi3 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_mcspi3_slaves[] = {
> +	&omap44xx_l4_per__mcspi3,
> +};
> +
> +static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
> +	.num_chipselect = 2,
> +};
> +
> +static struct omap_hwmod omap44xx_mcspi3_hwmod = {
> +	.name		= "mcspi3",
> +	.class		= &omap44xx_mcspi_hwmod_class,
> +	.mpu_irqs	= omap44xx_mcspi3_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi3_irqs),
> +	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi3_sdma_reqs),
> +	.main_clk	= "mcspi3_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_mcspi3_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi3_slaves),
> +	.dev_attr       = &omap_mcspi3_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* mcspi4 */
> +static struct omap_hwmod omap44xx_mcspi4_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_mcspi4_irqs[] = {
> +	{ .irq = 48 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] = {
> +	{ .name = "tx0", .dma_req = 69 + OMAP44XX_DMA_REQ_START },
> +	{ .name = "rx0", .dma_req = 70 + OMAP44XX_DMA_REQ_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_mcspi4_addrs[] = {
> +	{
> +		.pa_start	= 0x480ba000,
> +		.pa_end		= 0x480ba1ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_per -> mcspi4 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi4 = {
> +	.master		= &omap44xx_l4_per_hwmod,
> +	.slave		= &omap44xx_mcspi4_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_mcspi4_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi4_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcspi4 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_mcspi4_slaves[] = {
> +	&omap44xx_l4_per__mcspi4,
> +};
> +
> +static struct omap2_mcspi_dev_attr omap_mcspi4_dev_attr = {
> +	.num_chipselect = 1,
> +};
> +
> +static struct omap_hwmod omap44xx_mcspi4_hwmod = {
> +	.name		= "mcspi4",
> +	.class		= &omap44xx_mcspi_hwmod_class,
> +	.mpu_irqs	= omap44xx_mcspi4_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi4_irqs),
> +	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi4_sdma_reqs),
> +	.main_clk	= "mcspi4_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_mcspi4_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi4_slaves),
> +	.dev_attr       = &omap_mcspi4_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
>  static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>
>  	/* dmm class */
> @@ -2068,6 +2328,12 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>  	&omap44xx_wd_timer2_hwmod,
>  	&omap44xx_wd_timer3_hwmod,
>
> +	/* mcspi class */
> +	&omap44xx_mcspi1_hwmod,
> +	&omap44xx_mcspi2_hwmod,
> +	&omap44xx_mcspi3_hwmod,
> +	&omap44xx_mcspi4_hwmod,
> +
>  	NULL,
>  };
