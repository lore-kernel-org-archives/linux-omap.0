From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/19] omap3: hwmod: add smartreflex irqs
Date: Wed, 02 Mar 2011 15:48:31 -0800
Message-ID: <87bp1txewg.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47398 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754914Ab1CBXsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 18:48:36 -0500
Received: by yxa15 with SMTP id 15so197407yxa.23
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 15:48:35 -0800 (PST)
In-Reply-To: <1298116918-30744-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 19 Feb 2011 17:31:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> OMAP3 smartreflex irqs in hwmod structures with the same naming as
> present in OMAP4. Without these IRQs being registered, SmartReflex
> driver will be unable to get the irq numbers to handle notifications
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

minor: IRQ is an acronym, please capitalize consistenly throughout.

I know we haven't been too consitent about this but OMAP is also an
acronym, please capitialize (c.f. $SUBJECT).  This goes for the whole
series.

Otherwise patch looks fine.

Kevin

> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 8d81813..ea1f49a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -265,6 +265,15 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +
> +static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
> +	{.name = "sr1_irq", .irq = 18},
> +};
> +
> +static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
> +	{.name = "sr2_irq", .irq = 19},
> +};
> +
>  /* L4 CORE -> SR1 interface */
>  static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
>  	{
> @@ -1289,6 +1298,8 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
>  					CHIP_IS_OMAP3430ES3_0 |
>  					CHIP_IS_OMAP3430ES3_1),
>  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
> +	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
>  };
>  
>  static struct omap_hwmod omap36xx_sr1_hwmod = {
> @@ -1308,6 +1319,8 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
>  	.slaves		= omap3_sr1_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_mpu_irqs),
>  };
>  
>  /* SR2 */
> @@ -1335,6 +1348,8 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
>  					CHIP_IS_OMAP3430ES3_0 |
>  					CHIP_IS_OMAP3430ES3_1),
>  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
> +	.mpu_irqs	= omap3_smartreflex_core_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_core_irqs),
>  };
>  
>  static struct omap_hwmod omap36xx_sr2_hwmod = {
> @@ -1354,6 +1369,8 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
>  	.slaves		= omap3_sr2_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.mpu_irqs	= omap3_smartreflex_core_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3_smartreflex_core_irqs),
>  };
>  
>  static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
