From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH  0/24] omap4 for 2.6.34
Date: Tue, 16 Feb 2010 21:13:08 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF80C8@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF80C3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52062 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932628Ab0BPPnW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:43:22 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF80C3@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Ben Dooks <ben@fluff.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Resending with correct patch numbers. 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> Shilimkar, Santosh
> Sent: Tuesday, February 16, 2010 9:06 PM
> To: Tony Lindgren
> Cc: Ben Dooks; Samuel Ortiz; Kevin Hilman; Paul Walmsley; lrg@slimlogic.co.uk; linux-
> omap@vger.kernel.org
> Subject: [PATCH 0/24] omap4 for 2.6.34
> 
> Tony,
> Here are some patches towards upcoming 34 merge window. They are generated against
> linux-omap master as you suggested.
> 
> I am also copying Ben, Samuel, Liam, Paul and Kevin since some of the changes
> are in mfd, regulator, i2c and clocks.
> 
> The series enables most of the core driver like WDT, RTC, McBSP, Regulator,
> UART,DMA and I2C on omap4 platform. This series also has few fixes towards
> multi-omap build. It would be nice development platform for
> upcoming peripheral drivers like MMC, Keyboard, Ethernet, DSS, touch screen,
> audio etc.
> 
> The series is boot tested with multi-omap build (omap3_defconfig) on omap3430 sdp
> and omap4430 sdp. Also regular omap_4430sdp_defconfig and omap_3430sdp_defconfig
> boot tested.
> 
> The following changes since commit 301f2e037b161c79bf12f4194501c9ff9c12ced3:
>   Tony Lindgren (1):
>         Linux-omap rebuilt: dss board changes merged
> 
> Abhijit Pagare (3):
>       omap4: clocks: Make Uart driver's clock calls OMAP4 compatible
>       omap4: clokcs: Make gpio driver's clock calls OMAP4 compatible
>       omap4: clocks: Make i2c driver's clock calls OMAP4 compatible
> 
> Balaji T K (4):
>       twl6030: add base addr for ID0, ID1, ID2
>       omap4: add i2c1 peripherals data
>       omap4: add regulator board data for TWL6030
>       omap4: Enable RTC and regulator support
> 
> Rajendra Nayak (1):
>       twl6030: Fix vsel calculations in set/get voltage api's
> 
> Santosh Shilimkar (16):
>       omap 3/4: uart: fix full-fifo write abort
>       omap2/3/4: ioremap omap_globals module
>       omap4: sdma: Enable the idle modes on omap4
>       omap: sdma: Limit the secure reserve channel fix for omap3
>       omap4: Add needed IRQ line into irqs.h
>       omap4: Fix omap_type() for omap4
>       omap 3/4: Remove overlapping mapping of L4_WKUP io space
>       omap4: clocks: Make mcbsp driver's clock calls OMAP4 compatible
>       omap4: clocks: Make watchdog driver's clock calls OMAP4 compatible
>       omap4: clocks: Make dmtimer clocks calls OMAP4 compatible
>       omap4: clocks: Remove clock hacks from timer-gp.c
>       omap4: Enable WDT and McBSP support
>       omap4: clocks: Convert i2c clocks data to fclks
>       omap4: Add i2c support on omap4 platform
>       omap4: Add i2c board support for omap4 platform
>       omap4: multi-omap: Allow build to work
> 
>  arch/arm/configs/omap_4430sdp_defconfig   |   46 ++++++-
>  arch/arm/mach-omap2/board-4430sdp.c       |  186 +++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/clock44xx_data.c      |    8 +-
>  arch/arm/mach-omap2/control.c             |    6 +-
>  arch/arm/mach-omap2/id.c                  |    2 +
>  arch/arm/mach-omap2/io.c                  |   12 --
>  arch/arm/mach-omap2/prcm.c                |   16 ++-
>  arch/arm/mach-omap2/sdrc.c                |   11 ++-
>  arch/arm/mach-omap2/serial.c              |   55 +++++++--
>  arch/arm/mach-omap2/timer-gp.c            |    5 -
>  arch/arm/plat-omap/common.c               |   38 +++---
>  arch/arm/plat-omap/dma.c                  |    5 +-
>  arch/arm/plat-omap/dmtimer.c              |   25 +++-
>  arch/arm/plat-omap/gpio.c                 |    7 +-
>  arch/arm/plat-omap/i2c.c                  |   17 ++-
>  arch/arm/plat-omap/include/plat/common.h  |   12 +-
>  arch/arm/plat-omap/include/plat/control.h |    3 +
>  arch/arm/plat-omap/include/plat/io.h      |    9 --
>  arch/arm/plat-omap/include/plat/irqs.h    |    5 +
>  arch/arm/plat-omap/io.c                   |    4 -
>  arch/arm/plat-omap/mcbsp.c                |   13 ++-
>  drivers/i2c/busses/i2c-omap.c             |  169 ++++++++++++++++++++------
>  drivers/mfd/twl-core.c                    |    7 +-
>  drivers/regulator/twl-regulator.c         |   23 +++-
>  drivers/usb/musb/musb_core.c              |    4 +
>  drivers/watchdog/Kconfig                  |    6 +-
>  drivers/watchdog/omap_wdt.c               |   39 ++++--
>  include/linux/i2c/twl.h                   |    5 +
>  28 files changed, 576 insertions(+), 162 deletions(-)
> 
> 
> Regards,
> Santsoh
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
