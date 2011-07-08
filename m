From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [RFC 4/4] OMAP3: beagle rev-c4: enable OPP6
Date: Fri, 8 Jul 2011 17:23:47 +0100
Message-ID: <09F67D77-858A-48E2-8E1E-9EFCC26C26A0@dominion.thruhere.net>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com> <1310140588-26078-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0 (iPhone Mail 8J2)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57774 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab1GHQX4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 12:23:56 -0400
Received: by wwe5 with SMTP id 5so2132146wwe.1
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 09:23:55 -0700 (PDT)
In-Reply-To: <1310140588-26078-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<lrg@ti.com>" <lrg@ti.com>, "<broonie@opensource.wolfsonmicro.com>" <broonie@opensource.wolfsonmicro.com>



Op 8 jul. 2011 om 16:56 heeft Tero Kristo <t-kristo@ti.com> het volgende geschreven:

> Beagleboard rev-c4 has a speed sorted OMAP3530 chip which can run at 720MHz.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> arch/arm/mach-omap2/board-omap3beagle.c |   32 +++++++++++++++++++++++++++++++
> arch/arm/mach-omap2/opp3xxx_data.c      |    4 +++
> 2 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 6d3a266..bc3e5ed 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -574,6 +574,38 @@ static void __init beagle_opp_init(void)
>        return;
>    }
> 
> +    /* Custom OPP enabled for C4 */
> +    if (omap3_beagle_version == OMAP3BEAGLE_BOARD_C4) {

The 720 capable chips have a sku id you can read, so this is better done in the core code. Sanjeev Premi has been trying to get that merged for a while now, so please take this issue up with him.







> +        struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
> +        struct omap_hwmod *dh = omap_hwmod_lookup("iva");
> +        struct device *dev;
> +
> +        if (!mh || !dh) {
> +            pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
> +                __func__, mh, dh);
> +        }
> +        /* Enable MPU 720MHz opp */
> +        dev = &mh->od->pdev.dev;
> +        r = opp_enable(dev, 720000000);
> +
> +        /* Enable IVA 520MHz opp */
> +        dev = &dh->od->pdev.dev;
> +        r |= opp_enable(dev, 520000000);
> +
> +        if (r) {
> +            pr_err("%s: failed to enable higher opp %d\n",
> +                __func__, r);
> +            /*
> +             * Cleanup - disable the higher freqs - we dont care
> +             * about the results
> +             */
> +            dev = &mh->od->pdev.dev;
> +            opp_disable(dev, 720000000);
> +            dev = &dh->od->pdev.dev;
> +            opp_disable(dev, 520000000);
> +        }
> +    }
> +
>    /* Custom OPP enabled for all xM versions */
>    if (cpu_is_omap3630()) {
>        struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
> index d95f3f9..a0f5fe1 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -98,6 +98,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>    OPP_INITIALIZER("mpu", true, 550000000, OMAP3430_VDD_MPU_OPP4_UV),
>    /* MPU OPP5 */
>    OPP_INITIALIZER("mpu", true, 600000000, OMAP3430_VDD_MPU_OPP5_UV),
> +    /* MPU OPP6 : omap3530 high speed grade only */
> +    OPP_INITIALIZER("mpu", false, 720000000, OMAP3430_VDD_MPU_OPP5_UV),
> 
>    /*
>     * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
> @@ -123,6 +125,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>    OPP_INITIALIZER("iva", true, 400000000, OMAP3430_VDD_MPU_OPP4_UV),
>    /* DSP OPP5 */
>    OPP_INITIALIZER("iva", true, 430000000, OMAP3430_VDD_MPU_OPP5_UV),
> +    /* DSP OPP6 : omap3530 high speed grade only */
> +    OPP_INITIALIZER("iva", false, 520000000, OMAP3430_VDD_MPU_OPP5_UV),
> };
> 
> static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
> -- 
> 1.7.4.1
> 
> 
> Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
