From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 3/3] usb: host: ohci-omap3: Remove driver in favor of
 ohci-platform
Date: Tue, 23 May 2017 12:56:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1705231254120.1853-100000@iolanthe.rowland.org>
References: <20170522160007.9264-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170522160007.9264-4-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 22 May 2017, Tony Lindgren wrote:

> This driver is no longer needed and can be removed. The reason why
> it's safe to remove this driver is that most omap devices don't have a
> USB low-speed or full-speed compatible PHY installed and configured
> with drivers/mfd/omap-usb-host.c. This means that devices like
> beagleboard and pandaboard need to use a high-speed USB hub in order
> to use devices like keyboard and mice.
> 
> Currently the only known configured for a full-speed PHY is the
> mdm6600 modem on droid 4 and I've verified it works just fine with
> ohci-platform.
> 
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/usb/host/Kconfig      |   6 +-
>  drivers/usb/host/Makefile     |   1 -
>  drivers/usb/host/ohci-omap3.c | 211 ------------------------------------------
>  3 files changed, 5 insertions(+), 213 deletions(-)
>  delete mode 100644 drivers/usb/host/ohci-omap3.c
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -473,8 +473,12 @@ config USB_OHCI_HCD_AT91
>  config USB_OHCI_HCD_OMAP3
>  	tristate "OHCI support for OMAP3 and later chips"
>  	depends on (ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5)
> +	select USB_OHCI_HCD_PLATFORM
>  	default y
> -	---help---
> +	help
> +	  This option is deprecated now and the driver was removed, use
> +	  USB_OHCI_HCD_PLATFORM instead.
> +
>  	  Enables support for the on-chip OHCI controller on
>  	  OMAP3 and later chips.
>  
...

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
