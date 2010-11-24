From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v7 07/11] OMAP3: hwmod data: Add GPIO
Date: Wed, 24 Nov 2010 23:51:24 +0100
Message-ID: <4CED96EC.1040608@ti.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <1290524213-395-8-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58881 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755594Ab0KXWvF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 17:51:05 -0500
In-Reply-To: <1290524213-395-8-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
> Add GPIO hwmod data for OMAP3
>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

> ---
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  360 ++++++++++++++++++++++++++++
>   1 files changed, 360 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index a8bed84..9ca2206 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -20,6 +20,7 @@
>   #include<plat/serial.h>
>   #include<plat/l4_3xxx.h>
>   #include<plat/i2c.h>
> +#include<plat/gpio.h>
>   #include<plat/omap34xx.h>
>
>   #include "omap_hwmod_common_data.h"
> @@ -45,6 +46,12 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
>   static struct omap_hwmod omap3xxx_i2c1_hwmod;
>   static struct omap_hwmod omap3xxx_i2c2_hwmod;
>   static struct omap_hwmod omap3xxx_i2c3_hwmod;
> +static struct omap_hwmod omap3xxx_gpio1_hwmod;
> +static struct omap_hwmod omap3xxx_gpio2_hwmod;
> +static struct omap_hwmod omap3xxx_gpio3_hwmod;
> +static struct omap_hwmod omap3xxx_gpio4_hwmod;
> +static struct omap_hwmod omap3xxx_gpio5_hwmod;
> +static struct omap_hwmod omap3xxx_gpio6_hwmod;
>
>   /* L3 ->  L4_CORE interface */
>   static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
> @@ -739,6 +746,351 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>   };
>
> +/* l4_wkup ->  gpio1 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio1_addrs[] = {
> +	{
> +		.pa_start	= 0x48310000,
> +		.pa_end		= 0x483101ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__gpio1 = {
> +	.master		=&omap3xxx_l4_wkup_hwmod,
> +	.slave		=&omap3xxx_gpio1_hwmod,
> +	.addr		= omap3xxx_gpio1_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio1_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per ->  gpio2 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio2_addrs[] = {
> +	{
> +		.pa_start	= 0x49050000,
> +		.pa_end		= 0x490501ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio2 = {
> +	.master		=&omap3xxx_l4_per_hwmod,
> +	.slave		=&omap3xxx_gpio2_hwmod,
> +	.addr		= omap3xxx_gpio2_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio2_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per ->  gpio3 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio3_addrs[] = {
> +	{
> +		.pa_start	= 0x49052000,
> +		.pa_end		= 0x490521ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio3 = {
> +	.master		=&omap3xxx_l4_per_hwmod,
> +	.slave		=&omap3xxx_gpio3_hwmod,
> +	.addr		= omap3xxx_gpio3_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio3_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per ->  gpio4 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio4_addrs[] = {
> +	{
> +		.pa_start	= 0x49054000,
> +		.pa_end		= 0x490541ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio4 = {
> +	.master		=&omap3xxx_l4_per_hwmod,
> +	.slave		=&omap3xxx_gpio4_hwmod,
> +	.addr		= omap3xxx_gpio4_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio4_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per ->  gpio5 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio5_addrs[] = {
> +	{
> +		.pa_start	= 0x49056000,
> +		.pa_end		= 0x490561ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio5 = {
> +	.master		=&omap3xxx_l4_per_hwmod,
> +	.slave		=&omap3xxx_gpio5_hwmod,
> +	.addr		= omap3xxx_gpio5_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio5_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per ->  gpio6 */
> +static struct omap_hwmod_addr_space omap3xxx_gpio6_addrs[] = {
> +	{
> +		.pa_start	= 0x49058000,
> +		.pa_end		= 0x490581ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio6 = {
> +	.master		=&omap3xxx_l4_per_hwmod,
> +	.slave		=&omap3xxx_gpio6_hwmod,
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
> +	.sysc_fields    =&omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap3xxx_gpio_hwmod_class = {
> +	.name = "gpio",
> +	.sysc =&omap3xxx_gpio_sysc,
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
> +	{ .name = "gpio_mpu_irq", .irq = 29 }, /* INT_34XX_GPIO_BANK1 */

In this case the name is not necessarily needed since there is only one 
irq line.
You can save some memory by just adding the .irq field.

Benoit
