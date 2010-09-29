From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Wed, 29 Sep 2010 20:21:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02BAE@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36804 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab0I2Ovt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 10:51:49 -0400
In-Reply-To: <8762xpenf8.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>


Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, September 28, 2010 11:55 PM
> To: linux-omap@vger.kernel.org
> Cc: Varadarajan, Charulatha; Nayak, Rajendra; Raja, Govindraj
> Subject: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog,
> UART, i2c
> 
> Tony,
> 
> The following pull request will bring hwmod driver conversions for
> watchdog, UART and i2c drivers.  It is based on your omap-for-linus
> branch.
> 
> The i2c driver is waiting for final signoff/ack from the upstream
> subsystem maintainers, but are otherwise ready to go for broader
> testing.  After I get the final ack, I will update the branch for a
> final pull.
> 
> In the meantime, I'd like to get them into l-o master (or omap-testing)
> for broader testing.
> 
> Note this also depends on a handful of patches from my pm-backports
> branch, most of which you have picked into omap-testing, except for the
> one I just posted to linux-arm-kernel:
> 
>    ARM: add cpu_idle_wait() to support CPUidle on SMP systems.
> 
> This one is required now that the default config enables SMP.
> 
> Charu, Rajendra, Govindraj, since all of the hwmod data changes touch
> the same files, pulling these together meant I had to manually merge
> these together.  Please do a sanity check of the resulting merge.
> Thanks.

Minor observations as mentioned below.

> 
> Kevin
> 
> 
> The following changes since commit
> b6a26b4b87d7b030a546e7bdaf390ffc58323f36:

<<snip>>

> 
>  arch/arm/mach-omap1/devices.c                 |   27 +
>  arch/arm/mach-omap2/Kconfig                   |   11 +-
>  arch/arm/mach-omap2/board-3630sdp.c           |    1 -
>  arch/arm/mach-omap2/board-zoom-peripherals.c  |    1 +
>  arch/arm/mach-omap2/clock3xxx_data.c          |   22 +
>  arch/arm/mach-omap2/cm-regbits-24xx.h         |    4 +
>  arch/arm/mach-omap2/cm-regbits-34xx.h         |    2 +
>  arch/arm/mach-omap2/devices.c                 |   39 +
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c    |  397 ++++++++-

"cm-regbits-24xx.h" is included twice in this file

>  arch/arm/mach-omap2/omap_hwmod_2430_data.c    |  410 ++++++++-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  549 ++++++++++-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  605 +++++++++++

The order of hwmod structures for different modules are mixed up.
Example, under 'wd_timer' class, uart sysc definitions are placed.

>  arch/arm/mach-omap2/pm34xx.c                  |   17 +-
>  arch/arm/mach-omap2/prcm-common.h             |    5 +
>  arch/arm/mach-omap2/prm-regbits-34xx.h        |    4 +
>  arch/arm/mach-omap2/serial.c                  |  555 ++++++-----
>  arch/arm/plat-omap/common.c                   |   16 -
>  arch/arm/plat-omap/devices.c                  |   41 -
>  arch/arm/plat-omap/i2c.c                      |  124 +--
>  arch/arm/plat-omap/include/plat/common.h      |    1 -
>  arch/arm/plat-omap/include/plat/dma.h         |    2 +
>  arch/arm/plat-omap/include/plat/i2c.h         |   13 +
>  arch/arm/plat-omap/include/plat/irqs.h        |    2 +
>  arch/arm/plat-omap/include/plat/l4_3xxx.h     |   24 +
>  arch/arm/plat-omap/include/plat/omap-serial.h |  129 +++
>  drivers/i2c/busses/i2c-omap.c                 |   69 +-
>  drivers/serial/Kconfig                        |   27 +
>  drivers/serial/Makefile                       |    1 +
>  drivers/serial/omap-serial.c                  | 1333
> +++++++++++++++++++++++++
>  drivers/watchdog/omap_wdt.c                   |   42 +-
>  include/linux/i2c-omap.h                      |    5 +
>  include/linux/serial_core.h                   |    3 +
>  32 files changed, 3984 insertions(+), 497 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/l4_3xxx.h
>  create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
>  create mode 100644 drivers/serial/omap-serial.c
