From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 1/6] OMAP3: hwmod data: Add watchdog timer
Date: Wed, 15 Sep 2010 23:26:54 +0200
Message-ID: <4C913A1E.2060906@ti.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com> <1284528403-6494-2-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48164 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab0IOV1E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Sep 2010 17:27:04 -0400
In-Reply-To: <1284528403-6494-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 9/15/2010 7:26 AM, Varadarajan, Charulatha wrote:
> Add watchdog timer hwmod data for OMAP3 chip
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   61 ++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/prcm-common.h          |    4 ++
>   2 files changed, 65 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 5d8eb58..a9812a8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -36,6 +36,7 @@ static struct omap_hwmod omap3xxx_iva_hwmod;
>   static struct omap_hwmod omap3xxx_l3_main_hwmod;
>   static struct omap_hwmod omap3xxx_l4_core_hwmod;
>   static struct omap_hwmod omap3xxx_l4_per_hwmod;
> +static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
>
>   /* L3 ->  L4_CORE interface */
>   static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
> @@ -197,6 +198,65 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
>   };
>
> +/* WDTIMER2<- L4_WKUP interface */

Minor point, but the name convention is wd_timerX. It is valid for all 
other comments in this file.

> +static struct omap_hwmod_addr_space omap3xxx_wd_timer2_addrs[] = {
> +	{
> +		.pa_start	= 0x48314000,
> +		.pa_end		= 0x4831407f,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__wd_timer2 = {
> +	.master		=&omap3xxx_l4_wkup_hwmod,
> +	.slave		=&omap3xxx_wd_timer2_hwmod,
> +	.clk		= "wdt2_ick",
> +	.addr		= omap3xxx_wd_timer2_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* WDTIMER common */
> +
> +static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
> +			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> +			   SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields    =&omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap3xxx_wd_timer_hwmod_class = {
> +	.name = "wd_timer",
> +	.sysc =&omap3xxx_wd_timer_sysc,
> +};
> +
> +/* WDTIMER2 */
> +static struct omap_hwmod_ocp_if *omap3xxx_wd_timer2_slaves[] = {
> +	&omap3xxx_l4_wkup__wd_timer2,
> +};
> +
> +static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
> +	.name		= "wd_timer2",
> +	.class		=&omap3xxx_wd_timer_hwmod_class,
> +	.main_clk	= "wdt2_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_EN_WDT2_SHIFT,
> +			.module_offs = WKUP_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP3430_EN_WDT2_SHIFT,
> +		},
> +	},
> +	.slaves		= omap3xxx_wd_timer2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +};
> +
>   static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>   	&omap3xxx_l3_main_hwmod,
>   	&omap3xxx_l4_core_hwmod,
> @@ -204,6 +264,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>   	&omap3xxx_l4_wkup_hwmod,
>   	&omap3xxx_mpu_hwmod,
>   	&omap3xxx_iva_hwmod,
> +	&omap3xxx_wd_timer2_hwmod,
>   	NULL,
>   };
>
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index 995b7ed..e190c64 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -237,6 +237,8 @@
>   #define OMAP24XX_ST_USB_MASK				(1<<  0)
>
>   /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
> +#define OMAP24XX_EN_WDT2_SHIFT				3
> +#define OMAP24XX_EN_WDT2_MASK				(1<<  3)
>   #define OMAP24XX_EN_GPIOS_SHIFT				2
>   #define OMAP24XX_EN_GPIOS_MASK				(1<<  2)
>   #define OMAP24XX_EN_GPT1_SHIFT				0
> @@ -344,6 +346,8 @@
>   #define OMAP3430_ST_D2D_MASK				(1<<  3)
>
>   /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
> +#define OMAP3430_EN_WDT2_SHIFT				5
> +#define OMAP3430_EN_WDT2_MASK				(1<<  5)
>   #define OMAP3430_EN_GPIO1_MASK				(1<<  3)
>   #define OMAP3430_EN_GPIO1_SHIFT				3
>   #define OMAP3430_EN_GPT12_MASK				(1<<  1)

That part is not related to the subject of this patch. You should 
probably put that in another patch.

Benoit
