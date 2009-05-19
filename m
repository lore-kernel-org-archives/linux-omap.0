From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/10] Omap updates for merge window after 2.6.30
Date: Tue, 19 May 2009 16:30:48 -0700
Message-ID: <20090519232905.12760.15490.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49574 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbZESXaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:30:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi all,

This series contains omap updates for review. There will be one more
series after this for omap3 specific patches.

Regards,

Tony

---

Eero Nurkkala (1):
      ARM: OMAP: McBSP: Fix legacy interrupts to clear their status

Imre Deak (1):
      ARM: OMAP2: 2430SDP: Add FB support to board file

Jarkko Nikula (1):
      ARM: OMAP: Update contact address of I2C registration helper

Juha Yrjola (1):
      ARM: OMAP2/3: Add generic onenand support when connected to GPMC

Mans Rullgard (1):
      ARM: OMAP: Increase VMALLOC_END to allow 256MB RAM

Santosh Shilimkar (1):
      ARM: OMAP2/3: sDMA: Correct omap_request_dma_chain()

Tomi Valkeinen (1):
      ARM: OMAP2/3: DMA: implement trans copy and const fill

Tony Lindgren (3):
      ARM: OMAP2/3: Add generic smc91x support when connected to GPMC
      ARM: OMAP1: Make 770 LCD work
      ARM: OMAP1: Misc clean-up


 arch/arm/configs/rx51_defconfig               |    2 
 arch/arm/mach-omap1/Kconfig                   |    1 
 arch/arm/mach-omap1/Makefile                  |    4 
 arch/arm/mach-omap1/board-nokia770.c          |   17 +
 arch/arm/mach-omap2/Makefile                  |    6 
 arch/arm/mach-omap2/board-2430sdp.c           |  112 ++------
 arch/arm/mach-omap2/board-3430sdp.c           |   78 ++----
 arch/arm/mach-omap2/board-rx51-peripherals.c  |  192 ++++++--------
 arch/arm/mach-omap2/gpmc-onenand.c            |  340 +++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc-smc91x.c             |  189 ++++++++++++++
 arch/arm/plat-omap/dma.c                      |   79 ++++--
 arch/arm/plat-omap/i2c.c                      |    2 
 arch/arm/plat-omap/include/mach/dma.h         |    3 
 arch/arm/plat-omap/include/mach/gpmc-smc91x.h |   46 +++
 arch/arm/plat-omap/include/mach/hwa742.h      |    5 
 arch/arm/plat-omap/include/mach/onenand.h     |   29 ++
 arch/arm/plat-omap/include/mach/vmalloc.h     |    2 
 arch/arm/plat-omap/mcbsp.c                    |   30 ++
 arch/arm/plat-omap/sram.c                     |    4 
 drivers/video/omap/hwa742.c                   |   26 +-
 20 files changed, 851 insertions(+), 316 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpmc-onenand.c
 create mode 100644 arch/arm/mach-omap2/gpmc-smc91x.c
 create mode 100644 arch/arm/plat-omap/include/mach/gpmc-smc91x.h

-- 
Signature
