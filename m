From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.2-rc2
Date: Sat, 19 Nov 2011 11:44:08 -0800
Message-ID: <20111119194408.GD31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54979 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752159Ab1KSToM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Nov 2011 14:44:12 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Most of this pull request are fixes needed by Tomi for the
display driver clocking.

Regards,

Tony


The following changes since commit 6aaf05f472c97ebceff47d9eef464574f1a55727:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git390.marist.edu/pub/scm/linux-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Archit Taneja (1):
      ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if display is enabled in bootloader

Felipe Balbi (1):
      arm: omap: smartreflex: fix IRQ handling bug

Govindraj.R (1):
      ARM: OMAP2+: Fix Compilation error when omap_l3_noc built as module

Kevin Hilman (2):
      ARM: OMAP3: CPUidle: include <linux/export.h>
      ARM: OMAP: PM: only register TWL with voltage layer when device is present

Ming Lei (1):
      arm: omap2: select ARM_AMBA if OMAP3_EMU is defined

Thomas Weber (1):
      ARM: OMAP2+: Remove empty io.h

Tomi Valkeinen (9):
      ARM: OMAP2xxx: HWMOD: Fix DSS reset
      ARM: OMAP2xxx: HWMOD: fix DSS clock data
      ARM: OMAP3: HWMOD: Fix DSS reset
      ARM: OMAP3: HWMOD: fix DSS clock data
      ARM: OMAP4: HWMOD: remove extra clocks
      ARM: OMAP4: HWMOD: Add HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core
      ARM: OMAP4: HWMOD: fix DSS clock data
      ARM: OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
      ARM: OMAP: HWMOD: Unify DSS resets for OMAPs

Tony Lindgren (6):
      ARM: OMAP: Fix map_io for Amstrad E3
      ARM: OMAP: Fix dpll_data compile error when omap2 only is selected
      ARM: OMAP: Fix reprogramming of dpll1 rate
      Merge branch 'for_3.2-rc/hwmod-fixes' of git://gitorious.org/omap-pm/linux into fixes
      Merge branch 'for_3.2/fixes/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes
      Merge branch 'hwmod_dss_fixes_3.2rc' of git://git.pwsan.com/linux-2.6 into fixes

sricharan (1):
      ARM: OMAP: hwmod: Fix the addr space, irq, dma count APIs

 arch/arm/configs/omap1_defconfig                   |    1 -
 arch/arm/mach-omap1/Kconfig                        |    8 -
 arch/arm/mach-omap1/board-ams-delta.c              |   10 +-
 arch/arm/mach-omap1/clock.h                        |    3 +-
 arch/arm/mach-omap1/clock_data.c                   |   53 ++++---
 arch/arm/mach-omap1/devices.c                      |    3 +
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/Makefile                       |    5 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |    1 +
 arch/arm/mach-omap2/display.c                      |  159 ++++++++++++++++++++
 arch/arm/mach-omap2/display.h                      |   29 ++++
 arch/arm/mach-omap2/omap_hwmod.c                   |    6 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   17 ++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   17 ++-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   37 ++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   24 ++--
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |    4 +
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    4 +
 arch/arm/mach-omap2/omap_l3_noc.c                  |    2 +-
 arch/arm/mach-omap2/pm.c                           |    6 +-
 arch/arm/mach-omap2/smartreflex.c                  |    2 +-
 arch/arm/mach-omap2/twl-common.c                   |   11 ++
 arch/arm/mach-omap2/twl-common.h                   |    3 +
 arch/arm/plat-omap/include/plat/clock.h            |    2 +-
 arch/arm/plat-omap/include/plat/common.h           |    3 +
 include/video/omapdss.h                            |    7 -
 27 files changed, 346 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm/mach-omap2/display.h
 delete mode 100644 arch/arm/mach-omap2/io.h
