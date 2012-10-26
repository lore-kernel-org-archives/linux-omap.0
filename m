From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap plat header removal for v3.8 merge window,
 part1
Date: Fri, 26 Oct 2012 10:09:50 -0700
Message-ID: <20121026170949.GF11908@atomide.com>
References: <20121019023300.GN30550@atomide.com>
 <201210261402.19759.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:46037 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754809Ab2JZRJ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 13:09:56 -0400
Content-Disposition: inline
In-Reply-To: <201210261402.19759.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

* Arnd Bergmann <arnd@arndb.de> [121026 07:04]:
> On Friday 19 October 2012, Tony Lindgren wrote:
> > Hi Arnd & Olof,
> > 
> > Here's the first set of omap plat header removal for v3.8 merge
> > window. I have at least one more related set coming, but I wanted
> > to get these into linux next before driver patches add more
> > things for me to chase down and fix.
> > 
> > Oh, forgot to mention in the tag that the increase in diffstat
> > is mostly because plat-omap/clock shared clock code is duplicated
> > as that's also needed for the common clock framework patches
> > coming up.
> 
> Hi Tony,
> 
> This is very cool, great work! I'm sorry for taking so long before
> we processed them, I wasn't coordinating well with Olof for the last
> week.
> 
> I've applied all of it to a new next/headers branch. I thought about
> using the next/cleanup branch, but since it touches a lot of files
> outside of arch/arm, I decided to keep it separate. We might decide
> to merge it later after all.

OK thanks, yes it's OK to keep it separate as I have few more pull
requests coming to this as I get acks. It should all merge fine with
other branches, let me know if that's not the case.

> I tried running my old multiplatform scripts again and have a few
> comments, but none of them serious:
> 
> $ git grep include.*mach-omap2
> arch/arm/plat-omap/debug-devices.c:#include "../mach-omap2/debug-devices.h"
> arch/arm/plat-omap/dma.c:#include "../mach-omap2/soc.h"
> arch/arm/plat-omap/dmtimer.c:#include "../mach-omap2/omap-pm.h"
> arch/arm/plat-omap/i2c.c:#include "../mach-omap2/soc.h"
> arch/arm/plat-omap/include/plat/cpu.h:#include "../../mach-omap2/soc.h"
> arch/arm/plat-omap/omap-pm-noop.c:#include "../mach-omap2/omap_device.h"
> arch/arm/plat-omap/omap-pm-noop.c:#include "../mach-omap2/omap-pm.h"
> arch/arm/plat-omap/sram.c:#include "../mach-omap2/soc.h"
> arch/arm/plat-omap/sram.c:#include "../mach-omap2/iomap.h"
> arch/arm/plat-omap/sram.c:#include "../mach-omap2/prm2xxx_3xxx.h"
> arch/arm/plat-omap/sram.c:#include "../mach-omap2/sdrc.h"
> 
> I don't like the relative include paths too much. I would have preferred
> adding the mach-omap2/include/mach path in the plat-omap Makefile, but
> I suppose you want to leave it like it is now since you mention you 
> have already built on top of it.

Well I wanted to keep them local to arch/arm/*omap*/ directories,
and not have them exposed at all for drivers.

Other than that I don't have an issue using non-relative paths, except
mach-omap2/include/mach traditionally has been exposed to drivers
as the legacy #include <mach/*.h>, so IMHO local headers in the
arch/arm/*omap*/ directories are better.

But now I wonder if we can somehow have drivers not be able to
include these local headers?
 
> drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/powerdomain.h>
> drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/clockdomain.h>
> drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/cm2xxx_3xxx.h>
> drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/prm-regbits-34xx.h>
> drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/cm-regbits-34xx.h>
> drivers/staging/tidspbridge/core/tiomap3430_pwr.c:#include <mach-omap2/prm-regbits-34xx.h>
> drivers/staging/tidspbridge/core/tiomap3430_pwr.c:#include <mach-omap2/cm-regbits-34xx.h>
> drivers/staging/tidspbridge/rmgr/drv_interface.c:#include <mach-omap2/omap3-opp.h>
> 
> This code is broken now. I wonder whether it's time to remove it from
> staging since we now have rpmsg/remoteproc, rather than getting it to
> compile again.

Oh crap, I totally missed these :( The drivers _should_not_ include
these files at all. Whatever they are doing with those includes is
totally wrong and a bad layering violation.

If it's not fixed, then yeah, I'd say let's just remove the breaking
pieces. Let's give Omar and Laurent a quick chance to fix it up before
dropping it though, I've added them to cc.

> sound/soc/omap/am3517evm.c:#include <mach-omap2/hardware.h>
> sound/soc/omap/am3517evm.c:#include <mach-omap2/gpio.h>
> sound/soc/omap/ams-delta.c:#include <mach-omap2/board-ams-delta.h>
> sound/soc/omap/n810.c:#include <mach-omap2/hardware.h>
> sound/soc/omap/sdp3430.c:#include <mach-omap2/hardware.h>
> sound/soc/omap/sdp3430.c:#include <mach-omap2/gpio.h>
> sound/soc/omap/zoom2.c:#include <mach-omap2/hardware.h>
> sound/soc/omap/zoom2.c:#include <mach-omap2/gpio.h>
> sound/soc/omap/zoom2.c:#include <mach-omap2/board-zoom.h>
> 
> Not sure if you were just missing these or if you already have other
> patch lined up for them.

In which branch do you see the above?

I'm not seeing them in v3.7-rc2, looks like all sound/soc/omap/*.c
files have already been fixed up.
 
> $ git grep include.*mach-omap1
> drivers/video/omap/lcd_ams_delta.c:#include <mach-omap1/board-ams-delta.h>
> drivers/video/omap/lcd_inn1510.c:#include <mach-omap1/hardware.h>
> drivers/video/omap/lcd_osk.c:#include <mach-omap1/mux.h>
> drivers/video/omap/lcdc.c:#include <mach-omap1/lcdc.h>
> sound/soc/omap/osk5912.c:#include <mach-omap1/hardware.h>
> 
> Same thing here.

I'm not seeing these either, you're probably looking at some
experimental branch modified with your automated scripts?

In any case, let's not have #include <mach-omap1/*.h> or
#include <mach-omap2/*.h> includes in the drivers, they are
wrong. Those headers are meant to be local, the legacy shared
headers should be in #include <mach/*.h>. Whatever needs to
be passed from arch/arm/*omap*/ to drivers, should be done
using include/linux/platform_data/*.h files.

For omap1, we might as well keep the existing ones from
#include <mach/*.h> as they are until somebody wants to fix
up things properly for omap1 for CONFIG_MULTIPLATFORM.

Regards,

Tony
