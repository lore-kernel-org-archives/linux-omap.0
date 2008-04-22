From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Tue, 22 Apr 2008 19:32:41 +0300
Message-ID: <20080422163241.GB10066@kedavra.cpe.vivax.com.br>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55872 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbYDVQbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 12:31:09 -0400
Content-Disposition: inline
In-Reply-To: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

On Tue, Apr 22, 2008 at 09:57:48AM +0200, Koen Kooi wrote:
> In case of broken-mailer-white-space-damage: http://amethyst.openembedded.net/~koen/beagleboard/0001-omap3beagle-register-SD-interface.patch
>
> From a4127c880913185919f065800535c8d90751ac3c Mon Sep 17 00:00:00 2001
> From: Koen Kooi <koen@openembedded.org>
> Date: Tue, 22 Apr 2008 09:45:45 +0200
> Subject: [PATCH] omap3beagle: register SD interface
>
> Signed-off-by: Koen Kooi <koen@openembedded.org>
> - ---
> arch/arm/mach-omap2/Makefile            |    3 ++-
> arch/arm/mach-omap2/board-omap3beagle.c |   11 +++++++++++
> arch/arm/mach-omap2/board-omap3beagle.h |   12 ++++++++++++
> 3 files changed, 25 insertions(+), 1 deletions(-)
> create mode 100644 arch/arm/mach-omap2/board-omap3beagle.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 9414141..84d99d2 100644
> - --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -35,7 +35,8 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
> 					   board-3430sdp-usb.o \
> 					   board-3430sdp-flash.o
> obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
> - -obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
> +obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
> +					   board-sdp-hsmmc.o
> obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
> 					   board-apollon-mmc.o	\
> 					   board-apollon-keys.o
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
> omap2/board-omap3beagle.c
> index 0727ee2..866ecfb 100644
> - --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -29,6 +29,8 @@
> #include <asm/arch/board.h>
> #include <asm/arch/common.h>
>
> +#include "board-omap3beagle.h"

please don't... use include/asm-arm/arch-omap/board-omap3beagle.h

it's included from asm/hardware.h already.

> +
> static struct omap_uart_config omap3_beagle_uart_config __initdata = {
> 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
> };
> @@ -48,8 +50,16 @@ static void __init omap3_beagle_init_irq(void)
> 	omap_gpio_init();
> }
>
> +static struct omap_mmc_config omap3beagle_mmc_config __initdata = {
> +	.mmc [0] = {
> +		.enabled	= 1,
> +		.wire4		= 1,
> +	},
> +};
> +
> static struct omap_board_config_kernel omap3_beagle_config[] __initdata = 
									   ^whitespace
> {
> 	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
> +	{OMAP_TAG_MMC, &omap3beagle_mmc_config },
> };
>
> static void __init omap3_beagle_init(void)
> @@ -57,6 +67,7 @@ static void __init omap3_beagle_init(void)
> 	omap_board_config = omap3_beagle_config;
> 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
> 	omap_serial_init();
> +	sdp_mmc_init();
> }
>
> arch_initcall(omap3_beagle_i2c_init);
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.h b/arch/arm/mach- 
> omap2/board-omap3beagle.h
> new file mode 100644
> index 0000000..696ef00
> - --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3beagle.h
> @@ -0,0 +1,12 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-omap3beagle.h
> + *
> + * Copyright (C) 2008 Koen Kooi <koen@openembedded.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +extern void __init sdp_mmc_init(void);
> +
> - --
> 1.5.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
