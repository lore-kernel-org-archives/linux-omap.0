From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: musb bogosity
Date: Fri, 8 Aug 2008 18:21:09 +0900
Message-ID: <20080808092109.GA7468@linux-sh.org>
References: <20080808082722.GA6580@linux-sh.org> <20080808083245.GS30719@gandalf.research.nokia.com> <20080808090445.GT30719@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080808090445.GT30719@gandalf.research.nokia.com>
Sender: linux-next-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-next@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 08, 2008 at 12:04:45PM +0300, Felipe Balbi wrote:
> On Fri, Aug 08, 2008 at 11:32:45AM +0300, Felipe Balbi wrote:
> > > other users. Why this driver isn't using ioread/writeXX_rep() is beyond
> 
> I'll try to fix io routines asap. From your next mail I could see that
> it's really bogus :-p
> 
> > > drivers/usb/musb/musb_core.c: In function 'fifo_setup':
> > > drivers/usb/musb/musb_core.c:1122: error: 'MUSB_C_RAM_BITS' undeclared (first use in this function)
> > > drivers/usb/musb/musb_core.c:1122: error: (Each undeclared identifier is reported only once
> > > drivers/usb/musb/musb_core.c:1122: error: for each function it appears in.)
> > > drivers/usb/musb/musb_core.c: In function 'ep_config_from_table':
> > > drivers/usb/musb/musb_core.c:1246: error: 'MUSB_C_RAM_BITS' undeclared (first use in this function)
> > > drivers/usb/musb/musb_core.c: In function 'musb_remove':
> > > drivers/usb/musb/musb_core.c:2131: warning: unused variable 'ctrl_base'
> > > make[1]: *** [drivers/usb/musb/musb_core.o] Error 1
> > > make: *** [drivers/usb/musb/musb_core.o] Error 2
> 
> Below is the patch that fixes it.
> 
> I don't have sh cross-compilers, so if you could try it out and be sure
> it works, I'd be glad.
> 
Yes, that fixes that problem at least, thanks.

Now the I/O bits are the only outstanding issue, as I still need the
CONFIG_SUPERH test in musb_io.h to get around conflicting definitions.

Presently ARM and SH are the only ones that define the readsl() variants
anyways, so stubbing in an extra ifdef there is fine as a temporary
measure, but it's not a long-term solution. The only reason SH defines
them at all is because we ran in to this exact same problem the last time
an ARM driver tried passing itself off as generic ;-)

> ==== cut here ====
> 
> From 0bbc416e8170c4169608f7496b8d67be3828d76b Mon Sep 17 00:00:00 2001
> From: Felipe Balbi <felipe.balbi@nokia.com>
> Date: Fri, 8 Aug 2008 11:39:41 +0300
> Subject: [PATCH] usb: musb: pass configuration specifics via pdata
> 
> Use platform_data to pass musb configuration-specific
> details to musb driver.
> 
> This patch will prevent that other platforms selecting
> HAVE_CLK and enabling musb won't break tree building.
> 
> The other parts of it will come when linux-omap merge
> up more omap2/3 board-files.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>
