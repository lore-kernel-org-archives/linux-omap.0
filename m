From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 1/2] Initial B&N Nook Color (Encore) support
Date: Wed, 27 Apr 2011 11:54:48 +0300
Message-ID: <4DB7D9D8.4030009@compulab.co.il>
References: <1303869133-27976-1-git-send-email-green@linuxhacker.ru> <1303869133-27976-2-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:49725
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754992Ab1D0Ir3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 04:47:29 -0400
In-Reply-To: <1303869133-27976-2-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org

On 04/27/11 04:52, green@linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> Just bare-bones board file that has only serial console working.
> ---
>  arch/arm/mach-omap2/Kconfig                    |    5 +
>  arch/arm/mach-omap2/Makefile                   |    1 +
>  arch/arm/mach-omap2/board-omap3encore.c        |  152 ++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/board-encore.h |   76 ++++++++++++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    1 +
>  arch/arm/tools/mach-types                      |    2 +-
>  6 files changed, 236 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-omap3encore.c
>  create mode 100644 arch/arm/plat-omap/include/plat/board-encore.h
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index b997a35..5370561 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -173,6 +173,11 @@ config MACH_OMAP3_TORPEDO
>  	 for full description please see the products webpage at
>  	 http://www.logicpd.com/products/development-kits/zoom-omap35x-torpedo-development-kit
>  
> +config MACH_ENCORE
> +        bool "Barnes & Noble Encore (Nook Color)"
> +        depends on ARCH_OMAP3
> +        select OMAP_PACKAGE_CBP
> +
>  config MACH_OVERO
>  	bool "Gumstix Overo board"
>  	depends on ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 512b152..207f372 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -189,6 +189,7 @@ obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o \
>  					   hsmmc.o
> +obj-$(CONFIG_MACH_ENCORE)               += board-omap3encore.o
>  obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
> diff --git a/arch/arm/mach-omap2/board-omap3encore.c b/arch/arm/mach-omap2/board-omap3encore.c
> new file mode 100644
> index 0000000..9a00d6b
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3encore.c
> @@ -0,0 +1,152 @@
> +/*
> + *
> + * Copyright (C) 2008 Texas Instruments Inc.
> + * Vikram Pandita <vikram.pandita@ti.com>
> + *
> + * Modified from mach-omap2/board-ldp.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Apri 2011 Oleg Drokin <green@linuxhacker.ru> - Port to 2.6.39
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/workqueue.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/interrupt.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/fixed.h>
> +#include <linux/dma-mapping.h>
> +#include <plat/board-encore.h>
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <plat/mcspi.h>
> +#include <mach/gpio.h>
> +#include <plat/board.h>
> +#include <plat/common.h>
> +#include <plat/gpmc.h>
> +#include <plat/usb.h>
> +#include <plat/mux.h>
> +
> +#include <asm/system.h> // For system_serial_high & system_serial_low

No C++ comments, please.

> +#include <asm/io.h>
> +#include <asm/delay.h>
> +#include <plat/sram.h>
> +
> +#include <plat/display.h>
> +#include <plat/omap-serial.h>
> +
> +#include <plat/system.h>
> +
> +#include "mux.h"
> +#include "prcm-common.h"
> +
> +#include "sdram-hynix-h8mbx00u0mer-0em.h"
> +
> +#include <media/v4l2-int-device.h>

Please check what header files are actually required and drop the rest...

> +#ifdef CONFIG_ANDROID_RAM_CONSOLE
> +#include <linux/bootmem.h>
> +#endif

AFAIK, there's no CONFIG_ANDROID_ in the kernel

> +/* Use address that is most likely unused and untouched by u-boot */
> +#define ENCORE_RAM_CONSOLE_START 0x8e000000
> +#define ENCORE_RAM_CONSOLE_SIZE (0x20000)
> +
> +static struct resource encore_ram_console_resource[] = { 
> +    {
> +        .start  = ENCORE_RAM_CONSOLE_START,
> +        .end    = ENCORE_RAM_CONSOLE_START + ENCORE_RAM_CONSOLE_SIZE - 1,
> +        .flags  = IORESOURCE_MEM,
> +    }
> +};
> +
> +static struct platform_device encore_ram_console_device = {
> +    .name           = "ram_console",
> +    .id             = 0,
> +    .num_resources  = ARRAY_SIZE(encore_ram_console_resource),
> +    .resource       = encore_ram_console_resource,
> +};

and there's no ram_console driver as well.
I don't think it'd make sense to register ram_console device at all.

> +static struct platform_device *encore_devices[] __initdata = {
> +	&encore_ram_console_device,
> +};
> +
> +static void __init omap_encore_init_early(void)
> +{
> +printk("in early ini\n");
> +	omap2_init_common_infrastructure();
> +	omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
> +				  h8mbx00u0mer0em_sdrc_params);
> +#ifdef CONFIG_ANDROID_RAM_CONSOLE
> +	reserve_bootmem(ENCORE_RAM_CONSOLE_START, ENCORE_RAM_CONSOLE_SIZE, 0);
> +#endif /* CONFIG_ANDROID_RAM_CONSOLE */
> +printk("done early ini\n");
> +}
> +
> +#if defined(CONFIG_USB_ANDROID) || defined(CONFIG_USB_ANDROID_MODULE)
> +static struct usb_mass_storage_platform_data mass_storage_pdata = {
> +	.vendor = "B&N     ",
> +	.product = "Ebook Disk      ",
> +	.release = 0x0100,
> +};
> +
> +static struct platform_device usb_mass_storage_device = {
> +	.name = "usb_mass_storage",
> +	.id = -1,
> +	.dev = {
> +		.platform_data = &mass_storage_pdata,
> +		},
> +};
> +#endif

