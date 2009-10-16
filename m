From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/14] Use ioremap for omap,
	split OMAP2_IO_ADDRESS for more space
Date: Fri, 16 Oct 2009 16:40:04 -0700
Message-ID: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49529 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZJPXkC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:40:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

This series intended for the merge window after 2.6.32 removes
OMAP2_IO_ADDRESS to reclaim more address space.

OMAP2_IO_ADDRESS is replaced with ioremap where possible, and
the remaining usage is split into OMAP2_L3_IO_ADDRESS and
OMAP2_L4_IO_ADDRESS.

Some usage still remains in *.S files and headers. Eventually we should
be able to remove the usage and only define it locally.

Note that after this series omap4 no longer uses these macros.
Other omaps will need more work still.

Regards,

Tony

---

Santosh Shilimkar (5):
      omap: Add OMAP4 L3 and L4 peripherals.
      omap: Fix DEBUG_LL UART io address
      omap: Move SRAM map to claim more io space
      omap: Remap L3, L4 to get more kernel io address space
      omap: Split OMAP2_IO_ADDRESS to L3 and L4

Tony Lindgren (9):
      omap: Use ioremap in dispc.c
      omap: Use ioremap for omap4 L4 code
      omap: Use getnstimeofday for omap_device
      omap: Use ioremap in omap_hwmod.c
      omap: Use ioremap in gpio.c
      omap: Use ioremap in dmtimer.c
      omap: Use ioremap in dma.c
      omap: Use ioremap in irq.c
      omap: Change low-level serial init to use ioremap


 arch/arm/mach-omap1/serial.c                  |   11 +
 arch/arm/mach-omap2/board-2430sdp.c           |    2 
 arch/arm/mach-omap2/board-3430sdp.c           |    2 
 arch/arm/mach-omap2/board-4430sdp.c           |   15 +-
 arch/arm/mach-omap2/board-apollon.c           |    2 
 arch/arm/mach-omap2/board-generic.c           |    2 
 arch/arm/mach-omap2/board-h4.c                |    2 
 arch/arm/mach-omap2/board-ldp.c               |    2 
 arch/arm/mach-omap2/board-n8x0.c              |    6 -
 arch/arm/mach-omap2/board-omap3beagle.c       |    2 
 arch/arm/mach-omap2/board-omap3evm.c          |    2 
 arch/arm/mach-omap2/board-omap3pandora.c      |    2 
 arch/arm/mach-omap2/board-overo.c             |    2 
 arch/arm/mach-omap2/board-rx51.c              |    2 
 arch/arm/mach-omap2/board-zoom2.c             |    2 
 arch/arm/mach-omap2/cm.h                      |    6 -
 arch/arm/mach-omap2/io.c                      |   18 ++
 arch/arm/mach-omap2/irq.c                     |   12 +
 arch/arm/mach-omap2/omap-smp.c                |   28 ++-
 arch/arm/mach-omap2/omap_hwmod.c              |   18 +-
 arch/arm/mach-omap2/pm-debug.c                |    3 
 arch/arm/mach-omap2/prm.h                     |    6 -
 arch/arm/mach-omap2/sdrc.h                    |    9 +
 arch/arm/mach-omap2/serial.c                  |   15 +-
 arch/arm/mach-omap2/sram242x.S                |    4 
 arch/arm/mach-omap2/sram243x.S                |    4 
 arch/arm/mach-omap2/timer-gp.c                |    3 
 arch/arm/plat-omap/common.c                   |   44 ++---
 arch/arm/plat-omap/dma.c                      |   34 +++-
 arch/arm/plat-omap/dmtimer.c                  |   16 +-
 arch/arm/plat-omap/gpio.c                     |  222 ++++++++++++++-----------
 arch/arm/plat-omap/include/mach/control.h     |   15 +-
 arch/arm/plat-omap/include/mach/debug-macro.S |    4 
 arch/arm/plat-omap/include/mach/entry-macro.S |    6 -
 arch/arm/plat-omap/include/mach/io.h          |  124 ++++++++++----
 arch/arm/plat-omap/include/mach/omap44xx.h    |    8 -
 arch/arm/plat-omap/include/mach/sdrc.h        |    6 -
 arch/arm/plat-omap/include/mach/vmalloc.h     |    2 
 arch/arm/plat-omap/io.c                       |   20 ++
 arch/arm/plat-omap/omap_device.c              |   50 ++----
 arch/arm/plat-omap/sram.c                     |   24 +--
 drivers/video/omap/dispc.c                    |   20 ++
 42 files changed, 479 insertions(+), 298 deletions(-)

-- 
Signature
