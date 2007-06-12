From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/12] Add support for the HTC Typhoon,
	Hurricane and Tornado smartphone
Date: Tue, 12 Jun 2007 16:58:22 +0530
Message-ID: <5d5443650706120428p53e6d6afw6cbba17a29f9b13f@mail.gmail.com>
References: <466ADDB9.60708@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <466ADDB9.60708@free.fr>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vivien Chappelier <vivien.chappelier@free.fr>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 6/9/07, Vivien Chappelier <vivien.chappelier@free.fr> wrote:
> This patch adds support for the HTC smartphone boards based on the
> OMAP730 and
> OMAP850 platform. Phone model is detected at runtime.
>
> Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>
>
>
> ---
>  arch/arm/mach-omap1/Kconfig               |    7 +
>  arch/arm/mach-omap1/Makefile              |    1 +
>  arch/arm/mach-omap1/board-typhoon.c       |  301
> +++++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/board-typhoon.h |   62 ++++++
>  4 files changed, 371 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/board-typhoon.c
>  create mode 100644 include/asm-arm/arch-omap/board-typhoon.h
>
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index 79f0b1f..eb12ca5 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -125,6 +125,13 @@ config MACH_NOKIA770
>        Support for the Nokia 770 Internet Tablet. Say Y here if you
>        have such a device.
>
> +config MACH_TYPHOON
> +    bool "HTC Typhoon"
> +    depends on ARCH_OMAP1 && ARCH_OMAP730
> +    help
> +      Support for the HTC Typhoon/Tornado smartphone. Say Y here if you
> +      have such a phone.
> +
>  config MACH_AMS_DELTA
>      bool "Amstrad E3 (Delta)"
>      depends on ARCH_OMAP1 && ARCH_OMAP15XX
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index 8377665..9f6bcbb 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_MACH_OMAP_PALMTE)        += board-palmte.o
>  obj-$(CONFIG_MACH_OMAP_PALMZ71)        += board-palmz71.o
>  obj-$(CONFIG_MACH_OMAP_PALMTT)        += board-palmtt.o
>  obj-$(CONFIG_MACH_NOKIA770)        += board-nokia770.o
> +obj-$(CONFIG_MACH_TYPHOON)        += board-typhoon.o
>  obj-$(CONFIG_MACH_AMS_DELTA)        += board-ams-delta.o
>  obj-$(CONFIG_MACH_SX1)            += board-sx1.o
>
> diff --git a/arch/arm/mach-omap1/board-typhoon.c
> b/arch/arm/mach-omap1/board-typhoon.c
> new file mode 100644
> index 0000000..814cf3f
> --- /dev/null
> +++ b/arch/arm/mach-omap1/board-typhoon.c
> @@ -0,0 +1,301 @@
> +/*
> + * linux/arch/arm/mach-omap1/board-typhoon.c
> + *
> + * Modified from board-perseus2.c
> + *
> + * Copyright 2005 Vivien Chappelier <vivien.chappelier@free.fr>
> + * Original OMAP730 support by Jean Pihet <j-pihet@ti.com>
> + * Updated for 2.6 by Kevin Hilman <kjh@hilman.org>
> + *
> + * MMC and watchdog reinitialization by Nicolas Schichan
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/input.h>
> +#include <linux/bootmem.h>
> +
> +#include <asm/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/flash.h>
> +#include <asm/mach/map.h>
> +
> +#include <asm/arch/gpio.h>
> +#include <asm/arch/mux.h>
> +#include <asm/arch/fpga.h>
> +#include <asm/arch/common.h>
> +
> +#include <asm/arch/board.h>
> +#include <asm/arch/usb.h>
> +#include <asm/arch/board-typhoon.h>
> +
> +/* LCD device */
> +static struct platform_device lcd_device = {
> +    .name        = "lcd_typhoon",
> +    .id        = -1,
> +};
> +
> +/* GSM device */
> +#define TYPHOON_GSM_PHYS_START        0x11d80000 /* end of RAM */
> +#define TYPHOON_GSM_PHYS_SIZE        0x00280000 /* 2.5 MB code/data/fifo */
> +
> +#define TORNADO_GSM_PHYS_START        0x13c00000 /* end of RAM */
> +#define TORNADO_GSM_PHYS_SIZE        0x00400000 /* 4.0 MB code/data/fifo */
> +
> +static struct resource gsm_resources[] = {
> +    {    /* GSM DSP MMU */
> +        .start        = IO_ADDRESS(OMAP730_DSP_MMU_BASE),
> +        .end        = IO_ADDRESS(OMAP730_DSP_MMU_BASE) + 0x54,

Is it tabs or spaces? use tabs not spaces for indentation.

> +        .flags        = IORESOURCE_MEM,
> +    },
> +    {    /* GSM software interrupt */
> +        .start        = INT_730_ICR,
> +        .flags        = IORESOURCE_IRQ,
> +    },
> +    {       /* GSM radio interrupt */
> +        .start        = INT_730_DBB_RF_EN,
> +        .flags        = IORESOURCE_IRQ,
> +    },
> +};
> +
> +static struct platform_device gsm_device = {
> +        .name           = "typhoon-gsm",
> +        .id             = 1,
> +    .num_resources    = ARRAY_SIZE(gsm_resources),
> +    .resource    = gsm_resources,
> +};

