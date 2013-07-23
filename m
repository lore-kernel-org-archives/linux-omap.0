From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 23 Jul 2013 09:35:51 -0700
Message-ID: <20130723163551.GA12990@kroah.com>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <51EE9EC0.6060905@ti.com>
 <20130723161846.GD2486@kroah.com>
 <51EEAF32.4040905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51EEAF32.4040905-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Daniel
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 23, 2013 at 09:58:34PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> On Tuesday 23 July 2013 09:48 PM, Greg KH wrote:
> > On Tue, Jul 23, 2013 at 08:48:24PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi,
> >>
> >> On Tuesday 23 July 2013 08:07 PM, Alan Stern wrote:
> >>> On Tue, 23 Jul 2013, Tomasz Figa wrote:
> >>>
> >>>> On Tuesday 23 of July 2013 09:29:32 Tomasz Figa wrote:
> >>>>> Hi Alan,
> >>>
> >>> Thanks for helping to clarify the issues here.
> >>>
> >>>>>> Okay.  Are PHYs _always_ platform devices?
> >>>>>
> >>>>> They can be i2c, spi or any other device types as well.
> >>>
> >>> In those other cases, presumably there is no platform data associated
> >>> with the PHY since it isn't a platform device.  Then how does the
> >>> kernel know which controller is attached to the PHY?  Is this spelled
> >>> out in platform data associated with the PHY's i2c/spi/whatever parent?
> .
> .
> <snip>
> .
> .
> >>
> >> 	static struct phy *phy_lookup(void *priv) {
> >> 		.
> >> 		.
> >> 		if (phy->priv==priv) //instead of string comparison, we'll use pointer
> >> 			return phy;
> >> 	}
> >>
> >> PHY driver should be like
> >> 	phy_create((dev, ops, pdata->info);
> >>
> >> The controller driver would do
> >> 	phy_get(dev, NULL, pdata->info);
> >>
> >> Now the PHY framework will check for a match of *priv* pointer and return the PHY.
> >>
> >> I think this should be possible?
> > 
> > Ick, no.  Why can't you just pass the pointer to the phy itself?  If you
> > had a "priv" pointer to search from, then you could have just passed the
> > original phy pointer in the first place, right?
> > 
> > The issue is that a string "name" is not going to scale at all, as it
> > requires hard-coded information that will change over time (as the
> > existing clock interface is already showing.)
> > 
> > Please just pass the real "phy" pointer around, that's what it is there
> > for.  Your "board binding" logic/code should be able to handle this, as
> > it somehow was going to do the same thing with a "name".
> 
> The problem is the board file won't have the *phy* pointer. *phy* pointer is
> created at a much later time when the phy driver is probed.

Ok, then save it then, as no one could have used it before then, right?

All I don't want to see is any "get by name/void *" functions in the
api, as that way is fragile and will break, as people have already
shown.

Just pass the real pointer around.  If that is somehow a problem, then
something larger is a problem with how board devices are tied together :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
