From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 0/3] Add support for TI814X processor series
Date: Thu, 4 Aug 2011 23:14:29 +0530
Message-ID: <1312479869-21948-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41680 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab1HDRou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 13:44:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch set adds support for DM814x, C6A814x and AM387x device series having
Cortex-A8 MPU.

The technical documents are available from following link:

http://focus.ti.com/docs/prod/folders/print/tms320dm8148.html

This series is referred in code as TI814X.

Since these devices share similar architecture as TI816X devices, existing
TI816X code is updated to accomodate TI814X support. The code shared across
TI816X and TI814X devices is updated with TI81XX/ti81xx prefix as applicable,
while maintaining cpu_is_ti816x() and cpu_is_ti814x() to distinguish specific
execution differences.

Hemant Pedanekar (3):
  TI81XX: Prepare for addition of TI814X support
  TI814X: Add cpu type macros and detection support
  TI814X: Create board support and enable build for TI8148 EVM

 arch/arm/mach-omap2/Kconfig                        |   11 +++-
 arch/arm/mach-omap2/Makefile                       |    1 +
 arch/arm/mach-omap2/board-ti8148evm.c              |   57 ++++++++++++++++++++
 arch/arm/mach-omap2/board-ti8168evm.c              |    6 +-
 arch/arm/mach-omap2/clock.c                        |    2 +-
 arch/arm/mach-omap2/clock.h                        |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c               |    5 ++-
 arch/arm/mach-omap2/common.c                       |   22 ++++----
 arch/arm/mach-omap2/control.h                      |    8 ++--
 arch/arm/mach-omap2/id.c                           |   26 ++++++++--
 arch/arm/mach-omap2/include/mach/debug-macro.S     |   12 ++--
 arch/arm/mach-omap2/include/mach/entry-macro.S     |    4 +-
 arch/arm/mach-omap2/io.c                           |   10 ++--
 arch/arm/mach-omap2/irq.c                          |    2 +-
 arch/arm/mach-omap2/opp2xxx.h                      |    2 +-
 arch/arm/mach-omap2/serial.c                       |    6 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h      |    1 +
 arch/arm/plat-omap/include/plat/clock.h            |    3 +-
 arch/arm/plat-omap/include/plat/common.h           |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h              |   25 ++++++++-
 arch/arm/plat-omap/include/plat/hardware.h         |    2 +-
 arch/arm/plat-omap/include/plat/io.h               |    6 +-
 arch/arm/plat-omap/include/plat/irqs.h             |    2 +-
 arch/arm/plat-omap/include/plat/serial.h           |   14 +++---
 .../plat-omap/include/plat/{ti816x.h => ti81xx.h}  |   18 +++---
 arch/arm/plat-omap/include/plat/uncompress.h       |   11 +++--
 arch/arm/plat-omap/io.c                            |    2 +-
 27 files changed, 187 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-ti8148evm.c
 rename arch/arm/plat-omap/include/plat/{ti816x.h => ti81xx.h} (60%)

-- 
1.7.3.5

