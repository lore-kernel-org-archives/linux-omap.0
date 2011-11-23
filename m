From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.2-rc2, take 2
Date: Wed, 23 Nov 2011 15:55:29 -0800
Message-ID: <20111123235529.GK31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61086 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1KWXzc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 18:55:32 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

This one has the DSS patches left out, some patches sent to
stable, and based on -rc2.

Regards,

Tony

The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
  Linus Torvalds (1):
        Linux 3.2-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Felipe Balbi (1):
      ARM: OMAP: smartreflex: fix IRQ handling bug

Govindraj.R (1):
      ARM: OMAP2+: Fix Compilation error when omap_l3_noc built as module

Kevin Hilman (2):
      ARM: OMAP3: CPUidle: include <linux/export.h>
      ARM: OMAP: PM: only register TWL with voltage layer when device is present

Ming Lei (1):
      ARM: OMAP2: select ARM_AMBA if OMAP3_EMU is defined

Thomas Weber (1):
      ARM: OMAP2+: Remove empty io.h

Tony Lindgren (4):
      ARM: OMAP: Fix map_io for Amstrad E3
      ARM: OMAP: Fix dpll_data compile error when omap2 only is selected
      ARM: OMAP: Fix reprogramming of dpll1 rate
      Merge branch 'fixes-v3.2-rc2' into fixes

sricharan (1):
      ARM: OMAP: hwmod: Fix the addr space, irq, dma count APIs

 arch/arm/configs/omap1_defconfig        |    1 -
 arch/arm/mach-omap1/Kconfig             |    8 -----
 arch/arm/mach-omap1/board-ams-delta.c   |   10 ++++--
 arch/arm/mach-omap1/clock.h             |    3 +-
 arch/arm/mach-omap1/clock_data.c        |   53 ++++++++++++++++++++-----------
 arch/arm/mach-omap1/devices.c           |    3 ++
 arch/arm/mach-omap2/Kconfig             |    1 +
 arch/arm/mach-omap2/cpuidle34xx.c       |    1 +
 arch/arm/mach-omap2/omap_hwmod.c        |    6 ++--
 arch/arm/mach-omap2/omap_l3_noc.c       |    2 +-
 arch/arm/mach-omap2/pm.c                |    6 +--
 arch/arm/mach-omap2/smartreflex.c       |    2 +-
 arch/arm/mach-omap2/twl-common.c        |   11 ++++++
 arch/arm/mach-omap2/twl-common.h        |    3 ++
 arch/arm/plat-omap/include/plat/clock.h |    2 +-
 15 files changed, 70 insertions(+), 42 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/io.h
