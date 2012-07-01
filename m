From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/6] omap non-critical fixes for v3.6 merge window
Date: Sun, 1 Jul 2012 02:01:15 -0700
Message-ID: <16480.7496512823$1341133286@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18926 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab2GAJBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Jul 2012 05:01:20 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-non-critical-for-v3.6

for you to fetch changes up to f6f1f12f6d4e9e4a44587e58ec96db25673083ec:

  Merge tag 'omap-devel-d-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into fixes-non-critical (2012-06-29 06:07:08 -0700)

----------------------------------------------------------------

This branch contains fixes that were too intrusive or not
critical enough for the 3.5 -rc cycle. The biggest changes are
fixes for the am35xx clock and hwmod data, and the removal of dead
code for the 730 and 850 headers.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: OMAP depends on MMU

Brian Austin (1):
      ARM: OMAP: beagle: Set USB Host Port 1 to OMAP_USBHS_PORT_MODE_UNUSED

Daniel Lezcano (1):
      ARM: OMAP3/4: consolidate cpuidle Makefile

Igor Grinberg (1):
      ARM: OMAP: fix the ads7846 init code

Javier Martinez Canillas (1):
      ARM: OMAP: omap2plus_defconfig: Enable EXT4 support

Juan Gutierrez (2):
      ARM: OMAP: enable mailbox irq per instance
      ARM: OMAP4: fix irq and clock name for dsp-iommu

Kevin Hilman (3):
      ARM: OMAP2+: TWL: remove usage of pdata->irq_base/_end
      mfd: twl: remove pdata->irq_base/_end, no more users
      ARM: OMAP2+: fix CONFIG_CPU_IDLE dependency on CONFIG_PM

Mark A. Greer (4):
      ARM: OMAP3: PM: Only access IVA if one exists
      ARM: OMAP AM35x: EMAC/MDIO integration: Add Davinci EMAC/MDIO hwmod support
      ARM: OMAP AM35x: clockdomain data: Fix clockdomain dependencies
      arm: omap3: am35x: Set proper powerdomain states

Nishanth Menon (1):
      ARM: OMAP2+: OPP: Fix to ensure check of right oppdef after bad one

Ohad Ben-Cohen (1):
      ARM: OMAP4: hwspinlocks_init() should be static

Paul Bolle (3):
      ARM: OMAP7XX:  Remove omap730.h and omap850.h
      ARM: OMAP: fix typos related to OMAP330
      ARM: OMAP: remove unused cpu detection macros

Paul Walmsley (4):
      ARM: OMAP AM35xx: clock and hwmod data: fix AM35xx HSOTGUSB hwmod
      ARM: OMAP AM35xx: clock and hwmod data: fix UART4 data
      ARM: OMAP: AM35xx: fix UART4 softreset
      Merge branches 'am35xx_hwmod_data_fixes_a_3.6', 'am35xx_emac_mdio_devel_3.6' and 'am35xx_prcm_data_devel_3.6' into am35xx_devel_3.6

Peter Ujfalusi (1):
      ARM: OMAP2: twl-common: Fix compiler warning

Roland Stigge (1):
      ARM: OMAP: Fix dts files w/ status property: "disable" -> "disabled"

Tony Lindgren (5):
      Merge branch 'for-tony' of git://git.kernel.org/.../ohad/linux into fixes-omap4-dsp
      Merge branch 'fixes-omap4-dsp' into fixes-non-critical
      Merge branch 'for_3.6/cleanup/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes-non-critical
      Merge branch 'for_3.6/cleanup/twl-irq' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes-non-critical
      Merge tag 'omap-devel-d-for-3.6' of git://git.kernel.org/.../pjw/omap-pending into fixes-non-critical

Venkatraman S (1):
      ARM: OMAP2+: fix naming collision of variable nr_irqs

 arch/arm/Kconfig                            |    1 +
 arch/arm/boot/dts/omap3-beagle.dts          |    4 +-
 arch/arm/boot/dts/omap4-panda.dts           |    6 +-
 arch/arm/boot/dts/omap4-sdp.dts             |    4 +-
 arch/arm/configs/omap2plus_defconfig        |    1 +
 arch/arm/mach-omap2/Kconfig                 |    2 +
 arch/arm/mach-omap2/Makefile                |    7 +-
 arch/arm/mach-omap2/am35xx-emac.c           |   90 +++++++--------
 arch/arm/mach-omap2/board-2430sdp.c         |    3 -
 arch/arm/mach-omap2/board-omap3beagle.c     |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c      |    3 -
 arch/arm/mach-omap2/clock3xxx_data.c        |   28 +++--
 arch/arm/mach-omap2/clockdomains3xxx_data.c |  157 ++++++++++++++++++++++++---
 arch/arm/mach-omap2/cm-regbits-34xx.h       |    4 +-
 arch/arm/mach-omap2/common-board-devices.c  |   22 ++--
 arch/arm/mach-omap2/cpuidle34xx.c           |    8 --
 arch/arm/mach-omap2/cpuidle44xx.c           |    8 --
 arch/arm/mach-omap2/include/mach/am35xx.h   |    2 +
 arch/arm/mach-omap2/irq.c                   |    8 +-
 arch/arm/mach-omap2/mailbox.c               |    2 -
 arch/arm/mach-omap2/omap-iommu.c            |    6 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  |  143 ++++++++++++++++++++++--
 arch/arm/mach-omap2/opp.c                   |    3 +-
 arch/arm/mach-omap2/pm.h                    |   17 ++-
 arch/arm/mach-omap2/pm34xx.c                |   15 ++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  139 ++++++++++++++++++++++--
 arch/arm/mach-omap2/prcm-common.h           |    4 +-
 arch/arm/mach-omap2/prm_common.c            |    8 +-
 arch/arm/mach-omap2/twl-common.c            |   11 +-
 arch/arm/plat-omap/include/plat/cpu.h       |   20 +---
 arch/arm/plat-omap/include/plat/mux.h       |    2 +-
 arch/arm/plat-omap/include/plat/omap730.h   |  102 -----------------
 arch/arm/plat-omap/include/plat/omap850.h   |  102 -----------------
 arch/arm/plat-omap/mailbox.c                |   13 ++-
 include/linux/i2c/twl.h                     |    1 -
 35 files changed, 550 insertions(+), 398 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/omap730.h
 delete mode 100644 arch/arm/plat-omap/include/plat/omap850.h
