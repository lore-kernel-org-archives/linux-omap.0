From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 07/13 v3] OMAP: GPIO: add GPIO hwmods structures for
 OMAP3
Date: Thu, 24 Jun 2010 14:14:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366AF03@dbde02.ent.ti.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
 <1276614348-5201-2-git-send-email-charu@ti.com>
 <1276614348-5201-3-git-send-email-charu@ti.com>
 <1276614348-5201-4-git-send-email-charu@ti.com>
 <1276614348-5201-5-git-send-email-charu@ti.com>
 <1276614348-5201-6-git-send-email-charu@ti.com>
 <1276614348-5201-7-git-send-email-charu@ti.com>
 <1276614348-5201-8-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40430 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab0FXIpV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 04:45:21 -0400
In-Reply-To: <1276614348-5201-8-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, akpm@linux-found
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Varadarajan, Charulatha
> Sent: Tuesday, June 15, 2010 8:36 PM
> To: david-b@pacbell.net; broonie@opensource.wolfsonmicro.com; akpm@linux-
> foundation.org; linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; Nayak, Rajendra; Cousson, Benoit;
> khilman@deeprootsystems.com; tony@atomide.com; Varadarajan, Charulatha
> Subject: [PATCH 07/13 v3] OMAP: GPIO: add GPIO hwmods structures for OMAP3
> 
> From: Charulatha V <charu@ti.com>
> 
> Add hwmod structures for GPIO module on OMAP3
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  366
> ++++++++++++++++++++++++++++
>  1 files changed, 366 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_3xxx_data.c
> index e288b20..91ef205 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -17,6 +17,7 @@
>  #include <mach/irqs.h>
>  #include <plat/cpu.h>
>  #include <plat/dma.h>
> +#include <plat/gpio.h>
> 
>  #include "omap_hwmod_common_data.h"
> 
> @@ -81,6 +82,12 @@ static struct omap_hwmod omap3xxx_l3_hwmod = {
>  };
> 
>  static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
> +static struct omap_hwmod omap3xxx_gpio1_hwmod;
> +static struct omap_hwmod omap3xxx_gpio2_hwmod;
> +static struct omap_hwmod omap3xxx_gpio3_hwmod;
> +static struct omap_hwmod omap3xxx_gpio4_hwmod;
> +static struct omap_hwmod omap3xxx_gpio5_hwmod;
> +static struct omap_hwmod omap3xxx_gpio6_hwmod;
> 
>  /* L4_CORE -> L4_WKUP interface */
>  static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
> @@ -89,6 +96,114 @@ static struct omap_hwmod_ocp_if
> omap3xxx_l4_core__l4_wkup = {
>  	.user	= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
> +/* L4 WKUP -> GPIO1 interface */
> +static struct omap_hwmod_addr_space omap3xxx_gpio1_addrs[] = {
> +	{
> +		.pa_start	= OMAP34XX_GPIO1_BASE,
> +		.pa_end		= OMAP34XX_GPIO1_BASE + SZ_4K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__gpio1 = {
> +	.master		= &omap3xxx_l4_wkup_hwmod,
> +	.slave		= &omap3xxx_gpio1_hwmod,
> +	.clk		= "gpio1_ick",
> +	.addr		= omap3xxx_gpio1_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio1_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* L4 PER -> GPIO2 interface */
> +static struct omap_hwmod_addr_space omap3xxx_gpio2_addrs[] = {
> +	{
> +		.pa_start	= OMAP34XX_GPIO2_BASE,
> +		.pa_end		= OMAP34XX_GPIO2_BASE + SZ_4K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio2 = {
> +	.master		= &omap3xxx_l4_per_hwmod,
> +	.slave		= &omap3xxx_gpio2_hwmod,
> +	.clk		= "gpio2_ick",
> +	.addr		= omap3xxx_gpio2_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio2_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* L4 PER -> GPIO3 interface */
> +static struct omap_hwmod_addr_space omap3xxx_gpio3_addrs[] = {
> +	{
> +		.pa_start	= OMAP34XX_GPIO3_BASE,
> +		.pa_end		= OMAP34XX_GPIO3_BASE + SZ_4K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio3 = {
> +	.master		= &omap3xxx_l4_per_hwmod,
> +	.slave		= &omap3xxx_gpio3_hwmod,
> +	.clk		= "gpio3_ick",
> +	.addr		= omap3xxx_gpio3_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio3_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* L4 PER -> GPIO4 interface */
> +static struct omap_hwmod_addr_space omap3xxx_gpio4_addrs[] = {
> +	{
> +		.pa_start	= OMAP34XX_GPIO4_BASE,
> +		.pa_end		= OMAP34XX_GPIO4_BASE + SZ_4K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio4 = {
> +	.master		= &omap3xxx_l4_per_hwmod,
> +	.slave		= &omap3xxx_gpio4_hwmod,
> +	.clk		= "gpio4_ick",
> +	.addr		= omap3xxx_gpio4_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio4_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* L4 PER -> GPIO5 interface */
> +static struct omap_hwmod_addr_space omap3xxx_gpio5_addrs[] = {
> +	{
> +		.pa_start	= OMAP34XX_GPIO5_BASE,
> +		.pa_end		= OMAP34XX_GPIO5_BASE + SZ_4K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio5 = {
> +	.master		= &omap3xxx_l4_per_hwmod,
> +	.slave		= &omap3xxx_gpio5_hwmod,
> +	.clk		= "gpio5_ick",
> +	.addr		= omap3xxx_gpio5_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio5_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* L4 PER -> GPIO6 interface */
> +static struct omap_hwmod_addr_space omap3xxx_gpio6_addrs[] = {
> +	{
> +		.pa_start	= OMAP34XX_GPIO6_BASE,
> +		.pa_end		= OMAP34XX_GPIO6_BASE + SZ_4K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio6 = {
> +	.master		= &omap3xxx_l4_per_hwmod,
> +	.slave		= &omap3xxx_gpio6_hwmod,
> +	.clk		= "gpio6_ick",
> +	.addr		= omap3xxx_gpio6_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio6_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* Slave interfaces on the L4_CORE interconnect */
>  static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
>  	&omap3xxx_l3__l4_core,
> @@ -168,12 +283,263 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  };
> 
> +/* GPIO common */
> +static struct omap_gpio_dev_attr gpio_dev_attr = {
> +	.gpio_bank_count = 6,
> +	.gpio_bank_bits = 32,
> +	.dbck_flag = true,
> +};
(i) I thought following structure is what is being initialized above. If so, why the field names are not matching? Or, there is some disconnect in my observation!
struct omap_gpio_dev_attr {
	int gpio_bank_width;	/* GPIO bank width */
	bool dbck_flag;		/* dbck validity - True only for OMAP3&4 */
	bool omap1_ick_flag;	/* OMAP1 ick - True only for OMAP15xx */
};

(ii) If the structures are different, can we have the field names as:
bank_count
bank_bits

> +
> +static struct omap_hwmod_class_sysconfig omap3xxx_gpio_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
> +			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields    = &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap3xxx_gpio_hwmod_class = {
> +	.name = "gpio",
> +	.sysc = &omap3xxx_gpio_sysc,
> +};
> +
> +/* GPIO1 */
> +
> +static struct omap_hwmod_irq_info omap3xxx_gpio1_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK1 },
> +};
> +
> +static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
> +	{ .role = "dbclk", .clk = "gpio1_dbck", },
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_gpio1_slaves[] = {
> +	&omap3xxx_l4_wkup__gpio1,
> +};
> +
> +static struct omap_hwmod omap3xxx_gpio1_hwmod = {
> +	.name		= "gpio1",
> +	.mpu_irqs	= omap3xxx_gpio1_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio1_irqs),
> +	.main_clk	= NULL,
> +	.opt_clks	= gpio1_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_GPIO1_SHIFT,
> +			.module_offs = WKUP_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = 3,
> +		},
> +	},
> +	.slaves		= omap3xxx_gpio1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio1_slaves),
> +	.class		= &omap3xxx_gpio_hwmod_class,
> +	.dev_attr	= &gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +};
> +
> +/* GPIO2 */
> +
> +static struct omap_hwmod_irq_info omap3xxx_gpio2_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK2 },
> +};
> +
> +static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
> +	{ .role = "dbclk", .clk = "gpio2_dbck", },
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_gpio2_slaves[] = {
> +	&omap3xxx_l4_per__gpio2,
> +};
> +
> +static struct omap_hwmod omap3xxx_gpio2_hwmod = {
> +	.name		= "gpio2",
> +	.mpu_irqs	= omap3xxx_gpio2_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio2_irqs),
> +	.main_clk	= NULL,
> +	.opt_clks	= gpio2_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_GPIO2_SHIFT,
> +			.module_offs = OMAP3430_PER_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = 13,
> +		},
> +	},
> +	.slaves		= omap3xxx_gpio2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio2_slaves),
> +	.class		= &omap3xxx_gpio_hwmod_class,
> +	.dev_attr	= &gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +};
> +
> +/* GPIO3 */
> +
> +static struct omap_hwmod_irq_info omap3xxx_gpio3_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK3 },
> +};
> +
> +static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
> +	{ .role = "dbclk", .clk = "gpio3_dbck", },
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_gpio3_slaves[] = {
> +	&omap3xxx_l4_per__gpio3,
> +};
> +
> +static struct omap_hwmod omap3xxx_gpio3_hwmod = {
> +	.name		= "gpio3",
> +	.mpu_irqs	= omap3xxx_gpio3_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio3_irqs),
> +	.main_clk	= NULL,
> +	.opt_clks	= gpio3_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_GPIO3_SHIFT,
> +			.module_offs = OMAP3430_PER_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = 14,
> +		},
> +	},
> +	.slaves		= omap3xxx_gpio3_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio3_slaves),
> +	.class		= &omap3xxx_gpio_hwmod_class,
> +	.dev_attr	= &gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +};
> +
> +/* GPIO4 */
> +
> +static struct omap_hwmod_irq_info omap3xxx_gpio4_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK4 },
> +};
> +
> +static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
> +	{ .role = "dbclk", .clk = "gpio4_dbck", },
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_gpio4_slaves[] = {
> +	&omap3xxx_l4_per__gpio4,
> +};
> +
> +static struct omap_hwmod omap3xxx_gpio4_hwmod = {
> +	.name		= "gpio4",
> +	.mpu_irqs	= omap3xxx_gpio4_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio4_irqs),
> +	.main_clk	= NULL,
> +	.opt_clks	= gpio4_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_GPIO4_SHIFT,
> +			.module_offs = OMAP3430_PER_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = 15,
> +		},
> +	},
> +	.slaves		= omap3xxx_gpio4_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio4_slaves),
> +	.class		= &omap3xxx_gpio_hwmod_class,
> +	.dev_attr	= &gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +};
> +
> +
> +/* GPIO5 */
> +
> +static struct omap_hwmod_irq_info omap3xxx_gpio5_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK5 },
> +};
> +
> +static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
> +	{ .role = "dbclk", .clk = "gpio5_dbck", },
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_gpio5_slaves[] = {
> +	&omap3xxx_l4_per__gpio5,
> +};
> +
> +static struct omap_hwmod omap3xxx_gpio5_hwmod = {
> +	.name		= "gpio5",
> +	.mpu_irqs	= omap3xxx_gpio5_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio5_irqs),
> +	.main_clk	= NULL,
> +	.opt_clks	= gpio5_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_GPIO5_SHIFT,
> +			.module_offs = OMAP3430_PER_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = 16,
> +		},
> +	},
> +	.slaves		= omap3xxx_gpio5_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio5_slaves),
> +	.class		= &omap3xxx_gpio_hwmod_class,
> +	.dev_attr	= &gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +};
> +
> +/* GPIO6 */
> +
> +static struct omap_hwmod_irq_info omap3xxx_gpio6_irqs[] = {
> +	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK6 },
> +};
> +
> +static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
> +	{ .role = "dbclk", .clk = "gpio6_dbck", },
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_gpio6_slaves[] = {
> +	&omap3xxx_l4_per__gpio6,
> +};
> +
> +static struct omap_hwmod omap3xxx_gpio6_hwmod = {
> +	.name		= "gpio6",
> +	.mpu_irqs	= omap3xxx_gpio6_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio6_irqs),
> +	.main_clk	= NULL,
> +	.opt_clks	= gpio6_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_GPIO6_SHIFT,
> +			.module_offs = OMAP3430_PER_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = 17,
> +		},
> +	},
> +	.slaves		= omap3xxx_gpio6_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio6_slaves),
> +	.class		= &omap3xxx_gpio_hwmod_class,
> +	.dev_attr	= &gpio_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +};
> +
>  static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>  	&omap3xxx_l3_hwmod,
>  	&omap3xxx_l4_core_hwmod,
>  	&omap3xxx_l4_per_hwmod,
>  	&omap3xxx_l4_wkup_hwmod,
>  	&omap3xxx_mpu_hwmod,
> +	&omap3xxx_gpio1_hwmod,
> +	&omap3xxx_gpio2_hwmod,
> +	&omap3xxx_gpio3_hwmod,
> +	&omap3xxx_gpio4_hwmod,
> +	&omap3xxx_gpio5_hwmod,
> +	&omap3xxx_gpio6_hwmod,
>  	NULL,
>  };
> 
> --
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
