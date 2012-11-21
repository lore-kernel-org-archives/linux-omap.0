From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Wed, 21 Nov 2012 09:52:27 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211210942570.1731-100000@iolanthe.rowland.org>
References: <20121121140044.GQ10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121121140044.GQ10216-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 21 Nov 2012, Felipe Balbi wrote:

> On Thu, Nov 15, 2012 at 04:34:14PM +0200, Roger Quadros wrote:
> > From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > 
> > This patch changes the management of the two GPIO for
> > "hub reset" (actually controls enable of ULPI PHY and hub reset) and
> > "hub power" (controls power to hub + eth).
> 
> looks like this should be done by the hub driver. Alan, what would you
> say ? Should the hub driver know how to power itself up ?

Not knowing the context, I'm a little confused.  What is this hub 
you're talking about?  Is it a separate USB hub incorporated into the 
IP (like Intel's "rate-matching" hubs in their later chipsets)?  Or is 
it the root hub?

Under what circumstances would the hub not be powered (i.e., when is it
not in use)?  If it isn't powered, can it be suspended?  Or enumerated?

Is this the sort of thing that should be handled by a PM domain?

As much as possible, the hub driver tries to ignore the differences
between root hubs and non-root hubs.  So for example, all hubs have to
be told to turn on VBUS power to their ports; therefore the hub driver
tells them.  But external hubs are either self-powered or bus-powered;
there's no need and no way for the hub driver to turn the hub power on
or off.  Therefore it doesn't try, not even for root hubs.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
