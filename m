From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH RESEND v8 0/7] nand prefetch-irq support and ecc layout chanage
Date: Wed, 19 Jan 2011 18:54:56 +0530
Message-ID: <1295443503-14515-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39607 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228Ab1ASNZM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 08:25:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

The following set of patches applies on linux-2.6.

The main motivations behind this patch series are -
        1. support NAND I/O in irq mode.
        2. support of different ECC schema.
        3. also add support ecc layout as like in romcode ecc layout, but not enabled

v8: free_irq() added; usedtimeout for this while loop.
Rebase and resend of http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41614.html

v7: NAND type (x16 or x8) is board specific and not omap specific; this passed form board file.
    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41469.html

v6: configurable transfer type from board file; 
    #define irq number used for nand-irq
    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39397.html
    
v5: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35860.html
This address the input as to support the irq_chained in GPMC.
And resend of
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35848.html

v4: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34882.html
and resend of
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32689.html

v3: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32071.html
Rebase on latest codebase and previous patch(posted).
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31963.html

v2: Rebase on latest codebase and previous patch(posted).
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31471.html

v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26666.html

Sukumar Ghorai (7):
  omap3630: nand: fix device size to work in polled mode
  omap3: nand: configurable transfer type per board
  omap: gpmc: enable irq mode in gpmc
  omap3: nand: prefetch in irq mode support
  omap3: nand: configurable fifo threshold to gain the throughput
  omap3: nand: ecc layout select from board file
  omap3: nand: making ecc layout as compatible with romcode ecc

 arch/arm/mach-omap2/board-2430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3430sdp.c        |    3 +-
 arch/arm/mach-omap2/board-3630sdp.c        |    4 +-
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +
 arch/arm/mach-omap2/board-apollon.c        |    1 +
 arch/arm/mach-omap2/board-cm-t35.c         |    1 +
 arch/arm/mach-omap2/board-devkit8000.c     |    1 +
 arch/arm/mach-omap2/board-flash.c          |   13 +-
 arch/arm/mach-omap2/board-flash.h          |    4 +-
 arch/arm/mach-omap2/board-generic.c        |    2 +
 arch/arm/mach-omap2/board-h4.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c       |    1 +
 arch/arm/mach-omap2/board-ldp.c            |    3 +-
 arch/arm/mach-omap2/board-n8x0.c           |    2 +
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +
 arch/arm/mach-omap2/board-omap3stalker.c   |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +
 arch/arm/mach-omap2/board-overo.c          |    1 +
 arch/arm/mach-omap2/board-rx51.c           |    1 +
 arch/arm/mach-omap2/board-zoom.c           |    7 +-
 arch/arm/mach-omap2/gpmc-nand.c            |    7 +-
 arch/arm/mach-omap2/gpmc.c                 |   50 ++++-
 arch/arm/mach-omap2/io.c                   |    3 -
 arch/arm/plat-omap/include/plat/gpmc.h     |   17 ++-
 arch/arm/plat-omap/include/plat/irqs.h     |    9 +-
 arch/arm/plat-omap/include/plat/nand.h     |   11 +
 drivers/mtd/nand/Kconfig                   |   17 --
 drivers/mtd/nand/omap2.c                   |  367 +++++++++++++++++++++-------
 32 files changed, 411 insertions(+), 129 deletions(-)

