From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [GIT PULL] omap2 sparse fixes
Date: Thu, 30 Sep 2010 01:21:00 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB7FE8F9@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
 <20100923225851.GR4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
 <20100925001914.GO4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F917C@dbde02.ent.ti.com>
 <20100928152139.GB3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F94C9@dbde02.ent.ti.com>
 <20100928183157.GH3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39323 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab0I2TvZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 15:51:25 -0400
In-Reply-To: <20100928183157.GH3117@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>


Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Wednesday, September 29, 2010 12:02 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Samuel Ortiz; Dmitry 
> Torokhov; linux-mtd@lists.infradead.org; Russell King - ARM Linux
> Subject: Re: [GIT PULL] omap2 sparse fixes
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [100928 08:26]:
...

> Yes please take out all patches that are not in arch/arm/*omap*/ path.
> The others really should go to the driver maintainers.
> 
> Tony

Here is new branch which has only arch/arm/*omap*/ related patches.

-Manjunath

The following changes since commit 899611ee7d373e5eeda08e9a8632684e1ebbbf00:
  Linus Torvalds (1):
        Linux 2.6.36-rc6

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git omap_sparse_fixes

G, Manjunath Kondaiah (7):
      OMAP: mach-omap2: Fix incorrect assignment warnings
      OMAP: mach-omap2: Fix static declaration warnings
      OMAP: mach-omap2: Fix static function warnings
      OMAP: mach-omap2: Fix miscellaneous sparse warnings
      OMAP: plat-omap: Fix static function warnings
      OMAP: Convert write/read functions to raw read/write
      OMAP3: Keypad: Fix incorrect type initializer

 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                |    3 +-
 arch/arm/mach-omap2/board-am3517evm.c              |    5 +--
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    4 +-
 arch/arm/mach-omap2/board-igep0020.c               |    4 +-
 arch/arm/mach-omap2/board-ldp.c                    |    2 +-
 arch/arm/mach-omap2/board-n8x0.c                   |   16 +----------
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    8 +++---
 arch/arm/mach-omap2/board-omap3stalker.c           |    6 ++--
 arch/arm/mach-omap2/board-omap3touchbook.c         |    4 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    4 ++-
 arch/arm/mach-omap2/board-rx51-sdram.c             |    2 +-
 arch/arm/mach-omap2/board-rx51-video.c             |    2 +
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    4 ++-
 arch/arm/mach-omap2/control.c                      |    5 ++-
 arch/arm/mach-omap2/gpmc-onenand.c                 |    8 +++---
 arch/arm/mach-omap2/include/mach/board-flash.h     |    2 +
 arch/arm/mach-omap2/include/mach/board-rx51.h      |   11 ++++++++
 arch/arm/mach-omap2/io.c                           |    1 +
 arch/arm/mach-omap2/io.h                           |    7 +++++
 arch/arm/mach-omap2/irq.c                          |    1 -
 arch/arm/mach-omap2/mux2420.c                      |    2 +-
 arch/arm/mach-omap2/mux2430.c                      |    2 +-
 arch/arm/mach-omap2/mux34xx.c                      |   12 ++++----
 arch/arm/mach-omap2/pm-debug.c                     |    2 +-
 arch/arm/mach-omap2/pm34xx.c                       |    2 +-
 arch/arm/mach-omap2/powerdomain.c                  |   28 --------------------
 arch/arm/mach-omap2/prcm.c                         |    2 +-
 .../include/plat => mach-omap2}/timer-gp.h         |    3 +-
 arch/arm/plat-omap/cpu-omap.c                      |    4 +-
 arch/arm/plat-omap/dmtimer.c                       |    6 ++--
 arch/arm/plat-omap/fb.c                            |    2 +
 arch/arm/plat-omap/fb.h                            |   10 +++++++
 arch/arm/plat-omap/include/plat/dmtimer.h          |    4 ++-
 arch/arm/plat-omap/include/plat/sdrc.h             |    1 +
 arch/arm/plat-omap/include/plat/sram.h             |    1 -
 arch/arm/plat-omap/mcbsp.c                         |   10 +++---
 arch/arm/plat-omap/sram.c                          |   21 ++++++--------
 arch/arm/plat-omap/sram.h                          |    6 ++++
 43 files changed, 115 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/board-rx51.h
 create mode 100644 arch/arm/mach-omap2/io.h
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/timer-gp.h (86%)
 create mode 100644 arch/arm/plat-omap/fb.h
 create mode 100644 arch/arm/plat-omap/sram.h
