From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH] OMAP3: RX51: support sleep indicator LEDs
Date: Mon, 05 Oct 2009 14:02:15 +0300
Message-ID: <4AC9D237.6000309@nokia.com>
References: <1254497755-1822-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48153 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932598AbZJELEb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 07:04:31 -0400
In-Reply-To: <1254497755-1822-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Kevin Hilman wrote:
> The sleep indicator LEDs can be enabled/disabled by toggling GPIO162.
> Request this GPIO in RX51 board init, disable by default and expose
> GPIO162 to userspace so LEDs can be toggled from userspace:

It would also make more sense to use gpio_export_link() to provide a named link 
to userspace (e.g. sleep_ind, instead of GPIO162), as it is possible for gpio 
number to change among board revisions and userspace shouldn't bother about that.

-roger

> 
> To enable:
> 
>   # echo 1 > /sys/class/gpio/gpio162/value
> 
> To disable:
> 
>   # echo 0 > /sys/class/gpio/gpio162/value
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/board-rx51.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index f9196c3..6ad44d8 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -31,6 +31,8 @@
>  #include <mach/gpmc.h>
>  #include <mach/usb.h>
>  
> +#define RX51_GPIO_SLEEP_IND 162
> +
>  static struct omap_lcd_config rx51_lcd_config = {
>  	.ctrl_name	= "internal",
>  };
> @@ -74,6 +76,11 @@ static void __init rx51_init(void)
>  	/* Ensure SDRC pins are mux'd for self-refresh */
>  	omap_cfg_reg(H16_34XX_SDRC_CKE0);
>  	omap_cfg_reg(H17_34XX_SDRC_CKE1);
> +
> +	if (!(gpio_request(RX51_GPIO_SLEEP_IND, "SLEEP_IND"))) {
> +		gpio_direction_output(RX51_GPIO_SLEEP_IND, 0);
> +		gpio_export(RX51_GPIO_SLEEP_IND, 1);
> +	}
>  }
>  
>  static void __init rx51_map_io(void)


