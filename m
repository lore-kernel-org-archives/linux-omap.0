From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Wed, 13 Feb 2013 17:16:32 +0200
Message-ID: <511BAE50.2090507@compulab.co.il>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:59704 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759536Ab3BMPQl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 10:16:41 -0500
In-Reply-To: <1360765345-19312-6-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Archit,

On 02/13/13 16:21, Archit Taneja wrote:
> The cm-t35 board file currently requests gpios required to configure the tdo35s
> panel, and provides platform_enable/disable callbacks to configure them.
> 
> These tasks have been moved to the generic dpi panel driver itself and shouldn't
> be done in the board files.
> 
> Remove the gpio requests and the platform callbacks from the board file.
> Add the gpio information to generic dpi panel's platform data so that it's
> passed to the panel driver.
> 
> Note: In cm_t35_init_display(), the gpios were disabled, and the LCD_EN gpio was
> enabled after a 50 millisecond delay. This code has been removed and is not
> taken care of in the generic panel driver. The impact of this needs to be
> tested. The panel's gpios are also not exported any more. Hence, they can't be
> accessed via sysfs interface.

Indeed, there is an impact - the LCD no longer works.
The reason for the LCD_EN gpio being pushed high after the 50ms delay,
is to get the LCD out of reset, so the SPI transaction will succeed
and initialize the LCD.
Now, when you remove the gpio handling for the LCD_EN pin,
the LCD no longer works.

I don't agree with this breakage.

> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  arch/arm/mach-omap2/board-cm-t35.c |   46 ++++--------------------------------
>  1 file changed, 5 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index f940a79..563d5ab 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -189,32 +189,6 @@ static inline void cm_t35_init_nand(void) {}
>  #define CM_T35_LCD_BL_GPIO 58
>  #define CM_T35_DVI_EN_GPIO 54
>  
> -static int lcd_enabled;
> -static int dvi_enabled;
> -
> -static int cm_t35_panel_enable_lcd(struct omap_dss_device *dssdev)
> -{
> -	if (dvi_enabled) {
> -		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
> -		return -EINVAL;
> -	}
> -
> -	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
> -	gpio_set_value(CM_T35_LCD_BL_GPIO, 1);
> -
> -	lcd_enabled = 1;
> -
> -	return 0;
> -}
> -
> -static void cm_t35_panel_disable_lcd(struct omap_dss_device *dssdev)
> -{
> -	lcd_enabled = 0;
> -
> -	gpio_set_value(CM_T35_LCD_BL_GPIO, 0);
> -	gpio_set_value(CM_T35_LCD_EN_GPIO, 0);
> -}
> -
>  static int cm_t35_panel_enable_tv(struct omap_dss_device *dssdev)
>  {
>  	return 0;
> @@ -226,8 +200,11 @@ static void cm_t35_panel_disable_tv(struct omap_dss_device *dssdev)
>  
>  static struct panel_generic_dpi_data lcd_panel = {
>  	.name			= "toppoly_tdo35s",
> -	.platform_enable	= cm_t35_panel_enable_lcd,
> -	.platform_disable	= cm_t35_panel_disable_lcd,
> +	.num_gpios		= 2,
> +	.gpios			= {
> +		CM_T35_LCD_BL_GPIO,
> +		CM_T35_LCD_EN_GPIO
> +	},
>  };
>  
>  static struct omap_dss_device cm_t35_lcd_device = {
> @@ -303,19 +280,6 @@ static void __init cm_t35_init_display(void)
>  	spi_register_board_info(cm_t35_lcd_spi_board_info,
>  				ARRAY_SIZE(cm_t35_lcd_spi_board_info));
>  
> -	err = gpio_request_array(cm_t35_dss_gpios,
> -				 ARRAY_SIZE(cm_t35_dss_gpios));
> -	if (err) {
> -		pr_err("CM-T35: failed to request DSS control GPIOs\n");
> -		return;
> -	}
> -
> -	gpio_export(CM_T35_LCD_EN_GPIO, 0);
> -	gpio_export(CM_T35_LCD_BL_GPIO, 0);
> -
> -	msleep(50);
> -	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
> -
>  	err = omap_display_init(&cm_t35_dss_data);
>  	if (err) {
>  		pr_err("CM-T35: failed to register DSS device\n");
> 

-- 
Regards,
Igor.
