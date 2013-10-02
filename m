From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH v2 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Wed, 2 Oct 2013 10:52:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1310021043490.1293-100000@iolanthe.rowland.org>
References: <524C0D94.8050100@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524C0D94.8050100-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2 Oct 2013, Daniel Mack wrote:

> On 02.10.2013 14:01, Sebastian Andrzej Siewior wrote:
> > On 10/02/2013 01:14 PM, Daniel Mack wrote:
> >> On 02.10.2013 12:49, Sebastian Andrzej Siewior wrote:
> 
> >>> What happens if the device is unplugged while the host is suspended and
> >>> not there on resume?
> >>
> >> That condition is detected and a full teardown of the connected drivers
> >> is conducted. Try what happens on your notebook when you do that.
> >> Embedded systems should behave just the same.
> > 
> > I had the feeling that the USB device gets disconnected and
> > re-enumerated on resume.
> 
> Yes. The device looses its +5V power supply, so it has to be reset and
> re-enumerated on resume of course. It's just that USB drivers know about
> the state the device has to be put back into after resume, and don't
> assume the device was disconnected and reconnected. The latter would
> (for usb-storage) also cause paritions to be removed and added.

This description may be slightly misleading.

According to the USB spec, a device is not supposed to lose its +5V 
power supply during suspend.  Therefore it does not need to be reset 
and re-enumerated upon resume.  (Except that some devices don't handle 
suspend properly because of buggy firmware; they _do_ need to be 
reset.)

Of course, some systems don't follow the spec.  If they can't supply
suspend power to the host controller and the USB bus, then the device
_will_ need to be reset and re-enumerated.

Some USB drivers (those which define a reset_resume method) are able to
handle this -- they put the device back into the right state and then
act as if nothing had happened.  Others aren't; they get unbound and
rebound just as though the device really had been disconnected and
reconnected.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
