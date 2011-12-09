From: Alex Gershgorin <alexg@meprolight.com>
Subject: RE: [PATCH] ARM: OMAP3LOGIC: Adding DSS support
Date: Sat, 10 Dec 2011 01:55:04 +0200
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2C89899242@MEP-EXCH.meprolight.com>
References: <1323345948-14533-1-git-send-email-alexg@meprolight.com>,<20111209210801.GY31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.meprolight.com ([194.90.149.17]:43933 "EHLO meprolight.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755110Ab1LIXye convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 18:54:34 -0500
In-Reply-To: <20111209210801.GY31337@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tim.nordell@logicpd.com" <tim.nordell@logicpd.com>, "baruch@tkos.co.il" <baruch@tkos.co.il>

Hi Tomi,

Yes of course :-)

Regards
Alex Gershgorin
_______________________________
From: Tony Lindgren [tony@atomide.com]
Sent: Friday, December 09, 2011 11:08 PM
To: Alex Gershgorin; Tomi Valkeinen
Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; tim.nordell@logicpd.com; baruch@tkos.co.il
Subject: Re: [PATCH] ARM: OMAP3LOGIC: Adding DSS support

Tomi,

* Alex <alexg@meprolight.com> [111208 03:46]:
> This patch adds DSS2 support to the LogicPD OMAP 35x Torpedo boardfile. LCD and
> TV-out are supported.

Want to take this one? Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>

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
> +
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
> +
> +#else
> +static void __init omap3logic_display_init(void) { }
> +static void __init omap3logic_video_mem_init(void){ }
> +#endif /* defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE) */
> +
> +static void __init omap3logic_reserve(void)
> +{
> +     omap3logic_video_mem_init();
> +     omap_reserve();
> +}
> +
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
>       { .reg_offset = OMAP_MUX_TERMINATOR },
> @@ -197,6 +346,7 @@ static void __init omap3logic_init(void)
>       omap_sdrc_init(NULL, NULL);
>       board_mmc_init();
>       board_smsc911x_init();
> +     omap3logic_display_init();
>
>       /* Ensure SDRC pins are mux'd for self-refresh */
>       omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
> @@ -205,6 +355,7 @@ static void __init omap3logic_init(void)
>
>  MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
>       .atag_offset    = 0x100,
> +     .reserve        = omap3logic_reserve,
>       .map_io         = omap3_map_io,
>       .init_early     = omap35xx_init_early,
>       .init_irq       = omap3_init_irq,
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html