From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/6] omap prcm cleanup for v3.8 merge window, part2
Date: Tue, 13 Nov 2012 11:07:10 -0800
Message-ID: <20121113190710.GE6801@atomide.com>
References: <pull-1352828737-887235>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41462 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751292Ab2KMTHP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 14:07:15 -0500
Content-Disposition: inline
In-Reply-To: <pull-1352828737-887235>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33:

  Merge branch 'omap-for-v3.8/cleanup-headers' into omap-for-v3.8/cleanup-prcm (2012-10-26 13:32:22 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-prcm-part2-signed

for you to fetch changes up to cc4b1e24b93dd529b1d49258bee044d319b5b129:

  ARM: OMAP2: Fix compillation error in cm_common (2012-11-12 13:42:46 -0800)

----------------------------------------------------------------
More PRCM cleanups via Paul Walmsley <paul@pwsan.com>:

Second set of OMAP PRCM cleanups for 3.8.

These patches remove the use of omap_prcm_get_reset_sources() from the
OMAP watchdog driver, and remove mach-omap2/prcm.c and
plat-omap/include/plat/prcm.h.

Basic test logs for this branch on top of Tony's cleanup-prcm branch
at commit 7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33 are here:

    http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121108151646/

However, cleanup-prcm at 7fc54fd3 does not include some fixes
that are needed for a successful test.  With several reverts,
fixes, and workarounds applied, the following test logs were
obtained:

    http://www.pwsan.com/omap/testlogs/TEST_prcm_cleanup_b_3.8/20121108151930/

which indicate that the series tests cleanly.

This second pull request updates one of the patches which broke
with rmk's allnoconfigs, and also updates the tag description to
indicate that 7fc54fd3 is building cleanly here.

----------------------------------------------------------------
Paul Walmsley (17):
      ARM: OMAP1: CGRM: fix omap1_get_reset_sources() return type
      ARM: OMAP2+: WDT: move init; add read_reset_sources pdata function pointer
      watchdog: OMAP: use standard GETBOOTSTATUS interface; use platform_data fn ptr
      ARM: OMAP2+: PRCM: remove omap_prcm_get_reset_sources()
      ARM: OMAP2+: common: remove mach-omap2/common.c globals and map_common_io code
      ARM: OMAP2/3: PRM: add SoC reset functions (using the CORE DPLL method)
      ARM: OMAP2xxx: clock: remove global 'dclk' variable
      ARM: OMAP2xxx: clock: move virt_prcm_set code into clkt2xxx_virt_prcm_set.c
      ARM: OMAP2+: PRCM: create SoC-specific chip restart functions
      ARM: OMAP2+: board files: use SoC-specific system restart functions
      ARM: OMAP2xxx: APLL/CM: convert to use omap2_cm_wait_module_ready()
      ARM: OMAP2+: CM/clock: convert _omap2_module_wait_ready() to use SoC-independent CM functions
      ARM: OMAP2+: PRCM: remove omap2_cm_wait_idlest()
      ARM: OMAP2+: PRCM: split and relocate the PRM/CM globals setup
      ARM: OMAP2+: PRCM: consolidate PRCM-related timeout macros
      ARM: OMAP2+: hwmod: call to _omap4_disable_module() should use the SoC-specific call
      ARM: OMAP2+: PRCM: remove obsolete prcm.[ch]

Peter Ujfalusi (1):
      ARM: OMAP2: Fix compillation error in cm_common

Tony Lindgren (1):
      Merge tag 'omap-cleanup-b2-for-3.8' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.8/cleanup-prcm

 arch/arm/mach-omap1/common.h                 |   2 +-
 arch/arm/mach-omap1/devices.c                |  21 ++-
 arch/arm/mach-omap1/reset.c                  |   9 +-
 arch/arm/mach-omap2/Makefile                 |   7 +-
 arch/arm/mach-omap2/am33xx.h                 |   1 +
 arch/arm/mach-omap2/board-2430sdp.c          |   2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |   2 +-
 arch/arm/mach-omap2/board-3630sdp.c          |   2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |   2 +-
 arch/arm/mach-omap2/board-am3517crane.c      |   2 +-
 arch/arm/mach-omap2/board-am3517evm.c        |   2 +-
 arch/arm/mach-omap2/board-apollon.c          |   2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |  18 +--
 arch/arm/mach-omap2/board-cm-t3517.c         |   2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |   2 +-
 arch/arm/mach-omap2/board-generic.c          |  10 +-
 arch/arm/mach-omap2/board-h4.c               |   2 +-
 arch/arm/mach-omap2/board-igep0020.c         |   4 +-
 arch/arm/mach-omap2/board-ldp.c              |   2 +-
 arch/arm/mach-omap2/board-n8x0.c             |   6 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |   2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |   2 +-
 arch/arm/mach-omap2/board-omap3logic.c       |   4 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |   2 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |   2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |   2 +-
 arch/arm/mach-omap2/board-omap4panda.c       |   2 +-
 arch/arm/mach-omap2/board-overo.c            |   2 +-
 arch/arm/mach-omap2/board-rm680.c            |   4 +-
 arch/arm/mach-omap2/board-rx51.c             |   2 +-
 arch/arm/mach-omap2/board-ti8168evm.c        |   4 +-
 arch/arm/mach-omap2/board-zoom.c             |   4 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c          |  57 ++------
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |  36 ++++-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |  70 ++++++++--
 arch/arm/mach-omap2/clkt_iclk.c              |   1 -
 arch/arm/mach-omap2/clock.c                  |  57 +++++++-
 arch/arm/mach-omap2/clock.h                  |  28 ----
 arch/arm/mach-omap2/clock2420_data.c         |  26 +---
 arch/arm/mach-omap2/clock2430_data.c         |  26 +---
 arch/arm/mach-omap2/clock2xxx.c              |  16 ---
 arch/arm/mach-omap2/clock2xxx.h              |   9 +-
 arch/arm/mach-omap2/cm-regbits-24xx.h        |   2 +
 arch/arm/mach-omap2/cm.h                     |  20 ++-
 arch/arm/mach-omap2/cm2xxx.c                 | 128 +++++++++++++++++-
 arch/arm/mach-omap2/cm2xxx.h                 |   4 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h            |   8 +-
 arch/arm/mach-omap2/cm3xxx.c                 |  66 ++++++++++
 arch/arm/mach-omap2/cm3xxx.h                 |   5 +
 arch/arm/mach-omap2/cm_common.c              |  71 +++++++++-
 arch/arm/mach-omap2/cminst44xx.h             |   2 +
 arch/arm/mach-omap2/common.c                 | 183 --------------------------
 arch/arm/mach-omap2/common.h                 | 133 +++++--------------
 arch/arm/mach-omap2/control.c                |  10 +-
 arch/arm/mach-omap2/control.h                |   2 +
 arch/arm/mach-omap2/cpuidle34xx.c            |   1 -
 arch/arm/mach-omap2/devices.c                |  26 ----
 arch/arm/mach-omap2/display.c                |   2 +-
 arch/arm/mach-omap2/hdq1w.c                  |   4 +-
 arch/arm/mach-omap2/i2c.c                    |   6 +-
 arch/arm/mach-omap2/id.c                     |   7 +-
 arch/arm/mach-omap2/io.c                     |  86 +++++++++---
 arch/arm/mach-omap2/mcbsp.c                  |   2 +-
 arch/arm/mach-omap2/msdi.c                   |   4 +-
 arch/arm/mach-omap2/omap2-restart.c          |  65 +++++++++
 arch/arm/mach-omap2/omap3-restart.c          |  36 +++++
 arch/arm/mach-omap2/omap4-common.c           |  19 +++
 arch/arm/mach-omap2/omap_hwmod.c             |   8 +-
 arch/arm/mach-omap2/pm34xx.c                 |   1 -
 arch/arm/mach-omap2/powerdomain.c            |   2 -
 arch/arm/mach-omap2/prcm-common.h            |  22 ----
 arch/arm/mach-omap2/prcm.c                   | 189 ---------------------------
 arch/arm/mach-omap2/prcm_mpu44xx.c           |  17 +++
 arch/arm/mach-omap2/prcm_mpu44xx.h           |   9 +-
 arch/arm/mach-omap2/prm.h                    |  24 +++-
 arch/arm/mach-omap2/prm2xxx.c                |  15 ++-
 arch/arm/mach-omap2/prm2xxx.h                |   2 +
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |   7 -
 arch/arm/mach-omap2/prm3xxx.c                |  16 ++-
 arch/arm/mach-omap2/prm3xxx.h                |   2 +
 arch/arm/mach-omap2/prm44xx.c                |   1 -
 arch/arm/mach-omap2/prm_common.c             |  16 ++-
 arch/arm/mach-omap2/prminst44xx.h            |   2 +
 arch/arm/mach-omap2/sdrc.c                   |   8 +-
 arch/arm/mach-omap2/sdrc.h                   |   2 +
 arch/arm/mach-omap2/ti81xx.h                 |   9 ++
 arch/arm/mach-omap2/wd_timer.c               |  40 +++++-
 arch/arm/plat-omap/include/plat/prcm.h       |  37 ------
 drivers/watchdog/omap_wdt.c                  |  26 ++--
 include/linux/platform_data/omap-wd-timer.h  |  38 ++++++
 90 files changed, 992 insertions(+), 851 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap2-restart.c
 create mode 100644 arch/arm/mach-omap2/omap3-restart.c
 delete mode 100644 arch/arm/mach-omap2/prcm.c
 delete mode 100644 arch/arm/plat-omap/include/plat/prcm.h
 create mode 100644 include/linux/platform_data/omap-wd-timer.h
