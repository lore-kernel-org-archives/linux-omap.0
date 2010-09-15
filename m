From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 4/6] OMAP4: hwmod data: Add watchdog timer
Date: Wed, 15 Sep 2010 23:18:39 +0200
Message-ID: <4C91382F.1060505@ti.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com> <1284528403-6494-5-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42738 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab0IOVSr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Sep 2010 17:18:47 -0400
In-Reply-To: <1284528403-6494-5-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Charu,

On 9/15/2010 7:26 AM, Varadarajan, Charulatha wrote:
> From: Benoit Cousson<b-cousson@ti.com>
>
> Add watchdog timer hwmod data for OMAP4 chip
>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
> This patch is extracted from the below patch sent by Benoit
> OMAP4: hwmod: Add partial hwmod support for OMAP4430 ES1.0
> https://patchwork.kernel.org/patch/99052/
>
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   68 ++++++++++++++++++++++++++++
>   1 files changed, 68 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index e20b0ee..06851f7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -452,6 +452,72 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
> +/*
> + * 'wd_timer' class
> + * 32-bit watchdog upward counter that generates a pulse on the reset pin on
> + * overflow condition
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
> +			   SYSC_HAS_SOFTRESET),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	=&omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
> +	.name = "wd_timer",
> +	.sysc =&omap44xx_wd_timer_sysc,
> +};
> +
> +/* wd_timer2 */
> +static struct omap_hwmod omap44xx_wd_timer2_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_wd_timer2_irqs[] = {
> +	{ .irq = 80 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] = {
> +	{
> +		.pa_start	= 0x4a314000,
> +		.pa_end		= 0x4a31407f,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_wkup ->  wd_timer2 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
> +	.master		=&omap44xx_l4_wkup_hwmod,
> +	.slave		=&omap44xx_wd_timer2_hwmod,
> +	.clk		= "l4_wkup_clk_mux_ck",
> +	.addr		= omap44xx_wd_timer2_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* wd_timer2 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_wd_timer2_slaves[] = {
> +	&omap44xx_l4_wkup__wd_timer2,
> +};
> +
> +static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
> +	.name		= "wd_timer2",
> +	.class		=&omap44xx_wd_timer_hwmod_class,
> +	.mpu_irqs	= omap44xx_wd_timer2_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_irqs),
> +	.main_clk	= "wd_timer2_fck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_WKUP_WDT2_CLKCTRL,
> +		},
> +	},
> +	.slaves		= omap44xx_wd_timer2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
>   static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	/* dmm class */
>   	&omap44xx_dmm_hwmod,
> @@ -472,6 +538,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>
>   	/* mpu class */
>   	&omap44xx_mpu_hwmod,
> +	/* wd_timer class */
> +	&omap44xx_wd_timer2_hwmod,
>   	NULL,
>   };

What about the wd_timer3? It is in the audio backend, and I'm not sure 
who will use it, but it does exist.

Benoit
