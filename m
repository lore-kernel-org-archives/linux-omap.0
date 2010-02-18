From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/9] omap4 updates for 2.6.34
Date: Thu, 18 Feb 2010 14:23:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C417F61A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41967 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282Ab0BRIxM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 03:53:12 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

This series have few omap4 updates and is based on Tony's 
'omap-for-linus' branch. This series patches are part of the
below series posted on linux-omap for review earlier this week.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg23939.html

>From the previous series, I have dropped all the clock and i2c patches
because of few dependencies. The auto-generated dma and irq headers are
included as per comments.

The series is boot tested on omap4430 and omap4430 sdp's with multi-omap
and regular defconfig builds.


The following changes since commit 80c20d543d142ee54ec85259b77aaf0b83c32db5:
  Tony Lindgren (1):
        Merge branch 'omap-fixes-for-linus' into omap-for-linus

Santosh Shilimkar (9):
      omap3/4: uart: fix full-fifo write abort
      omap2/3/4: ioremap omap_globals module
      omap4: sdma: Enable the idle modes on omap4
      omap: sdma: Limit the secure reserve channel fix for omap3
      omap4: Fix omap_type() for omap4
      omap3/4: Remove overlapping mapping of L4_WKUP io space
      omap4: Add auto-generated irq and dma headers
      omap4: Use dma line defines from dma-44xx.h
      omap4: Use irq line defines from irq-44xx.h

 arch/arm/mach-omap2/control.c                |    6 +-
 arch/arm/mach-omap2/devices.c                |    8 +-
 arch/arm/mach-omap2/id.c                     |    2 +
 arch/arm/mach-omap2/include/mach/irqs-44xx.h |  144 +++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/irqs.h      |    1 +
 arch/arm/mach-omap2/io.c                     |   12 --
 arch/arm/mach-omap2/prcm.c                   |   16 +++-
 arch/arm/mach-omap2/sdrc.c                   |   11 ++-
 arch/arm/mach-omap2/serial.c                 |   31 +++++-
 arch/arm/mach-omap2/timer-mpu.c              |    2 +-
 arch/arm/plat-omap/common.c                  |   38 ++++----
 arch/arm/plat-omap/devices.c                 |    4 +-
 arch/arm/plat-omap/dma.c                     |    7 +-
 arch/arm/plat-omap/dmtimer.c                 |   24 ++--
 arch/arm/plat-omap/gpio.c                    |   12 +-
 arch/arm/plat-omap/include/plat/common.h     |   17 ++--
 arch/arm/plat-omap/include/plat/control.h    |    3 +
 arch/arm/plat-omap/include/plat/dma-44xx.h   |  145 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dma.h        |   86 +---------------
 arch/arm/plat-omap/include/plat/io.h         |    9 --
 arch/arm/plat-omap/include/plat/irqs.h       |   89 ----------------
 arch/arm/plat-omap/io.c                      |    4 -
 22 files changed, 411 insertions(+), 260 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/irqs-44xx.h
 create mode 100644 arch/arm/plat-omap/include/plat/dma-44xx.h

Regards,
Santosh

