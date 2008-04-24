From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Wed, 23 Apr 2008 17:21:20 -0700
Message-ID: <20080424002120.GE27546@atomide.com>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com> <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl> <200804220957.43599.david-b@pacbell.net> <E7D86ACF-575E-4A2B-8193-82A3A0B6FFCF@student.utwente.nl> <20080422170758.GB10347@kedavra.cpe.vivax.com.br> <BF39A517-6A64-4B10-B595-CBBF2F6BF5D0@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51110 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbYDXAVW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2008 20:21:22 -0400
Content-Disposition: inline
In-Reply-To: <BF39A517-6A64-4B10-B595-CBBF2F6BF5D0@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org, "Syed Mohammed, Khasim" <khasim@ti.com>

Hi,

* Koen Kooi <k.kooi@student.utwente.nl> [080423 00:42]:
> From dac3cdc5952ab39fa7ae0545d43e2daa95329b07 Mon Sep 17 00:00:00 2001
> From: Koen Kooi <koen@openembedded.org>
> Date: Wed, 23 Apr 2008 09:38:31 +0200
> Subject: [PATCH] omap3beagle: register SD interface

Thanks for updating it. I've pushed it now, but I had to apply some
parts manually because of recent changes. Can you please check it
got applied OK?

Tony

> Signed-off-by: Koen Kooi <koen@openembedded.org>
> ---
>  arch/arm/mach-omap2/Makefile                  |    3 ++-
>  arch/arm/mach-omap2/board-omap3beagle.c       |    9 +++++++++
>  include/asm-arm/arch-omap/board-omap3beagle.h |    2 ++
>  3 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 9414141..84d99d2 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -35,7 +35,8 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
>  					   board-3430sdp-usb.o \
>  					   board-3430sdp-flash.o
>  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
> -obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
> +obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
> +					   board-sdp-hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
>  					   board-apollon-mmc.o	\
>  					   board-apollon-keys.o
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
> omap2/board-omap3beagle.c
> index 0727ee2..c03bb26 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -48,8 +48,16 @@ static void __init omap3_beagle_init_irq(void)
>  	omap_gpio_init();
>  }
>
> +static struct omap_mmc_config omap3beagle_mmc_config __initdata = {
> +	.mmc [0] = {
> +		.enabled	= 1,
> +		.wire4		= 1,
> +	},
> +};
> +
>  static struct omap_board_config_kernel omap3_beagle_config[] __initdata 
> = {
>  	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
> +	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
>  };
>
>  static void __init omap3_beagle_init(void)
> @@ -57,6 +65,7 @@ static void __init omap3_beagle_init(void)
>  	omap_board_config = omap3_beagle_config;
>  	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>  	omap_serial_init();
> +	sdp_mmc_init();
>  }
>
>  arch_initcall(omap3_beagle_i2c_init);
> diff --git a/include/asm-arm/arch-omap/board-omap3beagle.h b/include/ 
> asm-arm/arch-omap/board-omap3beagle.h
> index c42db78..fcdf0bc 100644
> --- a/include/asm-arm/arch-omap/board-omap3beagle.h
> +++ b/include/asm-arm/arch-omap/board-omap3beagle.h
> @@ -29,6 +29,8 @@
>  #ifndef __ASM_ARCH_OMAP3_BEAGLE_H
>  #define __ASM_ARCH_OMAP3_BEAGLE_H
>
> +extern void sdp_mmc_init(void);
> +
>  #ifdef CONFIG_TWL4030_CORE
>
>  #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
> -- 
> 1.5.4.3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
