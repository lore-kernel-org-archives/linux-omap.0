From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Work around hardcoded interrupts
Date: Thu, 15 Jan 2015 08:20:23 -0800
Message-ID: <20150115162022.GD18552@atomide.com>
References: <1421335212-4115-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15133 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751219AbbAOQYX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2015 11:24:23 -0500
Content-Disposition: inline
In-Reply-To: <1421335212-4115-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Felipe Balbi <balbi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Marc Zyngier <marc.zyngier@arm.com> [150115 07:24]:
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -256,6 +256,38 @@ static int __init omap4_sar_ram_init(void)
>  }
>  omap_early_initcall(omap4_sar_ram_init);
>  
> +static struct of_device_id gic_match[] = {
> +	{ .compatible = "arm,cortex-a9-gic", },
> +	{ .compatible = "arm,cortex-a15-gic", },
> +	{ },
> +};
> +
> +static struct device_node *gic_node;
> +
> +unsigned int omap4_xlate_irq(unsigned int hwirq)
> +{
> +	struct of_phandle_args irq_data;
> +	unsigned int irq;
> +
> +	if (!gic_node)
> +		gic_node = of_find_matching_node(NULL, gic_match);
> +
> +	if (WARN_ON(!gic_node))
> +		return hwirq;
> +
> +	irq_data.np = gic_node;
> +	irq_data.args_count = 3;
> +	irq_data.args[0] = 0;
> +	irq_data.args[1] = hwirq - OMAP44XX_IRQ_GIC_START;
> +	irq_data.args[2] = IRQ_TYPE_LEVEL_HIGH;
> +
> +	irq = irq_create_of_mapping(&irq_data);
> +	if (WARN_ON(!irq))
> +		irq = hwirq;
> +
> +	return irq;
> +}
> +
>  void __init omap_gic_of_init(void)
>  {
>  	struct device_node *np;

Thanks for the quick fix, this is is fine with me as long as we
don't have other legacy users. At least I did not find any other
legacy users based on a quick grep.

> --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> @@ -288,6 +288,7 @@ static struct omap_hwmod omap54xx_dma_system_hwmod = {
>  	.class		= &omap54xx_dma_hwmod_class,
>  	.clkdm_name	= "dma_clkdm",
>  	.mpu_irqs	= omap54xx_dma_system_irqs,
> +	.xlate_irq	= omap4_xlate_irq,
>  	.main_clk	= "l3_iclk_div",
>  	.prcm = {
>  		.omap4 = {

We could now drop the legacy DMA init completely for omap4 and later.
But that would require patching the legacy DMA for the exported
functions.. So probably not doable for the -rc series and does not
solve the issue with other legacy IRQ users.

> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -71,9 +71,12 @@ void __init omap4_pmic_init(const char *pmic_type,
>  		    struct i2c_board_info *devices, int nr_devices)
>  {
>  	/* PMIC part*/
> +	unsigned int irq;
> +
>  	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
>  	omap_mux_init_signal("fref_clk0_out.sys_drm_msecure", OMAP_PIN_OUTPUT);
> -	omap_pmic_init(1, 400, pmic_type, 7 + OMAP44XX_IRQ_GIC_START, pmic_data);
> +	irq = omap4_xlate_irq(7 + OMAP44XX_IRQ_GIC_START);
> +	omap_pmic_init(1, 400, pmic_type, irq, pmic_data);
>  
>  	/* Register additional devices on i2c1 bus if needed */
>  	if (devices)

FYI, I posted a patch yesterday to drop the legacy init code
for twl6040 as the legacy omap4_pmic_init() is no longer used.
No need to change this patch though.

So unless somebody has better ideas for the fix for -rc series,
I'll queue this with the twl6040 code removal patch.

Regards,

Tony
