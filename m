From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Fri, 23 Nov 2012 11:25:32 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211231108000.1734-100000@iolanthe.rowland.org>
References: <20121123104416.GD29585@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121123104416.GD29585-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 23 Nov 2012, Felipe Balbi wrote:

> > Thanks for the example. The only problem is, how do we associate a
> > regulator to a specific port in the system.
> 
> heh, that's the 1 million dollar question, isn't it ? :-)
> 
> that's what we need to figure out now. Luckily we have Alan Stern
> helping us out ;-)

Some people might think having me around to interfere was not so lucky
after all...  :-)

First question: Should we worry about individual ports?  Ordinarily I'd
say No, because hubs always power up all of their ports.  But with Lan
Tianyu's recent work, that won't be true any more.  In this case, it's
conceivable that the user might want to power-off the LAN95xx in order
to save energy, even though ehci-hcd is still loaded and managing other
USB devices.

Either way, the regulator has to be associated with _something_: either
a root-hub port or the host controller itself.  And this will most
likely have to be done before the port's or the controller's struct
device exists.

Something like Andy's scheme might work.  It would require the kernel
to parse name strings in various formats, which could get complicated.  
It would be great if the difficult parts could be stuck in the PM core
somewhere.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
