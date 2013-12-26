From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: Rework USB and USB_GADGET dependency
Date: Thu, 26 Dec 2013 16:40:19 +0400
Message-ID: <52BC23B3.4080107@cogentembedded.com>
References: <1388060693-2716-1-git-send-email-ezequiel.garcia@free-electrons.com> <1388060693-2716-3-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1388060693-2716-3-git-send-email-ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 26-12-2013 16:24, Ezequiel Garcia wrote:

> This USB controller can work in as host-only, gadget-only or dual-role
> modes. Rework the dependency on the USB and USB_GADGET configs in order
> to allow building the driver when !USB or !USG_GADGET.

> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
[...]

> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 57dfc0c..a1d805f 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -6,7 +6,7 @@
>   # (M)HDRC = (Multipoint) Highspeed Dual-Role Controller
>   config USB_MUSB_HDRC
>   	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
> -	depends on USB_GADGET
> +	depends on (USB || USB_GADGET)

    Parens are not needed here. Be consistent with other entries MUSB please.

>   	help
>   	  Say Y here if your system has a dual role high speed USB
>   	  controller based on the Mentor Graphics silicon IP.  Then
> @@ -35,21 +35,21 @@ choice
>
>   config USB_MUSB_HOST
>   	bool "Host only mode"
> -	depends on USB
> +	depends on USB=y || USB=USB_MUSB_HDRC
>   	help
>   	  Select this when you want to use MUSB in host mode only,
>   	  thereby the gadget feature will be regressed.
>
>   config USB_MUSB_GADGET
>   	bool "Gadget only mode"
> -	depends on USB_GADGET
> +	depends on USB_GADGET=y || USB_GADGET=USB_MUSB_HDRC
>   	help
>   	  Select this when you want to use MUSB in gadget mode only,
>   	  thereby the host feature will be regressed.
>
>   config USB_MUSB_DUAL_ROLE
>   	bool "Dual Role mode"
> -	depends on (USB && USB_GADGET)
> +	depends on ((USB=y || USB=USB_MUSB_HDRC) && (USB_GADGET=y || USB_GADGET=USB_MUSB_HDRC))

    Outer parens are not needed either...

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
