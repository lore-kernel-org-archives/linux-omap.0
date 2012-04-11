From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 00/12] ARM: OMAP: resolve some warnings
Date: Tue, 10 Apr 2012 18:35:16 -0600
Message-ID: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43907 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab2DKAiT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

This is the latest version of the OMAP warnings cleanup series.
This version fixes most of the warnings with arch/arm/mach-omap1,
arch/arm/mach-omap2, and arch/arm/plat-omap.  It also fixes some
bugs discovered in the process.

Boot-tested on 5912OSK, N800, 35xx BeagleBoard, 37xx EVM,
and 4430 Pandaboard.  Build-tested on the configs listed below,
which are available from git://git.pwsan.com/omap_kconfigs.

This series is also available from git://git.pwsan.com/linux-2.6
in the branch 'sparse_cppcheck_cleanup_3.5'.

Felipe, one of the patches in this branch touches
drivers/usb/host/ohci-omap.c - could you ack it for me if you are
okay with the change?


- Paul

---

object size (delta in bytes from v3.4-rc2):
 text 	 data 	  bss 	total 	kernel
  -84 	  +24 	    0 	  -60 	5912osk_testconfig/vmlinux
 -100 	   -8 	    0 	 -108 	n800_multi_omap2xxx/vmlinux
  -68 	   -8 	    0 	  -76 	n800_testconfig/vmlinux
 -224 	  +56 	  -32 	 -200 	omap1_defconfig/vmlinux
 -148 	  +32 	    0 	 -116 	omap2_4_testconfig/vmlinux
 -212 	    0 	    0 	 -212 	omap2plus_defconfig/vmlinux
 -148 	    0 	    0 	 -148 	omap2plus_no_pm/vmlinux
 -152 	    0 	    0 	 -152 	omap3_4_testconfig/vmlinux
 -100 	   -8 	    0 	 -108 	omap3_testconfig/vmlinux
 -188 	  -24 	  -64 	 -276 	omap4_testconfig/vmlinux

Paul Walmsley (12):
      ARM: OMAP2+: declare file-local functions as static
      ARM: OMAP: add includes for missing prototypes
      ARM: OMAP1: OCPI: move to mach-omap1/
      ARM: OMAP1: OHCI: use platform_data fn ptr to enable OCPI bus
      ARM: OMAP2+: GPMC: resolve type-conversion warning from sparse
      ARM: OMAP: fix 'using plain integer as NULL pointer' sparse warnings
      ARM: OMAP: OCM RAM: use memset_io() when clearing SRAM
      ARM: OMAP: DMA: use constant array maximum, drop some LCD DMA code
      ARM: OMAP: USB: remove unnecessary sideways include
      ARM: OMAP1: board files: deduplicate and clean some NAND-related code
      ARM: OMAP1: DMTIMER: fix broken timer clock source selection
      ARM: OMAP2+: clean up some cppcheck warnings


 arch/arm/mach-omap1/Makefile                 |   13 ++++++---
 arch/arm/mach-omap1/ams-delta-fiq.c          |    2 +
 arch/arm/mach-omap1/board-fsample.c          |   16 +----------
 arch/arm/mach-omap1/board-h2.c               |   17 +----------
 arch/arm/mach-omap1/board-h3.c               |   16 +----------
 arch/arm/mach-omap1/board-nand.c             |   39 ++++++++++++++++++++++++++
 arch/arm/mach-omap1/board-palmz71.c          |    4 +--
 arch/arm/mach-omap1/board-perseus2.c         |   16 +----------
 arch/arm/mach-omap1/clock.c                  |    3 +-
 arch/arm/mach-omap1/common.h                 |   11 +++++++
 arch/arm/mach-omap1/fpga.c                   |    2 +
 arch/arm/mach-omap1/id.c                     |    2 +
 arch/arm/mach-omap1/io.c                     |    3 +-
 arch/arm/mach-omap1/irq.c                    |    2 +
 arch/arm/mach-omap1/lcd_dma.c                |    7 +----
 arch/arm/mach-omap1/ocpi.c                   |    7 +++--
 arch/arm/mach-omap1/pm.c                     |    9 +++---
 arch/arm/mach-omap1/reset.c                  |    2 +
 arch/arm/mach-omap1/timer.c                  |    7 ++---
 arch/arm/mach-omap1/usb.c                    |    3 ++
 arch/arm/mach-omap2/am35xx-emac.c            |   37 +++++++++++--------------
 arch/arm/mach-omap2/board-omap3evm.c         |    8 +++--
 arch/arm/mach-omap2/board-omap4panda.c       |    8 +++--
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 +--
 arch/arm/mach-omap2/board-zoom-display.c     |    1 +
 arch/arm/mach-omap2/common.h                 |    2 -
 arch/arm/mach-omap2/devices.c                |    7 ++---
 arch/arm/mach-omap2/gpio.c                   |    2 +
 arch/arm/mach-omap2/gpmc-onenand.c           |    3 +-
 arch/arm/mach-omap2/gpmc.c                   |    3 +-
 arch/arm/mach-omap2/hwspinlock.c             |    2 +
 arch/arm/mach-omap2/io.c                     |    1 +
 arch/arm/mach-omap2/irq.c                    |    3 +-
 arch/arm/mach-omap2/mux.c                    |    2 +
 arch/arm/mach-omap2/omap-secure.c            |    1 +
 arch/arm/mach-omap2/omap-wakeupgen.c         |    2 +
 arch/arm/mach-omap2/pm24xx.c                 |    3 --
 arch/arm/mach-omap2/pm34xx.c                 |   10 ++-----
 arch/arm/mach-omap2/prm_common.c             |    4 ++-
 arch/arm/mach-omap2/serial.c                 |    2 +
 arch/arm/mach-omap2/usb-tusb6010.c           |    2 +
 arch/arm/plat-omap/Makefile                  |    3 --
 arch/arm/plat-omap/common.c                  |    1 +
 arch/arm/plat-omap/dma.c                     |   13 +++++++--
 arch/arm/plat-omap/dmtimer.c                 |    3 +-
 arch/arm/plat-omap/include/plat/board.h      |    2 +
 arch/arm/plat-omap/include/plat/common.h     |    2 +
 arch/arm/plat-omap/include/plat/dma.h        |    1 +
 arch/arm/plat-omap/include/plat/dmtimer.h    |    4 +--
 arch/arm/plat-omap/omap_device.c             |    2 -
 arch/arm/plat-omap/sram.c                    |    4 +--
 arch/arm/plat-omap/usb.c                     |    4 ---
 drivers/usb/host/ohci-omap.c                 |    5 ++-
 53 files changed, 165 insertions(+), 167 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-nand.c
 rename arch/arm/{plat-omap/ocpi.c => mach-omap1/ocpi.c} (93%)


