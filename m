From: Alex Gershgorin <alexg@meprolight.com>
Subject: RE: [PATCH] ARM: OMAP3LOGIC: Adding DSS support
Date: Mon, 12 Dec 2011 16:20:26 +0200
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2C89899251@MEP-EXCH.meprolight.com>
References: <1323345948-14533-1-git-send-email-alexg@meprolight.com>,<1323688238.3852.18.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.meprolight.com ([194.90.149.17]:33937 "EHLO meprolight.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752737Ab1LLOT6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 09:19:58 -0500
In-Reply-To: <1323688238.3852.18.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tim.nordell@logicpd.com" <tim.nordell@logicpd.com>, "baruch@tkos.co.il" <baruch@tkos.co.il>


________________________________________
From: Tomi Valkeinen [tomi.valkeinen@ti.com]
Sent: Monday, December 12, 2011 1:10 PM
To: Alex Gershgorin
Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; tim.nordell@logicpd.com; baruch@tkos.co.il
Subject: Re: [PATCH] ARM: OMAP3LOGIC: Adding DSS support

Hi,

On Thu, 2011-12-08 at 14:05 +0200, Alex wrote:
> This patch adds DSS2 support to the LogicPD OMAP 35x Torpedo boardfile. LCD and
> TV-out are supported.
>
> Signed-off-by: Alex Gershgorin <alexg@meprolight.com>
> ---
>  arch/arm/mach-omap2/board-omap3logic.c |  151 ++++++++++++++++++++++++++++++++
>  1 files changed, 151 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
> index 7c0f193..86175fa 100644
> --- a/arch/arm/mach-omap2/board-omap3logic.c
> +++ b/arch/arm/mach-omap2/board-omap3logic.c
> @@ -7,6 +7,9 @@
>   * Copyright (C) 2010 Logic Product Development, Inc.
>   * Peter Barada <peter.barada@logicpd.com>
>   *
> + * Copyright (C) 2011 Meprolight, Ltd.
> + * Alex Gershgorin <alexg@meprolight.com>
> + *
>   * Modified from Beagle, EVM, and RX51
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -44,6 +47,10 @@
>  #include <plat/gpmc-smsc911x.h>
>  #include <plat/gpmc.h>
>  #include <plat/sdrc.h>
> +#include <plat/vram.h>
> +
> +#include <video/omapdss.h>
> +#include <video/omap-panel-generic-dpi.h>
>
>  #define OMAP3LOGIC_SMSC911X_CS                       1
>
> @@ -58,6 +65,14 @@ static struct regulator_consumer_supply omap3logic_vmmc1_supply[] = {
>       REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
>  };
>
> +static struct regulator_consumer_supply omap3logic_vdds_supplies[] = {
> +     REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
> +     REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> +};
> +
> +static struct regulator_consumer_supply omap3logic_vdac_supply =
> +     REGULATOR_SUPPLY("vdda_dac", "omapdss_venc");
> +
>  /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
>  static struct regulator_init_data omap3logic_vmmc1 = {
>       .constraints = {
> @@ -74,6 +89,34 @@ static struct regulator_init_data omap3logic_vmmc1 = {
>       .consumer_supplies      = omap3logic_vmmc1_supply,
>  };
>
> +static struct regulator_init_data omap3logic_vpll2 = {
> +     .constraints = {
> +             .name                   = "VDDS_DSI",
> +             .min_uV                 = 1800000,
> +             .max_uV                 = 1800000,
> +             .apply_uV               = true,
> +             .always_on              = true,
> +             .valid_modes_mask       = REGULATOR_MODE_NORMAL
> +                                     | REGULATOR_MODE_STANDBY,
> +             .valid_ops_mask         = REGULATOR_CHANGE_MODE,
> +     },
> +     .num_consumer_supplies  = ARRAY_SIZE(omap3logic_vdds_supplies),
> +     .consumer_supplies      = omap3logic_vdds_supplies,
> +};
> +
> +static struct regulator_init_data omap3logic_vdac = {
> +     .constraints = {
> +             .min_uV                 = 1800000,
> +             .max_uV                 = 1800000,
> +             .valid_modes_mask       = REGULATOR_MODE_NORMAL
> +                                     | REGULATOR_MODE_STANDBY,
> +             .valid_ops_mask         = REGULATOR_CHANGE_MODE
> +                                     | REGULATOR_CHANGE_STATUS,
> +     },
> +     .num_consumer_supplies  = 1,
> +     .consumer_supplies      = &omap3logic_vdac_supply,
> +};
> +
>  static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
>       .gpio_base      = OMAP_MAX_GPIO_LINES,
>       .irq_base       = TWL4030_GPIO_IRQ_BASE,
> @@ -91,6 +134,8 @@ static struct twl4030_platform_data omap3logic_twldata = {
>       /* platform_data for children goes here */
>       .gpio           = &omap3logic_gpio_data,
>       .vmmc1          = &omap3logic_vmmc1,
> +     .vpll2          = &omap3logic_vpll2,
> +     .vdac           = &omap3logic_vdac,
>  };

>The regulators are already set up in twl-common.c, so there shouldn't be
>need for the code above.

I will correct it .

>
>  static int __init omap3logic_i2c_init(void)
> @@ -182,6 +227,110 @@ static inline void __init board_smsc911x_init(void)
>       gpmc_smsc911x_init(&board_smsc911x_data);
>  }
>
> +#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
> +
> +#define OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO     154
> +#define OMAP3_TORPEDO_LCD_ENABLE_GPIO                155
> +#define OMAP3_TORPEDO_LCD_PWM_GPIO           56

>The PWM gpio doesn't seem to be used. Is it needed for something?

Excuse  me for  my neglect, I shall have it set to default in the function omap3logic_display_init.

> +static struct gpio omap3logic_dss_gpios[] __initdata = {
> +     {OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "lcd_bl_pwr"},
> +     {OMAP3_TORPEDO_LCD_PWM_GPIO, GPIOF_OUT_INIT_LOW, "lcd bl enable"},
> +     {OMAP3_TORPEDO_LCD_ENABLE_GPIO, GPIOF_OUT_INIT_LOW, "lcd enable"},
> +};
> +
> +static int omap3logic_enable_lcd(struct omap_dss_device *dssdev)
> +{
> +     gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 1);
> +     msleep(20);
> +     gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 1);
> +
> +     return 0;
> +}
> +
> +static void omap3logic_disable_lcd(struct omap_dss_device *dssdev)
> +{
> +     gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
> +     msleep(20);
> +     gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
> +}

