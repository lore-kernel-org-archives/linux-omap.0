From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/3] usb: fix Kconfig warning
Date: Tue, 19 Oct 2010 13:28:09 +0300
Message-ID: <20101019102808.GH31170@legolas.emea.dhcp.ti.com>
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
>Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Since this is related to MUSB, Greg to do you want me to queue for -rc0
cycle and re-send for you ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
