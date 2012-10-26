From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap plat header removal for v3.8 merge window, part1
Date: Fri, 26 Oct 2012 14:02:19 +0000
Message-ID: <201210261402.19759.arnd@arndb.de>
References: <20121019023300.GN30550@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64551 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933042Ab2JZOC2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 10:02:28 -0400
In-Reply-To: <20121019023300.GN30550@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 19 October 2012, Tony Lindgren wrote:
> Hi Arnd & Olof,
> 
> Here's the first set of omap plat header removal for v3.8 merge
> window. I have at least one more related set coming, but I wanted
> to get these into linux next before driver patches add more
> things for me to chase down and fix.
> 
> Oh, forgot to mention in the tag that the increase in diffstat
> is mostly because plat-omap/clock shared clock code is duplicated
> as that's also needed for the common clock framework patches
> coming up.

Hi Tony,

This is very cool, great work! I'm sorry for taking so long before
we processed them, I wasn't coordinating well with Olof for the last
week.

I've applied all of it to a new next/headers branch. I thought about
using the next/cleanup branch, but since it touches a lot of files
outside of arch/arm, I decided to keep it separate. We might decide
to merge it later after all.

I tried running my old multiplatform scripts again and have a few
comments, but none of them serious:

$ git grep include.*mach-omap2
arch/arm/plat-omap/debug-devices.c:#include "../mach-omap2/debug-devices.h"
arch/arm/plat-omap/dma.c:#include "../mach-omap2/soc.h"
arch/arm/plat-omap/dmtimer.c:#include "../mach-omap2/omap-pm.h"
arch/arm/plat-omap/i2c.c:#include "../mach-omap2/soc.h"
arch/arm/plat-omap/include/plat/cpu.h:#include "../../mach-omap2/soc.h"
arch/arm/plat-omap/omap-pm-noop.c:#include "../mach-omap2/omap_device.h"
arch/arm/plat-omap/omap-pm-noop.c:#include "../mach-omap2/omap-pm.h"
arch/arm/plat-omap/sram.c:#include "../mach-omap2/soc.h"
arch/arm/plat-omap/sram.c:#include "../mach-omap2/iomap.h"
arch/arm/plat-omap/sram.c:#include "../mach-omap2/prm2xxx_3xxx.h"
arch/arm/plat-omap/sram.c:#include "../mach-omap2/sdrc.h"

I don't like the relative include paths too much. I would have preferred
adding the mach-omap2/include/mach path in the plat-omap Makefile, but
I suppose you want to leave it like it is now since you mention you 
have already built on top of it.

drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/powerdomain.h>
drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/clockdomain.h>
drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/cm2xxx_3xxx.h>
drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/prm-regbits-34xx.h>
drivers/staging/tidspbridge/core/_tiomap.h:#include <mach-omap2/cm-regbits-34xx.h>
drivers/staging/tidspbridge/core/tiomap3430_pwr.c:#include <mach-omap2/prm-regbits-34xx.h>
drivers/staging/tidspbridge/core/tiomap3430_pwr.c:#include <mach-omap2/cm-regbits-34xx.h>
drivers/staging/tidspbridge/rmgr/drv_interface.c:#include <mach-omap2/omap3-opp.h>

This code is broken now. I wonder whether it's time to remove it from
staging since we now have rpmsg/remoteproc, rather than getting it to
compile again.

sound/soc/omap/am3517evm.c:#include <mach-omap2/hardware.h>
sound/soc/omap/am3517evm.c:#include <mach-omap2/gpio.h>
sound/soc/omap/ams-delta.c:#include <mach-omap2/board-ams-delta.h>
sound/soc/omap/n810.c:#include <mach-omap2/hardware.h>
sound/soc/omap/sdp3430.c:#include <mach-omap2/hardware.h>
sound/soc/omap/sdp3430.c:#include <mach-omap2/gpio.h>
sound/soc/omap/zoom2.c:#include <mach-omap2/hardware.h>
sound/soc/omap/zoom2.c:#include <mach-omap2/gpio.h>
sound/soc/omap/zoom2.c:#include <mach-omap2/board-zoom.h>

Not sure if you were just missing these or if you already have other
patch lined up for them.

$ git grep include.*mach-omap1
drivers/video/omap/lcd_ams_delta.c:#include <mach-omap1/board-ams-delta.h>
drivers/video/omap/lcd_inn1510.c:#include <mach-omap1/hardware.h>
drivers/video/omap/lcd_osk.c:#include <mach-omap1/mux.h>
drivers/video/omap/lcdc.c:#include <mach-omap1/lcdc.h>
sound/soc/omap/osk5912.c:#include <mach-omap1/hardware.h>

Same thing here.

	Arnd
