From: Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Tue, 19 Oct 2010 16:40:37 +0300
Message-ID: <4CBD9FD5.506@nokia.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com> <1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287482608-11320-4-git-send-email-felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 10/19/2010 01:03 PM, ext Felipe Contreras wrote:
> Add missing dependencies, and remove redundant ones, and select sensible
> defaults.
>
> Signed-off-by: Felipe Contreras<felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/mfd/Kconfig        |    3 ++-
>   drivers/regulator/Kconfig  |    1 +
>   drivers/usb/gadget/Kconfig |    3 +--
>   drivers/usb/musb/Kconfig   |    6 ++----
>   drivers/usb/otg/Kconfig    |    2 ++
>   5 files changed, 8 insertions(+), 7 deletions(-)
>

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index c530bc6..2aac57e 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -111,7 +111,6 @@ config	USB_GADGET_SELECTED
>   #
>   choice
>   	prompt "USB Peripheral Controller"
> -	depends on USB_GADGET
>   	help
>   	   A USB device uses a controller to talk to its host.
>   	   Systems should have only one such upstream link.
> @@ -191,7 +190,6 @@ config USB_GADGET_OMAP
>   	boolean "OMAP USB Device Controller"
>   	depends on ARCH_OMAP
>   	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_H4_OTG
> -	select USB_OTG_UTILS if ARCH_OMAP
>   	help
>   	   Many Texas Instruments OMAP processors have flexible full
>   	   speed USB device controllers, with support for up to 30
> @@ -843,6 +841,7 @@ config USB_CDC_COMPOSITE
>   config USB_G_NOKIA
>   	tristate "Nokia composite gadget"
>   	depends on PHONET
> +	depends on USB_GADGET_MUSB_HDRC

This is wrong. Is there a build problem or run-time problem without this?

-- 
regards,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
