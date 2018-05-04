From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] ti-sysc driver changes for v4.18 merge window
Date: Fri,  4 May 2018 09:17:31 -0700
Message-ID: <pull-1525450571-674978@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/ti-sysc-signed

for you to fetch changes up to dc4c85eac6bc8cfe25144936c5636aa1415bbc12:

  bus: ti-sysc: Show module information for suspend if DEBUG is enabled (2018-05-01 06:54:17 -0700)

----------------------------------------------------------------
ti-sysc driver related changes for omap variants

This series improves the ti-sysc interconnect target module driver to
the point where a most of SoC can be booted with interconnect target
module data configured in device tree instead of legacy platform data.
The related device tree changes need some more work though, and can
wait for v4.19. Also some drivers using nested interconnects like DSS
need more work.

We can now remove the unused pm-noop code that is not doing anything
any longer. And we can now initialize things for PM and display pdata
later to prepare things for using ti-sysc driver.

We also need to add  some more quirk handling so we can boot both with
platform data and dts data.

----------------------------------------------------------------
Tony Lindgren (16):
      ARM: OMAP2+: Drop unused pm-noop
      ARM: OMAP2+: Allow using ti-sysc for system timers
      ARM: OMAP2+: Use signed value for sysc register offsets
      ARM: OMAP2+: Only probe SDMA via ti-sysc if configured in dts
      ARM: OMAP2+: Initialize SoC PM later
      ARM: OMAP2+: Make display related init into device_initcall
      bus: ti-sysc: Handle simple-bus for nested children
      bus: ti-sysc: Make child clock alias handling more generic
      bus: ti-sysc: Add handling for clkctrl opt clocks
      bus: ti-sysc: Tag some modules resource providers for noirq suspend
      bus: ti-sysc: Improve suspend and resume handling
      bus: ti-sysc: Add initial support for external resets
      bus: ti-sysc: Detect omap4 type timers for quirk
      bus: ti-sysc: Detect UARTs for SYSC_QUIRK_LEGACY_IDLE quirk on omap4
      bus: ti-sysc: Tag sdio and wdt with legacy mode for suspend
      bus: ti-sysc: Show module information for suspend if DEBUG is enabled

 Documentation/devicetree/bindings/bus/ti-sysc.txt  |   6 +-
 arch/arm/mach-omap2/Makefile                       |   1 -
 arch/arm/mach-omap2/board-generic.c                |   2 -
 arch/arm/mach-omap2/common.h                       |  18 +-
 arch/arm/mach-omap2/display.c                      |  10 +-
 arch/arm/mach-omap2/hsmmc.c                        |   1 -
 arch/arm/mach-omap2/i2c.c                          |   1 -
 arch/arm/mach-omap2/io.c                           |  70 +---
 arch/arm/mach-omap2/omap-pm-noop.c                 | 176 ----------
 arch/arm/mach-omap2/omap-pm.h                      | 161 ---------
 arch/arm/mach-omap2/omap_device.c                  |  22 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  21 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |   6 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   4 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   4 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   3 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   6 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |   1 +
 arch/arm/mach-omap2/pdata-quirks.c                 |  15 -
 arch/arm/mach-omap2/pm-debug.c                     |   5 -
 arch/arm/mach-omap2/pm.c                           |  21 +-
 arch/arm/mach-omap2/pm33xx-core.c                  |   4 +-
 arch/arm/mach-omap2/timer.c                        |  68 +++-
 arch/arm/plat-omap/Kconfig                         |  10 -
 drivers/bus/ti-sysc.c                              | 388 ++++++++++++++++++---
 drivers/media/rc/ir-rx51.c                         |  17 +-
 include/linux/platform_data/media/ir-rx51.h        |   9 -
 include/linux/platform_data/ti-sysc.h              |   1 +
 30 files changed, 494 insertions(+), 559 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap-pm-noop.c
 delete mode 100644 arch/arm/mach-omap2/omap-pm.h
 delete mode 100644 include/linux/platform_data/media/ir-rx51.h
