From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 10:10:30 -0700
Message-ID: <20080424171030.GC16834@atomide.com>
References: <1209044786-9244-1-git-send-email-felipe.balbi@nokia.com> <1209044786-9244-2-git-send-email-felipe.balbi@nokia.com> <1209044786-9244-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:63496 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbYDXRKb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 13:10:31 -0400
Content-Disposition: inline
In-Reply-To: <1209044786-9244-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, khasim@ti.com

* Felipe Balbi <felipe.balbi@nokia.com> [080424 06:48]:
> Create a generic board-file for initializing usb
> on omap2430 and omap3 boards.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/Makefile                       |    4 +-
>  arch/arm/mach-omap2/board-2430sdp-usb.c            |   96 --------------------
>  arch/arm/mach-omap2/board-2430sdp.c                |    3 +-
>  arch/arm/mach-omap2/board-3430sdp.c                |    3 +-
>  .../mach-omap2/{board-3430sdp-usb.c => usb-musb.c} |   32 ++++---
>  include/asm-arm/arch-omap/usb-musb.h               |   35 +++++++
>  6 files changed, 61 insertions(+), 112 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/board-2430sdp-usb.c
>  rename arch/arm/mach-omap2/{board-3430sdp-usb.c => usb-musb.c} (91%)
>  create mode 100644 include/asm-arm/arch-omap/usb-musb.h
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index c37df1a..d95f8e9 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -29,11 +29,11 @@ obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o board-h4-mmc.o
>  obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
>  					   board-2430sdp-flash.o \
>  					   board-sdp-hsmmc.o \
> -					   board-2430sdp-usb.o
> +					   usb-musb.o
>  obj-$(CONFIG_MACH_OMAP_2430OSK)		+= board-2430osk.o
>  obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
>  					   board-sdp-hsmmc.o \
> -					   board-3430sdp-usb.o \
> +					   usb-musb.o \
>  					   board-3430sdp-flash.o
>  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
>  obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
> diff --git a/arch/arm/mach-omap2/board-2430sdp-usb.c b/arch/arm/mach-omap2/board-2430sdp-usb.c
> deleted file mode 100644
> index cfbf73e..0000000
> --- a/arch/arm/mach-omap2/board-2430sdp-usb.c
> +++ /dev/null
> @@ -1,96 +0,0 @@
> -/*
> - * linux/arch/arm/mach-omap2/board-2430sdp-usb.c
> - *
> - * Copyright (C) 2007 MontaVista Software, Inc. <source@mvista.com>
> - * Author: Kevin Hilman
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/delay.h>
> -#include <linux/platform_device.h>
> -#include <linux/clk.h>
> -#include <linux/usb/musb.h>
> -
> -#include <asm/arch/hardware.h>
> -#include <asm/arch/pm.h>
> -#include <asm/arch/usb.h>
> -
> -static struct resource musb_resources[] = {
> -	[0] = {
> -		.start	= OMAP243X_HS_BASE,
> -		.end	= OMAP243X_HS_BASE + SZ_8K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {	/* general IRQ */
> -		.start	= INT_243X_HS_USB_MC,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -	[2] = {	/* DMA IRQ */
> -		.start	= INT_243X_HS_USB_DMA,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -static int usbhs_ick_on;
> -
> -static int musb_set_clock(struct clk *clk, int state)
> -{
> -       if (state) {
> -               if (usbhs_ick_on > 0)
> -                       return -ENODEV;
> -
> -               omap2_block_sleep();
> -               clk_enable(clk);
> -               usbhs_ick_on = 1;
> -       } else {
> -               if (usbhs_ick_on == 0)
> -                       return -ENODEV;
> -
> -               clk_disable(clk);
> -               usbhs_ick_on = 0;
> -               omap2_allow_sleep();
> -       }
> -
> -       return 0;
> -}
> -
> -static struct musb_hdrc_platform_data musb_plat = {
> -#ifdef CONFIG_USB_MUSB_OTG
> -	.mode		= MUSB_OTG,
> -#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> -	.mode		= MUSB_HOST,
> -#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> -	.mode		= MUSB_PERIPHERAL,
> -#endif
> -	.multipoint	= 1,
> -	.clock		= "usbhs_ick",
> -	.set_clock	= musb_set_clock,
> -};
> -
> -static u64 musb_dmamask = ~(u32)0;
> -
> -static struct platform_device musb_device = {
> -	.name		= "musb_hdrc",
> -	.id		= 0,
> -	.dev = {
> -		.dma_mask		= &musb_dmamask,
> -		.coherent_dma_mask	= 0xffffffff,
> -		.platform_data		= &musb_plat,
> -	},
> -	.num_resources	= ARRAY_SIZE(musb_resources),
> -	.resource	= musb_resources,
> -};
> -
> -void __init sdp2430_usb_init(void)
> -{
> -	if (platform_device_register(&musb_device) < 0) {
> -		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
> -		return;
> -	}
> -}
> -
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index 76bbe06..623c38e 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -35,6 +35,7 @@
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/mux.h>
>  #include <asm/arch/board.h>
> +#include <asm/arch/usb-musb.h>
>  #include <asm/arch/common.h>
>  #include <asm/arch/keypad.h>
>  #include <asm/arch/gpmc.h>
> @@ -390,7 +391,7 @@ static void __init omap_2430sdp_init(void)
>  	omap_serial_init();
>  
>  	sdp2430_flash_init();
> -	sdp2430_usb_init();
> +	usb_musb_init();
>  
>  	spi_register_board_info(sdp2430_spi_board_info,
>  				ARRAY_SIZE(sdp2430_spi_board_info));
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 1eb84a6..4b400f6 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -33,6 +33,7 @@
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/mux.h>
>  #include <asm/arch/board.h>
> +#include <asm/arch/usb-musb.h>
>  #include <asm/arch/common.h>
>  #include <asm/arch/keypad.h>
>  #include <asm/arch/dma.h>
> @@ -297,7 +298,7 @@ static void __init omap_3430sdp_init(void)
>  	ads7846_dev_init();
>  	sdp3430_flash_init();
>  	omap_serial_init();
> -	sdp3430_usb_init();
> +	usb_musb_init();
>  	sdp_mmc_init();
>  }
>  
> diff --git a/arch/arm/mach-omap2/board-3430sdp-usb.c b/arch/arm/mach-omap2/usb-musb.c
> similarity index 91%
> rename from arch/arm/mach-omap2/board-3430sdp-usb.c
> rename to arch/arm/mach-omap2/usb-musb.c
> index 048f017..0bcc2c9 100644
> --- a/arch/arm/mach-omap2/board-3430sdp-usb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -1,10 +1,11 @@
>  /*
> - * linux/arch/arm/mach-omap2/board-3430sdp-usb.c
> + * linux/arch/arm/mach-omap2/usb-musb.c
>   *
>   * This file will contain the board specific details for the
>   * MENTOR USB OTG and Synopsys EHCI host controllers on OMAP3430
>   *
> - * Copyright (C) 2007 Texas Instruments
> + * Copyright (C) 2007-2008 Texas Instruments
> + * Copyright (C) 2008 Nokia Corporation
>   * Author: Vikram Pandita
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -28,8 +29,12 @@
>  #ifdef CONFIG_USB_MUSB_SOC
>  static struct resource musb_resources[] = {
>  	[0] = {
> -		.start	= OMAP34XX_HSUSB_OTG_BASE,
> -		.end	= OMAP34XX_HSUSB_OTG_BASE + SZ_8K - 1,
> +		.start	= cpu_class_is_omap3()
> +			? OMAP34XX_HSUSB_OTG_BASE
> +			: OMAP243X_HS_BASE,
> +		.end	= cpu_class_is_omap3()
> +			? OMAP34XX_HSUSB_OTG_BASE + SZ_8K - 1
> +			: OMAP243X_HS_BASE + SZ_8K -1,
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {	/* general IRQ */
> @@ -42,23 +47,23 @@ static struct resource musb_resources[] = {
>  	},
>  };
>  
> -static int hsotgusb_ick_on;
> +static int clk_on;
>  
>  static int musb_set_clock(struct clk *clk, int state)
>  {
>  	if (state) {
> -		if (hsotgusb_ick_on > 0)
> +		if (clk_on > 0)
>  			return -ENODEV;
>  
>  		omap2_block_sleep();
>  		clk_enable(clk);
> -		hsotgusb_ick_on = 1;
> +		clk_on = 1;
>  	} else {
> -		if (hsotgusb_ick_on == 0)
> +		if (clk_on == 0)
>  			return -ENODEV;
>  
>  		clk_disable(clk);
> -		hsotgusb_ick_on = 0;
> +		clk_on = 0;
>  		omap2_allow_sleep();
>  	}
>  
> @@ -74,7 +79,9 @@ static struct musb_hdrc_platform_data musb_plat = {
>  	.mode		= MUSB_PERIPHERAL,
>  #endif
>  	.multipoint	= 1,
> -	.clock		= "hsotgusb_ick",
> +	.clock		= cpu_class_is_omap3()
> +			? "hsotgusb_ick"
> +			: "usbhs_ick",
>  	.set_clock	= musb_set_clock,
>  };

Can you please check for cpu_is_omap34xx() here instead? Or
cpu_is_omap3430() if we don't have omap34xx yet.


> @@ -217,7 +224,7 @@ static void setup_ehci_io_mux(void)
>  
>  #endif /* EHCI specific data */
>  
> -void __init sdp3430_usb_init(void)
> +void __init usb_musb_init(void)
>  {
>  #ifdef CONFIG_USB_MUSB_SOC
>  	if (platform_device_register(&musb_device) < 0) {
> @@ -229,7 +236,8 @@ void __init sdp3430_usb_init(void)
>  #if     defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
>  
>  	/* Setup Pin IO MUX for EHCI */
> -	setup_ehci_io_mux();
> +	if (cpu_class_is_omap3())
> +		setup_ehci_io_mux();

Here too.


>  	if (platform_device_register(&ehci_device) < 0) {
>  		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
> diff --git a/include/asm-arm/arch-omap/usb-musb.h b/include/asm-arm/arch-omap/usb-musb.h
> new file mode 100644
> index 0000000..4f0c830
> --- /dev/null
> +++ b/include/asm-arm/arch-omap/usb-musb.h
> @@ -0,0 +1,35 @@
> +/*
> + * linux/include/asm-arm/arch-omap/usb-musb.h
> + *
> + * Hardware definitions for Mentor Graphics MUSBMHDRC.
> + *
> + * Initial creation by Felipe Balbi.
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
> +#ifndef __ASM_ARCH_OMAP_USB_MUSB_H
> +#define __ASM_ARCH_OMAP_USB_MUSB_H
> +
> +extern void usb_musb_init(void);
> +
> +#endif /* __ASM_ARCH_OMAP_USB_MUSB_H */
> +
> -- 
> 1.5.5.1.57.g5909c
> 
