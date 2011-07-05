From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] non-critical omap fixes for v3.1 merge window
Date: Tue, 5 Jul 2011 03:23:50 -0700
Message-ID: <20110705102349.GE5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:37381 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750812Ab1GEKXz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 06:23:55 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

Hi Arnd,

Please pull some fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-fixes

These are intented for the merge window, there's no rush for
these to go in during the -rc cycle this late. I have one fix
queued for the -rc cycle still that I'll send separately.

The dmtimer fix in this series has a dependency to the cleanup
series you pulled earlier.

Regards,

Tony


The following changes since commit 48cb1258e8b0f8c81cfb699b42326c5b2147b3f8:
  Tony Lindgren (1):
        Merge branch 'for_3.1/pm-misc' of git://git.kernel.org/.../khilman/linux-omap-pm into devel-cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-fixes

Ambresh K (1):
      OMAP4: DMTIMER: enable autoidle mode

Charulatha V (1):
      omap: ZOOM: QUART: Request reset GPIO

Daniel Mack (1):
      omap: Overo: remove duplicate call to overo_ads7846_init()

Igor Grinberg (2):
      arm: omap3: cm-t35: minor comments fixes
      arm: omap3: cm-t35: fix slow path warning

Julia Lawall (1):
      arch/arm/mach-omap2/clock.c: add missing clk_put

Ohad Ben-Cohen (2):
      omap: iovmm: s/sg_dma_len(sg)/sg->length/
      OMAP4: iommu: fix clock name

Silesh C V (1):
      omap: HSMMC: Fix GPIO muxing

Suman Anna (1):
      omap: iommu: fix pte programming

Tony Lindgren (1):
      Merge branch 'iommu-for-tony' of git://github.com/ohadbc/omap-iommu into devel-fixes

 arch/arm/mach-omap2/board-cm-t35.c          |   18 +++++++-----------
 arch/arm/mach-omap2/board-overo.c           |    1 -
 arch/arm/mach-omap2/board-zoom-debugboard.c |    9 +++++++++
 arch/arm/mach-omap2/clock.c                 |    1 +
 arch/arm/mach-omap2/hsmmc.c                 |    7 +++----
 arch/arm/mach-omap2/iommu2.c                |    4 ++--
 arch/arm/mach-omap2/omap-iommu.c            |    2 +-
 arch/arm/plat-omap/dmtimer.c                |    4 ++--
 arch/arm/plat-omap/iovmm.c                  |    6 +++---
 9 files changed, 28 insertions(+), 24 deletions(-)
