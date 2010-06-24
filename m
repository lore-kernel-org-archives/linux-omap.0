From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 13/13] OMAP3: hwmod data: add data for OMAP3 IVA2
Date: Thu, 24 Jun 2010 13:43:35 -0700
Message-ID: <87aaqk6u14.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-14-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55013 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0FXUnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 16:43:37 -0400
Received: by pxi8 with SMTP id 8so381484pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 13:43:37 -0700 (PDT)
In-Reply-To: <1277336563-24988-14-git-send-email-khilman@deeprootsystems.com>
	(Kevin Hilman's message of "Wed, 23 Jun 2010 16:42:43 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Add hwmod data for DSP on OMAP3 (a.k.a. IVA2.)
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Also changing the name here from "dsp" to "iva2".

Kevin

> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   31 ++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index ec6a5f8..fe41089 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -32,6 +32,7 @@
>   */
>  
>  static struct omap_hwmod omap3xxx_mpu_hwmod;
> +static struct omap_hwmod omap3xxx_iva2_hwmod;
>  static struct omap_hwmod omap3xxx_l3_hwmod;
>  static struct omap_hwmod omap3xxx_l4_core_hwmod;
>  static struct omap_hwmod omap3xxx_l4_per_hwmod;
> @@ -168,12 +169,42 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  };
>  
> +/*
> + * IVA2_2 interface data
> + */
> +
> +/* IVA2 <- L3 interface */
> +static struct omap_hwmod_ocp_if omap3xxx_l3__iva2 = {
> +	.master		= &omap3xxx_l3_hwmod,
> +	.slave		= &omap3xxx_iva2_hwmod,
> +	.clk		= "iva2_ck",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod_ocp_if *omap3xxx_iva2_masters[] = {
> +	&omap3xxx_l3__iva2,
> +};
> +
> +/*
> + * IVA2 (IVA2)
> + */
> +
> +static struct omap_hwmod omap3xxx_iva2_hwmod = {
> +	.name		= "dsp",
> +	.class		= &dsp_hwmod_class,
> +	.main_clk	= "iva2_ck",
> +	.masters	= omap3xxx_iva2_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva2_masters),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> +};
> +
>  static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>  	&omap3xxx_l3_hwmod,
>  	&omap3xxx_l4_core_hwmod,
>  	&omap3xxx_l4_per_hwmod,
>  	&omap3xxx_l4_wkup_hwmod,
>  	&omap3xxx_mpu_hwmod,
> +	&omap3xxx_iva2_hwmod,
>  	NULL,
>  };
