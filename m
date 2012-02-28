From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 08/14] ARM: OMAP3+: hwmod: add SmartReflex IRQs
Date: Tue, 28 Feb 2012 14:47:22 -0800
Message-ID: <877gz6k22t.fsf@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
	<1328723039-15952-9-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:57751 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757347Ab2B1Wra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 17:47:30 -0500
Received: by mail-pz0-f54.google.com with SMTP id c6so5148309dae.13
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 14:47:27 -0800 (PST)
In-Reply-To: <1328723039-15952-9-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Wed, 8 Feb 2012 18:43:53 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> OMAP3 SmartReflex IRQs in hwmod structures with the same naming as
> present in OMAP4. Without these IRQs being registered, SmartReflex
> driver will be unable to get the IRQ numbers to handle notifications
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 8688960..eef31cb 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -377,6 +377,16 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
> +	{ .name = "sr1_irq", .irq = 18},
> +	{ .irq = -1 }
> +};
> +
> +static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
> +	{ .name = "sr2_irq", .irq = 19},
> +	{ .irq = -1 }
> +};

minor: I don't think the .name field is required here since there's only
one, and the driver does not use get_resource_by_name().

Kevin

>  /* L4 CORE -> SR1 interface */
>  static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
>  	{
> @@ -2689,6 +2699,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
>  	.slaves		= omap3_sr1_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
>  	.dev_attr	= &sr1_dev_attr,
> +	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
>  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
>  };
>  
> @@ -2708,6 +2719,7 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
>  	.slaves		= omap3_sr1_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
>  	.dev_attr	= &sr1_dev_attr,
> +	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
>  };
>  
>  /* SR2 */
> @@ -2735,6 +2747,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
>  	.slaves		= omap3_sr2_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
>  	.dev_attr	= &sr2_dev_attr,
> +	.mpu_irqs	= omap3_smartreflex_core_irqs,
>  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
>  };
>  
> @@ -2754,6 +2767,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
>  	.slaves		= omap3_sr2_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
>  	.dev_attr	= &sr2_dev_attr,
> +	.mpu_irqs	= omap3_smartreflex_core_irqs,
>  };
>  
>  /*
