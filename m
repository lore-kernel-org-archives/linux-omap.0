From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: MMC: Generalize mmc init routine
Date: Thu, 24 Apr 2008 16:07:16 -0700
Message-ID: <20080424230715.GW16834@atomide.com>
References: <1209075462-14296-1-git-send-email-felipe.balbi@nokia.com> <1209075462-14296-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57373 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbYDXXHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 19:07:18 -0400
Content-Disposition: inline
In-Reply-To: <1209075462-14296-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080424 15:32]:
> Make sdp_mmc_init routine more generic by moving files
> around and changing function names.

Great, seems to work on 3430sdp, pushing.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/Makefile                       |    6 ++--
>  arch/arm/mach-omap2/board-2430sdp.c                |    3 +-
>  arch/arm/mach-omap2/board-3430sdp.c                |    3 +-
>  arch/arm/mach-omap2/board-omap3beagle.c            |    3 +-
>  arch/arm/mach-omap2/{board-sdp-hsmmc.c => hsmmc.c} |   35 ++++++++++---------
>  include/asm-arm/arch-omap/hsmmc.h                  |   35 ++++++++++++++++++++
>  6 files changed, 62 insertions(+), 23 deletions(-)
>  rename arch/arm/mach-omap2/{board-sdp-hsmmc.c => hsmmc.c} (88%)
>  create mode 100644 include/asm-arm/arch-omap/hsmmc.h
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 725dae5..512b446 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -28,19 +28,19 @@ obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
>  obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o board-h4-mmc.o
>  obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
>  					   board-2430sdp-flash.o \
> -					   board-sdp-hsmmc.o \
> +					   hsmmc.o \
>  					   usb-musb.o \
>  					   usb-ehci.o
>  obj-$(CONFIG_MACH_OMAP_2430OSK)		+= board-2430osk.o
>  obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
> -					   board-sdp-hsmmc.o \
> +					   hsmmc.o \
>  					   usb-musb.o \
>  					   usb-ehci.o \
>  					   board-3430sdp-flash.o
>  obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
>  obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
>  					   usb-musb.o usb-ehci.o \
> -					   board-sdp-hsmmc.o
> +					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
>  					   board-apollon-mmc.o	\
>  					   board-apollon-keys.o
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index 2018b5d..5ea0a6b 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -37,6 +37,7 @@
>  #include <asm/arch/board.h>
>  #include <asm/arch/usb-musb.h>
>  #include <asm/arch/usb-ehci.h>
> +#include <asm/arch/hsmmc.h>
>  #include <asm/arch/common.h>
>  #include <asm/arch/keypad.h>
>  #include <asm/arch/gpmc.h>
> @@ -398,7 +399,7 @@ static void __init omap_2430sdp_init(void)
>  	spi_register_board_info(sdp2430_spi_board_info,
>  				ARRAY_SIZE(sdp2430_spi_board_info));
>  	ads7846_dev_init();
> -	sdp_mmc_init();
> +	hsmmc_init();
>  
>  	/* turn off secondary LCD backlight */
>  	omap_set_gpio_direction(SECONDARY_LCD_GPIO, 0);
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 060c976..f6cd08b 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -35,6 +35,7 @@
>  #include <asm/arch/board.h>
>  #include <asm/arch/usb-musb.h>
>  #include <asm/arch/usb-ehci.h>
> +#include <asm/arch/hsmmc.h>
>  #include <asm/arch/common.h>
>  #include <asm/arch/keypad.h>
>  #include <asm/arch/dma.h>
> @@ -301,7 +302,7 @@ static void __init omap_3430sdp_init(void)
>  	omap_serial_init();
>  	usb_musb_init();
>  	usb_ehci_init();
> -	sdp_mmc_init();
> +	hsmmc_init();
>  }
>  
>  static void __init omap_3430sdp_map_io(void)
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index ad5ad2e..626f004 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -29,6 +29,7 @@
>  #include <asm/arch/board.h>
>  #include <asm/arch/usb-musb.h>
>  #include <asm/arch/usb-ehci.h>
> +#include <asm/arch/hsmmc.h>
>  #include <asm/arch/common.h>
>  
>  static struct omap_uart_config omap3_beagle_uart_config __initdata = {
> @@ -67,7 +68,7 @@ static void __init omap3_beagle_init(void)
>  	omap_board_config = omap3_beagle_config;
>  	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>  	omap_serial_init();
> -	sdp_mmc_init();
> +	hsmmc_init();
>  	usb_musb_init();
>  	usb_ehci_init();
>  }
> diff --git a/arch/arm/mach-omap2/board-sdp-hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> similarity index 88%
> rename from arch/arm/mach-omap2/board-sdp-hsmmc.c
> rename to arch/arm/mach-omap2/hsmmc.c
> index fcf5e86..e16d6c0 100644
> --- a/arch/arm/mach-omap2/board-sdp-hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -1,7 +1,8 @@
>  /*
>   * linux/arch/arm/mach-omap2/board-sdp-hsmmc.c
>   *
> - * Copyright (C) 2007 Texas Instruments
> + * Copyright (C) 2007-2008 Texas Instruments
> + * Copyright (C) 2008 Nokia Corporation
>   * Author: Texas Instruments
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -45,7 +46,7 @@
>  #define OMAP2_CONTROL_PBIAS_PWRDNZ	(1 << 1)
>  #define OMAP2_CONTROL_PBIAS_SCTRL	(1 << 2)
>  
> -static int sdp_mmc_card_detect(int irq)
> +static int hsmmc_card_detect(int irq)
>  {
>  	return twl4030_get_gpio_datain(irq - TWL4030_GPIO_IRQ_BASE);
>  }
> @@ -53,7 +54,7 @@ static int sdp_mmc_card_detect(int irq)
>  /*
>   * MMC Slot Initialization.
>   */
> -static int sdp_mmc_late_init(struct device *dev)
> +static int hsmmc_late_init(struct device *dev)
>  {
>  	int ret = 0;
>  
> @@ -85,7 +86,7 @@ err:
>  	return ret;
>  }
>  
> -static void sdp_mmc_cleanup(struct device *dev)
> +static void hsmmc_cleanup(struct device *dev)
>  {
>  	int ret = 0;
>  
> @@ -129,7 +130,7 @@ err:
>  	return ret;
>  }
>  
> -static int sdp_mmc_suspend(struct device *dev, int slot)
> +static int hsmmc_suspend(struct device *dev, int slot)
>  {
>  	int ret = 0;
>  
> @@ -139,7 +140,7 @@ static int sdp_mmc_suspend(struct device *dev, int slot)
>  	return ret;
>  }
>  
> -static int sdp_mmc_resume(struct device *dev, int slot)
> +static int hsmmc_resume(struct device *dev, int slot)
>  {
>  	int ret = 0;
>  
> @@ -151,7 +152,7 @@ static int sdp_mmc_resume(struct device *dev, int slot)
>  
>  #endif
>  
> -static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
> +static int hsmmc_set_power(struct device *dev, int slot, int power_on,
>  				int vdd)
>  {
>  	u32 vdd_sel = 0, devconf = 0, reg = 0;
> @@ -254,17 +255,17 @@ err:
>  	return 1;
>  }
>  
> -static struct omap_mmc_platform_data sdp_mmc_data = {
> +static struct omap_mmc_platform_data hsmmc_data = {
>  	.nr_slots			= 1,
>  	.switch_slot			= NULL,
> -	.init				= sdp_mmc_late_init,
> -	.cleanup			= sdp_mmc_cleanup,
> +	.init				= hsmmc_late_init,
> +	.cleanup			= hsmmc_cleanup,
>  #ifdef CONFIG_PM
> -	.suspend			= sdp_mmc_suspend,
> -	.resume				= sdp_mmc_resume,
> +	.suspend			= hsmmc_suspend,
> +	.resume				= hsmmc_resume,
>  #endif
>  	.slots[0] = {
> -		.set_power		= sdp_mmc_set_power,
> +		.set_power		= hsmmc_set_power,
>  		.set_bus_mode		= NULL,
>  		.get_ro			= NULL,
>  		.get_cover_state	= NULL,
> @@ -273,18 +274,18 @@ static struct omap_mmc_platform_data sdp_mmc_data = {
>  		.name			= "first slot",
>  
>  		.card_detect_irq        = TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ),
> -		.card_detect            = sdp_mmc_card_detect,
> +		.card_detect            = hsmmc_card_detect,
>  	},
>  };
>  
> -void __init sdp_mmc_init(void)
> +void __init hsmmc_init(void)
>  {
> -	omap_set_mmc_info(1, &sdp_mmc_data);
> +	omap_set_mmc_info(1, &hsmmc_data);
>  }
>  
>  #else
>  
> -void __init sdp_mmc_init(void)
> +void __init hsmmc_init(void)
>  {
>  
>  }
> diff --git a/include/asm-arm/arch-omap/hsmmc.h b/include/asm-arm/arch-omap/hsmmc.h
> new file mode 100644
> index 0000000..587e8ab
> --- /dev/null
> +++ b/include/asm-arm/arch-omap/hsmmc.h
> @@ -0,0 +1,35 @@
> +/*
> + * include/asm-arm/arch-omap/hsmmc.h
> + *
> + * Hardware definitions for SD/MMC Controller on OMAP243x and OMAP34xx
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
> +#ifndef __ASM_ARCH_OMAP_HSMMC_H
> +#define __ASM_ARCH_OMAP_HSMMC_H
> +
> +extern void hsmmc_init(void);
> +
> +#endif /* __ASM_ARCH_OMAP_HSMMC_H */
> +
> -- 
> 1.5.4.3.447.gc95b3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
