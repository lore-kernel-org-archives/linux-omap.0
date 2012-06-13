From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Wed, 13 Jun 2012 17:02:28 +0530
Message-ID: <cover.1339586624.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58616 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab2FMLsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 07:48:09 -0400
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

v2:
[mtd: nand: omap2: handle nand on gpmc] simplify omap_prefetch_enable()

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
 drivers/mtd/nand/omap2.c               |  291 ++++++++++++++++++++++++--------
 drivers/mtd/onenand/omap2.c            |   29 ++--
 7 files changed, 436 insertions(+), 112 deletions(-)

-- 
1.7.10.2

