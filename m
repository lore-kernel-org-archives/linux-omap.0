From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 0/6] Introduce support for TI816X processor series
Date: Sat, 31 Jul 2010 02:21:08 +0530
Message-ID: <1280523068-24957-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34951 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302Ab0G3UvR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jul 2010 16:51:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch series adds support for TI816X processor series. First device in this
series is DM8168 and details can be found at:

http://www.ti.com/ww/en/dsp/davinci-netra/index.shtml

This device is architecturally closer to the OMAP devices. Hence, these patches
are being submitted on linux-omap.

These patches are tested on OMAP3 EVM with multi-omap build.

Note that, additional patches consisting of TI816X specific clock data and
DMTIMER changes, are required to enable successful booting on TI816X EVM. These
patches will follow shortly.

Hemant Pedanekar (6):
  TI816X: Create architecture macros and config entries
  TI816X: Update common omap platform files
  TI816X: Update common OMAP machine specific sources
  TI816X: Create board support for TI816X_EVM
  TI816X: Enable Build for TI816X EVM
  TI816X: Add low level debug support

 arch/arm/Makefile                              |    1 +
 arch/arm/mach-omap2/Kconfig                    |   14 +++
 arch/arm/mach-omap2/Makefile                   |    2 +
 arch/arm/mach-omap2/board-ti8168evm.c          |   71 +++++++++++++
 arch/arm/mach-omap2/clockdomain.c              |   18 ++--
 arch/arm/mach-omap2/id.c                       |   25 +++++
 arch/arm/mach-omap2/include/mach/debug-macro.S |   12 ++
 arch/arm/mach-omap2/include/mach/entry-macro.S |   44 ++++++++-
 arch/arm/mach-omap2/io.c                       |   21 ++++-
 arch/arm/mach-omap2/irq.c                      |    4 +
 arch/arm/mach-omap2/serial.c                   |    3 +-
 arch/arm/plat-omap/Kconfig                     |    2 +-
 arch/arm/plat-omap/common.c                    |   20 ++++
 arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
 arch/arm/plat-omap/include/plat/clock.h        |    1 +
 arch/arm/plat-omap/include/plat/common.h       |    1 +
 arch/arm/plat-omap/include/plat/control.h      |   23 ++++
 arch/arm/plat-omap/include/plat/cpu.h          |   29 +++++-
 arch/arm/plat-omap/include/plat/hardware.h     |    1 +
 arch/arm/plat-omap/include/plat/io.h           |   20 ++++
 arch/arm/plat-omap/include/plat/irqs-ti816x.h  |  128 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h         |    3 +
 arch/arm/plat-omap/include/plat/multi.h        |    8 ++
 arch/arm/plat-omap/include/plat/serial.h       |    8 ++
 arch/arm/plat-omap/include/plat/ti816x.h       |   40 ++++++++
 arch/arm/plat-omap/include/plat/uncompress.h   |    7 ++
 arch/arm/plat-omap/io.c                        |    7 ++
 27 files changed, 498 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-ti8168evm.c
 create mode 100644 arch/arm/plat-omap/include/plat/irqs-ti816x.h
 create mode 100644 arch/arm/plat-omap/include/plat/ti816x.h

