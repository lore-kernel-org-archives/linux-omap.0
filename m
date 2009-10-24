From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap-fixes for v2.6.32-rc5
Date: Sat, 24 Oct 2009 14:36:55 -0700
Message-ID: <20091024213655.GM16230@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54113 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZJXVhA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Oct 2009 17:37:00 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 012abeea669ea49636cf952d13298bb68654146a:
  Linus Torvalds (1):
        Linux 2.6.32-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Hiroshi DOYU (1):
      omap: iommu: fix wrong condition check for SUPERSECTION

Janusz Krzysztofik (3):
      omap: Fix omap-keypad by restoring old keypad.h without breaking omap2 boards that use matrix_keypad
      omap1: Fix redundant UARTs pin muxing that can break other hardware support
      omap1: Fix DSP public peripherals support for ams-delta

Kevin Hilman (1):
      omap3: PM: enable UART3 module wakeups

Santosh Shilimkar (3):
      omap: SDMA: Fix omap_stop_dma() API for channel linking
      omap4: Allow omap_serial_early_init() for OMAP4430 board
      omap4: Fix UART4 platform data on omap4

Tony Lindgren (2):
      omap2: Fix detection of n8x0
      omap2: Fix console serial port number for n8x0

 arch/arm/configs/n8x0_defconfig              |    2 +-
 arch/arm/mach-omap1/board-ams-delta.c        |    6 ++++++
 arch/arm/mach-omap1/board-generic.c          |    8 ++++++++
 arch/arm/mach-omap1/board-innovator.c        |   20 ++++++++++++++++++++
 arch/arm/mach-omap1/board-palmte.c           |    8 ++++++++
 arch/arm/mach-omap1/board-palmtt.c           |    8 ++++++++
 arch/arm/mach-omap1/board-palmz71.c          |    8 ++++++++
 arch/arm/mach-omap1/board-sx1.c              |    8 ++++++++
 arch/arm/mach-omap1/board-voiceblue.c        |    8 ++++++++
 arch/arm/mach-omap1/serial.c                 |   26 --------------------------
 arch/arm/mach-omap2/Kconfig                  |   12 ++++++++++++
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    4 ++--
 arch/arm/mach-omap2/board-ldp.c              |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-rx51.c             |    1 -
 arch/arm/mach-omap2/board-zoom2.c            |    2 +-
 arch/arm/mach-omap2/io.c                     |    2 ++
 arch/arm/mach-omap2/pm34xx.c                 |    7 ++++---
 arch/arm/mach-omap2/serial.c                 |   10 ----------
 arch/arm/plat-omap/dma.c                     |   18 ++++++++----------
 arch/arm/plat-omap/include/mach/keypad.h     |    5 ++++-
 arch/arm/plat-omap/iommu.c                   |    2 +-
 25 files changed, 114 insertions(+), 61 deletions(-)
