From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for 2.6.35-rc3
Date: Wed, 30 Jun 2010 14:39:19 +0300
Message-ID: <20100630113919.GB2822@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

These all should match your "major bugs or regressions" criteria for
various omaps :)

Regards,

Tony


The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:

  Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Amit Kucheria (1):
      omap: fix build failure due to missing include dma-mapping.h

Benoit Cousson (1):
      OMAP: hwmod: Fix the missing braces

Kevin Hilman (2):
      omap: GPIO: fix auto-disable of debounce clock
      OMAP3: PM: fix IO daisy chain enable to use PM_WKEN reg

Santosh Shilimkar (2):
      omap: Stalker board: switch over to gpio_set_debounce
      OMAP4: clock: Fix multi-omap boot with reset un-used clocks

Satish (1):
      omap iommu: Fix Memory leak

Tero Kristo (1):
      omap: DMTIMER: Ack pending interrupt always when stopping a timer

Tony Lindgren (1):
      Merge branch 'for_2.6.35rc' of git://git.pwsan.com/linux-2.6 into omap-fixes-for-linus

 arch/arm/mach-omap2/board-omap3stalker.c |    4 +---
 arch/arm/mach-omap2/clock44xx_data.c     |    2 ++
 arch/arm/mach-omap2/omap_hwmod.c         |    9 ++++++---
 arch/arm/mach-omap2/pm34xx.c             |    4 ++--
 arch/arm/mach-omap2/usb-ehci.c           |    2 ++
 arch/arm/plat-omap/dmtimer.c             |    6 +++---
 arch/arm/plat-omap/gpio.c                |    1 +
 arch/arm/plat-omap/iovmm.c               |    4 +++-
 8 files changed, 20 insertions(+), 12 deletions(-)
