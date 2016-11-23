From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Wed, 23 Nov 2016 07:57:48 -0800
Message-ID: <20161123155747.GF4082@atomide.com>
References: <20161107215020.31399-1-tony@atomide.com>
 <1557347.d3YjqqaO81@avalon>
 <839f0f26-3bb0-d368-8cff-dbccaffa7244@ti.com>
 <10445300.62NO2xvFpp@avalon>
 <47c6e11e-3725-8955-5cc4-654df4d1c3bc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <47c6e11e-3725-8955-5cc4-654df4d1c3bc-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [161123 07:54]:
> On 23/11/16 17:49, Laurent Pinchart wrote:
> > Hi Tomi,
> > 
> > On Wednesday 23 Nov 2016 12:14:17 Tomi Valkeinen wrote:
> >> On 10/11/16 23:25, Laurent Pinchart wrote:
> >>>>>> [    2.766174] musb_bus_suspend 2586: trying to suspend as a_idle while
> >>>>>> active
> >>>>>>
> >>>>>> printed in a loop at boot time. I've traced musb->is_active being set
> >>>>>> to 1 in musb_start() with
> >>>
> >>> Actually disabling CONFIG_USB_MUSB_HDRC gets rid of the problem, quite
> >>> understandably. It's not a fix though, just a workaround. Are you
> >>> interested in investigating this ?
> >>
> >> I'm seeing this too. Did you manage to boot your Panda? If I disable
> >> CONFIG_USB_MUSB_HDRC, I don't see that error print, but the ethernet
> >> doesn't work, and so my nfsroot doesn't mount.
> > 
> > Do you use ethernet over USB gadget or over LAN9514 (smsx95xx) ? The LAN9514 
> > is connected to the EHCI USB interface so it shouldn't depend on MUSB.
> 
> smsx95xx. I didn't look at it further, so possibly there's something
> else broken/changed that prevented the ethernet from working.

I have omap2plus_defconfig with initramfs work just fine for nfsroot
and musb peripheral mode on pandaboard es. Well I have not tried it
since last week with Linux next.

Regards,

Tony



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
