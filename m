From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH RESEND v5 0/3] Add support for TI814X processor series
Date: Sat, 10 Dec 2011 07:14:07 +0530
Message-ID: <1323481447-27360-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52334 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab1LJBoW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 20:44:22 -0500
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

Changes since v4:
1) Rebased on linux-omap/soc branch.
2) Updated for map_io and common.h changes.

Changes since v3:
1) Avoid renaming board-ti8168evm.c, just add TI8148 EVM support in it.
2) Drop changes in clock related data variables from u8 to u16 since the same
   was incorporated as part of AM33xx addition.

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
 arch/arm/mach-omap2/Makefile                       |    1 +
 arch/arm/mach-omap2/board-ti8168evm.c              |   33 +++++++++++--------
 arch/arm/mach-omap2/clock3xxx_data.c               |    5 ++-
 arch/arm/mach-omap2/common.c                       |   29 ++++++++++-------
 arch/arm/mach-omap2/common.h                       |   13 ++++---
 arch/arm/mach-omap2/control.h                      |    8 ++--
 arch/arm/mach-omap2/id.c                           |   29 +++++++++++++++--
 arch/arm/mach-omap2/include/mach/debug-macro.S     |   12 +++---
 arch/arm/mach-omap2/io.c                           |   14 ++++----
 arch/arm/mach-omap2/irq.c                          |    2 +-
 arch/arm/mach-omap2/serial.c                       |    6 ++--
 arch/arm/plat-omap/include/plat/clkdev_omap.h      |    1 +
 arch/arm/plat-omap/include/plat/clock.h            |    1 +
 arch/arm/plat-omap/include/plat/cpu.h              |   22 +++++++++++++
 arch/arm/plat-omap/include/plat/hardware.h         |    2 +-
 arch/arm/plat-omap/include/plat/serial.h           |   14 ++++----
 .../plat-omap/include/plat/{ti816x.h => ti81xx.h}  |   18 +++++-----
 arch/arm/plat-omap/include/plat/uncompress.h       |   11 ++++--
 19 files changed, 150 insertions(+), 82 deletions(-)
 rename arch/arm/plat-omap/include/plat/{ti816x.h => ti81xx.h} (60%)

