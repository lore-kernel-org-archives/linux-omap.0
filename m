From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 09/22] fbdev: omap: avoid using mach/*.h files
Date: Fri, 9 Aug 2019 13:34:37 +0200
Message-ID: <0c0f5ba1-fe66-25ea-35f6-089ec22f235e@samsung.com>
References: <20190808212234.2213262-1-arnd@arndb.de>
        <CGME20190808213111epcas1p2128deb055f9138740eda1a70187e4172@epcas1p2.samsung.com>
        <20190808212234.2213262-10-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808212234.2213262-10-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 8/8/19 11:22 PM, Arnd Bergmann wrote:
> All the headers we actually need are now in include/linux/soc,
> so use those versions instead and allow compile-testing on
> other architectures.
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
>  drivers/video/backlight/Kconfig          | 4 ++--
>  drivers/video/backlight/omap1_bl.c       | 4 ++--
>  drivers/video/fbdev/omap/Kconfig         | 4 ++--
>  drivers/video/fbdev/omap/lcd_ams_delta.c | 2 +-
>  drivers/video/fbdev/omap/lcd_dma.c       | 3 ++-
>  drivers/video/fbdev/omap/lcd_inn1510.c   | 2 +-
>  drivers/video/fbdev/omap/lcd_osk.c       | 4 ++--
>  drivers/video/fbdev/omap/lcdc.c          | 2 ++
>  drivers/video/fbdev/omap/omapfb_main.c   | 3 +--
>  drivers/video/fbdev/omap/sossi.c         | 1 +
>  10 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 8b081d61773e..195c71130827 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -213,8 +213,8 @@ config BACKLIGHT_LOCOMO
>  
>  config BACKLIGHT_OMAP1
>  	tristate "OMAP1 PWL-based LCD Backlight"
> -	depends on ARCH_OMAP1
> -	default y
> +	depends on ARCH_OMAP1 || COMPILE_TEST
> +	default ARCH_OMAP1
>  	help
>  	  This driver controls the LCD backlight level and power for
>  	  the PWL module of OMAP1 processors.  Say Y if your board
> diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
> index 74263021b1b3..69a49384b3de 100644
> --- a/drivers/video/backlight/omap1_bl.c
> +++ b/drivers/video/backlight/omap1_bl.c
> @@ -14,8 +14,8 @@
>  #include <linux/slab.h>
>  #include <linux/platform_data/omap1_bl.h>
>  
> -#include <mach/hardware.h>
> -#include <mach/mux.h>
> +#include <linux/soc/ti/omap1-io.h>
> +#include <linux/soc/ti/omap1-mux.h>
>  
>  #define OMAPBL_MAX_INTENSITY		0xff
>  
> diff --git a/drivers/video/fbdev/omap/Kconfig b/drivers/video/fbdev/omap/Kconfig
> index df2a5d0d4aa2..b1786cf1b486 100644
> --- a/drivers/video/fbdev/omap/Kconfig
> +++ b/drivers/video/fbdev/omap/Kconfig
> @@ -2,7 +2,7 @@
>  config FB_OMAP
>  	tristate "OMAP frame buffer support"
>  	depends on FB
> -	depends on ARCH_OMAP1
> +	depends on ARCH_OMAP1 || (ARM && COMPILE_TEST)
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> @@ -42,7 +42,7 @@ config FB_OMAP_LCD_MIPID
>  
>  config FB_OMAP_LCD_H3
>  	bool "TPS65010 LCD controller on OMAP-H3"
> -	depends on MACH_OMAP_H3
> +	depends on MACH_OMAP_H3 || COMPILE_TEST
>  	depends on TPS65010=y
>  	default y
>  	help
> diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
> index 8e54aae544a0..da2e32615abe 100644
> --- a/drivers/video/fbdev/omap/lcd_ams_delta.c
> +++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
> @@ -14,7 +14,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/lcd.h>
>  
> -#include <mach/hardware.h>
> +#include <linux/soc/ti/omap1-io.h>
>  
>  #include "omapfb.h"
>  
> diff --git a/drivers/video/fbdev/omap/lcd_dma.c b/drivers/video/fbdev/omap/lcd_dma.c
> index 867a63c06f42..f85817635a8c 100644
> --- a/drivers/video/fbdev/omap/lcd_dma.c
> +++ b/drivers/video/fbdev/omap/lcd_dma.c
> @@ -25,7 +25,8 @@
>  
>  #include <linux/omap-dma.h>
>  
> -#include <mach/hardware.h>
> +#include <linux/soc/ti/omap1-soc.h>
> +#include <linux/soc/ti/omap1-io.h>
>  
>  #include "lcdc.h"
>  #include "lcd_dma.h"
> diff --git a/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
> index 37ed0c14aa5a..bb915637e9b6 100644
> --- a/drivers/video/fbdev/omap/lcd_inn1510.c
> +++ b/drivers/video/fbdev/omap/lcd_inn1510.c
> @@ -10,7 +10,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  
> -#include <mach/hardware.h>
> +#include <linux/soc/ti/omap1-soc.h>
>  
>  #include "omapfb.h"
>  
> diff --git a/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
> index 5d5762128c8d..8168ba0d47fd 100644
> --- a/drivers/video/fbdev/omap/lcd_osk.c
> +++ b/drivers/video/fbdev/omap/lcd_osk.c
> @@ -11,8 +11,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
>  
> -#include <mach/hardware.h>
> -#include <mach/mux.h>
> +#include <linux/soc/ti/omap1-io.h>
> +#include <linux/soc/ti/omap1-mux.h>
>  
>  #include "omapfb.h"
>  
> diff --git a/drivers/video/fbdev/omap/lcdc.c b/drivers/video/fbdev/omap/lcdc.c
> index 65953b7fbdb9..3af758f12afd 100644
> --- a/drivers/video/fbdev/omap/lcdc.c
> +++ b/drivers/video/fbdev/omap/lcdc.c
> @@ -17,6 +17,8 @@
>  #include <linux/clk.h>
>  #include <linux/gfp.h>
>  
> +#include <linux/soc/ti/omap1-io.h>
> +#include <linux/soc/ti/omap1-soc.h>
>  #include <linux/omap-dma.h>
>  
>  #include <asm/mach-types.h>
> diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
> index dc06057de91d..af73a3f9ac53 100644
> --- a/drivers/video/fbdev/omap/omapfb_main.c
> +++ b/drivers/video/fbdev/omap/omapfb_main.c
> @@ -19,8 +19,7 @@
>  
>  #include <linux/omap-dma.h>
>  
> -#include <mach/hardware.h>
> -
> +#include <linux/soc/ti/omap1-soc.h>
>  #include "omapfb.h"
>  #include "lcdc.h"
>  
> diff --git a/drivers/video/fbdev/omap/sossi.c b/drivers/video/fbdev/omap/sossi.c
> index ade9d452254c..6b99d89fbe6e 100644
> --- a/drivers/video/fbdev/omap/sossi.c
> +++ b/drivers/video/fbdev/omap/sossi.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  
>  #include <linux/omap-dma.h>
> +#include <linux/soc/ti/omap1-io.h>
>  
>  #include "omapfb.h"
>  #include "lcd_dma.h"
