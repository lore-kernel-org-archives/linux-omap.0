From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] select NOP_USB_XCEIV for OMAP4
Date: Wed, 23 Jun 2010 13:33:17 -0700
Message-ID: <87k4ppqyk2.fsf@deeprootsystems.com>
References: <1277318873-8260-1-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1277318873-8260-1-git-send-email-x0132446-l0cyMroinI0@public.gmane.org> (David
	Anders's message of "Wed, 23 Jun 2010 13:47:53 -0500")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Anders <x0132446-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajay.gupta-l0cyMroinI0@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

David Anders <x0132446-l0cyMroinI0@public.gmane.org> writes:

> Add select statement to force selection of NOP_USB_XCEIV for OMAP4.
>
> Signed-off-by: David Anders <x0132446-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/musb/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index cfd38ed..e4624bc 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -11,6 +11,7 @@ config USB_MUSB_HDRC
>  	depends on (USB || USB_GADGET)
>  	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
>  	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
> +	select NOP_USB_XCEIV if ARCH_OMAP4
>  	select TWL4030_USB if MACH_OMAP_3430SDP
>  	select USB_OTG_UTILS
>  	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'

Shouldn't this be a board-specific option, and not set for every
OMAP4-based config?

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
