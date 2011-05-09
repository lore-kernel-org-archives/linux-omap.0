From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Mon, 9 May 2011 16:08:49 +0800
Message-ID: <4DC7A111.6040905@windriver.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com> <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:60015 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab1EIII4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 04:08:56 -0400
In-Reply-To: <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Acked-by: Stanley Miao <stanley.miao@windriver.com>

Stanley.

Tomi Valkeinen wrote:
> Port the old omapfb panel driver to DSS2i. This patch changes the board
> file only, the driver is ported in separate patch.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Stanley Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap2/board-ldp.c |   73 +++++++++++++++++++++++++++++++++-----
>  1 files changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index e2ba779..2fdfd7f 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -43,6 +43,8 @@
>  
>  #include <asm/delay.h>
>  #include <plat/usb.h>
> +#include <plat/display.h>
> +#include <plat/panel-generic-dpi.h>
>  
>  #include "board-flash.h"
>  #include "mux.h"
> @@ -275,19 +277,71 @@ static inline void __init ldp_init_smsc911x(void)
>  	gpio_direction_input(eth_gpio);
>  }
>  
> -static struct platform_device ldp_lcd_device = {
> -	.name		= "ldp_lcd",
> -	.id		= -1,
> +/* LCD */
> +
> +#define LCD_PANEL_BACKLIGHT_GPIO	(15 + OMAP_MAX_GPIO_LINES)
> +#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
> +#define LCD_PANEL_RESET_GPIO		55
> +#define LCD_PANEL_QVGA_GPIO		56
> +
> +static int ldp_panel_enable_lcd(struct omap_dss_device *dssdev)
> +{
> +	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
> +	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 1);
> +
> +	return 0;
> +}
> +
> +static void ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
> +{
> +	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
> +	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
> +}
> +
> +static struct panel_generic_dpi_data ldp_panel_data = {
> +	.name			= "2430sdp",
> +	.platform_enable	= ldp_panel_enable_lcd,
> +	.platform_disable	= ldp_panel_disable_lcd,
>  };
>  
> -static struct omap_lcd_config ldp_lcd_config __initdata = {
> -	.ctrl_name	= "internal",
> +static struct omap_dss_device ldp_lcd_device = {
> +	.name			= "lcd",
> +	.driver_name		= "generic_dpi_panel",
> +	.type			= OMAP_DISPLAY_TYPE_DPI,
> +	.phy.dpi.data_lines	= 16,
> +	.data			= &ldp_panel_data,
>  };
>  
> -static struct omap_board_config_kernel ldp_config[] __initdata = {
> -	{ OMAP_TAG_LCD,		&ldp_lcd_config },
> +static struct omap_dss_device *ldp_dss_devices[] = {
> +	&ldp_lcd_device,
> +};
> +
> +static struct omap_dss_board_info ldp_dss_data = {
> +	.num_devices	= ARRAY_SIZE(ldp_dss_devices),
> +	.devices	= ldp_dss_devices,
> +	.default_device	= &ldp_lcd_device,
>  };
>  
> +static void __init ldp_display_init(void)
> +{
> +	int r;
> +
> +	struct gpio gpios[] = {
> +		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
> +		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
> +		{LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
> +		{LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
> +	};
> +
> +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
> +	if (r) {
> +		pr_err("Cannot request LCD GPIOs, error %d\n", r);
> +		return;
> +	}
> +
> +	omap_display_init(&ldp_dss_data);
> +}
> +
>  static void __init omap_ldp_init_early(void)
>  {
>  	omap2_init_common_infrastructure();
> @@ -390,7 +444,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
>  
>  static struct platform_device *ldp_devices[] __initdata = {
>  	&ldp_smsc911x_device,
> -	&ldp_lcd_device,
>  	&ldp_gpio_keys_device,
>  };
>  
> @@ -441,8 +494,6 @@ static struct mtd_partition ldp_nand_partitions[] = {
>  static void __init omap_ldp_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> -	omap_board_config = ldp_config;
> -	omap_board_config_size = ARRAY_SIZE(ldp_config);
>  	ldp_init_smsc911x();
>  	omap_i2c_init();
>  	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
> @@ -459,6 +510,8 @@ static void __init omap_ldp_init(void)
>  	omap2_hsmmc_init(mmc);
>  	/* link regulators to MMC adapters */
>  	ldp_vmmc1_supply.dev = mmc[0].dev;
> +
> +	ldp_display_init();
>  }
>  
>  MACHINE_START(OMAP_LDP, "OMAP LDP board")
