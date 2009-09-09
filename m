From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/5] ARM: OMAP2/3/4: Reclaim the kernel IO address space
Date: Wed, 9 Sep 2009 10:49:52 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA89CED4@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C203@dbde02.ent.ti.com>
 <87vdk8ywnl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54941 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbZIIFUA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 01:20:00 -0400
In-Reply-To: <87vdk8ywnl.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

Tony,
What about this series? Shall I post this on ARM mailing list if you have already reviewed this.

Thanks !!
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, August 28, 2009 5:32 PM
> To: Shilimkar, Santosh
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/5] ARM: OMAP2/3/4: Reclaim the kernel IO address
> space
> 
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> 
> > This patch series is intended to free up the kernel IO address space for
> OMAP2XXX, OMAP3XXX and OMAP4430. It is generated against Tony's
> > "omap-headers "(2.6.31-rc6) branch and boot tested on OMAP3430 SDP and
> OMAP4430 platform.
> >
> > Some more combinations are possible but to make it uniform across
> > OMAP2, OMAP3 and OMAP4, these io combinations are chosen.
> >
> > If needed documentation entry can be created to ease up reading and
> debugging information.
> > 	Like "Documentation/arm/omap/io_map.txt"
> 
> Yes, this would be very helpful.
> 
> Otherwise, this series looks OK with me.
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> 
> > Summary of changes:
> >
> > The following changes since commit
> 95e32bc5b2d95370fb67a108a0e3678381fc42df:
> >   Tony Lindgren (1):
> >         OMAP: Remove ifdefs for io.h
> >
> > Santosh Shilimkar (5):
> >       ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and L4
> >       ARM: OMAP2/3/4: Remap L3, L4 to get more kernel io address space
> >       ARM: OMAP2/3/4: Move SRAM map to claim more io space
> >       ARM: OMAP2/3/4: Fix DEBUG_LL UART io address
> >       ARM: OMAP2/3/4: Add OMAP4 L3 and L4 peripherals.
> >
> >  arch/arm/mach-omap2/board-2430sdp.c           |    2 +-
> >  arch/arm/mach-omap2/board-3430sdp.c           |    2 +-
> >  arch/arm/mach-omap2/board-4430sdp.c           |    6 +-
> >  arch/arm/mach-omap2/board-apollon.c           |    2 +-
> >  arch/arm/mach-omap2/board-generic.c           |    2 +-
> >  arch/arm/mach-omap2/board-h4.c                |    2 +-
> >  arch/arm/mach-omap2/board-ldp.c               |    2 +-
> >  arch/arm/mach-omap2/board-omap3beagle.c       |    2 +-
> >  arch/arm/mach-omap2/board-omap3evm.c          |    2 +-
> >  arch/arm/mach-omap2/board-omap3pandora.c      |    2 +-
> >  arch/arm/mach-omap2/board-overo.c             |    2 +-
> >  arch/arm/mach-omap2/board-rx51.c              |    2 +-
> >  arch/arm/mach-omap2/board-zoom2.c             |    2 +-
> >  arch/arm/mach-omap2/cm.h                      |    6 +-
> >  arch/arm/mach-omap2/io.c                      |   18 ++++
> >  arch/arm/mach-omap2/irq.c                     |    4 +-
> >  arch/arm/mach-omap2/omap-smp.c                |    2 +-
> >  arch/arm/mach-omap2/pm-debug.c                |    3 +-
> >  arch/arm/mach-omap2/prm.h                     |    6 +-
> >  arch/arm/mach-omap2/sdrc.h                    |    9 +-
> >  arch/arm/mach-omap2/serial.c                  |    6 +-
> >  arch/arm/mach-omap2/sram242x.S                |    4 +-
> >  arch/arm/mach-omap2/sram243x.S                |    4 +-
> >  arch/arm/mach-omap2/timer-gp.c                |    2 +-
> >  arch/arm/plat-omap/common.c                   |   44 +++++-----
> >  arch/arm/plat-omap/dma.c                      |    6 +-
> >  arch/arm/plat-omap/dmtimer.c                  |    2 +-
> >  arch/arm/plat-omap/gpio.c                     |   42 ++++----
> >  arch/arm/plat-omap/include/mach/control.h     |   15 ++-
> >  arch/arm/plat-omap/include/mach/debug-macro.S |    4 +-
> >  arch/arm/plat-omap/include/mach/entry-macro.S |    4 +-
> >  arch/arm/plat-omap/include/mach/io.h          |  124 +++++++++++++++++-
> -------
> >  arch/arm/plat-omap/include/mach/omap44xx.h    |   14 ++-
> >  arch/arm/plat-omap/include/mach/sdrc.h        |    6 +-
> >  arch/arm/plat-omap/include/mach/vmalloc.h     |    2 +-
> >  arch/arm/plat-omap/io.c                       |   20 +++-
> >  arch/arm/plat-omap/sram.c                     |   24 +++---
> >  drivers/video/omap/dispc.c                    |    6 +-
> >  38 files changed, 246 insertions(+), 161 deletions(-)
> >

Regards,
Santosh
