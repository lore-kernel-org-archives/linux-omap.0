From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC 2/7] tty: add support for "tty slave" devices
Date: Sun, 14 Aug 2016 13:35:13 +0200
Message-ID: <20160814113513.GB21529@kroah.com>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-3-git-send-email-sre@kernel.org>
 <20160813100345.GA14665@kroah.com>
 <20160814084822.GA21321@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160814084822.GA21321@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Aug 14, 2016 at 10:48:22AM +0200, Pavel Machek wrote:
> On Sat 2016-08-13 12:03:45, Greg Kroah-Hartman wrote:
> > On Sat, Aug 13, 2016 at 05:14:33AM +0200, Sebastian Reichel wrote:
> > > From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> > > 
> > > A "tty slave" is a device connected via UART.  It may need a driver to,
> > > for example, power the device on when the tty is opened, and power it
> > > off when the tty is released.
> > > 
> > > Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> > > Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
> Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> 
> > > @@ -3317,6 +3318,11 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
> > >  	retval = device_register(dev);
> > >  	if (retval)
> > >  		goto error;
> > > +	if (device && device->of_node)
> > > +		/* Children are platform devices and will be
> > > +		 * runtime_pm managed by this tty.
> > > +		 */
> > > +		of_platform_populate(device->of_node, NULL, NULL, dev);
> > 
> > Why are these platform devices?  And why only OF?
> 
> OF based systems are the only ones that have this problem, so that's
> the only place where we can test this solution.
> 
> Given that these devices are connected over the UART, it seems right
> to categorize them as platform devices... You can't connect PCI, SATA
> or USB device over UART port.

No, that's a total abuse of the platform bus, please don't.

I've said before that a "serial" bus should be created and you can hang
devices off of it.  For some reason that message keeps getting
ignored...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
