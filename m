From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/3] usb: fix Kconfig warning
Date: Wed, 20 Oct 2010 09:34:05 +0300
Message-ID: <20101020063405.GF15448@legolas.emea.dhcp.ti.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
 <1287482608-11320-2-git-send-email-felipe.contreras@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287482608-11320-2-git-send-email-felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 19, 2010 at 05:03:26AM -0500, Felipe Contreras wrote:
>warning: (USB_MUSB_HDRC_HCD && USB_SUPPORT && USB_MUSB_HDRC &&
>(USB_MUSB_HOST || USB_MUSB_OTG) && USB_GADGET_MUSB_HDRC || USB_MUSB_OTG
>&& <choice> && USB && USB_GADGET && PM && EXPERIMENTAL) selects USB_OTG
>which has unmet direct dependencies (USB_GADGET_OMAP && ARCH_OMAP_OTG &&
>USB_OHCI_HCD)
>
>This doesn't seem to happen on 2.6.36-rc8, but still doesn't make sense
>to keep this duplicated config that is already defined in usb/core.
>

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

>Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> drivers/usb/gadget/Kconfig |   11 -----------
> 1 files changed, 0 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>index cd27f9b..19a6eb6 100644
>--- a/drivers/usb/gadget/Kconfig
>+++ b/drivers/usb/gadget/Kconfig
>@@ -209,17 +209,6 @@ config USB_OMAP
> 	default USB_GADGET
> 	select USB_GADGET_SELECTED
>
>-config USB_OTG
>-	boolean "OTG Support"
>-	depends on USB_GADGET_OMAP && ARCH_OMAP_OTG && USB_OHCI_HCD
>-	help
>-	   The most notable feature of USB OTG is support for a
>-	   "Dual-Role" device, which can act as either a device
>-	   or a host.  The initial role choice can be changed
>-	   later, when two dual-role devices talk to each other.
>-
>-	   Select this only if your OMAP board has a Mini-AB connector.
>-
> config USB_GADGET_PXA25X
> 	boolean "PXA 25x or IXP 4xx"
> 	depends on (ARCH_PXA && PXA25x) || ARCH_IXP4XX
>-- 
>1.7.3.1.2.g7fe2b

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
