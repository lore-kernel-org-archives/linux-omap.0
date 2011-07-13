From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2 4/5] TEMP: OMAP3: beagle rev-c4: enable OPP6
Date: Wed, 13 Jul 2011 23:19:32 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DB119F6@dbde02.ent.ti.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
 <1310565638-13140-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49869 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964805Ab1GMRtk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 13:49:40 -0400
In-Reply-To: <1310565638-13140-5-git-send-email-t-kristo@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, "Hilman, Kevin" <khilman@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kristo, Tero
> Sent: Wednesday, July 13, 2011 7:31 PM
> To: linux-omap@vger.kernel.org
> Cc: broonie@opensource.wolfsonmicro.com; Girdwood, Liam; Hilman, Kevin
> Subject: [PATCHv2 4/5] TEMP: OMAP3: beagle rev-c4: enable OPP6
> 
> Beagleboard rev-c4 has a speed sorted OMAP3530 chip which can 
> run at 720MHz.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |   32 
> +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/opp3xxx_data.c      |    4 +++
>  2 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c 
> b/arch/arm/mach-omap2/board-omap3beagle.c
> index d7ae648..5ab507d 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -592,6 +592,38 @@ static void __init beagle_opp_init(void)
>  		return;
>  	}
>  
> +	/* Custom OPP enabled for C4 */
> +	if (omap3_beagle_version == OMAP3BEAGLE_BOARD_C4) {
> +		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
> +		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
> +		struct device *dev;
> +
> +		if (!mh || !dh) {
> +			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
> +				__func__, mh, dh);
> +		}
> +		/* Enable MPU 720MHz opp */
> +		dev = &mh->od->pdev.dev;
> +		r = opp_enable(dev, 720000000);
> +
> +		/* Enable IVA 520MHz opp */
> +		dev = &dh->od->pdev.dev;
> +		r |= opp_enable(dev, 520000000);
> +
> +		if (r) {
> +			pr_err("%s: failed to enable higher opp %d\n",
> +				__func__, r);
> +			/*
> +			 * Cleanup - disable the higher freqs - 
> we dont care
> +			 * about the results
> +			 */
> +			dev = &mh->od->pdev.dev;
> +			opp_disable(dev, 720000000);
> +			dev = &dh->od->pdev.dev;
> +			opp_disable(dev, 520000000);
> +		}
> +	}
> +
>  	/* Custom OPP enabled for all xM versions */
>  	if (cpu_is_omap3630()) {
>  		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c 
> b/arch/arm/mach-omap2/opp3xxx_data.c
> index d95f3f9..a0f5fe1 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -98,6 +98,8 @@ static struct omap_opp_def __initdata 
> omap34xx_opp_def_list[] = {
>  	OPP_INITIALIZER("mpu", true, 550000000, 
> OMAP3430_VDD_MPU_OPP4_UV),
>  	/* MPU OPP5 */
>  	OPP_INITIALIZER("mpu", true, 600000000, 
> OMAP3430_VDD_MPU_OPP5_UV),
> +	/* MPU OPP6 : omap3530 high speed grade only */
> +	OPP_INITIALIZER("mpu", false, 720000000, 
> OMAP3430_VDD_MPU_OPP5_UV),
>  
>  	/*
>  	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage 
> for that OPP is
> @@ -123,6 +125,8 @@ static struct omap_opp_def __initdata 
> omap34xx_opp_def_list[] = {
>  	OPP_INITIALIZER("iva", true, 400000000, 
> OMAP3430_VDD_MPU_OPP4_UV),
>  	/* DSP OPP5 */
>  	OPP_INITIALIZER("iva", true, 430000000, 
> OMAP3430_VDD_MPU_OPP5_UV),
> +	/* DSP OPP6 : omap3530 high speed grade only */
> +	OPP_INITIALIZER("iva", false, 520000000, 
> OMAP3430_VDD_MPU_OPP5_UV),
>  };
>  
>  static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {

[sp] Basic support for 720MHz was already closed early this year.
     See: http://marc.info/?l=linux-omap&m=129735630928696&w=2

     I cannot check the current tree status right now; but I assume
     the patch should already be in.

~sanjeev

> -- 
> 1.7.4.1
> 
> 
> Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 
> 0115040-6. Kotipaikka: Helsinki
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 