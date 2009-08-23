From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/5] ARM: OMAP2/3/4: Reclaim the kernel IO address space
Date: Sun, 23 Aug 2009 19:00:21 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA29C203@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53484 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933959AbZHWNad convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 09:30:33 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,

This patch series is intended to free up the kernel IO address space for OMAP2XXX, OMAP3XXX and OMAP4430. It is generated against Tony's 
"omap-headers "(2.6.31-rc6) branch and boot tested on OMAP3430 SDP and OMAP4430 platform. 

Some more combinations are possible but to make it uniform across
OMAP2, OMAP3 and OMAP4, these io combinations are chosen.

If needed documentation entry can be created to ease up reading and debugging information.
	Like "Documentation/arm/omap/io_map.txt"

Summary of changes:

The following changes since commit 95e32bc5b2d95370fb67a108a0e3678381fc42df:
  Tony Lindgren (1):
        OMAP: Remove ifdefs for io.h

Santosh Shilimkar (5):
      ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and L4
      ARM: OMAP2/3/4: Remap L3, L4 to get more kernel io address space
      ARM: OMAP2/3/4: Move SRAM map to claim more io space
      ARM: OMAP2/3/4: Fix DEBUG_LL UART io address
      ARM: OMAP2/3/4: Add OMAP4 L3 and L4 peripherals.

 arch/arm/mach-omap2/board-2430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    6 +-
 arch/arm/mach-omap2/board-apollon.c           |    2 +-
 arch/arm/mach-omap2/board-generic.c           |    2 +-
 arch/arm/mach-omap2/board-h4.c                |    2 +-
 arch/arm/mach-omap2/board-ldp.c               |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c       |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |    2 +-
 arch/arm/mach-omap2/board-overo.c             |    2 +-
 arch/arm/mach-omap2/board-rx51.c              |    2 +-
 arch/arm/mach-omap2/board-zoom2.c             |    2 +-
 arch/arm/mach-omap2/cm.h                      |    6 +-
 arch/arm/mach-omap2/io.c                      |   18 ++++
 arch/arm/mach-omap2/irq.c                     |    4 +-
 arch/arm/mach-omap2/omap-smp.c                |    2 +-
 arch/arm/mach-omap2/pm-debug.c                |    3 +-
 arch/arm/mach-omap2/prm.h                     |    6 +-
 arch/arm/mach-omap2/sdrc.h                    |    9 +-
 arch/arm/mach-omap2/serial.c                  |    6 +-
 arch/arm/mach-omap2/sram242x.S                |    4 +-
 arch/arm/mach-omap2/sram243x.S                |    4 +-
 arch/arm/mach-omap2/timer-gp.c                |    2 +-
 arch/arm/plat-omap/common.c                   |   44 +++++-----
 arch/arm/plat-omap/dma.c                      |    6 +-
 arch/arm/plat-omap/dmtimer.c                  |    2 +-
 arch/arm/plat-omap/gpio.c                     |   42 ++++----
 arch/arm/plat-omap/include/mach/control.h     |   15 ++-
 arch/arm/plat-omap/include/mach/debug-macro.S |    4 +-
 arch/arm/plat-omap/include/mach/entry-macro.S |    4 +-
 arch/arm/plat-omap/include/mach/io.h          |  124 +++++++++++++++++--------
 arch/arm/plat-omap/include/mach/omap44xx.h    |   14 ++-
 arch/arm/plat-omap/include/mach/sdrc.h        |    6 +-
 arch/arm/plat-omap/include/mach/vmalloc.h     |    2 +-
 arch/arm/plat-omap/io.c                       |   20 +++-
 arch/arm/plat-omap/sram.c                     |   24 +++---
 drivers/video/omap/dispc.c                    |    6 +-
 38 files changed, 246 insertions(+), 161 deletions(-)


Regards,
Santosh

