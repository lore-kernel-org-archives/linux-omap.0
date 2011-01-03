From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v3 0/4] Introduce support for TI816X processor series
Date: Mon,  3 Jan 2011 22:58:49 +0530
Message-ID: <1294075729-22247-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44218 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab1ACR27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 12:28:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch set adds support for TI816X processor series. This series includes
DM8168, C6A816x and AM389x devices. The details can be found at following links:

http://focus.ti.com/general/docs/gencontent.tsp?contentId=77960
http://www.ti.com/ww/en/dsp/davinci-netra/index.shtml

This device is architecturally closer to the OMAP devices. Hence, these patches
are being submitted on linux-omap.

These patches are tested on OMAP3 EVM with multi-omap build.

Note that, additional patches consisting of TI816X specific hwmods, clock data
and DMTIMER changes, are required to enable successful booting on TI816X EVM.
These patches will follow shortly.

This patch set adds TI816X support as part of OMAP3 variant. The approach taken
is in accordance to the discussions in thread related to following post:
http://www.spinics.net/lists/linux-omap/msg41505.html

Hemant Pedanekar (4):
  TI816X: Update common omap platform files
  TI816X: Update common OMAP machine specific sources
  TI816X: Create board support and enable build for TI816X EVM
  TI816X: Add low level debug support

 arch/arm/mach-omap2/Kconfig                    |    5 +
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/board-ti8168evm.c          |   58 +++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c           |    5 +-
 arch/arm/mach-omap2/common.c                   |   24 +++++
 arch/arm/mach-omap2/control.h                  |   17 +++
 arch/arm/mach-omap2/id.c                       |   33 ++++++-
 arch/arm/mach-omap2/include/mach/debug-macro.S |   12 ++
 arch/arm/mach-omap2/include/mach/entry-macro.S |    8 ++
 arch/arm/mach-omap2/io.c                       |    2 +-
 arch/arm/mach-omap2/irq.c                      |    5 +-
 arch/arm/mach-omap2/serial.c                   |    8 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
 arch/arm/plat-omap/include/plat/clock.h        |    1 +
 arch/arm/plat-omap/include/plat/common.h       |    1 +
 arch/arm/plat-omap/include/plat/cpu.h          |   18 ++++
 arch/arm/plat-omap/include/plat/hardware.h     |    1 +
 arch/arm/plat-omap/include/plat/irqs-ti816x.h  |  131 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h         |    3 +
 arch/arm/plat-omap/include/plat/serial.h       |    8 ++
 arch/arm/plat-omap/include/plat/ti816x.h       |   31 ++++++
 arch/arm/plat-omap/include/plat/uncompress.h   |    7 ++
 22 files changed, 371 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-ti8168evm.c
 create mode 100644 arch/arm/plat-omap/include/plat/irqs-ti816x.h
 create mode 100644 arch/arm/plat-omap/include/plat/ti816x.h

