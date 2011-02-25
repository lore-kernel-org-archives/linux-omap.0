From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Fri, 25 Feb 2011 18:02:56 +0100
Message-ID: <4D67E0C0.4080805@ti.com>
References: <1298641689-7417-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33095 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932468Ab1BYRC7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 12:02:59 -0500
In-Reply-To: <1298641689-7417-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Hi Sanjeev,

On 2/25/2011 2:48 PM, Premi, Sanjeev wrote:
> This patch implements workaround to reuse the hwmods
> defined for OMAP3. Else, the master-slave dependency
> cascades into duplicating all of the hwmods.
>
> Without this workaround, the AM3517 EVM fails to boot
> due to kernel panic while initializing the SR hwmods.
> Until real solution is implemented, this workaround
> can be considered.
>
> Signed-off-by: Sanjeev Premi<premi@ti.com>

Could you try to put Paul and me in CC for such hwmod related email?
I almost missed it due to the increasing rate of email on l-o nowadays.

> ---
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   66 +++++++++++++++++++++++++++-
>   1 files changed, 65 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 800eda4..c8854eb 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1670,7 +1670,71 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>   	NULL,
>   };
>
> +/**
> + * HWMODs specific to AM35x processors
> + * Though they are quite similar to OMAP34xx definitions,
> + * having separate array makes customization easy.
> + */
> +static __initdata struct omap_hwmod *am35xx_hwmods[] = {
> +	&omap3xxx_l3_main_hwmod,
> +	&omap3xxx_l4_core_hwmod,
> +	&omap3xxx_l4_per_hwmod,
> +	&omap3xxx_l4_wkup_hwmod,
> +	&omap3xxx_mpu_hwmod,
> +	&omap3xxx_wd_timer2_hwmod,
> +	&omap3xxx_uart1_hwmod,
> +	&omap3xxx_uart2_hwmod,
> +	&omap3xxx_uart3_hwmod,
> +	&omap3xxx_uart4_hwmod,
> +	&omap3xxx_i2c1_hwmod,
> +	&omap3xxx_i2c2_hwmod,
> +	&omap3xxx_i2c3_hwmod,
> +
> +	/* gpio class */
> +	&omap3xxx_gpio1_hwmod,
> +	&omap3xxx_gpio2_hwmod,
> +	&omap3xxx_gpio3_hwmod,
> +	&omap3xxx_gpio4_hwmod,
> +	&omap3xxx_gpio5_hwmod,
> +	&omap3xxx_gpio6_hwmod,
> +
> +	/* dma_system class*/
> +	&omap3xxx_dma_system_hwmod,
> +
> +	/* mcspi class */
> +	&omap34xx_mcspi1,
> +	&omap34xx_mcspi2,
> +	&omap34xx_mcspi3,
> +	&omap34xx_mcspi4,
> +	NULL,
> +};
> +
>   int __init omap3xxx_hwmod_init(void)
>   {
> -	return omap_hwmod_init(omap3xxx_hwmods);
> +	if (cpu_is_omap3505() || cpu_is_omap3517()) {
> +
> +		/* TODO: Find better way to get this done.
> +		 *
> +		 * AM35xx doesn't support smartreflex. This requires:
> +		 * 1) Removing related hwmods from the initialization list.
> +		 *    (done).
> +		 * 2) Removing omap3_l4_core__sr1 and omap3_l4_core__sr2
> +		 *    from omap3xxx_l4_core_slaves.
> +		 *    This, however, has cascading effect on all hwmods,
> +		 *    due to master-slave relations between these hwmods.
> +		 *
> +		 * Instead of duplicating contents of this file, updating
> +		 * the structure to restrict slave count to 1; and setting
> +		 * address of omap3_l4_core__sr1&  omap3_l4_core__sr2 to
> +		 * NULL should be a reasonable workaround.
> +		 */
> +		omap3xxx_l4_core_slaves[1] = NULL;
> +		omap3xxx_l4_core_slaves[2] = NULL;

OK, this is not your fault, but it appears that these entries are wrong 
in the original omap_hwmod_3xxx_data.c file.
The l4_core does not have any slave port toward smartreflex, this is the 
opposite, l4_core does have 2 master ports toward smartreflex.

Since these master ports from interconnect generated some annoying 
circular reference during OMAP4 generation, I simply removed them.
There are not used for the moment, and you can still build that relation 
using the slave port from the IP.

So by removing directly these relations in the original file, that 
should simplify your life. The patch do fix that is below.
I just built it so if you can give a try it will be nice.

Thanks,
Benoit

---
 From 09506eedef901af0fa19ddb48f486ce4ef353645 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 25 Feb 2011 17:46:33 +0100
Subject: [PATCH] OMAP3: hwmod data: Remove masters port links for 
interconnects.

Master ports from interconnect are generating some annoying circular
references that become tricky to handle if we have to dynamically
remove some IP on some variant platforms.
Since they are not used for the moment, and since we can still build
that relation using the reverse relation (slave port from the IP
toward master port of the interconnect), let remove them for the
moment like it is done on OMAP4.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   28 
----------------------------
  1 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7fa2dfb..0e7d43f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -463,26 +463,12 @@ static struct omap_hwmod_ocp_if 
*am35xx_usbhsotg_slaves[] = {
  /* Slave interfaces on the L4_CORE interconnect */
  static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
  	&omap3xxx_l3_main__l4_core,
-	&omap3_l4_core__sr1,
-	&omap3_l4_core__sr2,
-};
-
-/* Master interfaces on the L4_CORE interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
-	&omap3xxx_l4_core__l4_wkup,
-	&omap3_l4_core__uart1,
-	&omap3_l4_core__uart2,
-	&omap3_l4_core__i2c1,
-	&omap3_l4_core__i2c2,
-	&omap3_l4_core__i2c3,
  };

  /* L4 CORE */
  static struct omap_hwmod omap3xxx_l4_core_hwmod = {
  	.name		= "l4_core",
  	.class		= &l4_hwmod_class,
-	.masters	= omap3xxx_l4_core_masters,
-	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_core_masters),
  	.slaves		= omap3xxx_l4_core_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_core_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -494,18 +480,10 @@ static struct omap_hwmod_ocp_if 
*omap3xxx_l4_per_slaves[] = {
  	&omap3xxx_l3_main__l4_per,
  };

-/* Master interfaces on the L4_PER interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] = {
-	&omap3_l4_per__uart3,
-	&omap3_l4_per__uart4,
-};
-
  /* L4 PER */
  static struct omap_hwmod omap3xxx_l4_per_hwmod = {
  	.name		= "l4_per",
  	.class		= &l4_hwmod_class,
-	.masters	= omap3xxx_l4_per_masters,
-	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_per_masters),
  	.slaves		= omap3xxx_l4_per_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_per_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -517,16 +495,10 @@ static struct omap_hwmod_ocp_if 
*omap3xxx_l4_wkup_slaves[] = {
  	&omap3xxx_l4_core__l4_wkup,
  };

-/* Master interfaces on the L4_WKUP interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] = {
-};
-
  /* L4 WKUP */
  static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
  	.name		= "l4_wkup",
  	.class		= &l4_hwmod_class,
-	.masters	= omap3xxx_l4_wkup_masters,
-	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_masters),
  	.slaves		= omap3xxx_l4_wkup_slaves,
  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
-- 
1.7.0.4
