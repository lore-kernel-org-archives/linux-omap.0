From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Add OMAP4 Panda support
Date: Fri, 18 Jun 2010 07:32:14 -0700
Message-ID: <87y6ecbedt.fsf@deeprootsystems.com>
References: <7B4574D56E4ADF438756313E9A172A8799C0D3C6@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:64630 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933443Ab0FROcR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 10:32:17 -0400
Received: by pxi12 with SMTP id 12so475702pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 07:32:16 -0700 (PDT)
In-Reply-To: <7B4574D56E4ADF438756313E9A172A8799C0D3C6@dlee01.ent.ti.com> (David Anders's message of "Mon\, 17 May 2010 15\:18\:22 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anders, David" <x0132446@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

"Anders, David" <x0132446@ti.com> writes:

> Add initial support for the OMAP4430 based Panda board.
>
> Signed-off-by: David Anders <x0132446@ti.com>
> ---
>  arch/arm/configs/omap4_panda_defconfig | 1094 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/Kconfig            |    4 +
>  arch/arm/mach-omap2/Makefile           |    1 +
>  arch/arm/mach-omap2/board-omap4panda.c |   80 +++
>  4 files changed, 1179 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/omap4_panda_defconfig
>  create mode 100644 arch/arm/mach-omap2/board-omap4panda.c

[...]

> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> new file mode 100644
> index 0000000..95faec0
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -0,0 +1,80 @@
> +/*
> + * Board support file for OMAP4430 based Panda.
> + *
> + * Copyright (C) 2010 Texas Instruments
> + *
> + * Author: David Anders <x0132446@ti.com>
> + *
> + * Based on mach-omap2/board-4430sdp.c
> + *
> + * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * Based on mach-omap2/board-3430sdp.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +#include <linux/usb/otg.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/omap4-common.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <plat/board.h>
> +#include <plat/common.h>
> +#include <plat/control.h>
> +#include <plat/timer-gp.h>
> +#include <plat/usb.h>
> +
> +static void __init omap4_panda_init_irq(void)
> +{
> +       omap2_init_common_hw(NULL, NULL);
> +#ifdef CONFIG_OMAP_32K_TIMER
> +       omap2_gp_clockevent_set_gptimer(1);
> +#endif
> +       gic_init_irq();
> +       omap_gpio_init();
> +}
> +
> +static struct omap_musb_board_data musb_board_data = {
> +       .interface_type         = MUSB_INTERFACE_UTMI,
> +       .mode                   = MUSB_PERIPHERAL,
> +       .power                  = 100,
> +};
> +
> +static void __init omap4_panda_init(void)
> +{
> +       omap_serial_init();
> +       /* OMAP4 SDP uses internal transceiver so register nop transceiver */

SDP?

> +       usb_nop_xceiv_register();
> +       /* FIXME: allow multi-omap to boot until musb is updated for omap4 */
> +       if (!cpu_is_omap44xx())
> +               usb_musb_init(&musb_board_data);
> +
> +}
> +
> +static void __init omap4_panda_map_io(void)
> +{
> +       omap2_set_globals_443x();
> +       omap44xx_map_common_io();
> +}
> +
> +MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
> +       /* Maintainer: David Anders - Texas Instruments Inc */
> +       .phys_io        = 0x48000000,
> +       .io_pg_offst    = ((0xfa000000) >> 18) & 0xfffc,
> +       .boot_params    = 0x80000100,
> +       .map_io         = omap4_panda_map_io,
> +       .init_irq       = omap4_panda_init_irq,
> +       .init_machine   = omap4_panda_init,
> +       .timer          = &omap_timer,
> +MACHINE_END


IIUC, Panda was built to be compatible with the SDP/Blaze, right?

If so, is there any reason we can't support both boards from the same
board file?

Just add the above MACHINE_START.._END section to board-4430sdp.c to handle
the both machine IDs, but all the functions could be common.

Kevin


