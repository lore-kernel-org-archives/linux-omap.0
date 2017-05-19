From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/4] usb: host: ohci-omap3: Print warning to get people
 to use ohci-platform
Date: Fri, 19 May 2017 10:39:46 -0700
Message-ID: <20170519173945.GF10472@atomide.com>
References: <20170517225922.17723-1-tony@atomide.com>
 <20170517225922.17723-4-tony@atomide.com>
 <20170518091502.f3q6opnoey7aw2aw@earth>
 <20170518140857.GA10472@atomide.com>
 <20170518172157.huhmkllpub3bujyv@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170518172157.huhmkllpub3bujyv@earth>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170518 10:25]:
> Hi,
> 
> On Thu, May 18, 2017 at 07:08:58AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170518 02:18]:
> > > On Wed, May 17, 2017 at 03:59:21PM -0700, Tony Lindgren wrote:
> > > > We can't just remove ohci-omap3 as that could make some people's
> > > > systems unusable for keyboard and mouse. Let's print a warning for
> > > > now, and then remove the driver in a year or so.
> > >
> > > I guess you could drop the driver and modify the Kconfig entry,
> > > so that it selects USB_OHCI_HCD_PLATFORM? I just checked and
> > > there are already a few examples of this in the USB host Kconfig :)
> > 
> > Right but there's still nothing telling people to load ohci-platform
> > instead of ohci-omap3 if we just remove ohci-omap3 without any warnings.
> 
> Shouldn't the driver be loaded automatically due to the DT
> compatible value?

Doesn't that depend on a collection of user space software of
varying quality and usability? :)

But I think we can actually ohci-omap3 once the issues are sorted
out. That's because for OHCI omaps need an OHCI PHY. In most cases
there is just EHCI PHY and an external hub is needed. I'll do some
more testing.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
