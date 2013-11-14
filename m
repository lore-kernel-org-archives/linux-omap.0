From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] isp1704_charger: Add DT support
Date: Thu, 14 Nov 2013 09:52:27 -0800
Message-ID: <20131114175227.GH10317@atomide.com>
References: <1384432734-1490-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384432734-1490-1-git-send-email-sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> [131114 04:40]:
> This patch introduces device tree support to the isp1704
> charger driver. Adding support involved moving the handling
> of the enable GPIO from board code into the driver.
> 
> Signed-off-by: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c | 10 +----
>  drivers/power/isp1704_charger.c              | 56 +++++++++++++++++++++++++---
>  include/linux/power/isp1704_charger.h        |  2 +-
>  3 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index a791fef..2986d16 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -273,13 +273,8 @@ static struct platform_device rx51_battery_device = {
>  	.id	= -1,
>  };
>  
> -static void rx51_charger_set_power(bool on)
> -{
> -	gpio_set_value(RX51_USB_TRANSCEIVER_RST_GPIO, on);
> -}
> -
>  static struct isp1704_charger_data rx51_charger_data = {
> -	.set_power	= rx51_charger_set_power,
> +	.enable_gpio	= RX51_USB_TRANSCEIVER_RST_GPIO,
>  };
>  
>  static struct platform_device rx51_charger_device = {
> @@ -291,9 +286,6 @@ static struct platform_device rx51_charger_device = {
>  
>  static void __init rx51_charger_init(void)
>  {
> -	WARN_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
> -		GPIOF_OUT_INIT_HIGH, "isp1704_reset"));
> -
>  	platform_device_register(&rx51_battery_device);
>  	platform_device_register(&rx51_charger_device);
>  }

Can you please separate out the changes to board-rx51-peripherals.c
as they have a huge chance of merge conflicts for v3.14 when
we're planning to flip omap3 to be device tree only?

To remove the dependency, how about add .enable_gpio to the
isp1704_charger.h and to the board-rx51-peripherals.c without
removing .set_power in the first patch?

Then we can set up an immutable branch that can be merged both
to linux-omap tree and Anton's tree to avoid merge conflicts.

Then the rest of the patches can go via Anton's tree and you
can just have .set_power do nothing, and then it can be
removed later on when no longer used at all.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
