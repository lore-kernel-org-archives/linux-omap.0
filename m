From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 2/5] usb: musb: call musb_port_suspend from musb_bus_suspend
Date: Mon, 25 Nov 2013 15:34:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1311251530170.1172-100000@iolanthe.rowland.org>
References: <20131125194629.GA18046@saruman.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131125194629.GA18046-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 25 Nov 2013, Felipe Balbi wrote:

> On Mon, Nov 25, 2013 at 08:39:50PM +0100, Daniel Mack wrote:
> > Make musb_port_suspend() externally available, and call it when to host
> > goes into suspend. This allows the core to go into suspend while a
> > device is connected.

> have you considered the fact that when musb looses context it'll cause a
> disconnect on the bus because soft_connect bit is lost ?
> 
> What if you have a mounted file system on a pendrive ? Should we allow
> suspend in that case ?
> 
> Alan, Greg, any hints ?

An HCD should strive to avoid losing power sessions over a
suspend/resume.  But if this is unavoidable, the USB Persist mechanism
should be able to cope by issuing a reset-resume.  (Unless userspace
has turned Persist off, of course -- I believe some distributions do
this.  Chrome?)

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
