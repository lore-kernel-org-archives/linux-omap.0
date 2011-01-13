From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCHv2] omap3: Add basic support for 720MHz part
Date: Thu, 13 Jan 2011 09:23:56 +0530
Message-ID: <20110113035355.GA2178@manju-desktop>
References: <1294857234-1676-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:54686 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978Ab1AMDyO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jan 2011 22:54:14 -0500
Received: by mail-yx0-f174.google.com with SMTP id 3so568244yxt.5
        for <linux-omap@vger.kernel.org>; Wed, 12 Jan 2011 19:54:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294857234-1676-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Sanjeev,

On Thu, Jan 13, 2011 at 12:03:54AM +0530, Sanjeev Premi wrote:
> This patch adds support for new speed enhanced parts with ARM
> and IVA running at 720MHz and 520MHz respectively. These parts
> can be probed at run-time by reading PRODID.SKUID[3:0] at
> 0x4830A20C [1].
> 
> This patch specifically doe following:
>  * Detect devices capable of 720MHz.
>  * Add new OPP
>  * Ensure that OPP is conditionally enabled.
> 
>   [1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> Since last revision:
> 1) Using opp_enable() to enable the OPP after the OPP
>    table has been initialized.
> 2) Starting at 3 levels of indent, the statements had
>    be broken into multiple lines for most of the code.
>    So, opted to create a new static that enables the
>    OPPs corresponding to 720MHz.
> 3) I have only build tested this patch - will be able
>    to confirm working tomorrow. With any further change,
>    if needed. (However, functionally nothing has changed.)
> 
>  arch/arm/mach-omap2/control.h         |    7 ++++
>  arch/arm/mach-omap2/id.c              |   10 ++++++
>  arch/arm/mach-omap2/opp3xxx_data.c    |   53 ++++++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/cpu.h |    2 +
>  4 files changed, 71 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index f0629ae..eebc045 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -365,6 +365,13 @@
>  #define		FEAT_NEON		0
>  #define		FEAT_NEON_NONE		1
>  
> +/*
> + * Product ID register
> + */
> +#define OMAP3_PRODID			0x020C
> +
> +#define OMAP3_SKUID_MASK		0x0f
> +#define		OMAP3_SKUID_720MHZ	0x08
>  
>  #ifndef __ASSEMBLY__
>  #ifdef CONFIG_ARCH_OMAP2PLUS
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 5f9086c..53fbe01 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -195,6 +195,15 @@ static void __init omap3_check_features(void)
>  	 * TODO: Get additional info (where applicable)
>  	 *       e.g. Size of L2 cache.
>  	 */
> +
> +	/*
> +	 * Does it support 720MHz?
> +	 */
multiline style comment
> +	status = (OMAP3_SKUID_MASK & read_tap_reg(OMAP3_PRODID));
> +
> +	if (status & OMAP3_SKUID_720MHZ) {
> +		omap3_features |= OMAP3_HAS_720MHZ;
> +	}
braces not required
>  }
>  
>  static void __init omap3_check_revision(void)
> @@ -445,6 +454,7 @@ static void __init omap3_cpuinfo(void)
>  	OMAP3_SHOW_FEATURE(neon);
>  	OMAP3_SHOW_FEATURE(isp);
>  	OMAP3_SHOW_FEATURE(192mhz_clk);
> +	OMAP3_SHOW_FEATURE(720mhz);
>  
>  	printk(")\n");
>  }
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
> index 0486fce..9405c3f 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -17,8 +17,10 @@
>   * GNU General Public License for more details.
>   */
>  #include <linux/module.h>
> +#include <linux/opp.h>
>  
>  #include <plat/cpu.h>
> +#include <plat/omap_device.h>
>  
>  #include "omap_opp_data.h"
>  
> @@ -33,6 +35,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>  	OPP_INITIALIZER("mpu", true, 550000000, 1270000),
>  	/* MPU OPP5 */
>  	OPP_INITIALIZER("mpu", true, 600000000, 1350000),
> +	/* MPU OPP6 */
> +	OPP_INITIALIZER("mpu", false, 720000000, 1350000),
>  
>  	/*
>  	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
> @@ -58,6 +62,8 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>  	OPP_INITIALIZER("iva", true, 400000000, 1270000),
>  	/* DSP OPP5 */
>  	OPP_INITIALIZER("iva", true, 430000000, 1350000),
> +	/* DSP OPP6 */
> +	OPP_INITIALIZER("iva", false, 520000000, 1350000),
>  };
>  
>  static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
> @@ -85,6 +91,46 @@ static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
>  	OPP_INITIALIZER("iva", false, 800000000, 1375000),
>  };
>  
> +
> +/**
> + * omap3_opp_enable_720Mhz() - Enable the OPP corresponding to 720MHz
> + *
> + * This function would be executed only if the silicon is capable of
> + * running at the 720MHz.
> + */
> +static int __init omap3_opp_enable_720Mhz(void)
> +{
> +	int r = -ENODEV;
> +	struct omap_hwmod *oh_mpu = omap_hwmod_lookup("mpu");
> +	struct omap_hwmod *oh_iva = omap_hwmod_lookup("iva");
> +
> +	if (!oh_mpu || !oh_mpu->od) {
> +		goto err;
> +	} else {
> +		r = opp_enable(&(oh_mpu->od->pdev.dev),	720000000);
> +		if (r < 0) {
> +			pr_err("%s: Unable to enable OPP for mpu.", __func__);
since you have dev pointer, pr_err can be replaced with dev_err
> +			goto err;
> +		}
> +	}
> +
> +	if (!oh_iva || !oh_iva->od) {
> +		r = -ENODEV;
> +		goto err;
> +	} else {
> +		r = opp_enable(&(oh_iva->od->pdev.dev), 520000000);
> +		if (r < 0) {
> +			pr_err("%s: Unable to enable OPP for iva.", __func__);
> +			goto err;
> +		}
> +	}
Can be optimized as(not tested and compiled):

	struct platform_device *pdev;
	struct omap_hwmod *oh_mpu = omap_hwmod_lookup("mpu");
	struct omap_hwmod *oh_iva = omap_hwmod_lookup("iva");
	int r = -ENODEV;

	if (!oh_mpu || !oh_mpu->od || !oh_iva || !oh_iva->od)
		goto err;

	pdev = oh_mpu->od->pdev;
	r = opp_enable(&pdev->dev, 720000000);
	if (r < 0) {
		dev_err(&pdev->dev, "Unable to enable OPP for mpu.\n");
		goto err;
	}
	pdev = oh_iva->od->pdev;
	r = opp_enable(&pdev->dev, 520000000);
	if (r < 0) {
		dev_err(&pdev->dev, "Unable to enable OPP for iva.\n");
		goto err;
	}

Do you see any issues?

-Manjunath

[...]
