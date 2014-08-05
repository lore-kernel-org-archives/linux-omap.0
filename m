From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/3] [PATCH 0/3] mtd: nand: omap: Use Software ECC by default
Date: Tue, 5 Aug 2014 13:11:19 +0300
Message-ID: <1407233482-11642-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51606 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933145AbaHEKMl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Aug 2014 06:12:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: computersforpeace@gmail.com, tony@atomide.com
Cc: balbi@ti.com, ezequiel.garcia@free-electrons.com, pekon.gupta@gmail.com, artem.bityutskiy@linux.intel.com, dwmw2@infradead.org, jg1.han@samsung.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Hi,

In Linux v3.12 and earlier some boards [1] used Software based ECC as
the NAND ECC scheme. In 3.13 commit c66d039197e4 changed that to
Hardware ECC using ROM code ECC layout. This will cause NAND filesystems
created in 3.12 and earlier to be unreadable in v3.13 and later till
they are erased and re-created.

This series fixes this issue by using Software ECC as the default ECC
scheme for the affected boards.

Tested on omap3beagle.

[1] - Affected boards
-omap3beagle
-omap3touchbook
-overo
-am3517crane
-devkit8000
-ldp
-3430sdp

cheers,
-roger

---
Roger Quadros (3):
  mtd: nand: omap: Revert to using software ECC by default
  ARM: OMAP2+: GPMC: Support Software ECC scheme via DT
  ARM: dts: omap3430-sdp: Revert to using software ECC for NAND

 Documentation/devicetree/bindings/mtd/gpmc-nand.txt |  2 +-
 arch/arm/boot/dts/omap3430-sdp.dts                  |  2 +-
 arch/arm/mach-omap2/board-flash.c                   |  2 +-
 arch/arm/mach-omap2/gpmc-nand.c                     |  3 ++-
 arch/arm/mach-omap2/gpmc.c                          |  7 +++++--
 drivers/mtd/nand/omap2.c                            | 14 +++++++++++---
 include/linux/platform_data/mtd-nand-omap2.h        | 13 +++++++++++--
 7 files changed, 32 insertions(+), 11 deletions(-)

-- 
1.8.3.2

