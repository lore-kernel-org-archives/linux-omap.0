From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: ehci-omap: Update platform header file path
Date: Wed, 25 Nov 2009 09:57:39 -0800
Message-ID: <20091125175739.GE4348@atomide.com>
References: <20091125090259.GB30331@lixom.net>
 <20091125125326.GA18175@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091125125326.GA18175-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org> [091125 05:06]:
> On Wed, Nov 25, 2009 at 03:02:59AM -0600, Olof Johansson wrote:
> > The OMAP usb header file has moved, update the driver so it will build.
> > 
> > Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> > 
> > ---
> > 
> > Greg, any chance you can just ack this so Tony can merge it through his
> > tree for .33? The header files changes in question are going in through
> > that tree.
> 
> Sure, but for such a trivial change, I doubt you need my ack :)
> 
> Acked-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>

The ehci-omap.c driver should be in Greg's queue. I only have the
the related platform init code and header changes in my for-next
because of the omap header move from mach to plat.

IMHO, this fix would be best added to Greg's queue as the ehci-omap.c
driver is there [1]. Or just merged into the exisiting patch
to keep git bisect working:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Meanwhile, I'll also add this fix to omap-testing and master branches
so people can use it until it gets merged.

Regards,

Tony

[1] http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usb-host-ehci-introduce-omap-ehci-hcd-driver.patch
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
