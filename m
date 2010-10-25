From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/1] OMAP: AM3517/05: craneboard: Add craneboard support
Date: Mon, 25 Oct 2010 09:09:05 -0500
Message-ID: <4CC58F81.9070907@ti.com>
References: <1288013665-2487-1-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38884 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755828Ab0JYOJI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Oct 2010 10:09:08 -0400
In-Reply-To: <1288013665-2487-1-git-send-email-srinath@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "srinath@mistralsolutions.com" <srinath@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kridner, Jason" <jdk@ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "nagendra@mistralsolutions.com" <nagendra@mistralsolutions.com>, "umeshk@mistralsolutions.com" <umeshk@mistralsolutions.com>

This patch on a cursory look seems much better. thanks. couple of 
suggestions
$subject - you dont need that 1/1 for a single patch ;)
$subject - s/craneboard: Add craneboard support/Add craneboard support
might be good enough for reducing redundancy.

srinath@mistralsolutions.com had written, on 10/25/2010 08:34 AM, the 
following:
> From: Srinath <srinath@mistralsolutions.com>
> 
> This patch adds basic board file. Detailed support will follow in
> subsequent patches.
> 
>       [1] http://www.ti.com/sitara
>       [2] http://www.mistralsolutions.com/products/craneboard.php
> 
> This patch has been created against omap-next branch.
> 
> Signed-off-by: Srinath <srinath@mistralsolutions.com>
> ---
>  arch/arm/configs/omap2plus_defconfig         |    1 +
>  arch/arm/mach-omap2/Kconfig                  |    5 ++
>  arch/arm/mach-omap2/Makefile                 |    2 +
>  arch/arm/mach-omap2/board-am3517crane.c      |   74 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  5 files changed, 83 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-am3517crane.c
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index ccedde1..8c93f86 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -40,6 +40,7 @@ CONFIG_MACH_OMAP_LDP=y
>  CONFIG_MACH_OVERO=y
>  CONFIG_MACH_OMAP3EVM=y
>  CONFIG_MACH_OMAP3517EVM=y
> +CONFIG_MACH_CRANEBOARD=y
>  CONFIG_MACH_OMAP3_PANDORA=y
>  CONFIG_MACH_OMAP3_TOUCHBOOK=y
>  CONFIG_MACH_OMAP_3430SDP=y
not sure if Tony likes board support touching defconfigs as well.

> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index ab784bf..3688515 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -174,6 +174,11 @@ config MACH_OMAP3517EVM
>  	default y
>  	select OMAP_PACKAGE_CBB
>  
> +config MACH_CRANEBOARD
> +	bool "AM3517/05 CRANE board"
> +	depends on ARCH_OMAP3
> +	select OMAP_PACKAGE_CBB
> +
>  config MACH_OMAP3_PANDORA
>  	bool "OMAP3 Pandora"
>  	depends on ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 7352412..f885037 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -170,6 +170,8 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
>  
>  obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
>  
> +obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
> +
>  obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o \
>  					   hsmmc.o
>  # Platform specific device init code
> diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
> new file mode 100644
> index 0000000..152f6ee
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-am3517crane.c
> @@ -0,0 +1,74 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-am3517crane.c
might be a good idea to drop the file name here - might suffice to say 
support for AM3517/05 Craneboard
http://www.mistralsolutions.com/products/craneboard.php

> + *
> + * Copyright (C) 2010 Mistral Solutions Pvt Ltd. <www.mistralsolutions.com>
> + * Author: R.Srinath <srinath@mistralsolutions.com>
> + *
> + * Based on mach-omap2/board-am3517evm.c
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as  published by the
> + * Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <plat/board.h>
> +#include <plat/common.h>
> +
> +#include "mux.h"
> +
> +/* Board initialization */
> +static struct omap_board_config_kernel am3517_crane_config[] __initdata = {
> +};
> +
> +static struct platform_device *am3517_crane_devices[] __initdata = {
> +};
> +
> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_board_mux board_mux[] __initdata = {
> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#else
> +#define board_mux	NULL
> +#endif
> +
> +static void __init am3517_crane_init_irq(void)
> +{
> +	omap_board_config = am3517_crane_config;
> +	omap_board_config_size = ARRAY_SIZE(am3517_crane_config);
> +
> +	omap2_init_common_hw(NULL, NULL);
> +	omap_init_irq();
> +	omap_gpio_init();
> +}
> +
> +static void __init am3517_crane_init(void)
> +{
> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
hmmm...
if we had something like this:
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 074536a..6e1e9e6 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -709,7 +709,8 @@ static void omap_mux_init_package(struct omap_mux 
*superset,
  static void omap_mux_init_signals(struct omap_board_mux *board_mux)
  {
         omap_mux_set_cmdline_signals();
-       omap_mux_write_array(board_mux);
+       if (board_mux)
+               omap_mux_write_array(board_mux);
  }

  #else


then we'd not need to define an empty board_mux array for passing 
instead could just pass NULL for basic initialization..

but yeah, for the current implementation, we'd get a oops in 
omap_mux_write_array if we send a NULL pointer here..

Tony,
should'nt we support NULL passing? if yes, I can post the trivial patch 
for the same.

> +	platform_add_devices(am3517_crane_devices,
> +			ARRAY_SIZE(am3517_crane_devices));
you dont have any devices in the list -> why not remove this and 
associated structs and add it when you do really add device support to 
the board file?

> +	omap_serial_init();
> +}
> +
> +MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
> +	.boot_params	= 0x80000100,
> +	.map_io		= omap3_map_io,
> +	.reserve        = omap_reserve,
> +	.init_irq	= am3517_crane_init_irq,
> +	.init_machine	= am3517_crane_init,
> +	.timer		= &omap_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
> index 9036e37..229fbf2 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -145,6 +145,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>  		/* omap3 based boards using UART3 */
>  		DEBUG_LL_OMAP3(3, cm_t35);
>  		DEBUG_LL_OMAP3(3, cm_t3517);
> +		DEBUG_LL_OMAP3(3, craneboard);
>  		DEBUG_LL_OMAP3(3, igep0020);
>  		DEBUG_LL_OMAP3(3, igep0030);
>  		DEBUG_LL_OMAP3(3, nokia_rx51);


-- 
Regards,
Nishanth Menon
