From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
Date: Tue, 16 Nov 2010 17:21:06 +0200
Message-ID: <1289920866.2668.138.camel@tubuntu>
References: <1289881031-21354-1-git-send-email-bryan.wu@canonical.com>
	 <1289881031-21354-2-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:64976 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab0KPPVQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 10:21:16 -0500
In-Reply-To: <1289881031-21354-2-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gadiyar@ti.com" <gadiyar@ti.com>

Hi,

On Tue, 2010-11-16 at 05:17 +0100, ext Bryan Wu wrote:
> Generic DPI panel driver includes the driver and 4 similar panel configurations. It
> will match the panel name which is passed from platform data and setup the
> right configurations.
> 
> With generic DPI panel driver, we can remove those 4 duplicated panel display
> drivers. In the future, it is simple for us just add new panel configuration
> date in panel-generic-dpi.c to support new display panel.
> 
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  .../arm/plat-omap/include/plat/panel-generic-dpi.h |   37 +++
>  drivers/video/omap2/displays/Kconfig               |    8 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  drivers/video/omap2/displays/panel-generic-dpi.c   |  333 ++++++++++++++++++++
>  4 files changed, 379 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>  create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
> 
> diff --git a/arch/arm/plat-omap/include/plat/panel-generic-dpi.h b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
> new file mode 100644
> index 0000000..7906197
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/panel-generic-dpi.h
> @@ -0,0 +1,37 @@
> +/*
> + * Header for generic DPI panel driver
> + *
> + * Copyright (C) 2010 Canonical Ltd.
> + * Author: Bryan Wu <bryan.wu@canonical.com>
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
> +#ifndef __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
> +#define __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H
> +
> +#include "display.h"
> +
> +/**
> + * struct panel_generic_dpi_data - panel driver configuration data
> + * @name: panel name
> + * @platform_enable: platform specific panel enable function
> + * @platform_disable: platform specific panel disable function
> + */
> +struct panel_generic_dpi_data {
> +	const char *name;
> +	int (*platform_enable)(struct omap_dss_device *dssdev);
> +	void (*platform_disable)(struct omap_dss_device *dssdev);
> +};
> +
> +#endif /* __ARCH_ARM_PLAT_OMAP_PANEL_GENERIC_DPI_H */
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
> index 12327bb..cb3e339 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -1,6 +1,14 @@
>  menu "OMAP2/3 Display Device Drivers"
>          depends on OMAP2_DSS
>  
> +config PANEL_GENERIC_DPI
> +        tristate "Generic DPI Panel"
> +        help
> +	  Generic DPI panel driver.
> +	  Supports DVI output for Beagle and OMAP3 SDP.
> +	  Supports LCD Panel used in TI SDP3430 and EVM boards,
> +	  OMAP3517 EVM boards and CM-T35.
> +
>  config PANEL_GENERIC
>          tristate "Generic Panel"
>          help
> diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
> index aa38609..022058c 100644
> --- a/drivers/video/omap2/displays/Makefile
> +++ b/drivers/video/omap2/displays/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_PANEL_GENERIC_DPI) += panel-generic-dpi.o
>  obj-$(CONFIG_PANEL_GENERIC) += panel-generic.o
>  obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
>  obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
> new file mode 100644
> index 0000000..c3fff9e
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -0,0 +1,333 @@
> +/*
> + * Generic DPI Panels support
> + *
> + * Copyright (C) 2010 Canonical Ltd.
> + * Author: Bryan Wu <bryan.wu@canonical.com>
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
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
> +
> +#include <plat/panel-generic-dpi.h>
> +
> +struct panel_config {
> +	struct omap_video_timings timings;
> +
> +	int acbi;	/* ac-bias pin transitions per interrupt */
> +	/* Unit: line clocks */
> +	int acb;	/* ac-bias pin frequency */
> +
> +	enum omap_panel_config config;
> +
> +	int power_on_delay;
> +	int power_off_delay;
> +
> +	/*
> +	 * Used to match device to panel configuration
> +	 * when use generic panel driver
> +	 */
> +	const char *name;
> +};
> +
> +/* Panel configurations */
> +static struct panel_config generic_dpi_panels[] = {
> +	/* Generic Panel */
> +	{
> +		{
> +			.x_res		= 640,
> +			.y_res		= 480,
> +
> +			.pixel_clock	= 23500,
> +
> +			.hfp		= 48,
> +			.hsw		= 32,
> +			.hbp		= 80,
> +
> +			.vfp		= 3,
> +			.vsw		= 4,
> +			.vbp		= 7,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x0,
> +		.config			= OMAP_DSS_LCD_TFT,
> +		.power_on_delay		= 0,
> +		.power_off_delay	= 0,
> +		.name			= "generic",
> +	},
> +
> +	/* Sharp LQ043T1DG01 */
> +	{
> +		{
> +			.x_res		= 480,
> +			.y_res		= 272,
> +
> +			.pixel_clock	= 9000,
> +
> +			.hsw		= 42,
> +			.hfp		= 3,
> +			.hbp		= 2,
> +
> +			.vsw		= 11,
> +			.vfp		= 3,
> +			.vbp		= 2,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x0,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
> +		.power_on_delay		= 50,
> +		.power_off_delay	= 100,
> +		.name			= "sharp_lq",
> +	},
> +
> +	/* Sharp LS037V7DW01 */
> +	{
> +		{
> +			.x_res		= 480,
> +			.y_res		= 640,
> +
> +			.pixel_clock	= 19200,
> +
> +			.hsw		= 2,
> +			.hfp		= 1,
> +			.hbp		= 28,
> +
> +			.vsw		= 1,
> +			.vfp		= 1,
> +			.vbp		= 1,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x28,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +						OMAP_DSS_LCD_IHS,
> +		.power_on_delay		= 50,
> +		.power_off_delay	= 100,
> +		.name			= "sharp_ls",
> +	},
> +
> +	/* Toppoly TDO35S */
> +	{
> +		{
> +			.x_res		= 480,
> +			.y_res		= 640,
> +
> +			.pixel_clock	= 26000,
> +
> +			.hfp		= 104,
> +			.hsw		= 8,
> +			.hbp		= 8,
> +
> +			.vfp		= 4,
> +			.vsw		= 2,
> +			.vbp		= 2,
> +		},
> +		.acbi			= 0x0,
> +		.acb			= 0x0,
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC |
> +					OMAP_DSS_LCD_ONOFF,
> +		.power_on_delay		= 0,
> +		.power_off_delay	= 0,
> +		.name			= "toppoly_tdo35s",
> +	},
> +};
> +
> +static power_on_delay = 0;
> +
> +static power_off_delay = 0;

This is not right. There may be multiple panels in a single board, and
these would be shared by both of the panels.

What you need to do is have a struct, which contains pointer to the
panel configuration used with that particular dssdev, and set the struct
with dev_set_drvdata().

Check panel-taal.c for an example. There's struct taal_data, which
contains also quite a bit other data, but also a pointer to the panel
config.

 Tomi


