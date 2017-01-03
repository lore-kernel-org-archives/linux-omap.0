From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH] USB: ohci-omap: defer probe if PHY is missing
Date: Tue, 3 Jan 2017 22:12:18 +0200
Message-ID: <20170103201217.cxzx5yjthyki6q4w@raspberrypi-2.musicnaut.iki.fi>
References: <20170102205355.18920-1-aaro.koskinen@iki.fi>
 <20170103165143.GA25272@kroah.com>
 <20170103185031.viic6w5tzshb7mt5@raspberrypi-2.musicnaut.iki.fi>
 <20170103190504.GA10352@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170103190504.GA10352-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jan 03, 2017 at 08:05:04PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 03, 2017 at 08:50:31PM +0200, Aaro Koskinen wrote:
> > On Tue, Jan 03, 2017 at 05:51:43PM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Jan 02, 2017 at 10:53:55PM +0200, Aaro Koskinen wrote:
> > > > Defer probe if PHY is missing. E.g. on Nokia 770 several modules needs
> > > > to be loaded to get the PHY going and ohci-omap should wait for those.
> > > > 
> > > > Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> > > 
> > > Is this a new bug?  The 770 has been around for forever, why has this
> > > not been a problem before now?
> > 
> > PHY/OTG support for 770 has been around only since v3.14.
> 
> 3.14 was released March, 2014.  A long time ago in kernel development :)
> 
> > I was previously compiling phy-tahvo as built-in, and bumped into this
> > issue when compiling it as a module.
> 
> Why not just make the defconfig as built-in?

I have reverted back to using built-in in my .config.

> I'm not objecting to this patch, just really curious why no one else has
> ever hit it.

Maybe I'm the only user...

The only other board using OHCI OMAP with PHY driver is H2/H3, and they
have solved the issue making USB_OHCI_HCD_OMAP1 depend on the PHY driver:

	depends on ISP1301_OMAP || !(MACH_OMAP_H2 || MACH_OMAP_H3)

This way modprobe will handle the loading order automatically.

BTW, I just realized the same issue is with omap_udc. So I guess this patch
should be just dropped, or resent so that both drivers are fixed.

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
