From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v7 05/11] OMAP2420: hwmod data: Add GPIO
Date: Wed, 24 Nov 2010 23:13:11 +0100
Message-ID: <4CED8DF7.6040606@ti.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <1290524213-395-6-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47903 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885Ab0KXWNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 17:13:17 -0500
In-Reply-To: <1290524213-395-6-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>

On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
> Add GPIO hwmod data for OMAP2420
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |  229 ++++++++++++++++++++++++++++
>   arch/arm/plat-omap/include/plat/gpio.h     |    5 +
>   2 files changed, 234 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index a1a3dd6..c951061 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -17,6 +17,7 @@
>   #include<plat/dma.h>
>   #include<plat/serial.h>
>   #include<plat/i2c.h>
> +#include<plat/gpio.h>
>   #include<plat/omap24xx.h>
Do you still need that header file?

>
>   #include "omap_hwmod_common_data.h"
> @@ -38,6 +39,10 @@ static struct omap_hwmod omap2420_iva_hwmod;
>   static struct omap_hwmod omap2420_l3_main_hwmod;
>   static struct omap_hwmod omap2420_l4_core_hwmod;
>   static struct omap_hwmod omap2420_wd_timer2_hwmod;
> +static struct omap_hwmod omap2420_gpio1_hwmod;
> +static struct omap_hwmod omap2420_gpio2_hwmod;
> +static struct omap_hwmod omap2420_gpio3_hwmod;
> +static struct omap_hwmod omap2420_gpio4_hwmod;
>
>   /* L3 ->  L4_CORE interface */
>   static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
> @@ -557,6 +562,224 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
>   	.flags		= HWMOD_16BIT_REG,
>   };
>
> +/* l4_wkup ->  gpio1 */
> +static struct omap_hwmod_addr_space omap2420_gpio1_addr_space[] = {
> +	{
> +		.pa_start	= 0x48018000,
> +		.pa_end		= 0x480181ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio1 = {
> +	.master		=&omap2420_l4_wkup_hwmod,
> +	.slave		=&omap2420_gpio1_hwmod,
> +	.clk		= "gpios_ick",
> +	.addr		= omap2420_gpio1_addr_space,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_gpio1_addr_space),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_wkup ->  gpio2 */
> +static struct omap_hwmod_addr_space omap2420_gpio2_addr_space[] = {
> +	{
> +		.pa_start	= 0x4801a000,
> +		.pa_end		= 0x4801a1ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio2 = {
> +	.master		=&omap2420_l4_wkup_hwmod,
> +	.slave		=&omap2420_gpio2_hwmod,
> +	.clk		= "gpios_ick",
> +	.addr		= omap2420_gpio2_addr_space,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_gpio2_addr_space),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_wkup ->  gpio3 */
> +static struct omap_hwmod_addr_space omap2420_gpio3_addr_space[] = {
> +	{
> +		.pa_start	= 0x4801c000,
> +		.pa_end		= 0x4801c1ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio3 = {
> +	.master		=&omap2420_l4_wkup_hwmod,
> +	.slave		=&omap2420_gpio3_hwmod,
> +	.clk		= "gpios_ick",
> +	.addr		= omap2420_gpio3_addr_space,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_gpio3_addr_space),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_wkup ->  gpio4 */
> +static struct omap_hwmod_addr_space omap2420_gpio4_addr_space[] = {
> +	{
> +		.pa_start	= 0x4801e000,
> +		.pa_end		= 0x4801e1ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 = {
> +	.master		=&omap2420_l4_wkup_hwmod,
> +	.slave		=&omap2420_gpio4_hwmod,
> +	.clk		= "gpios_ick",
> +	.addr		= omap2420_gpio4_addr_space,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_gpio4_addr_space),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* gpio dev_attr */
> +static struct omap_gpio_dev_attr gpio_dev_attr = {
> +	.bank_width = 32,
> +	.dbck_flag = false,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap242x_gpio_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
> +			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields    =&omap_hwmod_sysc_type1,
> +};
> +
> +/*
> + * 'gpio' class
> + * general purpose io module
> + */
> +static struct omap_hwmod_class omap242x_gpio_hwmod_class = {
> +	.name = "gpio",
> +	.sysc =&omap242x_gpio_sysc,
> +	.rev = 0,
> +};
> +
> +/* gpio1 */
> +static struct omap_hwmod_irq_info omap242x_gpio1_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = 29 }, /* INT_24XX_GPIO_BANK1 */
> +};
> +
> +static struct omap_hwmod_ocp_if *omap2420_gpio1_slaves[] = {
> +	&omap2420_l4_wkup__gpio1,
> +};
> +
> +static struct omap_hwmod omap2420_gpio1_hwmod = {
> +	.name		= "gpio1",
> +	.mpu_irqs	= omap242x_gpio1_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio1_irqs),
> +	.main_clk	= "gpios_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
> +			.module_offs = WKUP_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_gpio1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio1_slaves),
> +	.class		=&omap242x_gpio_hwmod_class,
> +	.dev_attr	=&gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +};
> +
> +/* gpio2 */
> +static struct omap_hwmod_irq_info omap242x_gpio2_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = 30 }, /* INT_24XX_GPIO_BANK2 */
> +};
> +
> +static struct omap_hwmod_ocp_if *omap2420_gpio2_slaves[] = {
> +	&omap2420_l4_wkup__gpio2,
> +};
> +
> +static struct omap_hwmod omap2420_gpio2_hwmod = {
> +	.name		= "gpio2",
> +	.mpu_irqs	= omap242x_gpio2_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio2_irqs),
> +	.main_clk	= "gpios_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
> +			.module_offs = WKUP_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_gpio2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio2_slaves),
> +	.class		=&omap242x_gpio_hwmod_class,
> +	.dev_attr	=&gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +};
> +
> +/* gpio3 */
> +static struct omap_hwmod_irq_info omap242x_gpio3_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = 31 }, /* INT_24XX_GPIO_BANK3 */
> +};
> +
> +static struct omap_hwmod_ocp_if *omap2420_gpio3_slaves[] = {
> +	&omap2420_l4_wkup__gpio3,
> +};
> +
> +static struct omap_hwmod omap2420_gpio3_hwmod = {
> +	.name		= "gpio3",
> +	.mpu_irqs	= omap242x_gpio3_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio3_irqs),
> +	.main_clk	= "gpios_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
> +			.module_offs = WKUP_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_gpio3_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio3_slaves),
> +	.class		=&omap242x_gpio_hwmod_class,
> +	.dev_attr	=&gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +};
> +
> +/* gpio4 */
> +static struct omap_hwmod_irq_info omap242x_gpio4_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = 32 }, /* INT_24XX_GPIO_BANK4 */
> +};
> +
> +static struct omap_hwmod_ocp_if *omap2420_gpio4_slaves[] = {
> +	&omap2420_l4_wkup__gpio4,
> +};
> +
> +static struct omap_hwmod omap2420_gpio4_hwmod = {
> +	.name		= "gpio4",
> +	.mpu_irqs	= omap242x_gpio4_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio4_irqs),
> +	.main_clk	= "gpios_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
> +			.module_offs = WKUP_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPIOS_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_gpio4_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio4_slaves),
> +	.class		=&omap242x_gpio_hwmod_class,
> +	.dev_attr	=&gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +};
> +
>   static __initdata struct omap_hwmod *omap2420_hwmods[] = {
>   	&omap2420_l3_main_hwmod,
>   	&omap2420_l4_core_hwmod,
> @@ -569,6 +792,12 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
>   	&omap2420_uart3_hwmod,
>   	&omap2420_i2c1_hwmod,
>   	&omap2420_i2c2_hwmod,
> +
> +	/* gpio class */
> +	&omap2420_gpio1_hwmod,
> +	&omap2420_gpio2_hwmod,
> +	&omap2420_gpio3_hwmod,
> +	&omap2420_gpio4_hwmod,
>   	NULL,
>   };
>
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h

That change should not necessarily be there, it is not directly related 
to the subject.

Maybe that should be in an extra patch just before that one.

Beside these 2 minor comments, that patch seems good to me.

Almost-acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit

> index 5bef86d..24892a6 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -79,6 +79,11 @@
>   #define METHOD_GPIO_24XX	5
>   #define METHOD_GPIO_44XX	6
>
> +struct omap_gpio_dev_attr {
> +	int bank_width;		/* GPIO bank width */
> +	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
> +};
> +
>   struct omap_gpio_platform_data {
>   	u16 virtual_irq_start;
>   	int bank_type;

