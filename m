From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH v4 07/13] usb: otg: add OTG core
Date: Wed, 9 Sep 2015 11:26:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509091123040.2045-100000@iolanthe.rowland.org>
References: <55F013C1.9080400@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55F013C1.9080400-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Li Jun <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 9 Sep 2015, Roger Quadros wrote:

> (adding back folks in cc)
> 
> On 08/09/15 20:35, Alan Stern wrote:
> > On Tue, 8 Sep 2015, Roger Quadros wrote:
> > 
> >>>> What if there is another architecture like so?
> >>>>
> >>>> C:
> >>>> 			[Parent]
> >>>> 			   |
> >>>> 			   |
> >>>> 		|------------------|--------------|
> >>>> 	[OTG core]		[gadget]	[host]
> >>>>
> >>>> We need a more flexible mechanism to link the gadget and
> >>>> host device to the otg core for non DT case.
> >>>>
> >>>> How about adding struct usb_otg parameter to usb_otg_register_hcd()?
> >>>>
> >>>> e.g.
> >>>> int usb_otg_register_hcd(struct usb_otg *otg, struct usb_hcd *hcd, ..)
> >>>>
> >>>> If otg is NULL it will try DT otg-controller property or parent to
> >>>> get the otg controller.
> >>>
> >>> This seems a lot like something Peter and I discussed recently.  See
> >>>
> >>> 	http://marc.info/?l=linux-usb&m=143977568021328&w=2
> >>>
> >>> and the following messages in that thread.
> >>>
> >>
> >> If I understood right, your proposal was to add a usb_pointers data
> >> struct to the device's drvdata?
> > 
> > Right.
> > 
> >> This is fine only if the otg/gadget/host share the same device.
> >> It does not solve the problem where each have different platform devices.
> > 
> > Why not?  Each of the platform devices can store a pointer to the same 
> > usb_pointers structure.  Wouldn't that be suitable?
> > 
> 
> I didn't understand how all of them get the reference to the
> same usb_pointer structure (or contents) when their respective platform devices
> get created so that they can store it in their respective drvdata.
> 
> Worst case, the 3 devices could be totally independent of each other without a
> common parent, and get registered at different times.
> 
> The common resource here is the physical USB port for which the 3 drivers
> otg/host/gadget are being registered.
> There should be a mechanism for each device to tell that it is part of
> this particular USB port. (or usb_pointers struct)

True, it's not clear how to set up the common relationship among the 
three drivers.  But there must be some way to do it if they all are 
talking to the same port or PHY.

The details are an issue for the platform-specific code to handle.  
I'm not sure what would be involved; maybe you can invent something.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