>Is there a particular reason for msleep(20) in the enable and disable
>function?

No particular reason, it works now without delay.

> +
> +static struct panel_generic_dpi_data lcd_panel = {
> +     .name                   = "sharp_lq",
> +     .platform_enable        = omap3logic_enable_lcd,
> +     .platform_disable       = omap3logic_disable_lcd,
> +};
> +
> +static struct omap_dss_device omap3logic_lcd_device = {
> +     .name                   = "lcd",
> +     .driver_name            = "generic_dpi_panel",
> +     .type                   = OMAP_DISPLAY_TYPE_DPI,
> +     .data                   = &lcd_panel,
> +     .phy.dpi.data_lines     = 16,
> +};
> +
> +static struct omap_dss_device omap3logic_tv_device = {
> +     .name                   = "tv",
> +     .driver_name            = "venc",
> +     .type                   = OMAP_DISPLAY_TYPE_VENC,
> +     .phy.venc.type          = OMAP_DSS_VENC_TYPE_SVIDEO,
> +};
> +
> +static struct omap_dss_device *omap3logic_dss_devices[] = {
> +     &omap3logic_lcd_device,
> +     &omap3logic_tv_device,
> +};
> +
> +static struct omap_dss_board_info omap3logic_dss_data = {
> +     .num_devices            = ARRAY_SIZE(omap3logic_dss_devices),
> +     .devices                = omap3logic_dss_devices,
> +     .default_device         = &omap3logic_lcd_device,
> +};
> +
> +static void __init omap3logic_display_init(void)
> +{
> +     int r;
> +
> +     r = gpio_request_array(omap3logic_dss_gpios,
> +                            ARRAY_SIZE(omap3logic_dss_gpios));
> +     if (r) {
> +             printk(KERN_ERR "failed to get lcd_panel_* gpios\n");
> +             return;
> +     }
> +
> +     gpio_export(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
> +     gpio_export(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
> +     gpio_export(OMAP3_TORPEDO_LCD_PWM_GPIO, 0);
> +
> +     r = omap_display_init(&omap3logic_dss_data);
> +     if (r) {
> +             pr_err("OMAP3LOGIC: failed to register DSS device\n");
> +             gpio_free_array(omap3logic_dss_gpios,
> +                             ARRAY_SIZE(omap3logic_dss_gpios));
> +     }
> +}
> +
> +static void __init omap3logic_video_mem_init(void)
> +{
> +     /*
> +      * GFX 480x272x32bpp
> +      * VID1/2 480x272x32bpp double buffered
> +      */
> +     omap_vram_set_sdram_vram(PAGE_ALIGN(480 * 272 * 4) +
> +                     2 * PAGE_ALIGN(480 * 272 * 4 * 2), 0);
> +}

>You should normally let the bootloader or the user define the vram size
>via boot parameters, not in the board file like this.

I will send the corrected patch.

Thanks,
Alex Gershgorin

