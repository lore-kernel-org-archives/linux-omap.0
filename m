From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 13:32:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211221318470.2255-100000@netrider.rowland.org>
References: <20121122175340.GA22614@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121122175340.GA22614-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 22 Nov 2012, Felipe Balbi wrote:

> Hi,

Hello.

> > This is an interesting problem.  How should we handle devices which
> > live on a discoverable bus but whose power is controlled by an
> > undiscoverable platform-specific regulator?
> 
> a quirk on the hub's product ID/vendor ID pair ? All you need is to put
> a requirement on the format of the regulator name. Not the best
> solution, I agree, but that's all we can do.

That sounds a little too simple.  For example, what if there are two 
chips of the same type on the system, attached to two different 
regulators and two different host controllers?

> > from platform data at boot time.  The suggestion that the regulator
> > should really be associated with a port on the hub's parent is
> > reasonable at first glance.  But what if we don't know which port that
> > is?
> 
> What do you mean ? I'd expect all ports to have a regulator. Either one
> for each, or sharing the same supply. It all boils down to how the hub
> is integrated.

I wasn't clear enough.  I wasn't talking about downstream ports on that
hub, but about where its upstream port is connected.  This hub is
permanently wired to one of the root ports on the EHCI controller.  In
this case, we know which port it is attached to.  In other systems we
may not know, or it may be different on different revisions of the same
board.

> > If we can figure out a good way to set up the necessary association, I
> > won't mind adding the appropriate calls to the USB core.  But is the
> > hub driver the right place?  What if a similar power arrangement is
> > used for a different kind of USB-connected chip (for example, a webcam
> > or a fingerprint reader)?
> 
> Then the camera's driver or the fingerprint reader's driver should
> manage the regulator, no ? Or do you want to let teach the regulator to
> struct usb_device and manage it at usbcore level ?

The latter, more or less.  For example, maybe we can tell usbcore
somehow that regulator X is in control of a device attached to host
controller Y (not sure how we would express X and Y though).  Then when
usb_add_hcd() sees that the host controller being added is Y, it will
know to turn on regulator X.  Similarly for usb_remove_hcd().

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
