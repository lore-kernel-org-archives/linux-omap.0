From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V5 0/6] OMAPDSS: Cleanup cpu_is checks
Date: Thu, 30 Aug 2012 10:19:08 -0700
Message-ID: <20120830171908.GQ1303@atomide.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <cover.1345468541.git.cmahapatra@ti.com>
 <20120830002039.GP1303@atomide.com>
 <1346312061.2327.27.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34513 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2H3RTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 13:19:13 -0400
Content-Disposition: inline
In-Reply-To: <1346312061.2327.27.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120830 00:35]:
> On Wed, 2012-08-29 at 17:20 -0700, Tony Lindgren wrote:
> > 
> > Good to see this, we need this badly to avoid blocking
> > single zImage effort on omaps. Can you also please take
> 
> What is the issue with single zImage? How do cpu_is_ check affect it?

The usage for that should only be limited to arch/arm/mach-omap2
so we can make cpu.h local as we can't include mach and plat
header files from the drivers with single zImage.
 
> I had a brief look at drivers/video/omap*. Here's a brief status. I
> don't really know much about the old fb driver (drivers/video/omap) so
> my comments may not be totally correct. And all fixing I do there is
> done in blind, I don't have any omap1 devices.
> 
> I've left out the trivial cleanups from the list (i.e. file includes a
> header that it doesn't need), there were a bunch of those. I'll make a
> patch for these.
> 
> 
> $ git grep -E "<plat|<mach" drivers/video/omap*
> drivers/video/omap/lcd_ams_delta.c:#include <plat/board-ams-delta.h>
> * Needs to be moved

Yes, that should be either mach/board-ams-delta.h, or separate driver
specific headers in include/linux/platform_data. For omap1 we are not
planning common zImage support, so let's just make sure we're not
breaking anything there as people are still using it.

> * lcd_ams_delta uses also omap_write/read

Limiting omap_write/read to omap1 is OK for now, unless the fix
is trivial to do with ioremap + readw/writew.
 
> drivers/video/omap/lcd_inn1510.c:#include <plat/fpga.h>
> * No idea about this. Who wants to convert the fpga support? =)

I'll move it to mach/fpga.h as it's omap1 specifc.
 
> drivers/video/omap/lcd_mipid.c:#include <plat/lcd_mipid.h>
> * Needs to be moved
> 
> drivers/video/omap/lcd_osk.c:#include <plat/mux.h>
> * Uses omap_cfg_reg(PWL). I don't know what this is...

I'll move plat/mux.h into mach for omap1. For omap2+, we have
a local mux.h and are moving to use device tree based pinctrl-single
driver.

> * lcd_osk.c uses omap_write/read
> 
> drivers/video/omap/lcdc.c:#include <mach/lcdc.h>
> * Needs to be moved

This you can move to platform_data or mach for omap1?
 
> drivers/video/omap/lcdc.c:#include <plat/dma.h>
> * Uses arch/arm/mach-omap1/lcd_dma.c. Any idea about this? Will DMA
> engine support OMAP1's LCD DMA?

I think it should eventually as it can detect the device and could
automatically call those functions. Not sure if all options for
configuring it are available yet in dma engine.
 
> drivers/video/omap/omapfb_main.c:#include <plat/dma.h>
> * Uses DMA API to set DMA priority
> 
> drivers/video/omap/sossi.c:#include <plat/dma.h>
> * Uses arch/arm/mach-omap1/lcd_dma.c
> 
> drivers/video/omap2/dss/dss.c:#include <plat/cpu.h>
> * Uses cpu_is_* to find out the DSS version. dispc.c also uses cpu_is_*
> functions, but doesn't include plat/cpu.h. I know cpu_is_* checks should
> be removed, but is there some other file to include for the time being
> than plat/cpu.h?

We could make it mach/cpu.h for omap1, but ideally we would just
pass DSS_VERSION_XYZ type flag in platform data on omap1.
 
> drivers/video/omap2/dss/dss_features.c:#include <plat/cpu.h>
> * Uses cpu_is_* to find out the DSS version

Here too.
 
> drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vrfb.h>
> drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vram.h>
> drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vram.h>
> drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vrfb.h>
> drivers/video/omap2/omapfb/omapfb-sysfs.c:#include <plat/vrfb.h>
> drivers/video/omap2/vram.c:#include <plat/vram.h>
> drivers/video/omap2/vram.c:#include <plat/dma.h>
> drivers/video/omap2/vrfb.c:#include <plat/vrfb.h>
> drivers/video/omap2/vrfb.c:#include <plat/sdrc.h>
> 
> Of these, I'm not sure how to handle.

These should eventually be in platform_data as driver specific headers.
 
> Grep shows that vram.c is only used by (the newer) omapfb, so it could
> be considered a part of that driver. It still needs to be built-in, as
> it needs to reserve memory early in the boot process (done with a call
> from arch/arm/plat-omap/common.c).

Hmm it sounds like omap_vram_reserve_sdram_memblock() should be in
plat-omap and just pass the pointer for later use for vram.c.
 
> Also board files can use a func call to define the amount of memory to
> allocate, but only rx51 seems to do this in the mainline.
> 
> Anyway, I believe vram.c is going away when we start to use CMA.

OK cool. 
 
> As for vrfb... I'm not really sure where it belongs. It is used by the
> newer omapfb and OMAP V4L2 driver. VRFB is a part of the OMAP's memory
> controller, so I'm not sure if it's really a normal driver.

Maybe just split it to platform code for the memblock stuff and pass
the necessary information to the driver in platform_data?

Regards,

Tony

