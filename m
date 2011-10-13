From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 5/5 v14] omap: usb: host: Replace usbhs core driver APIs
 by Runtime pm APIs
Date: Thu, 13 Oct 2011 14:11:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110131408440.2026-100000@iolanthe.rowland.org>
References: <20111013175921.GN28290@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111013175921.GN28290-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 13 Oct 2011, Felipe Balbi wrote:

> Hi,
> 
> On Tue, Oct 11, 2011 at 01:22:11PM +0530, Keshava Munegowda wrote:
> > From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
> > 
> > The ehci and ohci drivers does not use the APIs of the usbhs
> > core driver; the runtime pm APIs are used for clock
> > enable/disable. Since usbhs is parent platform device of the
> > ehci and ohci devices, the runtime apis indirectly uses the
> > usb hs core device as input parameter to for clock functions.
> > 
> > Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> > Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> > Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
> 
> I'm not sure who should queue this one. Alan, maybe ?

All my stuff goes by way of Greg in any case.

> FWIW:
> 
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> 
> as an extra comment, this patch has a very deep dependency on the hwmod
> conversion patches which come before this. If those aren't applied on
> the same merge window, we will have a non-working *HCI driver on OMAP.

To keep things simple, this patch should go through the same submission 
path as the others in the series.  I view it more as an OMAP thing than 
an EHCI thing anyway.  For the record:

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
