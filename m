From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v7 0/4] Introduce support for TI816X processor series
Date: Tue, 15 Feb 2011 23:05:19 +0530
Message-ID: <1297791319-31891-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58163 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755267Ab1BORfe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 12:35:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Hemant Pedanekar <hemantp@ti.com>

This patch set adds support for TI816X processor series. This series includes
DM8168, C6A816x and AM389x devices.

The details can be found at following links:

http://focus.ti.com/general/docs/gencontent.tsp?contentId=77960
http://www.ti.com/ww/en/dsp/davinci-netra/index.shtml

This series is architecturally closer to the OMAP devices. Hence, these patches
are being submitted on linux-omap.

These patches are tested on OMAP3 EVM with multi-omap build.

Note that, additional patches consisting of TI816X specific hwmods, clock data
and DMTIMER changes, are required to enable successful booting on TI816X EVM.
These patches will follow shortly.

The TI816X support is added as part of OMAP3 variant. The approach taken is in
accordance to the discussions in thread related to following post:
http://www.spinics.net/lists/linux-omap/msg41505.html

In addition, TI816X specific customizations/optimizations are handled as a part
of build configuration CONFIG_SOC_OMAPTI816X. Discussed here:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41927.html

Hemant Pedanekar (4):
  TI816X: Update common omap platform files
  TI816X: Update common OMAP machine specific sources
  TI816X: Create board support and enable build for TI816X EVM
  TI816X: Add low level debug support

 arch/arm/mach-omap2/Kconfig                    |   10 ++++
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/board-ti8168evm.c          |   57 ++++++++++++++++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c           |    5 ++-
 arch/arm/mach-omap2/common.c                   |   21 +++++++++
 arch/arm/mach-omap2/control.h                  |    6 +++
 arch/arm/mach-omap2/id.c                       |   33 +++++++++++++-
 arch/arm/mach-omap2/include/mach/debug-macro.S |   12 +++++
 arch/arm/mach-omap2/include/mach/entry-macro.S |   13 +++++
 arch/arm/mach-omap2/io.c                       |   22 +++++++++-
 arch/arm/mach-omap2/irq.c                      |    5 ++-
 arch/arm/mach-omap2/serial.c                   |    8 ++--
 arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
 arch/arm/plat-omap/include/plat/clock.h        |    1 +
 arch/arm/plat-omap/include/plat/common.h       |    1 +
 arch/arm/plat-omap/include/plat/cpu.h          |   18 +++++++
 arch/arm/plat-omap/include/plat/hardware.h     |    1 +
 arch/arm/plat-omap/include/plat/io.h           |    8 +++
 arch/arm/plat-omap/include/plat/serial.h       |    8 +++
 arch/arm/plat-omap/include/plat/ti816x.h       |   27 +++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h   |    7 +++
 arch/arm/plat-omap/io.c                        |    5 ++-
 22 files changed, 260 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-ti8168evm.c
 create mode 100644 arch/arm/plat-omap/include/plat/ti816x.h

-- 
1.7.3.5

