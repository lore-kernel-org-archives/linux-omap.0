From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v4 1/3] omap3: beaglexm: fix EHCI power up GPIO dir
Date: Mon, 10 Jan 2011 14:44:19 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1101101442460.18906@esdhcp041196.research.nokia.com>
References: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes> <1294441282-17986-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:43421 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246Ab1AJMp6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jan 2011 07:45:58 -0500
In-Reply-To: <1294441282-17986-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>

Hi,

On Fri, 7 Jan 2011, Nishanth Menon wrote:
> From: Koen Kooi <koen@beagleboard.org>
>
> EHCI enable power pin is inverted (active high) in comparison
> to vanilla beagle which is active low. Handle this case conditionally.
>
> Without this fix, Beagle XM 4 port EHCI will not function and no
> networking will be available
>
> [nm@ti.com: split up, added descriptive changelogs]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Koen Kooi <koen@beagleboard.org>
> ---
> arch/arm/mach-omap2/board-omap3beagle.c |    9 ++++++++-
> 1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 6c12760..1b5aa7a 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -297,9 +297,16 @@ static int beagle_twl_gpio_setup(struct device *dev,
> 	gpio_request(gpio + 1, "EHCI_nOC");
> 	gpio_direction_input(gpio + 1);
>
> -	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
> +	/*
> +	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
> +	 * high / others active low)
> +	 */
> 	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
> 	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);

This call should be deleted.

> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
> +		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
> +	else
> +		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
>
> 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
> 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
> -- 
> 1.6.3.3
>