The above comment applies to the usb mass storage device

> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_board_mux board_mux[] __initdata = {
> +        { .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#else
> +#define board_mux       NULL
> +#endif
> +
> +static struct omap_board_config_kernel encore_config[] __initdata = {
> +};
> +
> +static void __init omap_encore_init(void)
> +{
> +printk("in encore init\n");

please remove debug leftovers

> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +	omap_serial_init();
> +
> +	omap_board_config = encore_config;
> +	omap_board_config_size = ARRAY_SIZE(encore_config);
> +
> +	platform_add_devices(encore_devices, ARRAY_SIZE(encore_devices));
> +
> +        BUG_ON(!cpu_is_omap3630());

In what exact circumstances can this trigger? Are there encore boards with CPU
other than omap3630?

> +
> +printk("done encore init\n");
> +}
> +
> +MACHINE_START(ENCORE, "encore")
> +	.boot_params	= 0x80000100,
> +	.reserve	= omap_reserve,
> +	.map_io		= omap3_map_io,
> +	.init_early	= omap_encore_init_early,
> +	.init_irq	= omap_init_irq,
> +	.init_machine	= omap_encore_init,
> +	.timer		= &omap_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-omap/include/plat/board-encore.h b/arch/arm/plat-omap/include/plat/board-encore.h
> new file mode 100644
> index 0000000..2dd33f6
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/board-encore.h

If you really think that this header is necessary, it should be
arch/arm/mach-omap2/board-encore.h, however, I think it can be removed at all
and all the defines moved to the board-encore.c

> @@ -0,0 +1,76 @@
> +/*
> + * arch/arm/plat-omap/include/mach/board-boxer.h

boxer?

> + * Hardware definitions for TI OMAP3-based Encore (B&N Nook Color).
> + *
> + * Copyright (C) 2008 Texas Instruments Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
> + * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __ASM_ARCH_OMAP_ENCORE_H
> +#define __ASM_ARCH_OMAP_ENCORE_H
> +
> +#define MAX17042_I2C_SLAVE_ADDRESS		0x36
> +#define MAX17042_GPIO_FOR_IRQ			100
> +
> +/*addition of MAXIM8903/TI GPIO mapping WRT schematics */
> +#define MAX8903_UOK_GPIO_FOR_IRQ 115
> +#define MAX8903_DOK_GPIO_FOR_IRQ 114      
> +#define MAX8903_GPIO_CHG_EN      110
> +#define MAX8903_GPIO_CHG_STATUS  111
> +#define MAX8903_GPIO_CHG_FLT     101
> +#define MAX8903_GPIO_CHG_IUSB    102
> +#define MAX8903_GPIO_CHG_USUS    104
> +#define MAX8903_GPIO_CHG_ILM     61
> +
> +#define BOXER_WIFI_PMENA_GPIO   22
> +#define BOXER_WIFI_IRQ_GPIO     15
> +#define BOXER_WIFI_EN_POW       16
> +
> +#define BOARD_ENCORE_REV_EVT1A      0x1
> +#define BOARD_ENCORE_REV_EVT1B      0x2
> +#define BOARD_ENCORE_REV_EVT2       0x3
> +#define BOARD_ENCORE_REV_DVT        0x4
> +#define BOARD_ENCORE_REV_PVT        0x5
> +#define BOARD_ENCORE_REV_UNKNOWN    0x6
> +
> +static inline int is_encore_board_evt2(void)
> +{
> +    return (system_rev >= BOARD_ENCORE_REV_EVT2);
> +}
> +
> +static inline int is_encore_board_evt1b(void)
> +{
> +    return (system_rev == BOARD_ENCORE_REV_EVT1B);
> +}
> +
> +#define KXTF9_DEVICE_ID			"kxtf9"
> +#define KXTF9_I2C_SLAVE_ADDRESS		0x0F
> +#define KXTF9_GPIO_FOR_PWR		34
> +#define KXTF9_GPIO_FOR_IRQ		113
> +
> +#define CYTTSP_I2C_SLAVEADDRESS 34
> +#define ENCORE_CYTTSP_GPIO        99
> +#define ENCORE_CYTTSP_RESET_GPIO 46
> +
> +
> +#endif /* __ASM_ARCH_OMAP_ENCORE_H */
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
> index 30b891c..c3c1a0d 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -169,6 +169,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>  		/* zoom2/3 external uart */
>  		DEBUG_LL_ZOOM(omap_zoom2);
>  		DEBUG_LL_ZOOM(omap_zoom3);
> +		DEBUG_LL_OMAP3(3, encore);

please move it after 'DEBUG_LL_OMAP3(3, touchbook);' for consistency

>  
>  		/* TI8168 base boards using UART3 */
>  		DEBUG_LL_TI816X(3, ti8168evm);
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 7ca41f0..2f0db3e 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -962,7 +962,7 @@ omapl138_case_a3	MACH_OMAPL138_CASE_A3	OMAPL138_CASE_A3	3280
>  uemd			MACH_UEMD		UEMD			3281
>  ccwmx51mut		MACH_CCWMX51MUT		CCWMX51MUT		3282
>  rockhopper		MACH_ROCKHOPPER		ROCKHOPPER		3283
> -nookcolor		MACH_NOOKCOLOR		NOOKCOLOR		3284
> +encore			MACH_ENCORE		ENCORE			3284
>  hkdkc100		MACH_HKDKC100		HKDKC100		3285
>  ts42xx			MACH_TS42XX		TS42XX			3286
>  aebl			MACH_AEBL		AEBL			3287


-- 
Sincerely yours,
Mike.
