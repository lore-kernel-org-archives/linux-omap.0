From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: Re: [PATCH 1/1] Add MMC support for OMAP3 EVM
Date: Mon, 28 Apr 2008 12:21:13 +0300
Message-ID: <48159709.7000507@indt.org.br>
References: <5e088bd90804262305l6f483aa3y4528cdd3a739725f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18563 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbYD1JW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 05:22:28 -0400
In-Reply-To: <5e088bd90804262305l6f483aa3y4528cdd3a739725f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

ext Steve Sakoman wrote:
> From: Steve Sakoman <steve@sakoman.com>
>
> Add MMC support for OMAP3 EVM
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>   
Acked-by: Francisco Alecrim <francisco.alecrim@indt.org.br>

I did not test, but it should work. :)
> ---
>  Makefile         |    3 ++-
>  board-omap3evm.c |   10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> diff -uprN a/arch/arm/mach-omap2/board-omap3evm.c
> b/arch/arm/mach-omap2/board-omap3evm.c
> --- a/arch/arm/mach-omap2/board-omap3evm.c	2008-04-26 06:32:12.000000000 -0700
> +++ b/arch/arm/mach-omap2/board-omap3evm.c	2008-04-26 22:17:03.000000000 -0700
> @@ -27,6 +27,7 @@
>
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/board.h>
> +#include <asm/arch/hsmmc.h>
>  #include <asm/arch/common.h>
>
>  static struct omap_uart_config omap3_evm_uart_config __initdata = {
> @@ -40,6 +41,13 @@ static int __init omap3_evm_i2c_init(voi
>  	omap_register_i2c_bus(3, 400, NULL, 0);
>  	return 0;
>  }
> +
> +static struct omap_mmc_config omap3_evm_mmc_config __initdata = {
> +	.mmc [0] = {
> +		.enabled        = 1,
> +		.wire4          = 1,
> +	},
> +};
>
>  static void __init omap3_evm_init_irq(void)
>  {
> @@ -50,6 +58,7 @@ static void __init omap3_evm_init_irq(vo
>
>  static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
>  	{ OMAP_TAG_UART,	&omap3_evm_uart_config },
> +	{ OMAP_TAG_MMC,		&omap3_evm_mmc_config },
>  };
>
>  static void __init omap3_evm_init(void)
> @@ -57,6 +66,7 @@ static void __init omap3_evm_init(void)
>  	omap_board_config = omap3_evm_config;
>  	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
>  	omap_serial_init();
> +	hsmmc_init();
>  }
>
>  arch_initcall(omap3_evm_i2c_init);
> diff -uprN a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> --- a/arch/arm/mach-omap2/Makefile	2008-04-26 06:32:12.000000000 -0700
> +++ b/arch/arm/mach-omap2/Makefile	2008-04-26 22:17:03.000000000 -0700
> @@ -37,7 +37,8 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= boar
>  					   usb-musb.o \
>  					   usb-ehci.o \
>  					   board-3430sdp-flash.o
> -obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
> +obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
>  					   usb-musb.o usb-ehci.o \
>  					   hsmmc.o
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   


-- 
Francisco Keppler Silva Alecrim - INdT
Phone: +55 92 2126-1017

