From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] arm: omap: musb: pass board mode to usb_musb_init
Date: Tue, 29 Dec 2009 11:51:57 -0800
Message-ID: <20091229195157.GG3512@atomide.com>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
 <1261998590-6639-8-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50846 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbZL2TwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 14:52:00 -0500
Content-Disposition: inline
In-Reply-To: <1261998590-6639-8-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [091228 03:10]:
> each board will have a different mode which is peculiar
> to that board.

The subject and description for this too should be updated
to say it fixes the mode.

Regards,

Tony
 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c          |    3 ++-
>  arch/arm/mach-omap2/board-3430sdp.c          |    3 ++-
>  arch/arm/mach-omap2/board-cm-t35.c           |    3 ++-
>  arch/arm/mach-omap2/board-igep0020.c         |    3 ++-
>  arch/arm/mach-omap2/board-ldp.c              |    3 ++-
>  arch/arm/mach-omap2/board-omap3beagle.c      |    3 ++-
>  arch/arm/mach-omap2/board-omap3evm.c         |    3 ++-
>  arch/arm/mach-omap2/board-omap3pandora.c     |    3 ++-
>  arch/arm/mach-omap2/board-omap3touchbook.c   |    3 ++-
>  arch/arm/mach-omap2/board-overo.c            |    3 ++-
>  arch/arm/mach-omap2/board-rx51.c             |    3 ++-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    3 ++-
>  arch/arm/mach-omap2/usb-musb.c               |   13 ++++---------
>  arch/arm/plat-omap/include/plat/usb.h        |    3 ++-
>  14 files changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index d3857d6..45d3197 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -23,6 +23,7 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/usb/musb.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -203,7 +204,7 @@ static void __init omap_2430sdp_init(void)
>  	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
>  	omap_serial_init();
>  	twl4030_mmc_init(mmc);
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  	board_smc91x_init();
>  
>  	/* Turn off secondary LCD backlight */
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 1d52fd1..37e7328 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -24,6 +24,7 @@
>  #include <linux/regulator/machine.h>
>  #include <linux/io.h>
>  #include <linux/gpio.h>
> +#include <linux/usb/musb.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -664,7 +665,7 @@ static void __init omap_3430sdp_init(void)
>  				ARRAY_SIZE(sdp3430_spi_board_info));
>  	ads7846_dev_init();
>  	omap_serial_init();
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  	board_smc91x_init();
>  	sdp3430_display_init();
>  	enable_board_wakeup_source();
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 56922f4..9d5db6b 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -27,6 +27,7 @@
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/usb/musb.h>
>  
>  #include <linux/i2c/at24.h>
>  #include <linux/i2c/twl.h>
> @@ -585,7 +586,7 @@ static void __init cm_t35_init(void)
>  	cm_t35_init_ethernet();
>  	cm_t35_init_led();
>  
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  }
>  
>  MACHINE_START(CM_T35, "Compulab CM-T35")
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 16be1d5..6fc0608 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
> +#include <linux/usb/musb.h>
>  
>  #include <linux/regulator/machine.h>
>  #include <linux/i2c/twl.h>
> @@ -216,7 +217,7 @@ static void __init igep2_init(void)
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	igep2_i2c_init();
>  	omap_serial_init();
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  
>  	igep2_init_smsc911x();
>  
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index ca2acd2..7e8c8a8 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -27,6 +27,7 @@
>  #include <linux/i2c/twl.h>
>  #include <linux/io.h>
>  #include <linux/smsc911x.h>
> +#include <linux/usb/musb.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -394,7 +395,7 @@ static void __init omap_ldp_init(void)
>  				ARRAY_SIZE(ldp_spi_board_info));
>  	ads7846_dev_init();
>  	omap_serial_init();
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  
>  	twl4030_mmc_init(mmc);
>  	/* link regulators to MMC adapters */
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 52f65e6..17f6381 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -23,6 +23,7 @@
>  #include <linux/gpio.h>
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
> +#include <linux/usb/musb.h>
>  
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -443,7 +444,7 @@ static void __init omap3_beagle_init(void)
>  	/* REVISIT leave DVI powered down until it's needed ... */
>  	gpio_direction_output(170, true);
>  
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  	usb_ehci_init(&ehci_pdata);
>  	omap3beagle_flash_init();
>  
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index c5fd85d..1160004 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -23,6 +23,7 @@
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/leds.h>
>  #include <linux/interrupt.h>
> +#include <linux/usb/musb.h>
>  
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> @@ -469,7 +470,7 @@ static void __init omap3_evm_init(void)
>  		omap_mux_init_gpio(135, OMAP_PIN_OUTPUT);
>  		ehci_pdata.reset_gpio_port[1] = 135;
>  	}
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  	usb_ehci_init(&ehci_pdata);
>  	ads7846_dev_init();
>  	omap3evm_init_smsc911x();
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> index b0cdf77..191b75c 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -29,6 +29,7 @@
>  #include <linux/input.h>
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/gpio_keys.h>
> +#include <linux/usb/musb.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -413,7 +414,7 @@ static void __init omap3pandora_init(void)
>  	omap3pandora_ads7846_init();
>  	usb_ehci_init(&ehci_pdata);
>  	pandora_keys_gpio_init();
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  
>  	/* Ensure SDRC pins are mux'd for self-refresh */
>  	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
> diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
> index f7f7670..287b914 100644
> --- a/arch/arm/mach-omap2/board-omap3touchbook.c
> +++ b/arch/arm/mach-omap2/board-omap3touchbook.c
> @@ -23,6 +23,7 @@
>  #include <linux/gpio.h>
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
> +#include <linux/usb/musb.h>
>  
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -545,7 +546,7 @@ static void __init omap3_touchbook_init(void)
>  	spi_register_board_info(omap3_ads7846_spi_board_info,
>  				ARRAY_SIZE(omap3_ads7846_spi_board_info));
>  	omap3_ads7846_init();
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  	usb_ehci_init(&ehci_pdata);
>  	omap3touchbook_flash_init();
>  
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index 4e07a08..df04029 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -28,6 +28,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/usb/musb.h>
>  
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/nand.h>
> @@ -420,7 +421,7 @@ static void __init overo_init(void)
>  	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
>  	omap_serial_init();
>  	overo_flash_init();
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  	usb_ehci_init(&ehci_pdata);
>  	overo_ads7846_init();
>  	overo_init_smsc911x();
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index 0e19316..2480870 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -16,6 +16,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/gpio.h>
> +#include <linux/usb/musb.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -82,7 +83,7 @@ static void __init rx51_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap_serial_init();
> -	usb_musb_init(0);
> +	usb_musb_init(MUSB_PERIPHERAL, 0);
>  	rx51_peripherals_init();
>  
>  	/* Ensure SDRC pins are mux'd for self-refresh */
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index abb5fc2..f157733 100755
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -16,6 +16,7 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/usb/musb.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -267,5 +268,5 @@ void __init zoom_peripherals_init(void)
>  {
>  	omap_i2c_init();
>  	omap_serial_init();
> -	usb_musb_init(100);
> +	usb_musb_init(MUSB_OTG, 100);
>  }
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 6c2895e..e0050c5 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -55,16 +55,10 @@ static struct musb_hdrc_config musb_config = {
>  };
>  
>  static struct musb_hdrc_platform_data musb_plat = {
> -#ifdef CONFIG_USB_MUSB_OTG
> -	.mode		= MUSB_OTG,
> -#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> -	.mode		= MUSB_HOST,
> -#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> -	.mode		= MUSB_PERIPHERAL,
> -#endif
>  	/* .clock is set dynamically */
>  	.config		= &musb_config,
>  	/* .power	= DYNAMIC, */
> +	/* .mode	= DYNAMIC, */
>  };
>  
>  static u64 musb_dmamask = DMA_BIT_MASK(32);
> @@ -81,7 +75,7 @@ static struct platform_device musb_device = {
>  	.resource	= musb_resources,
>  };
>  
> -void __init usb_musb_init(unsigned power)
> +void __init usb_musb_init(enum musb_mode mode, unsigned power)
>  {
>  	if (cpu_is_omap243x())
>  		musb_resources[0].start = OMAP243X_HS_BASE;
> @@ -95,6 +89,7 @@ void __init usb_musb_init(unsigned power)
>  	 */
>  	musb_plat.clock = "ick";
>  	musb_plat.power = power >> 1;
> +	musb_plat.mode = mode;
>  
>  	if (platform_device_register(&musb_device) < 0) {
>  		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
> @@ -103,7 +98,7 @@ void __init usb_musb_init(unsigned power)
>  }
>  
>  #else
> -void __init usb_musb_init(unsigned power)
> +void __init usb_musb_init(enum musb_mode mode, unsigned power)
>  {
>  }
>  #endif /* CONFIG_USB_MUSB_SOC */
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
> index 1b779a1..1e03105 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -3,6 +3,7 @@
>  #ifndef	__ASM_ARCH_OMAP_USB_H
>  #define	__ASM_ARCH_OMAP_USB_H
>  
> +#include <linux/usb/musb.h>
>  #include <plat/board.h>
>  
>  #define OMAP3_HS_USB_PORTS	3
> @@ -42,7 +43,7 @@ struct ehci_hcd_omap_platform_data {
>  #define UDC_BASE			OMAP2_UDC_BASE
>  #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
>  
> -extern void usb_musb_init(unsigned power);
> +extern void usb_musb_init(enum musb_mode mode, unsigned power);
>  
>  extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
>  
> -- 
> 1.6.6.rc0
> 
