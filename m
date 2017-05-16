From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: ohci: Allow ohci on omap5 also
Date: Tue, 16 May 2017 08:59:01 -0700
Message-ID: <20170516155901.GG31418@atomide.com>
References: <Pine.LNX.4.44L0.1609092131150.8630-100000@netrider.rowland.org>
 <Pine.LNX.4.44L0.1609102224120.31770-100000@netrider.rowland.org>
 <20160913224808.hzbahh33vz2f44wl@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160913224808.hzbahh33vz2f44wl-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160913 15:48]:
> * Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [160910 19:27]:
> > On Fri, 9 Sep 2016, Alan Stern wrote:
> > 
> > > On Fri, 9 Sep 2016, Tony Lindgren wrote:
> > > 
> > > > * Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [160909 13:41]:
> > > > > On Fri, 9 Sep 2016, Tony Lindgren wrote:
> > > > > 
> > > > > > * Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [160909 12:47]:
> > > > > > > You know, as far as I can tell the only thing that is OMAP-specific
> > > > > > > about the ohci-omap3 driver is the initialization of OHCI_CTRL_RWC.  
> > > > > > > This could be added to the platform data or the DT bindings, after
> > > > > > > which this driver wouldn't be needed at all -- the ohci_platform driver
> > > > > > > would work.  Does this seem reasonable?
> > > > > > 
> > > > > > Sure makes sense to me. Do we have some standard binding for
> > > > > > OCHI_CTRL_RWC?
> > > > > 
> > > > > No, one would have to be created.
> > > > 
> > > > OK I can do a patch for that, what should be binding be?
> > > > 
> > > > ohci-ctrl-rwc-something?
> > > 
> > > OHCI_CTRL_RWC is just a single-bit flag; the RWC part stands for
> > > "Remote Wakeup Control".
> > 
> > Sorry, careless mistake on my part.  It actually stands for "Remote 
> > Wakeup Connected"; meaning that the remote-wakeup output signal from 
> > the controller is connected to something really can wake up the system.
> > This is exactly the sort of hardware implementation detail that the 
> > firmware is supposed to know.
> 
> OK thanks. I think it can be set up as a generic wakeirq.

Sorry for the slowness on this one, I have not forgotten about this.
I now do have a nice testcase of a modem on the ohci bus I can test
with :)

Also looks we can pretty easily support GPIO wake-up events some
integrated USB devices have with the Linux generic wakeirqs. I did
some testing with that and the only question really is where to
configure it. For my tests, I just patched it into bin/unbind in
drivers/net/usb/cdc_ether.c, but I think it can be generic to all
USB devices.

Anyways, patches coming at some point, might take a while though.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
