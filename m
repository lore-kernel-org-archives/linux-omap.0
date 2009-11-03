From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/8] omap: zoom3: introduce zoom3 board support
Date: Tue, 3 Nov 2009 16:28:02 -0600
Message-ID: <4AF0AE72.20802@ti.com>
References: <1257283215-6448-1-git-send-email-vikram.pandita@ti.com> <1257283215-6448-2-git-send-email-vikram.pandita@ti.com> <1257283215-6448-3-git-send-email-vikram.pandita@ti.com> <1257283215-6448-4-git-send-email-vikram.pandita@ti.com> <1257283215-6448-5-git-send-email-vikram.pandita@ti.com> <1257283215-6448-6-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54875 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322AbZKCW15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Nov 2009 17:27:57 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3MS34O001826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 16:28:03 -0600
In-Reply-To: <1257283215-6448-6-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vikram Pandita <vikram.pandtia@ti.com>

Pandita, Vikram had written, on 11/03/2009 03:20 PM, the following:
> Zoom3 is the next versoin of Zoom2 board.
> There has been a silicon update from zoom2 to zoom3.
> 	Zoom2 has OMAP34xx
> 	Zoom3 has OMAP3630
> Zoom3 = OMAP3630 SOM board + same zoom2 main board + same debugboard
> 
> Zoom3 has a different SDRAM part from Hynix
> Zoom2 had SDRAM part from micron
> 
would have been great to get more details on zoom3.

> Reuse the zoom2 files as much for zoom3, as at board level,
> there is no change at all.
> 
> Signed-off-by: Vikram Pandita <vikram.pandtia@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig                        |    4 +
>  arch/arm/mach-omap2/Makefile                       |    4 +
>  arch/arm/mach-omap2/board-zoom3.c                  |   59 ++++++++++++++++++++
>  arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   54 ++++++++++++++++++
>  4 files changed, 121 insertions(+), 0 deletions(-)
>  create mode 100755 arch/arm/mach-omap2/board-zoom3.c
>  create mode 100644 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 8685df5..9824775 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -101,6 +101,10 @@ config MACH_CM_T35
>  	bool "CompuLab CM-T35 module"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>  
> +config MACH_OMAP_ZOOM3
> +	bool "OMAP3630 Zoom3 board"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +
>  config MACH_OMAP_4430SDP
>  	bool "OMAP 4430 SDP board"
>  	depends on ARCH_OMAP4
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 4d66b42..712e7fc 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -75,6 +75,10 @@ obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
>  					   board-zoom-peripherals.o \
>  					   mmc-twl4030.o \
>  					   board-zoom-debugboard.o
> +obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
> +					   board-zoom-peripherals.o \
> +					   mmc-twl4030.o \
> +					   board-zoom-debugboard.o
>  obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
>  					   mmc-twl4030.o
>  
> diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
> new file mode 100755
> index 0000000..aebe7b8
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-zoom3.c
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright (C) 2009 Texas Instruments Inc.
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/gpio.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <plat/common.h>
> +#include <plat/board.h>
> +
> +#include "sdram-hynix-h8mbx00u0mer-0em.h"
> +
> +static void __init omap_zoom_map_io(void)
> +{
> +	omap2_set_globals_343x();
> +	omap2_map_common_io();
> +}
> +
> +static struct omap_board_config_kernel zoom_config[] __initdata = {
> +};
EOL?
> +static void __init omap_zoom_init_irq(void)
> +{
> +	omap_board_config = zoom_config;
> +	omap_board_config_size = ARRAY_SIZE(zoom_config);
> +	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
> +			h8mbx00u0mer0em_sdrc_params);
> +	omap_init_irq();
> +	omap_gpio_init();
> +}
> +
> +extern int __init omap_zoom2_debugboard_init(void);
> +extern void __init zoom_peripherals_init(void);
> +
> +static void __init omap_zoom_init(void)
> +{
> +        zoom_peripherals_init();
    ^^^^^^^^ <- is that spaces here? could you checkpatch please?

> +	omap_zoom2_debugboard_init();
> +}
> +
> +MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
> +	.phys_io	= 0x48000000,
> +	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
> +	.boot_params	= 0x80000100,
> +	.map_io		= omap_zoom_map_io,
> +	.init_irq	= omap_zoom_init_irq,
> +	.init_machine	= omap_zoom_init,
> +	.timer		= &omap_timer,
> +MACHINE_END
love a small board file such as this.. thanks..

> diff --git a/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h b/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
> new file mode 100644
> index 0000000..c469c48
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
> @@ -0,0 +1,54 @@
> +/*
> + * SDRC register values for the Hynix H8MBX00U0MER-0EM
> + *
> + * Copyright (C) 2008-2009 Texas Instruments, Inc.
> + * Copyright (C) 2008-2009 Nokia Corporation
> + *
> + * Nicole Chalhoub / Vincent Bour
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_HYNIX_H8MBX00U0MER0EM
            ^^^ maybe a prefix of __?

-- 
Regards,
Nishanth Menon

