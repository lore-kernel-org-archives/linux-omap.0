From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 01/22] ARM: omap1: innovator: pass lcd control address
 as pdata
Date: Fri, 9 Aug 2019 13:29:59 +0200
Message-ID: <af560012-053e-b439-8c6a-8d3f05ff1ef7@samsung.com>
References: <20190808212234.2213262-1-arnd@arndb.de>
        <CGME20190808212328epcas1p36ee1f5a956c54d665dbe0c80d912e6b3@epcas1p3.samsung.com>
        <20190808212234.2213262-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808212234.2213262-2-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org


On 8/8/19 11:22 PM, Arnd Bergmann wrote:
> To avoid using the mach/omap1510.h header file, pass the correct
> address as platform data.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For fbdev part:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  arch/arm/mach-omap1/board-innovator.c  | 3 +++
>  drivers/video/fbdev/omap/lcd_inn1510.c | 7 +++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
> index cbe093f969d5..2425f1bacb33 100644
> --- a/arch/arm/mach-omap1/board-innovator.c
> +++ b/arch/arm/mach-omap1/board-innovator.c
> @@ -194,6 +194,9 @@ static struct platform_device innovator1510_smc91x_device = {
>  static struct platform_device innovator1510_lcd_device = {
>  	.name		= "lcd_inn1510",
>  	.id		= -1,
> +	.dev	= {
> +		.platform_data = (void __force *)OMAP1510_FPGA_LCD_PANEL_CONTROL,
> +	}
>  };
>  
>  static struct platform_device innovator1510_spi_device = {
> diff --git a/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
> index 776e7f8d656e..37ed0c14aa5a 100644
> --- a/drivers/video/fbdev/omap/lcd_inn1510.c
> +++ b/drivers/video/fbdev/omap/lcd_inn1510.c
> @@ -14,15 +14,17 @@
>  
>  #include "omapfb.h"
>  
> +static void __iomem *omap1510_fpga_lcd_panel_control;
> +
>  static int innovator1510_panel_enable(struct lcd_panel *panel)
>  {
> -	__raw_writeb(0x7, OMAP1510_FPGA_LCD_PANEL_CONTROL);
> +	__raw_writeb(0x7, omap1510_fpga_lcd_panel_control);
>  	return 0;
>  }
>  
>  static void innovator1510_panel_disable(struct lcd_panel *panel)
>  {
> -	__raw_writeb(0x0, OMAP1510_FPGA_LCD_PANEL_CONTROL);
> +	__raw_writeb(0x0, omap1510_fpga_lcd_panel_control);
>  }
>  
>  static struct lcd_panel innovator1510_panel = {
> @@ -48,6 +50,7 @@ static struct lcd_panel innovator1510_panel = {
>  
>  static int innovator1510_panel_probe(struct platform_device *pdev)
>  {
> +	omap1510_fpga_lcd_panel_control = (void __iomem *)pdev->dev.platform_data;
>  	omapfb_register_panel(&innovator1510_panel);
>  	return 0;
>  }
