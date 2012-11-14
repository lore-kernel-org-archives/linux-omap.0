From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Wed, 14 Nov 2012 17:41:03 +0100
Message-ID: <CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
References: <k80da6$61d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:52612 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161219Ab2KNQlE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 11:41:04 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so400242iay.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Nov 2012 08:41:04 -0800 (PST)
In-Reply-To: <k80da6$61d$1@ger.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i.mazanov@gmail.com, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Wed, Nov 14, 2012 at 4:28 PM, Igor Mazanov <i.mazanov@gmail.com> wrote:
> Hello,
>
> Beaglebone boot process is broken with the current git kernel. I use
> omap2plus_defconfig for tests.
>
> It looks like the boot process stops due to the last changes in the AM33xx
> clock sysbsystem. A following patch resolves this issue:
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index ad8d43b..858e180 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -586,7 +586,7 @@ static struct omap_hwmod am33xx_smartreflex0_hwmod = {
>         .class          = &am33xx_smartreflex_hwmod_class,
>         .clkdm_name     = "l4_wkup_clkdm",
>         .mpu_irqs       = am33xx_smartreflex0_irqs,
> -       .main_clk       = "smartreflex0_fck",
> +       .main_clk       = "smartreflex_mpu_fck",
>         .prcm           = {
>                 .omap4  = {
>                         .clkctrl_offs   =
> AM33XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET,
> @@ -606,7 +606,7 @@ static struct omap_hwmod am33xx_smartreflex1_hwmod = {
>         .class          = &am33xx_smartreflex_hwmod_class,
>         .clkdm_name     = "l4_wkup_clkdm",
>         .mpu_irqs       = am33xx_smartreflex1_irqs,
> -       .main_clk       = "smartreflex1_fck",
> +       .main_clk       = "smartreflex_core_fck",
>         .prcm           = {
>                 .omap4  = {
>                         .clkctrl_offs   =
> AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET,
>

About the name field in the hwmod entry: the SR code checks on the
value of "smartreflex_mpu_iva" to differentiate the SR IP blocks and
to apply the correct parameters to each of them. Cf. the function
sr_set_regfields in drivers/power/avs/smartreflex.c.

The patch should change the name of the hwmod entry as well, can you
fold this change in the current patch?

Note: I know the name "smartreflex_mpu_iva" is not perfect since it
does not apply to all OMAP3 variants, maybe we could change the SR
code to be more generic.

Nishant, what do you think?

Regards,
Jean

>
> Regards,
> Igor.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
