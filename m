From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] ARM: OMAP: Power on EHCI, serial, camera and DVI on beagleboard-xM
Date: Mon, 20 Dec 2010 10:48:52 -0800
Message-ID: <87d3ow5lgr.fsf@deeprootsystems.com>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org>
	<1292769735-54159-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:35161 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933044Ab0LTSs5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 13:48:57 -0500
Received: by gxk19 with SMTP id 19so1799742gxk.11
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 10:48:57 -0800 (PST)
In-Reply-To: <1292769735-54159-1-git-send-email-koen@dominion.thruhere.net>
	(Koen Kooi's message of "Sun, 19 Dec 2010 15:42:15 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen.kooi@gmail.com>
Cc: linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Koen Kooi <koen@beagleboard.org>

Koen Kooi <koen.kooi@gmail.com> writes:

> Signed-off-by: Koen Kooi <koen@beagleboard.org>

-ENO_DESCRIPTIVE_CHANGELOG

Also, please Cc linux-arm-kernel for patches intended for upstream.

Thanks,

Kevin

> ---
>
> Changes since v1:
> 	* Reenable the PMU stat LED
>
>  arch/arm/mach-omap2/board-omap3beagle.c |   26 ++++++++++++++++++++++++--
>  1 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index f1a8ede..4756ac7 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -297,13 +297,35 @@ static int beagle_twl_gpio_setup(struct device *dev,
>  	gpio_request(gpio + 1, "EHCI_nOC");
>  	gpio_direction_input(gpio + 1);
>  
> -	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
> +	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
> +	 * high / others active low) */
>  	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
> -	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
> +		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
> +	else
> +		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> +
> +	/* DVI reset GPIO is different between revisions */
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
> +		beagle_dvi_device.reset_gpio = 129;
> +	else
> +		beagle_dvi_device.reset_gpio = 170;
> +
> +	 /* Power on DVI, Serial and PWR led */
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +		gpio_request(gpio + 1, "nDVI_PWR_EN");
> +		gpio_direction_output(gpio + 1, 0);
> +	}
>  
>  	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
>  	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
>  
> +	/* Power on camera interface on P7/P8 or DVI on A2 and beyond */
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +		gpio_request(gpio + 2, "CAM_EN");
> +		gpio_direction_output(gpio + 2, 1);
> +	}
> +
>  	return 0;
>  }
