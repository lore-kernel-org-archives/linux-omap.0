From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Sat, 24 Nov 2012 19:41:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211241927020.10714-100000@netrider.rowland.org>
References: <50B14395.4010404@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B14395.4010404-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, 25 Nov 2012, Andy Green wrote:

> On 11/24/12 23:38, the mail apparently from Alan Stern included:
> > On Sat, 24 Nov 2012, Andy Green wrote:
> >
> >> If we're just looking at fixing the current "magic regulator name"
> >> scheme of "hsusb0" so that it can work with abstract devices like any
> >> hub / port, we could invert what my original "device path" scheme did.
> >>
> >> So instead of having a parser (which boiled down quite small, but is
> >> complicated by usb%d being the same for different usb drivers), we could
> >> just add a helper function that walks the device parents to generate a
> >> string representing the device instance.  Like
> >>
> >> int device_path_generate(struct device *device, char *name, int len);
> >>
> >> if you called it from the hub driver's probe function (or anything
> >> else's probe function) with the new hub device pointer, it might fill
> >> name with "ehci1/usbhub1-1/1-1.1" or somesuch.
> >
> > It's not that simple.  In your example, the very same device might show
> > up, after rebooting, as "ehci2/usbhub2-1/2-1.1".  Even if a more or
> > less stable name for the controller is used, the bus-number parts of
> > the name (the '2's in this example) are always subject to change.  The
> 
> Agreed; I pointed this out in a previous mail in this thread already, 
> after someone else pointed it out to me some months ago.  Indeed we 
> can't use "usb%d", the nth "usb" bus because the ordering of driver 
> insertion for the various drivers that can create "usb%d"s breaks the 
> determinism of it.
> 
> So we can only use in the matching paths a %d that represents the nth 
> instance of a device from a specific driver, the "nth ehci host 
> controller" for example.

That's not right.  The order in which devices are discovered and 
registered is not deterministic.  Something better is needed.

> > device_path_generate routine would have to possess special knowledge
> > about the USB subsystem's naming scheme to generate a truly stable
> > name.
> 
> I think there's enough info exposed to do everything generically with no 
> access to driver-private info.
> 
> When walking struct device "path" one of the things we know at each 
> stage is matched driver name.  So we might meet a device of name "usb2" 
> but afaik we can trivially also see the matched driver has the name 
> "ehci-hcd".
> 
> If we can walk a list of "usb%d"s, we can determine that our device is 
> the nth device of that type belonging to "ehci-hcd" driver.  That list 
> may be nondeterministic in terms of drivers getting modprobed in and 
> out, say inserting themselves randomly in the ordering of the list 
> before and after we modprobe ehci-hcd, but afaics no amount of insertion 
> or removal will change the sequencing of other entries of the same type 
> already there (first ehci-hcd one will always appear in the list in the 
> same relative order to the second ehci-hcd one).

No, that's not true either.  The order in which devices are bound to 
drivers is not deterministic.

>  I think this would be 
> reliable for getting as far as "ehci1/" and it's generic code walking 
> device path and bus member lists that will work on all buses with that 
> problem.
> 
> > Presumably the same would hold for other subsystems too.
> 
> Although it looks like that method will bounce off of usbhub%d since the 
> driver name does not vary, I think it can also be alright.
> 
> If we can walk a list of usbhubs finding the ones that have the same 
> parent pointer as the parent we arrived at in our walking, we should 
> again get an ordinal we can use representing the nth hub on that 
> particular host controller.  Afaics that should work for m hub levels 
> too if we just filter by an opaque parent device pointer.
> 
> Of course the code should not particularly know it's looking at "usb%d" 
> or "usbhub" just generic buses or classes or whatever it sees in use 
> while walking the device path.  And although there's some walking around 
> described, we only do it at probe time and only for devices that are 
> interested in getting a deterministic device name to bind assets with.
> 
> The above is logically workable I think but to find out if it's 
> practical to "walk usbhubs" and so on for me anyway the code needs to be 
> attempted.  So I'm curious if you see any flaw already with this scheme.

It simply will not be reliable.

For the case we have been discussing, we do in fact know the device
name of the controller in question (at least, I assume we do).  Let's
say it is "ehci-panda".  We also have to assume that we know which port
the LAN95xx hub is attached to; say it is port 3.  Then the device path
to search for would be something like "ehci-panda/usb*/*-3" or maybe
"ehci-panda/usb*/port-3", where the * would have to match any number
(that part of the name is not a stable value).  But you wouldn't know
this unless you were familiar with the details of the USB device naming
scheme.

Maybe some sort of specialized wildcard parser could do the matching.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
