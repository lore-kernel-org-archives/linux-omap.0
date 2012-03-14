From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/12] mfd: twl-core: don't depend on
 pdata->irq_base/end
Date: Wed, 14 Mar 2012 15:14:54 -0700
Message-ID: <20120314221454.GS12083@atomide.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-2-git-send-email-b-cousson@ti.com>
 <87pqcegapk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11344 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761510Ab2CNWPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 18:15:00 -0400
Content-Disposition: inline
In-Reply-To: <87pqcegapk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, sameo@linux.intel.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

* Kevin Hilman <khilman@ti.com> [120314 14:02]:
> From: Kevin Hilman <khilman@ti.com>
> Date: Wed, 14 Mar 2012 13:56:01 -0700
> Subject: [PATCH 2/2] ARM: OMAP2+: TWL: remove usage of pdata->irq_base/_end
> 
> The driver has been converted to use SPARSE_IRQ and no longer needs to
> be passed IRQ base/end.  The driver no longer uses these fields, so
> remove them from the reamaining users.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c    |    3 ---
>  arch/arm/mach-omap2/board-omap3logic.c |    3 ---
>  arch/arm/mach-omap2/twl-common.c       |    9 ---------
>  3 files changed, 15 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index c8bda62..b8b3700 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -218,9 +218,6 @@ static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
>  };
>  
>  static struct twl4030_platform_data sdp2430_twldata = {
> -	.irq_base	= TWL4030_IRQ_BASE,
> -	.irq_end	= TWL4030_IRQ_END,
> -
>  	/* platform_data for children goes here */
>  	.gpio		= &sdp2430_gpio_data,
>  	.vmmc1		= &sdp2430_vmmc1,
> diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
> index 4a7d8c8..f145935 100644
> --- a/arch/arm/mach-omap2/board-omap3logic.c
> +++ b/arch/arm/mach-omap2/board-omap3logic.c
> @@ -85,9 +85,6 @@ static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
>  };
>  
>  static struct twl4030_platform_data omap3logic_twldata = {
> -	.irq_base	= TWL4030_IRQ_BASE,
> -	.irq_end	= TWL4030_IRQ_END,
> -
>  	/* platform_data for children goes here */
>  	.gpio		= &omap3logic_gpio_data,
>  	.vmmc1		= &omap3logic_vmmc1,
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index 1cddcb2..5c9aa3f 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -184,10 +184,6 @@ static struct twl_regulator_driver_data omap3_vdd2_drvdata = {
>  void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
>  				  u32 pdata_flags, u32 regulators_flags)
>  {
> -	if (!pmic_data->irq_base)
> -		pmic_data->irq_base = TWL4030_IRQ_BASE;
> -	if (!pmic_data->irq_end)
> -		pmic_data->irq_end = TWL4030_IRQ_END;
>  	if (!pmic_data->vdd1) {
>  		omap3_vdd1.driver_data = &omap3_vdd1_drvdata;
>  		omap3_vdd1_drvdata.data = voltdm_lookup("mpu_iva");
> @@ -415,11 +411,6 @@ static struct twl_regulator_driver_data omap4_vdd3_drvdata = {
>  void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
>  				  u32 pdata_flags, u32 regulators_flags)
>  {
> -	if (!pmic_data->irq_base)
> -		pmic_data->irq_base = TWL6030_IRQ_BASE;
> -	if (!pmic_data->irq_end)
> -		pmic_data->irq_end = TWL6030_IRQ_END;
> -
>  	if (!pmic_data->vdd1) {
>  		omap4_vdd1.driver_data = &omap4_vdd1_drvdata;
>  		omap4_vdd1_drvdata.data = voltdm_lookup("mpu");
> -- 

Looks right to me:

Acked-by: Tony Lindgren <tony@atomide.com>
