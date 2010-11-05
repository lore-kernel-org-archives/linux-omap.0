From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH 1/3] OMAP: use generic panel data in board files
Date: Sat, 6 Nov 2010 02:47:24 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034BF2D67E@dbde02.ent.ti.com>
References: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
 <1288986236-30210-2-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33742 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646Ab0KEVRj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 17:17:39 -0400
In-Reply-To: <1288986236-30210-2-git-send-email-bryan.wu@canonical.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.

Hi,

linux-omap-owner@vger.kernel.org wrote:
> Introduce struct panel config data in panel.h, which will be
> used to match the right panel configurations in generic DPI
> panel driver and other future dsi panel drivers.
>
> Still keep sharp_ls_panel, since the sharp_ls_panel driver
> contains blacklight control driver code which will be moved
> out later. Then we can use generic DPI driver for sharp_ls_panel.
>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c               |   10 +++-
>  arch/arm/mach-omap2/board-am3517evm.c             |   19 +++++--
>  arch/arm/mach-omap2/board-cm-t35.c                |   19 +++++--
>  arch/arm/mach-omap2/board-devkit8000.c            |   22 +++++---
>  arch/arm/mach-omap2/board-igep0020.c              |   10 +++-
>  arch/arm/mach-omap2/board-omap3beagle.c           |   10 +++-
>  arch/arm/mach-omap2/board-omap3evm.c              |   10 +++-
>  arch/arm/mach-omap2/board-omap3stalker.c          |   19 +++++--
>  arch/arm/plat-omap/include/plat/nokia-dsi-panel.h |   31 -----------
>  arch/arm/plat-omap/include/plat/panel.h           |   57
>  +++++++++++++++++++++ drivers/video/omap2/displays/panel-taal.c         |
>  26 ++++------ 11 files changed, 148 insertions(+), 85 deletions(-)  delete
> mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
>  create mode 100644 arch/arm/plat-omap/include/plat/panel.h

I am not totally sure about the need of removal of nokia-dsi-panel.h
and the addition of a generic panel.h.

I guess the reason why nokia-dsi-panel.h was introduced (and others that
will be introduced in future) was to easily represent panel-specific data
across different boards that use the same panel.

For example, if there is a new panel which for some reson uses 2 pins, one
for switching off and one for switching on the panel, then it would make sense
to introduce a structure for this panel having members on_gpio and off_gpio, this
struct could then be passed and accessed through dssdev->data in the panel's probe
giving us the option to have different gpio numbers for different boards but finally
being accessed in the same way by the driver.

So, there isn't a need to generalize this struct and the corresponding header file
for all panels and make it available for all board files.

As far as the dummy panels are concerned, since the "name" is the only criteria to
differentiate the panel, I think passing the name to the data member of omap_dss_device
should itself be enough for the generic dpi driver to handle things.

