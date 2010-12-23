From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 4/5] OMAP4: hwmod: Add inital data for smartreflex
 modules.
Date: Thu, 23 Dec 2010 13:07:20 +0100
Message-ID: <4D133B78.5030807@ti.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com> <1292864437-15353-5-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49446 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740Ab0LWMHb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 07:07:31 -0500
In-Reply-To: <1292864437-15353-5-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Menon, Nishanth" <nm@ti.com>

Hi Thara,

On 12/20/2010 6:00 PM, Gopinath, Thara wrote:
> From: Benoit Cousson<b-cousson@ti.com>
> 
> This patch adds the hwmod details for OMAP4 smartreflex modules.
> 
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>

You're s-o-b is missing, along with the changed you did to the patch.

> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  168 ++++++++++++++++++++++++++++
>   1 files changed, 168 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7367648..0a6e674 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1740,6 +1740,169 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
> 
> +/*
> + * 'smartreflex' class
> + * smartreflex module (monitor silicon performance and outputs a measure of
> + * performance error)
> + */
> +
> +/* The IP is not compliant to type1 / type2 scheme */
> +static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_smartreflex = {
> +	.sidle_shift	= 24,
> +	.enwkup_shift	= 26,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
> +	.sysc_offs	= 0x0038,
> +	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),

The newly added SIDLE_SMART_WKUP flag is missing. 

> +	.sysc_fields	=&omap_hwmod_sysc_type_smartreflex,
> +};
> +
> +static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
> +	.name = "smartreflex",
> +	.sysc =&omap44xx_smartreflex_sysc,
> +	.rev  = 2,
> +};
> +
> +/* smartreflex_core */
> +static struct omap_hwmod omap44xx_smartreflex_core_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] = {
> +	{ .irq = 19 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_smartreflex_core_addrs[] = {
> +	{
> +		.pa_start	= 0x4a0dd000,
> +		.pa_end		= 0x4a0dd03f,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_cfg ->  smartreflex_core */
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_core = {
> +	.master		=&omap44xx_l4_cfg_hwmod,
> +	.slave		=&omap44xx_smartreflex_core_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_smartreflex_core_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* smartreflex_core slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_smartreflex_core_slaves[] = {
> +	&omap44xx_l4_cfg__smartreflex_core,
> +};
> +
> +static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
> +	.name		= "smartreflex_core",
> +	.class		=&omap44xx_smartreflex_hwmod_class,
> +	.mpu_irqs	= omap44xx_smartreflex_core_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_irqs),
> +	.main_clk	= "smartreflex_core_fck",
> +	.vdd_name	= "core",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_ALWON_SR_CORE_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_smartreflex_core_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_core_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* smartreflex_iva */
> +static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] = {
> +	{ .irq = 102 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_smartreflex_iva_addrs[] = {
> +	{
> +		.pa_start	= 0x4a0db000,
> +		.pa_end		= 0x4a0db03f,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_cfg ->  smartreflex_iva */
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_iva = {
> +	.master		=&omap44xx_l4_cfg_hwmod,
> +	.slave		=&omap44xx_smartreflex_iva_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_smartreflex_iva_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* smartreflex_iva slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_smartreflex_iva_slaves[] = {
> +	&omap44xx_l4_cfg__smartreflex_iva,
> +};
> +
> +static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
> +	.name		= "smartreflex_iva",
> +	.class		=&omap44xx_smartreflex_hwmod_class,
> +	.mpu_irqs	= omap44xx_smartreflex_iva_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_irqs),
> +	.main_clk	= "smartreflex_iva_fck",
> +	.vdd_name	= "iva",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_ALWON_SR_IVA_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_smartreflex_iva_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_iva_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* smartreflex_mpu */
> +static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] = {
> +	{ .irq = 18 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_smartreflex_mpu_addrs[] = {
> +	{
> +		.pa_start	= 0x4a0d9000,
> +		.pa_end		= 0x4a0d903f,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_cfg ->  smartreflex_mpu */
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu = {
> +	.master		=&omap44xx_l4_cfg_hwmod,
> +	.slave		=&omap44xx_smartreflex_mpu_hwmod,
> +	.clk		= "l4_div_ck",
> +	.addr		= omap44xx_smartreflex_mpu_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* smartreflex_mpu slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_smartreflex_mpu_slaves[] = {
> +	&omap44xx_l4_cfg__smartreflex_mpu,
> +};
> +
> +static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
> +	.name		= "smartreflex_mpu",
> +	.class		=&omap44xx_smartreflex_hwmod_class,
> +	.mpu_irqs	= omap44xx_smartreflex_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_irqs),
> +	.main_clk	= "smartreflex_mpu_fck",
> +	.vdd_name	= "mpu",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_ALWON_SR_MPU_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_smartreflex_mpu_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_smartreflex_mpu_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
>   static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	/* dmm class */
>   	&omap44xx_dmm_hwmod,
> @@ -1798,6 +1961,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	&omap44xx_wd_timer2_hwmod,
>   	&omap44xx_wd_timer3_hwmod,
> 
> +	/* smartreflex class */
> +	&omap44xx_smartreflex_core_hwmod,
> +	&omap44xx_smartreflex_iva_hwmod,
> +	&omap44xx_smartreflex_mpu_hwmod,
> +

The alphabetical order is not respected. Smartreflex should be before wd_timer.

Since Tony already pull that from Kevin's tree, I'll send a patch to Tony to fix these issues.

Please note the following log when enabling SR in Class 3 on an OMAP4430/sdp:

[    2.362182] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
[    2.369384] omap2_set_init_voltage: Unable to put vdd_mpu to its init voltage
[    2.369384]
[    2.378875] omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
[    2.386108] omap2_set_init_voltage: Unable to put vdd_iva to its init voltage
[    2.386108]
[    2.396484] Power Management for TI OMAP4.
[    2.401031] sr_init: No PMIC hook to init smartreflex
[    2.406494] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized
[    2.414825] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initialized
[    2.423187] smartreflex smartreflex.2: omap_sr_probe: SmartReflex driver initialized
[    2.431732] SmartReflex Class3 initialized

Is it expected? 
Why do we have that blank line in-between?

Regards,
Benoit



