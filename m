From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] arm: omap: musb: pass power to usb_musb_init
Date: Tue, 29 Dec 2009 11:51:13 -0800
Message-ID: <20091229195112.GF3512@atomide.com>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
 <1261998590-6639-7-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57753 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbZL2TvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 14:51:15 -0500
Content-Disposition: inline
In-Reply-To: <1261998590-6639-7-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [091228 03:10]:
> each board might have a different charge pump and
> thus able to source more or less current on vbus
> so let power be easily configurable.

In order to justify merging this as a fix, can you please update
the subject and description to describe that this fixes the
the power value?

Regards,

Tony
 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
>  arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
>  arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
>  arch/arm/mach-omap2/board-igep0020.c         |    2 +-
>  arch/arm/mach-omap2/board-ldp.c              |    2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
>  arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
>  arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
>  arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
>  arch/arm/mach-omap2/board-overo.c            |    2 +-
>  arch/arm/mach-omap2/board-rx51.c             |    2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
>  arch/arm/mach-omap2/usb-musb.c               |   12 ++++--------
>  arch/arm/plat-omap/include/plat/usb.h        |    2 +-
>  14 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index e508904..d3857d6 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -203,7 +203,7 @@ static void __init omap_2430sdp_init(void)
>  	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
>  	omap_serial_init();
>  	twl4030_mmc_init(mmc);
> -	usb_musb_init();
> +	usb_musb_init(100);
>  	board_smc91x_init();
>  
>  	/* Turn off secondary LCD backlight */
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index c90b0d0..1d52fd1 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -664,7 +664,7 @@ static void __init omap_3430sdp_init(void)
>  				ARRAY_SIZE(sdp3430_spi_board_info));
>  	ads7846_dev_init();
>  	omap_serial_init();
> -	usb_musb_init();
> +	usb_musb_init(100);
>  	board_smc91x_init();
>  	sdp3430_display_init();
>  	enable_board_wakeup_source();
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 2626a9f..56922f4 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -585,7 +585,7 @@ static void __init cm_t35_init(void)
>  	cm_t35_init_ethernet();
>  	cm_t35_init_led();
>  
> -	usb_musb_init();
> +	usb_musb_init(100);
>  }
>  
>  MACHINE_START(CM_T35, "Compulab CM-T35")
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 117b8fd..16be1d5 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -216,7 +216,7 @@ static void __init igep2_init(void)
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	igep2_i2c_init();
>  	omap_serial_init();
> -	usb_musb_init();
> +	usb_musb_init(100);
>  
>  	igep2_init_smsc911x();
>  
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index 995d4a2..ca2acd2 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -394,7 +394,7 @@ static void __init omap_ldp_init(void)
>  				ARRAY_SIZE(ldp_spi_board_info));
>  	ads7846_dev_init();
>  	omap_serial_init();
> -	usb_musb_init();
> +	usb_musb_init(100);
>  
>  	twl4030_mmc_init(mmc);
>  	/* link regulators to MMC adapters */
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 231cb4e..52f65e6 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -443,7 +443,7 @@ static void __init omap3_beagle_init(void)
>  	/* REVISIT leave DVI powered down until it's needed ... */
>  	gpio_direction_output(170, true);
>  
> -	usb_musb_init();
> +	usb_musb_init(100);
>  	usb_ehci_init(&ehci_pdata);
>  	omap3beagle_flash_init();
>  
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 34de178..c5fd85d 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -469,7 +469,7 @@ static void __init omap3_evm_init(void)
>  		omap_mux_init_gpio(135, OMAP_PIN_OUTPUT);
>  		ehci_pdata.reset_gpio_port[1] = 135;
>  	}
> -	usb_musb_init();
> +	usb_musb_init(100);
>  	usb_ehci_init(&ehci_pdata);
>  	ads7846_dev_init();
>  	omap3evm_init_smsc911x();
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> index ef17cf1..b0cdf77 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -413,7 +413,7 @@ static void __init omap3pandora_init(void)
>  	omap3pandora_ads7846_init();
>  	usb_ehci_init(&ehci_pdata);
>  	pandora_keys_gpio_init();
> -	usb_musb_init();
> +	usb_musb_init(100);
>  
>  	/* Ensure SDRC pins are mux'd for self-refresh */
>  	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
> diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
> index fe3d22c..f7f7670 100644
> --- a/arch/arm/mach-omap2/board-omap3touchbook.c
> +++ b/arch/arm/mach-omap2/board-omap3touchbook.c
> @@ -545,7 +545,7 @@ static void __init omap3_touchbook_init(void)
>  	spi_register_board_info(omap3_ads7846_spi_board_info,
>  				ARRAY_SIZE(omap3_ads7846_spi_board_info));
>  	omap3_ads7846_init();
> -	usb_musb_init();
> +	usb_musb_init(100);
>  	usb_ehci_init(&ehci_pdata);
>  	omap3touchbook_flash_init();
>  
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index d192dd9..4e07a08 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -420,7 +420,7 @@ static void __init overo_init(void)
>  	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
>  	omap_serial_init();
>  	overo_flash_init();
> -	usb_musb_init();
> +	usb_musb_init(100);
>  	usb_ehci_init(&ehci_pdata);
>  	overo_ads7846_init();
>  	overo_init_smsc911x();
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index 67bb347..0e19316 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -82,7 +82,7 @@ static void __init rx51_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap_serial_init();
> -	usb_musb_init();
> +	usb_musb_init(0);
>  	rx51_peripherals_init();
>  
>  	/* Ensure SDRC pins are mux'd for self-refresh */
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 8dd277c..abb5fc2 100755
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -267,5 +267,5 @@ void __init zoom_peripherals_init(void)
>  {
>  	omap_i2c_init();
>  	omap_serial_init();
> -	usb_musb_init();
> +	usb_musb_init(100);
>  }
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index d12e311..6c2895e 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -64,12 +64,7 @@ static struct musb_hdrc_platform_data musb_plat = {
>  #endif
>  	/* .clock is set dynamically */
>  	.config		= &musb_config,
> -
> -	/* REVISIT charge pump on TWL4030 can supply up to
> -	 * 100 mA ... but this value is board-specific, like
> -	 * "mode", and should be passed to usb_musb_init().
> -	 */
> -	.power		= 50,			/* up to 100 mA */
> +	/* .power	= DYNAMIC, */
>  };
>  
>  static u64 musb_dmamask = DMA_BIT_MASK(32);
> @@ -86,7 +81,7 @@ static struct platform_device musb_device = {
>  	.resource	= musb_resources,
>  };
>  
> -void __init usb_musb_init(void)
> +void __init usb_musb_init(unsigned power)
>  {
>  	if (cpu_is_omap243x())
>  		musb_resources[0].start = OMAP243X_HS_BASE;
> @@ -99,6 +94,7 @@ void __init usb_musb_init(void)
>  	 * musb_core.c have been converted to use use clkdev.
>  	 */
>  	musb_plat.clock = "ick";
> +	musb_plat.power = power >> 1;
>  
>  	if (platform_device_register(&musb_device) < 0) {
>  		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
> @@ -107,7 +103,7 @@ void __init usb_musb_init(void)
>  }
>  
>  #else
> -void __init usb_musb_init(void)
> +void __init usb_musb_init(unsigned power)
>  {
>  }
>  #endif /* CONFIG_USB_MUSB_SOC */
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
> index 33a500e..1b779a1 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -42,7 +42,7 @@ struct ehci_hcd_omap_platform_data {
>  #define UDC_BASE			OMAP2_UDC_BASE
>  #define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
>  
> -extern void usb_musb_init(void);
> +extern void usb_musb_init(unsigned power);
>  
>  extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
>  
> -- 
> 1.6.6.rc0
> 
