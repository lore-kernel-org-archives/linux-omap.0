From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] updated omap fixes for v3.2 merge window breakage
Date: Mon, 7 Nov 2011 16:25:48 -0800
Message-ID: <20111108002548.GG31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23125 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab1KHAZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 19:25:52 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

If you did not pull yet, please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

This is an updated version of an earlier pull request at:

http://marc.info/?l=linux-arm-kernel&m=132069904817116&w=2

With one additional fix for cpuidle export.h include found by Kevin
and missed in the earlier greps.

Regards,

Tony


The following changes since commit 32aaeffbd4a7457bf2f7448b33b5946ff2a960eb:
  Linus Torvalds (1):
        Merge branch 'modsplit-Oct31_2011' of git://git.kernel.org/.../paulg/linux

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Abhilash K V (1):
      ARM: OMAP: AM35x: remove hwmods that aren't generic

Archit Taneja (1):
      ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields

Axel Lin (3):
      ARM: OMAP2+: l3-noc: Include linux/module.h
      ARM: OMAP: dmtimer: Include linux/module.h
      ARM: OMAP: omap_device: Include linux/export.h

Balaji T K (2):
      ARM: OMAP4: hsmmc: Fix Pbias configuration on regulator OFF
      ARM: OMAP4: hsmmc: configure SDMMC1_DR0 properly

Benoit Cousson (2):
      ARM: OMAP2+: clock data: Remove redundant timer clkdev
      ARM: OMAP2+: timer: Remove omap_device_pm_latency

Bjarne Steinsbo (1):
      ARM: OMAP: usb: musb: OMAP: Delete unused function

Charulatha V (1):
      ARM: OMAP3: PM: fix pwrdm_post_transition call sequence

Jarkko Nikula (2):
      MAINTAINERS: Update linux-omap git repository
      ARM: OMAP1: Remove unused omap-alsa.h

Jon Hunter (3):
      ARM: OMAP3+: dpll: use DPLLs recalc function instead of omap2_get_dpll_rate
      ARM: OMAP4: clock: Add missing clock divider for OCP_ABE_ICLK
      ARM: OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices

Kevin Hilman (1):
      ARM: OMAP3: CPUidle: include <linux/export.h>

Laurent Pinchart (1):
      ARM: OMAP: I2C: Fix omap_register_i2c_bus() return value on success

Mike Turquette (3):
      ARM: OMAP4: clock: round_rate and recalc functions for DPLL_ABE
      ARM: OMAP3+: dpll: use DPLL's round_rate when setting rate
      ARM: OMAP3+: dpll: assign clk rate from rounded rate during rate set

Paul Walmsley (4):
      ARM: OMAP4460: Clock: Adding support for 4460 specific clocks
      ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock control detection
      ARM: OMAP3: PM: restrict erratum i443 handling to OMAP3430 only
      ARM: OMAP3: hwmod: fix variant registration and remove SmartReflex from common list

Peter Ujfalusi (1):
      ARM: OMAP2+: devices: Fixes for McPDM

Sanjeev Premi (1):
      ARM: OMAP: Fix errors and warnings when building for one board

Thomas Weber (1):
      ARM: OMAP: Devkit8000: Remove double omap_mux_init_gpio

Tomi Valkeinen (1):
      ARM: OMAP: change get_context_loss_count ret value to int

Tony Lindgren (7):
      Merge branch 'omap_clock_fixes_3.2' of git://git.pwsan.com/linux-2.6 into fixes
      Merge branch 'prcm_scm_misc_fixes_3.2' of git://git.pwsan.com/linux-2.6 into fixes
      Merge branch 'for_3.2/pm-cleanup-2' of git://github.com/khilman/linux-omap-pm into fixes
      ARM: OMAP1: Fix warnings about enabling 32 KiHz timer
      ARM: OMAP2: Fix H4 matrix keyboard warning
      ARM: OMAP: Fix export.h or module.h includes
      Merge branch 'fixes-modulesplit' into fixes

 MAINTAINERS                                        |    2 +-
 arch/arm/mach-omap1/board-palmz71.c                |    1 -
 arch/arm/mach-omap1/pm.c                           |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    1 -
 arch/arm/mach-omap2/board-generic.c                |    8 ++
 arch/arm/mach-omap2/board-h4.c                     |  122 +++++++++++---------
 arch/arm/mach-omap2/clkt_dpll.c                    |   51 ++++++---
 arch/arm/mach-omap2/clock.h                        |    2 +
 arch/arm/mach-omap2/clock2420_data.c               |   12 --
 arch/arm/mach-omap2/clock2430_data.c               |   12 --
 arch/arm/mach-omap2/clock3xxx_data.c               |   12 --
 arch/arm/mach-omap2/clock44xx.h                    |    7 +
 arch/arm/mach-omap2/clock44xx_data.c               |   43 ++++---
 arch/arm/mach-omap2/cpuidle34xx.c                  |    1 +
 arch/arm/mach-omap2/devices.c                      |   17 +---
 arch/arm/mach-omap2/dpll3xxx.c                     |    9 +-
 arch/arm/mach-omap2/dpll44xx.c                     |   69 +++++++++++
 arch/arm/mach-omap2/dsp.c                          |    1 +
 arch/arm/mach-omap2/hsmmc.c                        |   16 +--
 arch/arm/mach-omap2/id.c                           |    5 +-
 .../include/mach/ctrl_module_pad_core_44xx.h       |    8 +-
 arch/arm/mach-omap2/io.c                           |    6 +
 arch/arm/mach-omap2/mailbox.c                      |    1 +
 arch/arm/mach-omap2/omap-iommu.c                   |    1 +
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   17 ++-
 arch/arm/mach-omap2/omap_l3_noc.c                  |    1 +
 arch/arm/mach-omap2/pm34xx.c                       |   70 ++++++-----
 arch/arm/mach-omap2/powerdomain.c                  |   14 ++-
 arch/arm/mach-omap2/powerdomain.h                  |    2 +-
 arch/arm/mach-omap2/smartreflex.c                  |    1 +
 arch/arm/mach-omap2/timer.c                        |   12 +--
 arch/arm/mach-omap2/usb-musb.c                     |   38 ------
 arch/arm/plat-omap/dmtimer.c                       |    1 +
 arch/arm/plat-omap/i2c.c                           |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h              |   17 ++-
 arch/arm/plat-omap/include/plat/dmtimer.h          |    4 +-
 arch/arm/plat-omap/include/plat/omap-alsa.h        |  123 --------------------
 arch/arm/plat-omap/include/plat/omap-pm.h          |    4 +-
 arch/arm/plat-omap/include/plat/omap_device.h      |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c                  |   24 +++-
 arch/arm/plat-omap/omap_device.c                   |    3 +-
 43 files changed, 346 insertions(+), 402 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/omap-alsa.h
