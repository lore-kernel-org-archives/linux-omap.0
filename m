From: Michael Grzeschik <mgr-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Allow MUSB DSPS to use "force host" mode
Date: Fri, 22 Nov 2013 17:38:35 +0100
Message-ID: <20131122163835.GF24508@pengutronix.de>
References: <528F7E8F.5050807@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528F7E8F.5050807-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Jackson <mpfj-list-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org, anatol.pomozov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hallo,

On Fri, Nov 22, 2013 at 03:55:59PM +0000, Mark Jackson wrote:
> The IDDIG input pin is normally used to determine the USB mode
> (i.e. HOST or DEVICE).
> 
> On some systems (e.g. AM335x) leaving this pin floating allows
> the USB mode to be set via software.
> 
> This patch adds support for this via the device tree.
> 
> Signed-off-by: Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
> ---
>  .../devicetree/bindings/usb/am33xx-usb.txt         |    2 ++
>  drivers/usb/musb/musb_dsps.c                       |   14 ++++++++++++++
>  include/linux/usb/musb.h                           |    1 +
>  3 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> index 20c2ff2..560b7ff 100644
> --- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> @@ -47,6 +47,8 @@ USB
>  - dmas: specifies the dma channels
>  - dma-names: specifies the names of the channels. Use "rxN" for receive
>    and "txN" for transmit endpoints. N specifies the endpoint number.
> +- ti,force-host: specifies that the IDDIG input be ignored and the device be
> +  put into host mode regardless.

You should always CC devicetree-discuss if adding new bindings. Why
another binding anyway? We have the common binding dr_mode already.
Please use this and of_usb_get_dr_mode from drivers/usb/usb-common.c
instead.

Thanks,
Michael
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
