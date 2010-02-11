From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/17] omap updates for 2.6.34 merge window, part 1
Date: Wed, 10 Feb 2010 19:35:25 -0800
Message-ID: <20100211033310.1624.80025.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65474 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0BKDes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 22:34:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Over the next few days I'll be posting total of 66 omap patches
for review. Here's part 1.

Regards,

Tony


---

Felipe Balbi (4):
      omap1: mailbox: kill compile warning
      omap2/3/4: mailbox: kill compile warning in mailbox.c
      omap2/3/4: gpmc: kill compile warning
      omap2/3/4: gpmc: avoid section definitions on headers

Hiroshi DOYU (3):
      omap iommu: cleanup iommu page address mask and definitions
      omap: iommu: fix incorrect address for supersection 1st entry
      omap iommu: fix incorrect address for largepage 1st entry

Janusz Krzysztofik (4):
      omap: McBSP: Use macros for all register read/write operations
      omap: McBSP: Modify macros/functions API for easy cache access
      omap: McBSP: Introduce caching in register write operations
      omap: McBSP: Use cache when modifying individual register bits

Ladislav Michl (2):
      omap: convert boards to use physmap-flash
      MTD: remove no longer used OMAP flash map

Vimal Singh (3):
      omap2/3/4: Introducing 'gpmc-nand.c' for GPMC specific NAND init
      omap3: SDP: Introducing 'board-sdp-flash.c' for flash init
      omap3: Add support for flash on 3430SDP board

vikram pandita (1):
      omap2/3/4: serial: fix coding style indentaion


 arch/arm/mach-omap1/Makefile                 |    2 
 arch/arm/mach-omap1/board-fsample.c          |    9 -
 arch/arm/mach-omap1/board-h2.c               |    9 -
 arch/arm/mach-omap1/board-h3.c               |    9 -
 arch/arm/mach-omap1/board-innovator.c        |    9 -
 arch/arm/mach-omap1/board-osk.c              |    9 -
 arch/arm/mach-omap1/board-palmte.c           |    9 -
 arch/arm/mach-omap1/board-palmtt.c           |    9 -
 arch/arm/mach-omap1/board-palmz71.c          |   10 -
 arch/arm/mach-omap1/board-perseus2.c         |    9 -
 arch/arm/mach-omap1/board-sx1.c              |   11 -
 arch/arm/mach-omap1/board-voiceblue.c        |    9 -
 arch/arm/mach-omap1/devices.c                |    2 
 arch/arm/mach-omap1/flash.c                  |   33 ++
 arch/arm/mach-omap1/mailbox.c                |    9 -
 arch/arm/mach-omap1/mcbsp.c                  |   16 +
 arch/arm/mach-omap2/Makefile                 |    6 
 arch/arm/mach-omap2/board-2430sdp.c          |    7 
 arch/arm/mach-omap2/board-3430sdp.c          |  111 ++++++++
 arch/arm/mach-omap2/board-h4.c               |    7 
 arch/arm/mach-omap2/board-sdp-flash.c        |  272 +++++++++++++++++++
 arch/arm/mach-omap2/gpmc-nand.c              |  139 ++++++++++
 arch/arm/mach-omap2/gpmc.c                   |    6 
 arch/arm/mach-omap2/include/mach/board-sdp.h |   21 +
 arch/arm/mach-omap2/mailbox.c                |    2 
 arch/arm/mach-omap2/mcbsp.c                  |   20 +
 arch/arm/mach-omap2/serial.c                 |   19 +
 arch/arm/plat-omap/include/plat/flash.h      |   16 +
 arch/arm/plat-omap/include/plat/gpmc.h       |    4 
 arch/arm/plat-omap/include/plat/mcbsp.h      |    3 
 arch/arm/plat-omap/include/plat/nand.h       |   10 +
 arch/arm/plat-omap/iommu.c                   |    6 
 arch/arm/plat-omap/iopgtable.h               |   50 +++-
 arch/arm/plat-omap/mcbsp.c                   |  366 +++++++++++++-------------
 drivers/mtd/maps/Kconfig                     |    9 -
 drivers/mtd/maps/Makefile                    |    1 
 drivers/mtd/maps/omap_nor.c                  |  188 -------------
 drivers/mtd/nand/omap2.c                     |   35 --
 38 files changed, 962 insertions(+), 500 deletions(-)
 create mode 100644 arch/arm/mach-omap1/flash.c
 create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.c
 create mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h
 create mode 100644 arch/arm/plat-omap/include/plat/flash.h

-- 
Signature
