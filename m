From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: ohci: Allow ohci on omap5 also
Date: Sat, 10 Sep 2016 22:27:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609102224120.31770-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1609092131150.8630-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1609092131150.8630-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 9 Sep 2016, Alan Stern wrote:

> On Fri, 9 Sep 2016, Tony Lindgren wrote:
> 
> > * Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [160909 13:41]:
> > > On Fri, 9 Sep 2016, Tony Lindgren wrote:
> > > 
> > > > * Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [160909 12:47]:
> > > > > You know, as far as I can tell the only thing that is OMAP-specific
> > > > > about the ohci-omap3 driver is the initialization of OHCI_CTRL_RWC.  
> > > > > This could be added to the platform data or the DT bindings, after
> > > > > which this driver wouldn't be needed at all -- the ohci_platform driver
> > > > > would work.  Does this seem reasonable?
> > > > 
> > > > Sure makes sense to me. Do we have some standard binding for
> > > > OCHI_CTRL_RWC?
> > > 
> > > No, one would have to be created.
> > 
> > OK I can do a patch for that, what should be binding be?
> > 
> > ohci-ctrl-rwc-something?
> 
> OHCI_CTRL_RWC is just a single-bit flag; the RWC part stands for
> "Remote Wakeup Control".

Sorry, careless mistake on my part.  It actually stands for "Remote 
Wakeup Connected"; meaning that the remote-wakeup output signal from 
the controller is connected to something really can wake up the system.
This is exactly the sort of hardware implementation detail that the 
firmware is supposed to know.

Alan Stern

>  The flag indicates whether the controller
> hardware is able to wake up the system, and it is supposed to be set
> initially by the firmware during boot-up.  Under DT, the driver will
> have to set it manually.
> 
> So you could call it ohci-ctrl-rwc-on, or ohci-ctrl-rwc-enable, or 
> anything similar.  Use your own judgment.
> 
> Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
