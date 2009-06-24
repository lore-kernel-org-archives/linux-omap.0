From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 00/07] pm: remove late/early platform driver pm
	callbacks V2
Date: Wed, 24 Jun 2009 13:33:52 -0700
Message-ID: <20090624203352.GA28516@suse.de>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se> <200906242048.40956.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200906242048.40956.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 24, 2009 at 08:48:39PM +0200, Rafael J. Wysocki wrote:
> On Wednesday 24 June 2009, Magnus Damm wrote:
> > pm: remove late/early platform driver pm callbacks V2
> > 
> > [PATCH 01/07] arm: rework omap suspend_late()/resume_early()
> > [PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
> > [PATCH 03/07] dma: rework txx9dmac suspend_late()/resume_early()
> > [PATCH 04/07] i2c: rework i2c-pxa suspend_late()/resume_early()
> > [PATCH 05/07] i2c: rework i2c-s3c2410 suspend_late()/resume() V2
> > [PATCH 06/07] usb: rework musb suspend()/resume_early()
> > [PATCH 07/07] pm: remove platform device suspend_late()/resume_early() V2
> > 
> > These patches simply remove ->suspend_late() and ->resume_early()
> > from struct platform_driver. Drivers are converted to dev_pm_ops
> > with CONFIG_SUSPEND in mind. Untested.
> > 
> > All patches except [02/07] are known to compile.
> > 
> > Signed-off-by: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
> 
> If no one objects, I'd like to take this series into the suspend-2.6 tree as
> 2.6.32 material.  Greg?

Looks good to me, feel free to add an:
	Acked-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
to the whole series.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
