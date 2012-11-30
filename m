From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/3] omap late multiplatform cleanup for v3.8 merge
 window
Date: Fri, 30 Nov 2012 09:26:43 -0800
Message-ID: <20121130172643.GI5312@atomide.com>
References: <pull-1353978372-642963>
 <50b4120b.d088e50a.742e.ffffd3d3SMTPIN_ADDED_MISSING@mx.google.com>
 <20121130065314.GB6899@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:55400 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750709Ab2K3R0u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Nov 2012 12:26:50 -0500
Content-Disposition: inline
In-Reply-To: <20121130065314.GB6899@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [121129 22:55]:
> On Mon, Nov 26, 2012 at 05:06:12PM -0800, Tony Lindgren wrote:
> > The following changes since commit 0f9cb211ba5db93d488fe6b154138231fdd0e22d:
> > 
> >   Merge tag 'v3.7-rc7' into next/cleanup (2012-11-25 21:34:34 -0800)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-multiplatform-v2-signed
> > 
> > for you to fetch changes up to 5ebb428d045ea9b908864547819786d5bcebad05:
> > 
> >   ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h (2012-11-26 13:19:23 -0800)
> 
> Tony,
> 
> Did you mean to base this branch on next/cleanup? We normally try to avoid
> having vendor branches based on our common next/* branches, since it adds
> dependencies that makes it hard to rebuild our branch if needed for some
> reason.

Sorry I should have asked before. I wanted to base this on something
that compiles for with multiplatform support and is bootable with
minimal patching and does not produce new merge conflicts.

But I only need the resulting branch for testing, so as long as we
the resulting arm-soc/for-next branch is usable for me until -rc1
is out, I'll be happy.

For merging, the dependencies for these three patches are:

omap-for-v3.8/cleanup-fixes-part2-v2-signed (all the header clean-up)
omap-for-v3.8/devel-prcm-signed (needed the wdt changes)

So I've merged those two to use as a base, the patches on top
are the same. Hope that works for you better.

It's now missing the common clock changes, but that's OK as the
branch does not yet enable the multiplatform support. Updated pull
request below.

BTW, note that "[GIT PULL] omap iommu clean-up dependency branch for
v3.8 merge window" is still pending it seems?

Regards,

Tony


The following changes since commit 2589d056122f6dcb405d411eae872aac8cf9da1b:

  Merge tag 'tags/omap-for-v3.8/devel-prcm-signed' into omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3 (2012-11-30 08:40:31 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/tags/omap-for-v3.8/cleanup-multiplatform-no-clock-signed

for you to fetch changes up to 45c3eb7d3a07eb08d1b5b0f5983a996d41610b84:

  ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h (2012-11-30 08:41:50 -0800)

----------------------------------------------------------------
Remaining patches to allow omap2+ to build with multiplatform
enabled. Unfortunately the DMA header patch had to be redone
to avoid adding new multiplatform specific include paths, the
other patches are just trivial compile fixes.

Note that this does not yet contain the necessary Kconfig
changes as we are still waiting for some drivers to get
fixed up first.

----------------------------------------------------------------
Tony Lindgren (3):
      watchdog: OMAP: fixup for ARM multiplatform support
      ASoC: OMAP: mcbsp fixes for enabling ARM multiplatform support
      ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h

 arch/arm/mach-omap1/board-h2.c                     |   2 +-
 arch/arm/mach-omap1/board-h3.c                     |   2 +-
 arch/arm/mach-omap1/board-palmte.c                 |   2 +-
 arch/arm/mach-omap1/board-palmtt.c                 |   2 +-
 arch/arm/mach-omap1/board-palmz71.c                |   2 +-
 arch/arm/mach-omap1/board-sx1.c                    |   2 +-
 arch/arm/mach-omap1/dma.c                          |   2 +-
 arch/arm/mach-omap1/io.c                           |   2 +-
 arch/arm/mach-omap1/lcd_dma.c                      |   2 +-
 arch/arm/mach-omap1/mcbsp.c                        |   2 +-
 arch/arm/mach-omap1/pm.c                           |   2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |   2 +-
 arch/arm/mach-omap2/board-h4.c                     |   2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   2 +-
 arch/arm/mach-omap2/board-rx51.c                   |   2 +-
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/dma.c                          |   2 +-
 arch/arm/mach-omap2/io.c                           |   2 +-
 arch/arm/mach-omap2/mcbsp.c                        |   2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   2 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   3 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   2 +-
 arch/arm/mach-omap2/pm24xx.c                       |   2 +-
 arch/arm/mach-omap2/pm34xx.c                       |   3 +-
 arch/arm/mach-omap2/serial.c                       |   2 +-
 arch/arm/plat-omap/dma.c                           |   2 +-
 arch/arm/plat-omap/include/plat-omap/dma-omap.h    | 377 ---------------------
 drivers/crypto/omap-aes.c                          |   2 +-
 drivers/crypto/omap-sham.c                         |   2 +-
 drivers/dma/omap-dma.c                             |   2 -
 drivers/media/platform/omap/omap_vout.c            |   2 +-
 drivers/media/platform/omap/omap_vout_vrfb.c       |   2 +-
 drivers/media/platform/omap3isp/ispstat.h          |   2 +-
 drivers/media/platform/soc_camera/omap1_camera.c   |   2 +-
 drivers/mtd/nand/omap2.c                           |   1 -
 drivers/mtd/onenand/omap2.c                        |   2 +-
 drivers/usb/gadget/omap_udc.c                      |   2 +-
 drivers/usb/musb/tusb6010_omap.c                   |   2 +-
 drivers/video/omap/lcdc.c                          |   2 +-
 drivers/video/omap/omapfb_main.c                   |   2 +-
 drivers/video/omap/sossi.c                         |   2 +-
 drivers/watchdog/omap_wdt.c                        |   2 -
 include/linux/omap-dma.h                           | 366 ++++++++++++++++++++
 sound/soc/omap/mcbsp.c                             |   4 +-
 sound/soc/omap/mcbsp.h                             |   6 +
 sound/soc/omap/omap-mcbsp.c                        |   5 +-
 49 files changed, 417 insertions(+), 430 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat-omap/dma-omap.h