Ditto. Please check other parts of files too.

....

> +
> +# define       OMAP_MMC_REG_SYSC       (0xfffb7800 + 0x32)
> +# define       OMAP_MMC_REG_SYSS       (0xfffb7800 + 0x34)
> +# define       OMAP_MMC_REG_CTO        (0xfffb7800 + 0x0e)
> +# define       OMAP_MMC_REG_DTO        (0xfffb7800 + 0x1c)
> +
> +       /* put mmc host into reset ... */
> +       omap_writew(1, OMAP_MMC_REG_SYSC);
> +
> +       tries = 100;
> +       while (omap_readw(OMAP_MMC_REG_SYSS) == 0 && tries) {
> +               mdelay(50);
> +               --tries;
> +       }
> +       printk("MMC host reset done: remaining tries: %i\n", tries);

KERN_* facility level is required.

> +
> +       /* force mode 0 for D_SMC_DAT3, D_SMC_DAT2, D_SMC, no pull up
> enable */

multiline comment format is not correct.

It should be /*
                   * start here
                   */

> +       omap_writel(omap_readl(OMAP730_IO_CONF_2) & ~(0xF << 8),
> OMAP730_IO_CONF_2);
> +       omap_writel(omap_readl(OMAP730_IO_CONF_2) & ~(0xF << 12),
> OMAP730_IO_CONF_2);
> +       omap_writel(omap_readl(OMAP730_IO_CONF_2) & ~(0xF << 16),
> OMAP730_IO_CONF_2);
> +}
> +
> +static void omap_typhoon_lcd_init(void)
> +{
> +    u32 reg;
> +
> +# define       OMAP_LCDC_CONTROL               (0xfffec000 + 0x00)
> +# define       OMAP_LCDC_STATUS                (0xfffec000 + 0x10)
> +# define       OMAP_DMA_LCD_CCR                (0xfffee300 + 0xc2)
> +# define       OMAP_DMA_LCD_CTRL               (0xfffee300 + 0xc4)
> +# define       OMAP_LCDC_CTRL_LCD_EN           (1 << 0)
> +# define       OMAP_LCDC_STAT_DONE             (1 << 0)
> +
> +    /* disable controller if active */
> +    reg = omap_readl(OMAP_LCDC_CONTROL);
> +    if (reg & OMAP_LCDC_CTRL_LCD_EN) {
> +        reg &= ~OMAP_LCDC_CTRL_LCD_EN;
> +        omap_writel(reg, OMAP_LCDC_CONTROL);
> +
> +        /* wait for end of frame */
> +        while(!(omap_readl(OMAP_LCDC_STATUS) & OMAP_LCDC_STAT_DONE));

space before opening parenthesis.

> +
> +        /* turn off DMA */
> +        reg = omap_readw(OMAP_DMA_LCD_CCR);
> +        reg &= ~(1 << 7);
> +        omap_writew(reg, OMAP_DMA_LCD_CCR);
> +
> +        reg = omap_readw(OMAP_DMA_LCD_CTRL);
> +        reg &= ~(1 << 8);
> +        omap_writew(reg, OMAP_DMA_LCD_CTRL);
> +    }
> +}
> +

...

-- 
--Trilok Soni
