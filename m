From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCHv2] OMAP2: DSS: Add Innolux 7" display for DEVKIT8000
Date: Thu, 15 Apr 2010 14:03:37 +0300
Message-ID: <1271329417.2690.243.camel@tubuntu.research.nokia.com>
References: <1270665212-24061-1-git-send-email-swirl@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25382 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab0DOLDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 07:03:52 -0400
In-Reply-To: <1270665212-24061-1-git-send-email-swirl@gmx.li>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext swirl@gmx.li" <swirl@gmx.li>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vaibhav Hiremath <hvaibhav@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Thomas Weber <weber@corscience.de>

Hi,

On Wed, 2010-04-07 at 20:33 +0200, ext swirl@gmx.li wrote:
> From: Thomas Weber <swirl@gmx.li>
> 
> This patch adds the 7 inch display for the DEVKIT8000.
> 
> Thanks to Vaibhav Hiremath for comments.
> 
> Change log:
> 	v2 
> 	Kconfig option description changed.
> 	Remove unneeded header file inclusion.
> 	Remove gotos.

Don't add change logs or similar into commit message.

> 
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
> 
>  drivers/video/omap2/displays/Kconfig               |    8 +-
>  drivers/video/omap2/displays/Makefile              |    1 +
>  .../video/omap2/displays/panel-innolux-at070tn83.c |  148 ++++++++++++++++++++
>  3 files changed, 156 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-innolux-at070tn83.c
> 
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
> index dfb57ee..9d9742e 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -5,7 +5,7 @@ config PANEL_GENERIC
>          tristate "Generic Panel"
>          help
>  	  Generic panel driver.
> -	  Used for DVI output for Beagle and OMAP3 SDP.
> +	  Used for OMAP3 DVI output.

This change doesn't belong to this patch.

Otherwise the patch looks ok. Can you send me a new one without the
change above and without changelog lines in commit message, and I'll add
it to my tree.

 Tomi

>  
>  config PANEL_SHARP_LS037V7DW01
>          tristate "Sharp LS037V7DW01 LCD Panel"
> @@ -19,6 +19,12 @@ config PANEL_SHARP_LQ043T1DG01
>          help
>            LCD Panel used in TI's OMAP3517 EVM boards
>  
> +config PANEL_INNOLUX_AT070TN83
> +	tristate "Innolux AT070TN83 LCD Panel"
> +	depends on OMAP2_DSS
> +	help
> +	 LCD Panel used in TimLL's Devkit8000
> +
>  config PANEL_TAAL
>          tristate "Taal DSI Panel"
>          depends on OMAP2_DSS_DSI
> diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
> index e2bb321..fe3ae8d 100644
> --- a/drivers/video/omap2/displays/Makefile
> +++ b/drivers/video/omap2/displays/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
>  obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
>  obj-$(CONFIG_PANEL_TOPPOLY_TDO35S) += panel-toppoly-tdo35s.o
>  obj-$(CONFIG_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
> +obj-$(CONFIG_PANEL_INNOLUX_AT070TN83) += panel-innolux-at070tn83.o
> diff --git a/drivers/video/omap2/displays/panel-innolux-at070tn83.c b/drivers/video/omap2/displays/panel-innolux-at070tn83.c
> new file mode 100644
> index 0000000..2005653
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-innolux-at070tn83.c
> @@ -0,0 +1,148 @@
> +/*
> + * LCD panel driver for Innolux AT70TN83
> + *
> + * Copyright (C) 2010 Thomas Weber <weber@corscience.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +
> +#include <plat/display.h>
> +
> +static struct omap_video_timings innolux_at_timings = {
> +	.x_res		= 800,
> +	.y_res		= 480,
> +
> +	.pixel_clock	= 40000,
> +
> +	.hsw		= 48,
> +	.hfp		= 1,
> +	.hbp		= 1,
> +
> +	.vsw		= 3,
> +	.vfp		= 12,
> +	.vbp		= 25,
> +};
> +
> +static int innolux_at_panel_power_on(struct omap_dss_device *dssdev)
> +{
> +	int r;
> +
> +	r = omapdss_dpi_display_enable(dssdev);
> +	if (r)
> +		return r;
> +
> +	if (dssdev->platform_enable) {
> +		r = dssdev->platform_enable(dssdev);
> +		if (r)
> +			omapdss_dpi_display_disable(dssdev);
> +	}
> +	return r;
> +}
> +
> +static void innolux_at_panel_power_off(struct omap_dss_device *dssdev)
> +{
> +	if (dssdev->platform_disable)
> +		dssdev->platform_disable(dssdev);
> +
> +	omapdss_dpi_display_disable(dssdev);
> +
> +}
> +
> +static int innolux_at_panel_probe(struct omap_dss_device *dssdev)
> +{
> +	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +		OMAP_DSS_LCD_IHS;
> +	dssdev->panel.acb = 0x28;
> +	dssdev->panel.timings = innolux_at_timings;
> +
> +	return 0;
> +}
> +
> +static void innolux_at_panel_remove(struct omap_dss_device *dssdev)
> +{
> +}
> +
> +static int innolux_at_panel_enable(struct omap_dss_device *dssdev)
> +{
> +	int r = 0;
> +
> +	r = innolux_at_panel_power_on(dssdev);
> +	if (r)
> +		return r;
> +
> +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> +
> +	return 0;
> +}
> +
> +static void innolux_at_panel_disable(struct omap_dss_device *dssdev)
> +{
> +	innolux_at_panel_power_off(dssdev);
> +
> +	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
> +}
> +
> +static int innolux_at_panel_suspend(struct omap_dss_device *dssdev)
> +{
> +	innolux_at_panel_power_off(dssdev);
> +	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
> +	return 0;
> +}
> +
> +static int innolux_at_panel_resume(struct omap_dss_device *dssdev)
> +{
> +	int r = 0;
> +
> +	r = innolux_at_panel_power_on(dssdev);
> +
> +	if (r)
> +		return r;
> +
> +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> +
> +	return 0;
> +}
> +
> +static struct omap_dss_driver innolux_at_driver = {
> +	.probe		= innolux_at_panel_probe,
> +	.remove		= innolux_at_panel_remove,
> +
> +	.enable		= innolux_at_panel_enable,
> +	.disable	= innolux_at_panel_disable,
> +	.suspend	= innolux_at_panel_suspend,
> +	.resume		= innolux_at_panel_resume,
> +
> +	.driver         = {
> +		.name   = "innolux_at_panel",
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +static int __init innolux_at_panel_drv_init(void)
> +{
> +	return omap_dss_register_driver(&innolux_at_driver);
> +}
> +
> +static void __exit innolux_at_panel_drv_exit(void)
> +{
> +	omap_dss_unregister_driver(&innolux_at_driver);
> +}
> +
> +module_init(innolux_at_panel_drv_init);
> +module_exit(innolux_at_panel_drv_exit);
> +MODULE_LICENSE("GPL");


