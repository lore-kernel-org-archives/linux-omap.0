From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH v4] board-omap3-beagle: add DSS2 support
Date: Wed, 14 Apr 2010 14:16:09 +0000
Message-ID: <4BC5CE29.5030409@corscience.de>
References: <1271248380-24370-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49279 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab0DNNQx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 09:16:53 -0400
In-Reply-To: <1271248380-24370-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen.kooi@gmail.com>
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>

On 04/14/10 12:33, Koen Kooi wrote:
> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV-out are supported.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
> 
> Changes since v1:
>         * removed beagle_panel_enable_tv() and beagle_panel_disable_tv()
> Changes since v2:
>         * changed to REGULATOR_SUPPLY(_name, _dev_name) for dss regulators
> Changes since v3:
>         * really remove beagle_panel_enable_tv() and beagle_panel_disable_tv()
>         * moved comments to this section
> 
>  arch/arm/mach-omap2/board-omap3beagle.c |  102 ++++++++++++++++++++++--------
>  1 files changed, 75 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 962d377..96999a3 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -39,6 +39,7 @@
>  
>  #include <plat/board.h>
>  #include <plat/common.h>
> +#include <plat/display.h>
>  #include <plat/gpmc.h>
>  #include <plat/nand.h>
>  #include <plat/usb.h>
> @@ -106,6 +107,77 @@ static struct platform_device omap3beagle_nand_device = {
>  	.resource	= &omap3beagle_nand_resource,
>  };
>  
> +/* DSS */
> +
> +static int beagle_enable_dvi(struct omap_dss_device *dssdev)
> +{
> +	if (dssdev->reset_gpio != -1)
> +		gpio_set_value(dssdev->reset_gpio, 1);
> +
> +	return 0;
> +}
> +
> +static void beagle_disable_dvi(struct omap_dss_device *dssdev)
> +{
> +	if (dssdev->reset_gpio != -1)
> +		gpio_set_value(dssdev->reset_gpio, 0);
> +}
> +
> +static struct omap_dss_device beagle_dvi_device = {
> +	.type = OMAP_DISPLAY_TYPE_DPI,
> +	.name = "dvi",
> +	.driver_name = "generic_panel",
> +	.phy.dpi.data_lines = 24,
> +	.reset_gpio = 170,
> +	.platform_enable = beagle_enable_dvi,
> +	.platform_disable = beagle_disable_dvi,
> +};
> +
> +static struct omap_dss_device beagle_tv_device = {
> +	.name = "tv",
> +	.driver_name = "venc",
> +	.type = OMAP_DISPLAY_TYPE_VENC,
> +	.phy.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
> +};
> +
> +static struct omap_dss_device *beagle_dss_devices[] = {
> +	&beagle_dvi_device,
> +	&beagle_tv_device,
> +};
> +
> +static struct omap_dss_board_info beagle_dss_data = {
> +	.num_devices = ARRAY_SIZE(beagle_dss_devices),
> +	.devices = beagle_dss_devices,
> +	.default_device = &beagle_dvi_device,
> +};
> +
> +static struct platform_device beagle_dss_device = {
> +	.name          = "omapdss",
> +	.id            = -1,
> +	.dev            = {
> +		.platform_data = &beagle_dss_data,
> +	},
> +};
> +
> +static struct regulator_consumer_supply beagle_vdac_supply = 
Trailing whitespace
> +	REGULATOR_SUPPLY("vdda_dac", "omapdss");
> +
> +static struct regulator_consumer_supply beagle_vdvi_supply = 
Here too.

Thomas
