From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: ohci: Allow ohci on omap5 also
Date: Fri, 9 Sep 2016 14:11:19 -0700
Message-ID: <20160909211118.rtj53romz4vf5cng@atomide.com>
References: <20160909201114.7cehi2sgmjw46gfo@atomide.com>
 <Pine.LNX.4.44L0.1609091640470.2050-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1609091640470.2050-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [160909 13:41]:
> On Fri, 9 Sep 2016, Tony Lindgren wrote:
> 
> > * Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [160909 12:47]:
> > > You know, as far as I can tell the only thing that is OMAP-specific
> > > about the ohci-omap3 driver is the initialization of OHCI_CTRL_RWC.  
> > > This could be added to the platform data or the DT bindings, after
> > > which this driver wouldn't be needed at all -- the ohci_platform driver
> > > would work.  Does this seem reasonable?
> > 
> > Sure makes sense to me. Do we have some standard binding for
> > OCHI_CTRL_RWC?
> 
> No, one would have to be created.

OK I can do a patch for that, what should be binding be?

ohci-ctrl-rwc-something?

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