>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c
> b/arch/arm/mach-omap2/board-3430sdp.c
> index 4e3742c..859b4e5 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -38,6 +38,7 @@
>  #include <plat/dma.h>
>  #include <plat/gpmc.h>
>  #include <plat/display.h>
> +#include <plat/panel.h>
>
>  #include <plat/gpmc-smc91x.h>
>
> @@ -270,11 +271,14 @@ static struct omap_dss_device sdp3430_lcd_device = {
>       .platform_disable       = sdp3430_panel_disable_lcd,
>  };
>
> +static struct panel_data dvi_panel = {
> +     .name           = "generic",
> +};
> +
>  static struct omap_dss_device sdp3430_dvi_device = {         .name                   = "dvi",
> -     .driver_name            = "generic_panel",
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
> -     .phy.dpi.data_lines     = 24,
> +     .driver_name            = "dpi_panel",
> +     .data                   = &dvi_panel,
>       .platform_enable        = sdp3430_panel_enable_dvi,
>       .platform_disable       = sdp3430_panel_disable_dvi,
>  };
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c
> b/arch/arm/mach-omap2/board-am3517evm.c
> index 0739950..9b2b6ff 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -35,6 +35,7 @@
>  #include <plat/common.h>
>  #include <plat/usb.h>
>  #include <plat/display.h>
> +#include <plat/panel.h>
>
>  #include "mux.h"
>  #include "control.h"
> @@ -303,11 +304,14 @@ static void
> am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)          lcd_enabled =
>  0; }
>
> +static struct panel_data lcd_panel = {
> +     .name           = "sharp_lq",
> +};
> +
>  static struct omap_dss_device am3517_evm_lcd_device = {
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
>       .name                   = "lcd",
> -     .driver_name            = "sharp_lq_panel",
> -     .phy.dpi.data_lines     = 16,
> +     .driver_name            = "dpi_panel",
> +     .data                   = &lcd_panel,
>       .platform_enable        = am3517_evm_panel_enable_lcd,
>       .platform_disable       = am3517_evm_panel_disable_lcd,  };
> @@ -346,11 +350,14 @@ static void
> am3517_evm_panel_disable_dvi(struct omap_dss_device *dssdev)          dvi_enabled =
>  0; }
>
> +static struct panel_data dvi_panel = {
> +     .name           = "generic",
> +};
> +
>  static struct omap_dss_device am3517_evm_dvi_device = {
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
>       .name                   = "dvi",
> -     .driver_name            = "generic_panel",
> -     .phy.dpi.data_lines     = 24,
> +     .driver_name            = "dpi_panel",
> +     .data                   = &dvi_panel,
>       .platform_enable        = am3517_evm_panel_enable_dvi,
>       .platform_disable       = am3517_evm_panel_disable_dvi,  };
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c
> b/arch/arm/mach-omap2/board-cm-t35.c
> index 63f764e..326aa15 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -46,6 +46,7 @@
>  #include <plat/gpmc.h>
>  #include <plat/usb.h>
>  #include <plat/display.h>
> +#include <plat/panel.h>
>  #include <plat/mcspi.h>
>
>  #include <mach/hardware.h>
> @@ -351,20 +352,26 @@ static void
> cm_t35_panel_disable_tv(struct omap_dss_device *dssdev)  {  }
>
> +static struct panel_data lcd_panel = {
> +     .name           = "toppoly_tdo35s",
> +};
> +
>  static struct omap_dss_device cm_t35_lcd_device = {          .name                   = "lcd",
> -     .driver_name            = "toppoly_tdo35s_panel",
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
> -     .phy.dpi.data_lines     = 18,
> +     .driver_name            = "dpi_panel",
> +     .data                   = &lcd_panel,
>       .platform_enable        = cm_t35_panel_enable_lcd,
>       .platform_disable       = cm_t35_panel_disable_lcd,
>  };
>
> +static struct panel_data dvi_panel = {
> +     .name           = "generic",
> +};
> +
>  static struct omap_dss_device cm_t35_dvi_device = {          .name                   = "dvi",
> -     .driver_name            = "generic_panel",
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
> -     .phy.dpi.data_lines     = 24,
> +     .driver_name            = "dpi_panel",
> +     .data                   = &dvi_panel,
>       .platform_enable        = cm_t35_panel_enable_dvi,
>       .platform_disable       = cm_t35_panel_disable_dvi,
>  };
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c
> b/arch/arm/mach-omap2/board-devkit8000.c
> index 067f437..c38ece3 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -46,6 +46,7 @@
>  #include <plat/nand.h>
>  #include <plat/usb.h>
>  #include <plat/display.h>
> +#include <plat/panel.h>
>
>  #include <plat/mcspi.h>
>  #include <linux/input/matrix_keypad.h>
> @@ -149,21 +150,26 @@ static struct regulator_consumer_supply
> devkit8000_vmmc1_supply =  static struct
> regulator_consumer_supply devkit8000_vio_supply =
>       REGULATOR_SUPPLY("vcc", "spi2.0");
>
> +static struct panel_data lcd_panel = {
> +     .name           = "generic",
> +};
> +
>  static struct omap_dss_device devkit8000_lcd_device = {
>       .name                   = "lcd",
> -     .driver_name            = "generic_panel",
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
> -     .phy.dpi.data_lines     = 24,
> -     .reset_gpio             = -EINVAL, /* will be replaced */
> +     .driver_name            = "dpi_panel",
> +     .data                   = &lcd_panel,
>       .platform_enable        = devkit8000_panel_enable_lcd,
>       .platform_disable       = devkit8000_panel_disable_lcd,  };
> +
> +static struct panel_data dvi_panel = {
> +     .name           = "generic",
> +};
> +
>  static struct omap_dss_device devkit8000_dvi_device = {
>       .name                   = "dvi",
> -     .driver_name            = "generic_panel",
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
> -     .phy.dpi.data_lines     = 24,
> -     .reset_gpio             = -EINVAL, /* will be replaced */
> +     .driver_name            = "dpi_panel",
> +     .data                   = &dvi_panel,
>       .platform_enable        = devkit8000_panel_enable_dvi,
>       .platform_disable       = devkit8000_panel_disable_dvi,  };
> diff --git a/arch/arm/mach-omap2/board-igep0020.c
> b/arch/arm/mach-omap2/board-igep0020.c
> index 5e035a5..c2475bb 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -30,6 +30,7 @@
>  #include <plat/gpmc.h>
>  #include <plat/usb.h>
>  #include <plat/display.h>
> +#include <plat/panel.h>
>  #include <plat/onenand.h>
>
>  #include "mux.h"
> @@ -433,11 +434,14 @@ static void igep2_disable_dvi(struct omap_dss_device
>       *dssdev) gpio_direction_output(IGEP2_GPIO_DVI_PUP, 0);  }
>
> +static struct panel_data dvi_panel = {
> +     .name           = "generic",
> +};
> +
>  static struct omap_dss_device igep2_dvi_device = {
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
>       .name                   = "dvi",
> -     .driver_name            = "generic_panel",
> -     .phy.dpi.data_lines     = 24,
> +     .driver_name            = "dpi_panel",
> +     .data                   = &dvi_panel,
>       .platform_enable        = igep2_enable_dvi,
>       .platform_disable       = igep2_disable_dvi,
>  };
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
> b/arch/arm/mach-omap2/board-omap3beagle.c
> index 14f4224..1d2a634 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -41,6 +41,7 @@
>  #include <plat/board.h>
>  #include <plat/common.h>
>  #include <plat/display.h>
> +#include <plat/panel.h>
>  #include <plat/gpmc.h>
>  #include <plat/nand.h>
>  #include <plat/usb.h>
> @@ -194,11 +195,14 @@ static void beagle_disable_dvi(struct omap_dss_device
>               *dssdev) gpio_set_value(dssdev->reset_gpio, 0);  }
>
> +static struct panel_data dvi_panel = {
> +     .name = "generic",
> +};
> +
>  static struct omap_dss_device beagle_dvi_device = {
> -     .type = OMAP_DISPLAY_TYPE_DPI,
>       .name = "dvi",
> -     .driver_name = "generic_panel",
> -     .phy.dpi.data_lines = 24,
> +     .driver_name = "dpi_panel",
> +     .data = &dvi_panel,
>       .reset_gpio = 170,
>       .platform_enable = beagle_enable_dvi,
>       .platform_disable = beagle_disable_dvi, diff --git
> a/arch/arm/mach-omap2/board-omap3evm.c
> b/arch/arm/mach-omap2/board-omap3evm.c
> index b04365c..981de08 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -43,6 +43,7 @@
>  #include <plat/common.h>
>  #include <plat/mcspi.h>
>  #include <plat/display.h>
> +#include <plat/panel.h>
>
>  #include "mux.h"
>  #include "sdram-micron-mt46h32m32lf-6.h"
> @@ -301,11 +302,14 @@ static void
> omap3_evm_disable_dvi(struct omap_dss_device *dssdev)         dvi_enabled = 0;
>  }
>
> +static struct panel_data dvi_panel = {
> +     .name =         "generic",
> +};
> +
>  static struct omap_dss_device omap3_evm_dvi_device = {       .name                   = "dvi",
> -     .driver_name            = "generic_panel",
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
> -     .phy.dpi.data_lines     = 24,
> +     .driver_name            = "dpi_panel",
> +     .data                   = &dvi_panel,
>       .platform_enable        = omap3_evm_enable_dvi,
>       .platform_disable       = omap3_evm_disable_dvi,
>  };
> diff --git a/arch/arm/mach-omap2/board-omap3stalker.c
> b/arch/arm/mach-omap2/board-omap3stalker.c
> index f252721..85bcfd6 100644
> --- a/arch/arm/mach-omap2/board-omap3stalker.c
> +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> @@ -40,6 +40,7 @@
>  #include <plat/nand.h>
>  #include <plat/usb.h>
>  #include <plat/display.h>
> +#include <plat/panel.h>
>
>  #include <plat/mcspi.h>
>  #include <linux/input/matrix_keypad.h>
> @@ -160,11 +161,14 @@ static void
> omap3_stalker_disable_lcd(struct omap_dss_device *dssdev)     lcd_enabled = 0;
>  }
>
> +static struct panel_data lcd_panel = {
> +     .name           = "generic",
> +};
> +
>  static struct omap_dss_device omap3_stalker_lcd_device = {   .name                   = "lcd",
> -     .driver_name            = "generic_panel",
> -     .phy.dpi.data_lines     = 24,
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
> +     .driver_name            = "dpi_panel",
> +     .data                   = &lcd_panel,
>       .platform_enable        = omap3_stalker_enable_lcd,
>       .platform_disable       = omap3_stalker_disable_lcd,
>  };
> @@ -208,11 +212,14 @@ static void
> omap3_stalker_disable_dvi(struct omap_dss_device *dssdev)     dvi_enabled = 0;
>  }
>
> +static struct panel_data dvi_panel = {
> +     .name           = "generic",
> +};
> +
>  static struct omap_dss_device omap3_stalker_dvi_device = {   .name                   = "dvi",
> -     .driver_name            = "generic_panel",
> -     .type                   = OMAP_DISPLAY_TYPE_DPI,
> -     .phy.dpi.data_lines     = 24,
> +     .driver_name            = "dpi_panel",
> +     .data                   = &dvi_panel,
>       .platform_enable        = omap3_stalker_enable_dvi,
>       .platform_disable       = omap3_stalker_disable_dvi,
>  };
> diff --git
> a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
> b/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
> deleted file mode 100644
> index 01ab657..0000000
> --- a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h +++ /dev/null
> @@ -1,31 +0,0 @@
> -#ifndef __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H
> -#define __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H
> -
> -#include "display.h"
> -
> -/**
> - * struct nokia_dsi_panel_data - Nokia DSI panel driver configuration
> - * @name: panel name
> - * @use_ext_te: use external TE
> - * @ext_te_gpio: external TE GPIO
> - * @use_esd_check: perform ESD checks
> - * @max_backlight_level: maximum backlight level
> - * @set_backlight: pointer to backlight set function
> - * @get_backlight: pointer to backlight get function
> - */
> -struct nokia_dsi_panel_data {
> -     const char *name;
> -
> -     int reset_gpio;
> -
> -     bool use_ext_te;
> -     int ext_te_gpio;
> -
> -     bool use_esd_check;
> -
> -     int max_backlight_level;
> -     int (*set_backlight)(struct omap_dss_device *dssdev, int level);
> -     int (*get_backlight)(struct omap_dss_device *dssdev);
> -};
> -
> -#endif /* __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H */ diff
> --git a/arch/arm/plat-omap/include/plat/panel.h
> b/arch/arm/plat-omap/include/plat/panel.h
> new file mode 100644
> index 0000000..84c6ffd
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/panel.h
> @@ -0,0 +1,57 @@
> +/*
> + * Header for panel driver
> + *
> + * Copyright (C) 2010 Canonical Ltd.
> + * Author: Bryan Wu <bryan.wu@canonical.com>
> + *
> + * This program is free software; you can redistribute it
> and/or modify
> +it
> + * under the terms of the GNU General Public License version 2 as +published
> by + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be
> useful, but
> +WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public +License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License +along
> with + * this program.  If not, see <http://www.gnu.org/licenses/>. + */
> +
> +#ifndef __ARCH_ARM_PLAT_OMAP_PANEL_H
> +#define __ARCH_ARM_PLAT_OMAP_PANEL_H
> +
> +#include "display.h"
> +
> +/**
> + * struct panel_data - panel driver configuration
> + * @name: panel name
> + * @use_ext_te: use external TE
> + * @ext_te_gpio: external TE GPIO
> + * @use_esd_check: perform ESD checks
> + * @max_backlight_level: maximum backlight level
> + * @set_backlight: pointer to backlight set function
> + * @get_backlight: pointer to backlight get function  */ struct +panel_data {
> +     const char *name;
> +
> +     int reset_gpio;
> +
> +     bool use_ext_te;
> +     int ext_te_gpio;
> +
> +     bool use_esd_check;
> +
> +     int max_backlight_level;
> +     int (*set_backlight)(struct omap_dss_device *dssdev, int level);
> +     int (*get_backlight)(struct omap_dss_device *dssdev); }; +
> +static inline struct panel_data
> +*get_panel_data(const struct omap_dss_device *dssdev) {
> +     return (struct panel_data *) dssdev->data; }
> +
> +
> +#endif /* __ARCH_ARM_PLAT_OMAP_PANEL_H */
> diff --git a/drivers/video/omap2/displays/panel-taal.c
> b/drivers/video/omap2/displays/panel-taal.c
> index e1c765d..170ef63 100644
> --- a/drivers/video/omap2/displays/panel-taal.c
> +++ b/drivers/video/omap2/displays/panel-taal.c
> @@ -34,7 +34,7 @@
>  #include <linux/mutex.h>
>
>  #include <plat/display.h>
> -#include <plat/nokia-dsi-panel.h>
> +#include <plat/panel.h>
>
>  /* DSI Virtual channel. Hardcoded for now. */
>  #define TCH 0
> @@ -233,12 +233,6 @@ struct taal_data {
>       struct panel_config *panel_config;
>  };
>
> -static inline struct nokia_dsi_panel_data
> -*get_panel_data(const struct omap_dss_device *dssdev) -{
> -     return (struct nokia_dsi_panel_data *) dssdev->data; -}
> -
>  static void taal_esd_work(struct work_struct *work);
>
>  static void hw_guard_start(struct taal_data *td, int guard_msec)
> @@ -422,7 +416,7 @@ static int taal_bl_update_status(struct backlight_device
>  *dev) {
>       struct omap_dss_device *dssdev = dev_get_drvdata(&dev->dev);
>       struct taal_data *td = dev_get_drvdata(&dssdev->dev);
> -     struct nokia_dsi_panel_data *panel_data =
> get_panel_data(dssdev);
> +     struct panel_data *panel_data = get_panel_data(dssdev);         int r;
>       int level;
>
> @@ -639,7 +633,7 @@ static struct attribute_group taal_attr_group = {
>  static void taal_hw_reset(struct omap_dss_device *dssdev)  {
>       struct taal_data *td = dev_get_drvdata(&dssdev->dev);
> -     struct nokia_dsi_panel_data *panel_data =
> get_panel_data(dssdev);
> +     struct panel_data *panel_data = get_panel_data(dssdev);
>
>       if (panel_data->reset_gpio == -1)
>               return;
> @@ -663,7 +657,7 @@ static int taal_probe(struct
> omap_dss_device *dssdev)
>       struct backlight_properties props;
>       struct taal_data *td;
>       struct backlight_device *bldev;
> -     struct nokia_dsi_panel_data *panel_data =
> get_panel_data(dssdev);
> +     struct panel_data *panel_data = get_panel_data(dssdev);
>       struct panel_config *panel_config = NULL;
>       int r, i;
>
> @@ -802,7 +796,7 @@ err:
>  static void taal_remove(struct omap_dss_device *dssdev)  {
>       struct taal_data *td = dev_get_drvdata(&dssdev->dev);
> -     struct nokia_dsi_panel_data *panel_data =
> get_panel_data(dssdev);
> +     struct panel_data *panel_data = get_panel_data(dssdev);
>       struct backlight_device *bldev;
>
>       dev_dbg(&dssdev->dev, "remove\n");
> @@ -942,7 +936,7 @@ static void taal_power_off(struct
> omap_dss_device *dssdev)
>  static int taal_enable(struct omap_dss_device *dssdev)  {
>       struct taal_data *td = dev_get_drvdata(&dssdev->dev);
> -     struct nokia_dsi_panel_data *panel_data =
> get_panel_data(dssdev);
> +     struct panel_data *panel_data = get_panel_data(dssdev);         int r;
>
>       dev_dbg(&dssdev->dev, "enable\n");
> @@ -1035,7 +1029,7 @@ err:
>  static int taal_resume(struct omap_dss_device *dssdev)  {
>       struct taal_data *td = dev_get_drvdata(&dssdev->dev);
> -     struct nokia_dsi_panel_data *panel_data =
> get_panel_data(dssdev);
> +     struct panel_data *panel_data = get_panel_data(dssdev);         int r;
>
>       dev_dbg(&dssdev->dev, "resume\n");
> @@ -1122,7 +1116,7 @@ static int taal_update(struct
> omap_dss_device *dssdev,
>                                   u16 x, u16 y, u16 w, u16 h)
>  {
>       struct taal_data *td = dev_get_drvdata(&dssdev->dev);
> -     struct nokia_dsi_panel_data *panel_data =
> get_panel_data(dssdev);
> +     struct panel_data *panel_data = get_panel_data(dssdev);         int r;
>
>       dev_dbg(&dssdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
> @@ -1187,7 +1181,7 @@ static int taal_sync(struct
> omap_dss_device *dssdev)
>  static int _taal_enable_te(struct omap_dss_device *dssdev,
> bool enable)
>  {
>       struct taal_data *td = dev_get_drvdata(&dssdev->dev);
> -     struct nokia_dsi_panel_data *panel_data =
> get_panel_data(dssdev);
> +     struct panel_data *panel_data = get_panel_data(dssdev);         int r;
>
>       if (enable)
> @@ -1453,7 +1447,7 @@ static void taal_esd_work(struct
> work_struct *work)
>       struct taal_data *td = container_of(work, struct taal_data,
>       esd_work.work); struct omap_dss_device *dssdev = td->dssdev;
> -     struct nokia_dsi_panel_data *panel_data =
> get_panel_data(dssdev);
> +     struct panel_data *panel_data = get_panel_data(dssdev);         u8 state1, state2;
>       int r;
>
> --
> 1.7.1
