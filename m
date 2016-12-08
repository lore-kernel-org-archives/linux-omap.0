From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Thu, 08 Dec 2016 14:03:50 +0200
Message-ID: <1502451.JdlAJZmj6G@avalon>
References: <20161107215020.31399-1-tony@atomide.com> <32195517.5VSIMIXRqn@avalon> <20161208055122.GC4264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161208055122.GC4264-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wednesday 07 Dec 2016 21:51:23 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161123 08:44]:
> > On Wednesday 23 Nov 2016 18:40:09 Tomi Valkeinen wrote:
> >> On 23/11/16 18:34, Tony Lindgren wrote:
> >>> OK. And what changes to your current .config make the
> >>> musb_bus_suspend() issues show up?
> >>> 
> >>> If it happens with USB-B cable from host to musb with musb set to host
> >>> only mode I'm not suprised there are errors :)
> >> 
> >> I have no USB cables connected. I have attached my config. If
> >> CONFIG_USB_MUSB_HDRC is disabled, the musb error goes away.
> > 
> > For what it's worth, that's exactly the same problem I experienced. See
> > https://www.spinics.net/lists/linux-usb/msg149172.html for an analysis.
> 
> The problem is that with the built-in musb configuration we're trying to
> set USB-B cable to host mode with ID pin not grounded. That's not going
> to work on most hardware unless the PHY can configure the ID pin.
> 
> Here's how to fix the .config for built-in musb:
> 
> 1. Change to have CONFIG_USB_GADGET=y
>
> 2. Then change CONFIG_USB_MUSB_DUAL_ROLE=y instead of CONFIG_USB_MUSB_HOST
>
> We should probably get rid of CONFIG_USB_MUSB_HOST to avoid this.

The reason I went for host mode is that I had to disable CONFIG_USB_GADGET as 
compiling it as a module prevents selecting CONFIG_NOP_USB_XCEIV=y, which is a 
dependency for CONFIG_USB_EHCI_HCD_OMAP=m.

config NOP_USB_XCEIV
        tristate "NOP USB Transceiver Driver"
        depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, NOP can't be 
built-in
        select USB_PHY

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
