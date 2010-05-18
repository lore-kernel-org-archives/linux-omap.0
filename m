From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v3 0/3] omap3 nand: cleanup exiting platform related code
Date: Tue, 18 May 2010 16:46:26 +0530
Message-ID: <1274181389-7488-1-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60585 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756476Ab0ERLQu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 07:16:50 -0400
In-Reply-To: <Sukumar Ghorai <s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, tony@atomide.com, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com, Sukumar Ghorai <s-ghorai@ti.com>

   The following set of patches applies on top of for-next branch.
	http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git
   Patches verified on: omap3430-SDP, omap3630-sdp, zoom3 and beagle board

   And these are the patches required to address the following input -
     1. The NAND driver needs to stop tinkering with the GPMC registers
	The omap General Purpose Memory Controller (GPMC) registers are omap
        specific, and not driver specific. Tinkering with these registers can
        cause issues with the other devices on the GPMC.

     2. Passing hardcoded GPMC_CS0_BASE needs to go from the board files
	Passing hardcoded GPMC virtual addressess is sure way to mess up things.
        This should all become unnecessary once the NAND drivers stops messing
        with the GPMC registers directly.

  v2: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28467.html
	Few functionality was missing  like - There should be some locking 
	as only one chipselect can use the ECC or prefetch engine at a time. 
	If you have NAND in two chipselects, bad things would happen.
	
  v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28164.html
	Additionally, it was needed to implement more functions for the
	platform init code to use.


Sukumar Ghorai (3):
	omap3 gpmc: functionality enhancement
	omap3 nand: cleanup virtual address usages
	omap3 nand: fix issue in board file to detect nand

 arch/arm/mach-omap2/board-cm-t35.c         |   20 +---
 arch/arm/mach-omap2/board-devkit8000.c     |   25 +---
 arch/arm/mach-omap2/board-omap3beagle.c    |   24 +---
 arch/arm/mach-omap2/board-omap3touchbook.c |   25 +---
 arch/arm/mach-omap2/board-overo.c          |   24 +---
 arch/arm/mach-omap2/gpmc-nand.c            |   39 ++----
 arch/arm/mach-omap2/gpmc.c                 |    9 -
 arch/arm/plat-omap/include/plat/gpmc.h     |    7 +-
 arch/arm/plat-omap/include/plat/nand.h     |    6 +-
 drivers/mtd/nand/omap2.c                   |  242 +++++++++-------------------
 10 files changed, 93 insertions(+), 328 deletions(-)

