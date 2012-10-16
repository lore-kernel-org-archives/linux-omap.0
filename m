From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Tue, 16 Oct 2012 11:10:38 -0700
Message-ID: <20121016181038.GC15569@atomide.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com>
 <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:14150 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755367Ab2JPSKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 14:10:42 -0400
Content-Disposition: inline
In-Reply-To: <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>

* Ohad Ben-Cohen <ohad@wizery.com> [121014 11:32]:
> On Fri, Oct 12, 2012 at 6:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> Error setting wl12xx data: -38
> ..
> > Ohad, can you please take a look?
> 
> Sure, -38 is -ENOSYS which is returned when the wl12xx driver isn't configured.
> 
> This isn't an error (it's a user decision, and it shouldn't elicit any
> error) and the patch below (also attached) should make it go away on:
> 
> From 374f145568585c8d6a8d5e4b8b5d3e6baedd2f39 Mon Sep 17 00:00:00 2001
> From: Ohad Ben-Cohen <ohad@wizery.com>
> Date: Sun, 14 Oct 2012 20:16:01 +0200
> Subject: [PATCH] ARM: OMAP: don't print any error when wl12xx isn't
>  configured
> 
> Stop intimidating users with scary wlan error messages in case wl12xx
> support wasn't even built.
> 
> In addition, when wl12xx_set_platform_data() fails, don't bother
> registering wl12xx's fixed regulator device (on the relevant
> boards).
> 
> While we're at it, extract the wlan init code to a dedicated function to
> make (the relevant boards') init code look a bit nicer.
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks applying into omap-for-v3.7-rc1/fixes-part2.

Regards,

Tony

> ---
>  arch/arm/mach-davinci/board-da850-evm.c      |  7 ++++++-
>  arch/arm/mach-omap2/board-4430sdp.c          | 13 ++++++++++--
>  arch/arm/mach-omap2/board-omap3evm.c         | 11 +++++++++-
>  arch/arm/mach-omap2/board-omap3pandora.c     |  9 ++++++++-
>  arch/arm/mach-omap2/board-omap4panda.c       | 30 ++++++++++++++++++++++------
>  arch/arm/mach-omap2/board-zoom-peripherals.c | 20 ++++++++++++++++---
>  6 files changed, 76 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c
> b/arch/arm/mach-davinci/board-da850-evm.c
> index 32ee3f8..1b19415 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1404,8 +1404,13 @@ static __init int da850_wl12xx_init(void)
>  	da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
> 
>  	ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
> +	/* bail out silently in case wl12xx isn't configured */
> +	if (ret == -ENOSYS)
> +		goto free_wlan_irq;
> +
> +	/* bail out verbosely on any other error */
>  	if (ret) {
> -		pr_err("Could not set wl12xx data: %d\n", ret);
> +		pr_err("error setting wl12xx data: %d\n", ret);
>  		goto free_wlan_irq;
>  	}
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c
> b/arch/arm/mach-omap2/board-4430sdp.c
> index 3669c12..d1dd81a 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -826,9 +826,18 @@ static void __init omap4_sdp4430_wifi_init(void)
> 
>  	omap4_sdp4430_wifi_mux_init();
>  	omap4_sdp4430_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
> +
>  	ret = wl12xx_set_platform_data(&omap4_sdp4430_wlan_data);
> -	if (ret)
> -		pr_err("Error setting wl12xx data: %d\n", ret);
> +	/* bail out silently in case wl12xx isn't configured */
> +	if (ret == -ENOSYS)
> +		return;
> +
> +	/* bail out verbosely on any other error */
> +	if (ret) {
> +		pr_err("error setting wl12xx data: %d\n", ret);
> +		return;
> +	}
> +
>  	ret = platform_device_register(&omap_vwlan_device);
>  	if (ret)
>  		pr_err("Error registering wl12xx device: %d\n", ret);
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c
> b/arch/arm/mach-omap2/board-omap3evm.c
> index b9b776b..7f72e44 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -637,9 +637,18 @@ static void __init omap3_evm_wl12xx_init(void)
> 
>  	/* WL12xx WLAN Init */
>  	omap3evm_wlan_data.irq = gpio_to_irq(OMAP3EVM_WLAN_IRQ_GPIO);
> +
>  	ret = wl12xx_set_platform_data(&omap3evm_wlan_data);
> -	if (ret)
> +	/* bail out silently in case wl12xx isn't configured */
> +	if (ret == -ENOSYS)
> +		return;
> +
> +	/* bail out verbosely on any other error */
> +	if (ret) {
>  		pr_err("error setting wl12xx data: %d\n", ret);
> +		return;
> +	}
> +
>  	ret = platform_device_register(&omap3evm_wlan_regulator);
>  	if (ret)
>  		pr_err("error registering wl12xx device: %d\n", ret);
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c
> b/arch/arm/mach-omap2/board-omap3pandora.c
> index 00a1f4a..bbc4001 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -549,8 +549,15 @@ static void __init pandora_wl1251_init(void)
> 
>  	pandora_wl1251_pdata.use_eeprom = true;
>  	ret = wl12xx_set_platform_data(&pandora_wl1251_pdata);
> -	if (ret < 0)
> +	/* bail out silently in case wl12xx isn't configured */
> +	if (ret == -ENOSYS)
> +		goto fail_irq;
> +
> +	/* bail out verbosely on any other error */
> +	if (ret) {
> +		pr_err("error setting wl12xx data: %d\n", ret);
>  		goto fail_irq;
> +	}
> 
>  	return;
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
> b/arch/arm/mach-omap2/board-omap4panda.c
> index bfcd397..cc5cdd6 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -486,24 +486,42 @@ static void omap4_panda_init_rev(void)
>  	}
>  }
> 
> +static void __init omap4_panda_wlan_init(void)
> +{
> +	int ret;
> +
> +	omap_panda_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
> +
> +	ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
> +
> +	/* bail out silently in case wl12xx isn't configured */
> +	if (ret == -ENOSYS)
> +		return;
> +
> +	/* bail out verbosely on any other error */
> +	if (ret) {
> +		pr_err("error setting wl12xx data: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = platform_device_register(&omap_vwlan_device);
> +	if (ret)
> +		pr_err("error registering wl12xx's fixed regulator: %d\n", ret);
> +}
> +
>  static void __init omap4_panda_init(void)
>  {
>  	int package = OMAP_PACKAGE_CBS;
> -	int ret;
> 
>  	if (omap_rev() == OMAP4430_REV_ES1_0)
>  		package = OMAP_PACKAGE_CBL;
>  	omap4_mux_init(board_mux, NULL, package);
> 
> -	omap_panda_wlan_data.irq = gpio_to_irq(GPIO_WIFI_IRQ);
> -	ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
> -	if (ret)
> -		pr_err("error setting wl12xx data: %d\n", ret);
> +	omap4_panda_wlan_init();
> 
>  	omap4_panda_init_rev();
>  	omap4_panda_i2c_init();
>  	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
> -	platform_device_register(&omap_vwlan_device);
>  	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
>  	omap4_twl6030_hsmmc_init(mmc);
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index c166fe1..3506ed2 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -286,19 +286,33 @@ static void enable_board_wakeup_source(void)
>  		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
>  }
> 
> -void __init zoom_peripherals_init(void)
> +static void __init zoom_wlan_init(void)
>  {
>  	int ret;
> 
>  	omap_zoom_wlan_data.irq = gpio_to_irq(OMAP_ZOOM_WLAN_IRQ_GPIO);
> +
>  	ret = wl12xx_set_platform_data(&omap_zoom_wlan_data);
> +	/* bail out silently in case wl12xx isn't configured */
> +	if (ret == -ENOSYS)
> +		return;
> 
> -	if (ret)
> +	/* bail out verbosely on any other error */
> +	if (ret) {
>  		pr_err("error setting wl12xx data: %d\n", ret);
> +		return;
> +	}
> 
> +	ret = platform_device_register(&omap_vwlan_device);
> +	if (ret)
> +		pr_err("error registering wl12xx's fixed regulator: %d\n", ret);
> +}
> +
> +void __init zoom_peripherals_init(void)
> +{
>  	omap_hsmmc_init(mmc);
> +	zoom_wlan_init();
>  	omap_i2c_init();
> -	platform_device_register(&omap_vwlan_device);
>  	usb_musb_init(NULL);
>  	enable_board_wakeup_source();
>  	omap_serial_init();
> -- 
> 1.7.10.rc3.1067.gb129051


