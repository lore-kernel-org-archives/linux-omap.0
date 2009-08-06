From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP: Remove OMAP_IO_ADDRESS, use OMAP1_IO_ADDRESS
	and OMAP2_IO_ADDRESS instead
Date: Thu, 6 Aug 2009 13:50:07 +0300
Message-ID: <20090806105006.GC2358@atomide.com>
References: <20090806100614.2569.8531.stgit@localhost> <20090806101019.2569.75005.stgit@localhost> <20090806104031.GC1968@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61682 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbZHFKuT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 06:50:19 -0400
Content-Disposition: inline
In-Reply-To: <20090806104031.GC1968@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, hiroshi.doyu@nokia.com

* Felipe Balbi <felipe.balbi@nokia.com> [090806 13:39]:
> Hi,
> 
> On Thu, Aug 06, 2009 at 12:10:20PM +0200, ext Tony Lindgren wrote:
> > Search and replace OMAP_IO_ADDRESS with OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS,
> > and convert omap_read/write into a functions instead of a macros.
> > 
> > Also rename OMAP_MPUIO_VBASE to OMAP1_MPUIO_VBASE.
> > 
> > In the long run, most code should use ioremap + __raw_read/write instead.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap1/devices.c                 |    2 -
> >  arch/arm/mach-omap1/pm.h                      |    4 +
> >  arch/arm/mach-omap1/serial.c                  |    6 +-
> >  arch/arm/mach-omap1/sram.S                    |   12 ++-
> >  arch/arm/mach-omap1/time.c                    |    4 +
> >  arch/arm/mach-omap2/board-4430sdp.c           |    4 +
> >  arch/arm/mach-omap2/cm.h                      |    6 +-
> >  arch/arm/mach-omap2/omap-smp.c                |    2 -
> >  arch/arm/mach-omap2/pm-debug.c                |    2 -
> >  arch/arm/mach-omap2/prm.h                     |    6 +-
> >  arch/arm/mach-omap2/sdrc.h                    |    6 +-
> >  arch/arm/mach-omap2/serial.c                  |    6 +-
> >  arch/arm/mach-omap2/sram242x.S                |    4 +
> >  arch/arm/mach-omap2/sram243x.S                |    4 +
> >  arch/arm/mach-omap2/timer-gp.c                |    2 -
> >  arch/arm/plat-omap/dma.c                      |    8 +-
> >  arch/arm/plat-omap/dmtimer.c                  |    5 +
> >  arch/arm/plat-omap/gpio.c                     |   86 +++++++++++++------------
> >  arch/arm/plat-omap/include/mach/control.h     |   12 ++-
> >  arch/arm/plat-omap/include/mach/entry-macro.S |    8 +-
> >  arch/arm/plat-omap/include/mach/io.h          |   64 ++++++-------------
> >  arch/arm/plat-omap/include/mach/mtd-xip.h     |    2 -
> >  arch/arm/plat-omap/include/mach/omap44xx.h    |    8 +-
> >  arch/arm/plat-omap/include/mach/sdrc.h        |    6 +-
> >  arch/arm/plat-omap/io.c                       |   58 +++++++++++++++++
> >  arch/arm/plat-omap/sram.c                     |   20 +++---
> >  drivers/video/omap/dispc.c                    |    6 +-
> >  27 files changed, 196 insertions(+), 157 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
> > index bbbaeb0..0680843 100644
> > --- a/arch/arm/mach-omap1/devices.c
> > +++ b/arch/arm/mach-omap1/devices.c
> > @@ -71,7 +71,7 @@ static inline void omap_init_rtc(void) {}
> >  #  define INT_DSP_MAILBOX1     INT_1610_DSP_MAILBOX1
> >  #endif
> > 
> > -#define OMAP1_MBOX_BASE                IO_ADDRESS(OMAP16XX_MAILBOX_BASE)
> > +#define OMAP1_MBOX_BASE                OMAP1_IO_ADDRESS(OMAP16XX_MAILBOX_BASE)
> 
> any chance to ioremap() at least this one ?

Let's do once change at a time. It should be easy to start adding
ioremap conversion patches on top of this series.

Tony
