From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] [OMAP] HTCHERALD: MMC, I2C, HTCPLD and related
 devices
Date: Wed, 4 Aug 2010 13:10:09 +0300
Message-ID: <20100804101008.GD9881@atomide.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
 <1280762976-17284-2-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52161 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab0HDKJq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 06:09:46 -0400
Content-Disposition: inline
In-Reply-To: <1280762976-17284-2-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
> This change adds in MMC and I2C support to the HTC Herald board, as well
> as adding the HTCPLD driver for the PLD used on this phone.  It also
> adds in the gpio-keys entries for the front directional keys and
> selector and the cursor keys on the slide-out keyboard, and gpio-leds
> support for the LEDs attached to the htcpld.
> 
> The Kconfig was also modified to add 64 GPIOs and IRQs to the default
> maximum number of each for the HTC herald.  This is needed because the
> HTCPLD chip on this board exposes an additional 32 gpios and 16 irqs
> that would not fit in the default limits.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  arch/arm/mach-omap1/Kconfig           |    2 +
>  arch/arm/mach-omap1/board-htcherald.c |  288 ++++++++++++++++++++++++++++++++-
>  2 files changed, 284 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index 3b02d3b..94d5b52 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -64,6 +64,8 @@ config MACH_OMAP_HTCWIZARD
>  config MACH_HERALD
>  	bool "HTC Herald"
>  	depends on ARCH_OMAP850
> +	select OMAP_GPIO_EXTRA64
> +	select OMAP_IRQ_EXTRA64
>  	help
>  	  HTC Herald smartphone support (AKA T-Mobile Wing, ...)
>  

Looking at this patches again.. These above does not exist in
the mainline kernel.

> +/* HTCPLD definitions */
> +
> +/*
> + * CPLD Logic
> + *
> +
> +Chip 3 - 0x03
> +
> +Function            7 6 5 4  3 2 1 0
> +------------------------------------
> +DPAD light          x x x x  x x x 1
> +SoundDev            x x x x  1 x x x
> +Screen white        1 x x x  x x x x
> +MMC power on        x x x x  x 1 x x
> +Happy times (n)     0 x x x  x 1 x x
> +
> +Chip 4 - 0x04
> +
> +Function            7 6 5 4  3 2 1 0
> +------------------------------------
> +Keyboard light      x x x x  x x x 1
> +LCD Bright (4)      x x x x  x 1 1 x
> +LCD Bright (3)      x x x x  x 0 1 x
> +LCD Bright (2)      x x x x  x 1 0 x
> +LCD Bright (1)      x x x x  x 0 0 x
> +LCD Off             x x x x  0 x x x
> +LCD image (fb)      1 x x x  x x x x
> +LCD image (white)   0 x x x  x x x x
> +Caps lock LED       x x 1 x  x x x x
> +
> +Chip 5 - 0x05
> +
> +Function            7 6 5 4  3 2 1 0
> +------------------------------------
> +Red (solid)         x x x x  x 1 x x
> +Red (flash)         x x x x  x x 1 x
> +Green (GSM flash)   x x x x  1 x x x
> +Green (GSM solid)   x x x 1  x x x x
> +Green (wifi flash)  x x 1 x  x x x x
> +Blue (bt flash)     x 1 x x  x x x x
> +DPAD Int Enable     1 x x x  x x x 0
> +
> +(Combinations of the above can be made for different colors.)
> +The direction pad interrupt enable must be set each time the
> +interrupt is handled.
> +
> +Chip 6 - 0x06
> +
> +Function            7 6 5 4  3 2 1 0
> +------------------------------------
> +Vibrator            x x x x  1 x x x
> +Alt LED             x x x 1  x x x x
> +Screen white        1 x x x  x x x x
> +Screen white        x x 1 x  x x x x
> +Screen white        x 0 x x  x x x x
> +Enable kbd dpad     x x x x  x x 0 x
> +Happy Times         0 1 0 x  x x 0 x
> +*/

/*
 * Please put the above into standard comments like
 * this thanks
 */

Other than that, looks good to me. Have to leave this to the next
merge window though.

Regards,

Tony
