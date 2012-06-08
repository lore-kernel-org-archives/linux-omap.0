From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.5-rc1
Date: Fri, 8 Jun 2012 00:32:37 -0700
Message-ID: <20120608073237.GM12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47583 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab2FHHck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 03:32:40 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.5-rc1

for you to fetch changes up to febe9e02d63ed8a42e7e9c75ea16117821f90f07:

  ARM: OMAP2+: Fix compile for CONFIG_TIDSPBRIDGE platform init code (2012-06-06 01:42:20 -0700)

----------------------------------------------------------------
The biggest fix here is the long pending patch mux UART pins so PM
retention idle works again.

Also included are few other PM wake-up related fixes, and removal of
dead cpu detection code.

The other fixes are trivial build and randconfig related fixes.

----------------------------------------------------------------
Govindraj.R (1):
      OMAP2+: UART: Add mechanism to probe uart pins and configure rx wakeup

Kevin Hilman (3):
      ARM: OMAP3: PM: fix shared PRCM interrupts: leave disabled at boot
      ARM: OMAP3: clock data: cleanup AM3[35]x SoC detection
      ARM: OMAP: SoC detection: remove unused cpu_is macros

Mark A. Greer (1):
      arm: omap3: am35x: Don't mark missing features as present

NeilBrown (1):
      ARM: OMAP2+: INTC: fix suspend abort, set IRQCHIP_SKIP_SET_WAKE

Tony Lindgren (6):
      Merge branch 'for_3.5/fixes/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes
      Merge branch 'for_3.5/cleanup/am3xxx-cpu-is-leftovers' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes
      ARM: OMAP: Fix lis3lv02d accelerometer to use gpio_to_irq
      ARM: OMAP: Fix MMC_OMAP build when only MMC_OMAP_HS is selected
      ARM: OMAP3: Fix omap3_l3_block_irq warning when CONFIG_BUG is not set
      ARM: OMAP2+: Fix compile for CONFIG_TIDSPBRIDGE platform init code

 arch/arm/mach-omap2/board-rx51-peripherals.c |    6 ++-
 arch/arm/mach-omap2/clock3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/dsp.c                    |    3 ++
 arch/arm/mach-omap2/id.c                     |   11 +++++
 arch/arm/mach-omap2/irq.c                    |    1 +
 arch/arm/mach-omap2/mux.c                    |    3 +-
 arch/arm/mach-omap2/mux.h                    |   11 +++++
 arch/arm/mach-omap2/omap_l3_smx.c            |    3 +-
 arch/arm/mach-omap2/pm34xx.c                 |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |   14 ++++--
 arch/arm/mach-omap2/serial.c                 |   67 ++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/cpu.h        |   33 -------------
 arch/arm/plat-omap/include/plat/mmc.h        |    4 +-
 13 files changed, 110 insertions(+), 49 deletions(-)
