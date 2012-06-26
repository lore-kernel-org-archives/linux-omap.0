From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv8 03/13] I2C: OMAP: Remove reset at init
Date: Tue, 26 Jun 2012 04:15:13 -0700
Message-ID: <20120626111513.GD31393@atomide.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-4-git-send-email-shubhrajyoti@ti.com>
 <20120620102905.GC12766@atomide.com>
 <4FE2C750.3020803@ti.com>
 <20120621071959.GV12766@atomide.com>
 <4FE2E9D3.5060304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FE2E9D3.5060304-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> [120621 02:35]:
> On Thursday 21 June 2012 12:50 PM, Tony Lindgren wrote:
> > * Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> [120621 00:08]:
> >> On Wednesday 20 June 2012 03:59 PM, Tony Lindgren wrote:
> >>> See the comments regarding driver specific resets in hwmod code.
> >> you mean omap_hwmod.c
> >>> The way to set this up is to have a shared inline function in
> >>> i2c-omap.h that both the driver and hwmod code can use.
> >> hwmod reset function uses oh (omap_hwmod).
> >>
> >> How could the driver also pass oh ?
> >> Could we keep a local copy in driver data?
> >>> Eventually hwmod code will do the reset only in late initcall
> >>> if no driver is loaded for the device in question.
> > There's no need for the driver to know anything about oh.
> > The driver just needs to know the iobase.
> I will rework to make the hwmod and driver use the same function.
> In the meanwhile I will send a minimal/ remaining cleanups/ fixes so that
> it might get some time to bake in the next branch.

OK thanks!

Tony
