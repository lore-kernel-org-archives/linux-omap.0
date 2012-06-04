From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Mon, 4 Jun 2012 12:15:01 +0530
Message-ID: <cover.1338790117.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54486 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab2FDHBM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 03:01:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

Hi,

This series cleans up gpmc mtd interactions so that GPMC driver
conversion which is going to happen shortly would happen smoothly
by not creating much disturbance outside of arch/arm/*omap*/

This series,
1. provides the ability for OMAP NAND driver to configure GPMC-NAND
   registers by NAND driver itself instead of using exported GPMC
   symbols
2. modifies GPMC to provide OMAP ONENAND & NAND drivers with GPMC
   allocated address space as resource
3. creates a fictitious GPMC interrupt chip and provide the clients
   with interrupts that could be handled using standard APIs (helps
   in removing the requirement for driver of peripheral connected to
   GPMC having the knowledge about GPMC interrupt handling). The
   only user is OMAP NAND driver, it has also been modified to take
   advantage of this

This series has been made over 3.5-rc1

Regards
Afzal

Reference:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69066.html

Afzal Mohammed (10):
  ARM: OMAP2+: gpmc: update nand register helper
  ARM: OMAP2+: gpmc-nand: update gpmc-nand regs
  mtd: nand: omap2: handle nand on gpmc
  ARM: OMAP2+: gpmc-nand: update resource with memory
  ARM: OMAP2+: gpmc-onenand: provide memory as resource
  mtd: nand: omap2: obtain memory from resource
  mtd: onenand: omap2: obtain memory from resource
  ARM: OMAP2+: gpmc: Modify interrupt handling
  ARM: OMAP2+: gpmc-nand: Modify Interrupt handling
  mtd: nand: omap2: use gpmc provided irqs

 arch/arm/mach-omap2/gpmc-nand.c        |   28 ++-
 arch/arm/mach-omap2/gpmc-onenand.c     |   23 ++-
 arch/arm/mach-omap2/gpmc.c             |  156 +++++++++++++++--
 arch/arm/plat-omap/include/plat/gpmc.h |   19 +++
 arch/arm/plat-omap/include/plat/nand.h |    2 +-
 drivers/mtd/nand/omap2.c               |  294 ++++++++++++++++++++++++--------
 drivers/mtd/onenand/omap2.c            |   29 ++--
 7 files changed, 439 insertions(+), 112 deletions(-)

-- 
1.7.10.2

