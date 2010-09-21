From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 07/13] OMAP3: hwmod data: Add GPIO
Date: Tue, 21 Sep 2010 16:22:17 -0700
Message-ID: <87y6aufzrq.fsf@deeprootsystems.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
	<1284819353-8512-8-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54941 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0IUXWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 19:22:21 -0400
Received: by yxp4 with SMTP id 4so1816733yxp.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Sep 2010 16:22:21 -0700 (PDT)
In-Reply-To: <1284819353-8512-8-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Sat, 18 Sep 2010 19:45:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Add GPIO hwmod data for OMAP3 chip
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  364 ++++++++++++++++++++++++++++
>  1 files changed, 364 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 5d8eb58..43ed2ab 100644
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
> @@ -36,6 +37,12 @@ static struct omap_hwmod omap3xxx_iva_hwmod;
>  static struct omap_hwmod omap3xxx_l3_main_hwmod;
>  static struct omap_hwmod omap3xxx_l4_core_hwmod;
>  static struct omap_hwmod omap3xxx_l4_per_hwmod;
> +static struct omap_hwmod omap3xxx_gpio1_hwmod;
> +static struct omap_hwmod omap3xxx_gpio2_hwmod;
> +static struct omap_hwmod omap3xxx_gpio3_hwmod;
> +static struct omap_hwmod omap3xxx_gpio4_hwmod;
> +static struct omap_hwmod omap3xxx_gpio5_hwmod;
> +static struct omap_hwmod omap3xxx_gpio6_hwmod;
>  
>  /* L3 -> L4_CORE interface */
>  static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
> @@ -197,6 +204,357 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
>  };
>  
> +/* l4_wkup -> gpio1 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio1_addrs[] = {
> +	{
> +		.pa_start	= 0x48310000,
> +		.pa_end		= 0x483101ff,
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
> +/* l4_per -> gpio2 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio2_addrs[] = {
> +	{
> +		.pa_start	= 0x49050000,
> +		.pa_end		= 0x490501ff,
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
> +/* l4_per -> gpio3 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio3_addrs[] = {
> +	{
> +		.pa_start	= 0x49052000,
> +		.pa_end		= 0x490521ff,
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
> +/* l4_per -> gpio4 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio4_addrs[] = {
> +	{
> +		.pa_start	= 0x49054000,
> +		.pa_end		= 0x490541ff,
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
> +/* l4_per -> gpio5 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio5_addrs[] = {
> +	{
> +		.pa_start	= 0x49056000,
> +		.pa_end		= 0x490561ff,
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
> +/* l4_per -> gpio6 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio6_addrs[] = {
> +	{
> +		.pa_start	= 0x49058000,
> +		.pa_end		= 0x490581ff,
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
> +/*
> + * 'gpio' class
> + * general purpose io module
> + */
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
> +	.rev = 1,
> +};
> +
> +/* gpio_dev_attr*/
> +static struct omap_gpio_dev_attr gpio_dev_attr = {
> +	.bank_width = 32,
> +	.dbck_flag = true,
> +};
> +
> +/* gpio1 */
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

NULL entries can be left out, as that's the default.  However...

As GPIO doesn't really have a separate functional clock, the interface
clock is both the functional and interface clock.  In order for
initiator deps to be managed correctly by hwmod, the main clock for all
these modules should be gpio*_ick.

Same goes for the other omap3xx_gpio*_hwmod blocks.

Kevin
