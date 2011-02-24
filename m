From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 0/3] OMAP: DMA: mstandby mode and runtime pm support
Date: Thu, 24 Feb 2011 15:44:32 +0530
Message-ID: <1298542475-1460-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37778 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab1BXKRQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 05:17:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com

This patch series is remaining part of dma hwmod to support pm runtime 
and for handling mstandby mode for all applicable DMA mstandby mode errata.

The alignment for pm runtime API's usage is at:
http://thread.gmane.org/gmane.linux.ports.arm.omap/51588/focus=52493
http://thread.gmane.org/gmane.linux.ports.arm.omap/50762/focus=50840

The alignment for handling mstandby mode errata handling is at:
http://thread.gmane.org/gmane.linux.ports.arm.omap/47398/focus=47426
http://thread.gmane.org/gmane.linux.ports.arm.omap/47479/focus=47537

Testing:
Compile tested for
 - omap1_defconfig
 - omap2plus_defconfig

Boot test on:
 - OMAP1710-H3
 - OMAP2420-H4
 - OMAP3430-LDP
 - OMAP3630-Zoom3
 - OMAP4430-Blaze

DMA memory to memory test cases(including chaining) are executed for
all the above boards and for each test case, 
/sys/devices/platform/omap/omap_dma_system.0/power/runtime_status
was verified and after completion of the tests, runtime_status will be 
always suspended.

Apart from that, offmode testing is done for OMAP3430-LDP using the procedure:
echo 1 > /debug/pm_debug/sleep_while_idle
echo 1 > /debug/pm_debug/enable_off_mode
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout

With the above steps, core off mode count gets increasing if the the board
is idle for more than 5 seconds.

Baseline:
Applies cleanly on top of mainline 2.6.38-rc6:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
commit f5412be599602124d2bdd49947b231dd77c0bf99
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Feb 21 17:25:52 2011 -0800

    Linux 2.6.38-rc6

Note: OMAP1 is tested on top of 2.6.38-rc5 since rc6 is broken for omap1 build

Patch Summary:
==============
G, Manjunath Kondaiah (2):
  OMAP2+: PM: omap device: API's for handling mstandby mode
  OMAP2+: DMA: prevent races while setting M idle mode to nostandby

Manjunath G Kondaiah (1):
  OMAP: PM: DMA: Enable runtime pm

 arch/arm/mach-omap1/dma.c                     |    1 +
 arch/arm/mach-omap2/dma.c                     |   16 ++
 arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++
 arch/arm/plat-omap/dma.c                      |  190 +++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/dma.h         |    1 +
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
 arch/arm/plat-omap/omap_device.c              |   64 +++++++++
 8 files changed, 293 insertions(+), 27 deletions(-)

