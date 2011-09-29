From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v3 0/3] Add support for TI814X processor series
Date: Thu, 29 Sep 2011 06:38:58 +0530
Message-ID: <1317258538-30200-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33401 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689Ab1I2BJS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Sep 2011 21:09:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch set adds support for DM814x/AM387x device series having Cortex-A8
MPU.

The technical documents are available from following link:

http://focus.ti.com/docs/prod/folders/print/tms320dm8148.html

This series is referred in code as TI814X.

Since these devices share similar architecture as TI816X devices, existing
TI816X code is updated to accomodate TI814X support. The code shared across
TI816X and TI814X devices is updated with TI81XX/ti81xx prefix as applicable,
while maintaining cpu_is_ti816x() and cpu_is_ti814x() to distinguish specific
execution differences.

Changes since v2:
1) Incorporate Tony's suggestion about moving ti8168_evm_map_io() to
   arch/arm/mach-omap2/common.c to keep common across TI81XX.
2) Keeping single board file (board-ti81xxevm.c) for TI816X and TI814X EVMs

Changes since v1:
1) Rebased and updated after Paul's CHIP_IS removal changes
2) Removed call to omap2_init_common_devices() as per Kevin's comment

Hemant Pedanekar (3):
  ARM: OMAP: TI81XX: Prepare for addition of TI814X support
  ARM: OMAP: TI814X: Add cpu type macros and detection support
  ARM: OMAP: TI814X: Create board support and enable build for TI8148
    EVM

 arch/arm/mach-omap2/Kconfig                        |   11 +++++--
 arch/arm/mach-omap2/Makefile                       |    3 +-
 .../{board-ti8168evm.c => board-ti81xxevm.c}       |   34 +++++++++++---------
 arch/arm/mach-omap2/clock.c                        |    2 +-
 arch/arm/mach-omap2/clock.h                        |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c               |    5 ++-
 arch/arm/mach-omap2/common.c                       |   28 ++++++++++------
 arch/arm/mach-omap2/control.h                      |    8 ++--
 arch/arm/mach-omap2/id.c                           |   30 +++++++++++++++--
 arch/arm/mach-omap2/include/mach/debug-macro.S     |   12 +++---
 arch/arm/mach-omap2/include/mach/entry-macro.S     |    4 +-
 arch/arm/mach-omap2/io.c                           |   12 +++---
 arch/arm/mach-omap2/irq.c                          |    2 +-
 arch/arm/mach-omap2/opp2xxx.h                      |    2 +-
 arch/arm/mach-omap2/serial.c                       |    6 ++--
 arch/arm/plat-omap/include/plat/clkdev_omap.h      |    1 +
 arch/arm/plat-omap/include/plat/clock.h            |    3 +-
 arch/arm/plat-omap/include/plat/common.h           |    5 ++-
 arch/arm/plat-omap/include/plat/cpu.h              |   22 +++++++++++++
 arch/arm/plat-omap/include/plat/hardware.h         |    2 +-
 arch/arm/plat-omap/include/plat/io.h               |    6 ++--
 arch/arm/plat-omap/include/plat/irqs.h             |    2 +-
 arch/arm/plat-omap/include/plat/serial.h           |   14 ++++----
 .../plat-omap/include/plat/{ti816x.h => ti81xx.h}  |   18 +++++-----
 arch/arm/plat-omap/include/plat/uncompress.h       |   11 ++++--
 arch/arm/plat-omap/io.c                            |    2 +-
 26 files changed, 158 insertions(+), 89 deletions(-)
 rename arch/arm/mach-omap2/{board-ti8168evm.c => board-ti81xxevm.c} (60%)
 rename arch/arm/plat-omap/include/plat/{ti816x.h => ti81xx.h} (60%)

-- 
1.7.3.5

