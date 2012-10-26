From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap plat header removal for v3.8 merge window,
 part1
Date: Fri, 26 Oct 2012 10:55:38 -0700
Message-ID: <20121026175537.GL11908@atomide.com>
References: <20121019023300.GN30550@atomide.com>
 <201210261402.19759.arnd@arndb.de>
 <20121026170949.GF11908@atomide.com>
 <201210261728.22132.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45077 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932894Ab2JZRzo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 13:55:44 -0400
Content-Disposition: inline
In-Reply-To: <201210261728.22132.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

* Arnd Bergmann <arnd@arndb.de> [121026 10:30]:
> On Friday 26 October 2012, Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [121026 07:04]:
> >
> > > I tried running my old multiplatform scripts again and have a few
> > > comments, but none of them serious:
> > > 
> > > $ git grep include.*mach-omap2
> > > arch/arm/plat-omap/debug-devices.c:#include "../mach-omap2/debug-devices.h"
> > > arch/arm/plat-omap/dma.c:#include "../mach-omap2/soc.h"
> > > arch/arm/plat-omap/dmtimer.c:#include "../mach-omap2/omap-pm.h"
> > > arch/arm/plat-omap/i2c.c:#include "../mach-omap2/soc.h"
> > > arch/arm/plat-omap/include/plat/cpu.h:#include "../../mach-omap2/soc.h"
> > > arch/arm/plat-omap/omap-pm-noop.c:#include "../mach-omap2/omap_device.h"
> > > arch/arm/plat-omap/omap-pm-noop.c:#include "../mach-omap2/omap-pm.h"
> > > arch/arm/plat-omap/sram.c:#include "../mach-omap2/soc.h"
> > > arch/arm/plat-omap/sram.c:#include "../mach-omap2/iomap.h"
> > > arch/arm/plat-omap/sram.c:#include "../mach-omap2/prm2xxx_3xxx.h"
> > > arch/arm/plat-omap/sram.c:#include "../mach-omap2/sdrc.h"
> > > 
> > > I don't like the relative include paths too much. I would have preferred
> > > adding the mach-omap2/include/mach path in the plat-omap Makefile, but
> > > I suppose you want to leave it like it is now since you mention you 
> > > have already built on top of it.
> > 
> > Well I wanted to keep them local to arch/arm/*omap*/ directories,
> > and not have them exposed at all for drivers.
> > 
> > Other than that I don't have an issue using non-relative paths, except
> > mach-omap2/include/mach traditionally has been exposed to drivers
> > as the legacy #include <mach/*.h>, so IMHO local headers in the
> > arch/arm/*omap*/ directories are better.
> > 
> > But now I wonder if we can somehow have drivers not be able to
> > include these local headers?
> 
> Well, once CONFIG_MULTIPLATFORM gets enabled, the mach/*.h files are
> not visible to drivers any more, but they are still visible to files
> in plat-omap if you add a line like
> 
> ccflags-$(CONFIG_ARCH_OMAP2) := -I$(srctree)/arch/arm/mach-omap2/include
> ccflags-$(CONFIG_ARCH_OMAP1) := -I$(srctree)/arch/arm/mach-omap1/include
> 
> to arch/arm/plat-omap/Makefile. That is how the other multiplatform
> Makefiles do it. If a driver writer really wants to cheat, they can of
> course do the same thing in their directory, but they can also do
> #include "../../../../arch/arm/mach-omap2/foo.h"

OK thanks for clarifying that. Sounds like that can be used to
fix up the relative includes for plat-omap. I'll do some patches
for that after we have the #include <plat/*.h> and #include <mach/*.h>
issue sorted out.
 
> > > sound/soc/omap/am3517evm.c:#include <mach-omap2/hardware.h>
> > > sound/soc/omap/am3517evm.c:#include <mach-omap2/gpio.h>
> > > sound/soc/omap/ams-delta.c:#include <mach-omap2/board-ams-delta.h>
> > > sound/soc/omap/n810.c:#include <mach-omap2/hardware.h>
> > > sound/soc/omap/sdp3430.c:#include <mach-omap2/hardware.h>
> > > sound/soc/omap/sdp3430.c:#include <mach-omap2/gpio.h>
> > > sound/soc/omap/zoom2.c:#include <mach-omap2/hardware.h>
> > > sound/soc/omap/zoom2.c:#include <mach-omap2/gpio.h>
> > > sound/soc/omap/zoom2.c:#include <mach-omap2/board-zoom.h>
> > > 
> > > Not sure if you were just missing these or if you already have other
> > > patch lined up for them.
> > 
> > In which branch do you see the above?
> > 
> > I'm not seeing them in v3.7-rc2, looks like all sound/soc/omap/*.c
> > files have already been fixed up.
> 
> I am looking at the arm-soc for-next branch, which is based on v3.7-rc2.
> 
> Note that before my script, this reads
> 
> #include <mach/hardware.h>
> 
> not
> 
> #include <mach-omap2/hardware.h>
> 
> but the effect is the same if the file is not available.

Well for omap2+, drivers should no longer include anything
with #include <mach/*.h> (or #include <mach-omap2/hardware.h>)
and the drivers should be fixed instead.

For omap2+, mach/hardware.h is empty now. It still needs to be
included for omap1, so that might require some conditional
includes for the shared code between omap1 and omap2+ like
sound/soc/omap/*mcbsp*.c. And that code should just be able
to use platform_data for omap1, and not need hardware.h either
eventually.

AFAIK, all the sound/soc/omap/*.c files are almost fixed up
for omap2+, so let's not change those includes in arm-soc tree
as that will just cause conflicts. All the remaining
#include <mach/*.h> and #include <plat/*.h> under sound/soc/omap
can eventually be just removed for omap2+.

For omap1, we can just leave them as they are for now. Those
are the sound/soc/omap/ams-delta.c and sound/soc/omap/osk5912.c
files for omap1.
 
> > In any case, let's not have #include <mach-omap1/*.h> or
> > #include <mach-omap2/*.h> includes in the drivers, they are
> > wrong. Those headers are meant to be local, the legacy shared
> > headers should be in #include <mach/*.h>. Whatever needs to
> > be passed from arch/arm/*omap*/ to drivers, should be done
> > using include/linux/platform_data/*.h files.
> 
> I'm not suggesting to use mach-omap2/*.h, it's just what my
> old script shows when hunting for platform header files that are
> used in device drivers.

OK makes sense :) Well we should no have any of them after
v3.8 merge window except for the legacy ones for omap1.

Your script found a real issue though, and that's the tidspbridge
include of private headers from mach-omap2! That's something
that needs to be fixed or removed to cut the dependency between
core omap code and device drivers.
 
> > For omap1, we might as well keep the existing ones from
> > #include <mach/*.h> as they are until somebody wants to fix
> > up things properly for omap1 for CONFIG_MULTIPLATFORM.
> 
> Fair enough.

Sounds good.

Tony
