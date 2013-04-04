From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 04 Apr 2013 10:17:01 +0300
Message-ID: <515D28ED.20807@compulab.co.il>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il> <511C8D8F.9060805@ti.com> <511CA247.80606@compulab.co.il> <511CA9B3.70401@ti.com> <511CB1B3.80605@compulab.co.il> <511CC37C.3020706@ti.com> <511CDA91.1050300@compulab.co.il> <511CDE12.60701@ti.com> <511CEBC4.6050400@compulab.co.il> <515C1A3A.6050906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:49260 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933091Ab3DDHRH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 03:17:07 -0400
In-Reply-To: <515C1A3A.6050906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


[...]

>>> Can the LCD_BL_GPIO be handled by the omap panel driver? Otherwise the
>>> backlight will supposedly be always on. Is it just a simple switch for
>>> the BL power, which does not affect the SPI in any way?
>>
>> Yes, it can for now.
>> Also, I think we should also take into account the backlight framework,
>> including PMW.
> 
> I've updated this patch to set the LCD EN gpio once at boot time, and pass the
> LCD BL gpio to the panel driver. Updated patch below.
> 
> ---
> 
> commit a58a72363aa4359cdb75878de1517bd50faf9eb4
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Mon Dec 3 16:05:06 2012 +0530
> 
>     arm: omap: board-cm-t35: use generic dpi panel's gpio handling
>     
>     The cm-t35 board file currently requests gpios required to configure the tdo35s
>     panel, and provides platform_enable/disable callbacks to configure them.
>     
>     These tasks have been moved to the generic dpi panel driver itself and shouldn't
>     be done in the board files.
>     
>     Remove the gpio requests and the platform callbacks from the board file.
>     Add the gpio information to generic dpi panel's platform data so that it's
>     passed to the panel driver.
>     
>     Note: Only BL enable gpio is handled in the panel driver. The LCD enable
>     GPIO is handled in the board file at init time, as there's a 50 ms delay
>     required when using the GPIO, and the panel driver doesn't know about
>     that.
>     
>     Cc: Tony Lindgren <tony@atomide.com>
>     Cc: Igor Grinberg <grinberg@compulab.co.il>
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Looks good, thanks!

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index bccd3e5..cccbfea 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -190,32 +190,6 @@ static inline void cm_t35_init_nand(void) {}
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
> @@ -227,8 +201,10 @@ static void cm_t35_panel_disable_tv(struct omap_dss_device *dssdev)
>  
>  static struct panel_generic_dpi_data lcd_panel = {
>  	.name			= "toppoly_tdo35s",
> -	.platform_enable	= cm_t35_panel_enable_lcd,
> -	.platform_disable	= cm_t35_panel_disable_lcd,
> +	.num_gpios		= 1,
> +	.gpios			= {
> +		CM_T35_LCD_BL_GPIO,
> +	},
>  };
>  
>  static struct omap_dss_device cm_t35_lcd_device = {
> @@ -292,11 +268,6 @@ static struct spi_board_info cm_t35_lcd_spi_board_info[] __initdata = {
>  	},
>  };
>  
> -static struct gpio cm_t35_dss_gpios[] __initdata = {
> -	{ CM_T35_LCD_EN_GPIO, GPIOF_OUT_INIT_LOW,  "lcd enable"    },
> -	{ CM_T35_LCD_BL_GPIO, GPIOF_OUT_INIT_LOW,  "lcd bl enable" },
> -};
> -
>  static void __init cm_t35_init_display(void)
>  {
>  	int err;
> @@ -304,23 +275,21 @@ static void __init cm_t35_init_display(void)
>  	spi_register_board_info(cm_t35_lcd_spi_board_info,
>  				ARRAY_SIZE(cm_t35_lcd_spi_board_info));
>  
> -	err = gpio_request_array(cm_t35_dss_gpios,
> -				 ARRAY_SIZE(cm_t35_dss_gpios));
> +
> +	err = gpio_request_one(CM_T35_LCD_EN_GPIO, GPIOF_OUT_INIT_LOW,
> +			"lcd bl enable");
>  	if (err) {
> -		pr_err("CM-T35: failed to request DSS control GPIOs\n");
> +		pr_err("CM-T35: failed to request LCD EN GPIO\n");
>  		return;
>  	}
>  
> -	gpio_export(CM_T35_LCD_EN_GPIO, 0);
> -	gpio_export(CM_T35_LCD_BL_GPIO, 0);
> -
>  	msleep(50);
>  	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
>  
>  	err = omap_display_init(&cm_t35_dss_data);
>  	if (err) {
>  		pr_err("CM-T35: failed to register DSS device\n");
> -		gpio_free_array(cm_t35_dss_gpios, ARRAY_SIZE(cm_t35_dss_gpios));
> +		gpio_free(CM_T35_LCD_EN_GPIO);
>  	}
>  }
>  
> 
> 

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRXSjtAAoJEBDE8YO64EfakqEP/RxTWET2KP1KRIs5VW6o6JXG
w4Mil7k62AmpClojEWMJTF6UfOc08Zmg4m5ZPly1mT2NAgwtwStP1hkTRuPuL34w
NMfbwro5uUf4Wp49ZxZyuLLEnlzVh8VPWPmHKc+pRl9XQOqS9fau+EBxmIXKSAgC
qdAjeT6ONIXhvIqVsgY+7oexeD0DG4GQiYl9/VPo7VWh1/Whv4X53WVMz6gdgfIm
ax0h/XYPAt743EoAyh7QHas4XkXsULmesJH4Pn7RE2BCtyuHYV1QB6Sut1gAmKMd
WUILWCHIdpOhH7JxcdIgSLbQVbHph2sPmtKoesO75LzgzcwA4YeX2ZOOHhgF5BDp
JnNzMtf/cxzkmzQm2FagIgr7vZAA1/eECit//20xEnHeVl9icKTiDBltunbYkphR
WUIGxCxIKlUhKG1OwDeSWRPbAY3ZvPQXSPpcSSGmvdxae9H0+xkwN1+l4MlPGVe0
G1cEclDxLiefueskIOVSs0nmlpxF7fBcCVq1dEL7Su5P1P1gdSsgEe/V5AAFAymf
RbLhqt4l9+5y6ow/tSRIPTUCUvGqJoYGwDWFhiD+Cyy2b2g5vOHQGQCZ2wqsSrxY
V5m6h5pKxdH9ibDFeQemNbAqz86nuk6sfUSk0dOX7vYt1zMSRwbZ8cdaB1zgrT23
d5A216IHqnW5iLhaJxbx
=GpgV
-----END PGP SIGNATURE-----
