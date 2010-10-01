From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 2/6] omap3: fix and improve the LED handling on IGEP
 v2 board.
Date: Fri, 1 Oct 2010 13:02:55 -0700
Message-ID: <20101001200254.GX3117@atomide.com>
References: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
 <1285962353-9586-3-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58221 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0JAUC6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 16:02:58 -0400
Content-Disposition: inline
In-Reply-To: <1285962353-9586-3-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org

* Enric Balletbo i Serra <eballetbo@gmail.com> [101001 12:38]:
> The IGEP v2 board has four leds, this patch allows control all
> of these LEDs using the LED class if CONFIG_LEDS_GPIO is selected
> or using the General Purpose Input/Output (GPIO) interface if
> CONFIG_LEDS_GPIO is not selected.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |  156 +++++++++++++++++++---------------
>  1 files changed, 87 insertions(+), 69 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 1052a63..9f25d0d 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -261,6 +261,77 @@ static struct omap2_hsmmc_info mmc[] = {
>  	{}      /* Terminator */
>  };
>  
> +#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
> +#include <linux/leds.h>
> +
> +static struct gpio_led igep2_gpio_leds[] = {
> +	[0] = {
> +		.name = "gpio-led:red:d0",
> +		.gpio = IGEP2_GPIO_LED0_RED,
> +		.default_trigger = "default-off"
> +	},
> +	[1] = {
> +		.name = "gpio-led:green:d0",
> +		.gpio = IGEP2_GPIO_LED0_GREEN,
> +		.default_trigger = "default-off",
> +	},
> +	[2] = {
> +		.name = "gpio-led:red:d1",
> +		.gpio = IGEP2_GPIO_LED1_RED,
> +		.default_trigger = "default-off",
> +	},
> +	[3] = {
> +		.name = "gpio-led:green:d1",
> +		.default_trigger = "heartbeat",
> +		.gpio = -EINVAL, /* gets replaced */
> +	},
> +};

Please align the igep2_gpio_leds with tabs like you
do already below.

Regards,

Tony
