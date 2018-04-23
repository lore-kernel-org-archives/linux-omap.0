From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/16] ti-sysc driver changes to support more devices
Date: Mon, 23 Apr 2018 10:45:33 -0700
Message-ID: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

This series contains improvments for ti-sysc driver to allow booting
with more devices configured in device tree instead of the legacy
platform data. Looks like some device drivers also need updating for
suspend and resume, I'll be posting patches separately for those.

Regards,

Tony


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

 .../devicetree/bindings/bus/ti-sysc.txt       |   6 +-
 arch/arm/mach-omap2/Makefile                  |   1 -
 arch/arm/mach-omap2/board-generic.c           |   2 -
 arch/arm/mach-omap2/common.h                  |  18 +-
 arch/arm/mach-omap2/display.c                 |  10 +-
 arch/arm/mach-omap2/hsmmc.c                   |   1 -
 arch/arm/mach-omap2/i2c.c                     |   1 -
 arch/arm/mach-omap2/io.c                      |  70 +---
 arch/arm/mach-omap2/omap-pm-noop.c            | 176 --------
 arch/arm/mach-omap2/omap-pm.h                 | 161 --------
 arch/arm/mach-omap2/omap_device.c             |  22 +-
 arch/arm/mach-omap2/omap_hwmod.c              |  21 +-
 arch/arm/mach-omap2/omap_hwmod.h              |   6 +-
 .../omap_hwmod_33xx_43xx_ipblock_data.c       |   1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   4 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c    |   1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |   4 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    |   3 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c     |   6 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c    |   1 +
 arch/arm/mach-omap2/pdata-quirks.c            |  15 -
 arch/arm/mach-omap2/pm-debug.c                |   5 -
 arch/arm/mach-omap2/pm.c                      |  21 +-
 arch/arm/mach-omap2/pm33xx-core.c             |   4 +-
 arch/arm/mach-omap2/timer.c                   |  68 ++-
 arch/arm/plat-omap/Kconfig                    |  10 -
 drivers/bus/ti-sysc.c                         | 388 ++++++++++++++++--
 drivers/media/rc/ir-rx51.c                    |  17 +-
 include/linux/platform_data/media/ir-rx51.h   |   9 -
 include/linux/platform_data/ti-sysc.h         |   1 +
 30 files changed, 494 insertions(+), 559 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap-pm-noop.c
 delete mode 100644 arch/arm/mach-omap2/omap-pm.h
 delete mode 100644 include/linux/platform_data/media/ir-rx51.h

-- 
2.17.0
