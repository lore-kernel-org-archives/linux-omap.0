From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Tue, 17 May 2011 14:49:00 +0300
Message-ID: <1305632940.1847.8.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
	 <1305095563.2097.11.camel@deskari>  <4DCB80DD.5090408@compulab.co.il>
	 <1305535980.2002.34.camel@deskari>  <4DD106BD.4070009@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41275 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754214Ab1EQLu5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 07:50:57 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so146675eyx.33
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 04:50:54 -0700 (PDT)
In-Reply-To: <4DD106BD.4070009@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

On Mon, 2011-05-16 at 14:13 +0300, Igor Grinberg wrote:
> On 05/16/11 11:53, Tomi Valkeinen wrote:
> 
> > Here's an updated patch with the twl gpio code.
> 
> Looks good, though one minor issue below
> 
> > All the old omapfb porting patches, including new drivers for DSS2, can
> > be found from 
> >
> > git://gitorious.org/linux-omap-dss2/linux.git old-omapfb-port
> >
> >  Tomi
> >
> > diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> > index e2ba779..ed78b9a 100644
> > --- a/arch/arm/mach-omap2/board-ldp.c
> > +++ b/arch/arm/mach-omap2/board-ldp.c
> > @@ -44,6 +44,9 @@
> >  #include <asm/delay.h>
> >  #include <plat/usb.h>
> >  
> > +#include <video/omapdss.h>
> > +#include <video/omap-panel-generic-dpi.h>
> > +
> >  #include "board-flash.h"
> >  #include "mux.h"
> >  #include "hsmmc.h"
> > @@ -275,19 +278,70 @@ static inline void __init ldp_init_smsc911x(void)
> >  	gpio_direction_input(eth_gpio);
> >  }
> >  
> > -static struct platform_device ldp_lcd_device = {
> > -	.name		= "ldp_lcd",
> > -	.id		= -1,
> > +/* LCD */
> > +
> > +static int ldp_backlight_gpio;
> > +static int ldp_lcd_enable_gpio;
> > +
> > +#define LCD_PANEL_RESET_GPIO		55
> > +#define LCD_PANEL_QVGA_GPIO		56
> > +
> > +static int ldp_panel_enable_lcd(struct omap_dss_device *dssdev)
> > +{
> > +	gpio_direction_output(ldp_lcd_enable_gpio, 1);
> > +	gpio_direction_output(ldp_backlight_gpio, 1);
> > +
> > +	return 0;
> > +}
> > +
> > +static void ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
> > +{
> > +	gpio_direction_output(ldp_lcd_enable_gpio, 0);
> > +	gpio_direction_output(ldp_backlight_gpio, 0);
> > +}
> > +
> > +static struct panel_generic_dpi_data ldp_panel_data = {
> > +	.name			= "2430sdp",
> > +	.platform_enable	= ldp_panel_enable_lcd,
> > +	.platform_disable	= ldp_panel_disable_lcd,
> > +};
> > +
> > +static struct omap_dss_device ldp_lcd_device = {
> > +	.name			= "lcd",
> > +	.driver_name		= "generic_dpi_panel",
> > +	.type			= OMAP_DISPLAY_TYPE_DPI,
> > +	.phy.dpi.data_lines	= 16,
> > +	.data			= &ldp_panel_data,
> >  };
> >  
> > -static struct omap_lcd_config ldp_lcd_config __initdata = {
> > -	.ctrl_name	= "internal",
> > +static struct omap_dss_device *ldp_dss_devices[] = {
> > +	&ldp_lcd_device,
> >  };
> >  
> > -static struct omap_board_config_kernel ldp_config[] __initdata = {
> > -	{ OMAP_TAG_LCD,		&ldp_lcd_config },
> > +static struct omap_dss_board_info ldp_dss_data = {
> > +	.num_devices	= ARRAY_SIZE(ldp_dss_devices),
> > +	.devices	= ldp_dss_devices,
> > +	.default_device	= &ldp_lcd_device,
> >  };
> >  
> > +static void __init ldp_display_init(void)
> > +{
> > +	int r;
> > +
> > +	static struct gpio gpios[] __initdata = {
> > +		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
> > +		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
> > +	};
> > +
> > +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
> > +	if (r) {
> > +		pr_err("Cannot request LCD GPIOs, error %d\n", r);
> > +		return;
> > +	}
> > +
> > +	omap_display_init(&ldp_dss_data);
> > +}
> > +
> >  static void __init omap_ldp_init_early(void)
> >  {
> >  	omap2_init_common_infrastructure();
> > @@ -298,10 +352,30 @@ static struct twl4030_usb_data ldp_usb_data = {
> >  	.usb_mode	= T2_USB_MODE_ULPI,
> >  };
> >  
> > +static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
> > +{
> > +	int r;
> > +
> > +	struct gpio gpios[] = {
> > +		{gpio + 7 , GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
> > +		{gpio + 15, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
> > +	};
> > +
> > +	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
> > +	if (r)
> > +		pr_err("Cannot request LCD GPIOs, error %d\n", r);
> > +
> > +	ldp_backlight_gpio = gpio + 15;
> > +	ldp_lcd_enable_gpio = gpio + 7;
> 
> If the gpio_request_array() fails (though it shouldn't),
> won't it be right to set both variables to -EINVAL?

Ah, yes. I'll fix that.

Do you know what will happen if twl_gpio_setup fails? Just an error
print, or will TWL driver fail?

> Thanks for bringing this all together.

We still don't know if it works or not =).

 Tomi


