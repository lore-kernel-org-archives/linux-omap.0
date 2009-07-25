From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/8] Fixes for OMAP2/3 SDRC/clock for 2.6.31-rc*
Date: Fri, 24 Jul 2009 20:11:18 -0600
Message-ID: <20090725021102.29059.94214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50645 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZGYCND (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 22:13:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series contains fixes for 2.6.31-rc* for the OMAP2/3 SDRC SDRAM
controller and the OMAP2/3 clock code.

Boot-tested on BeagleBoard rev C2 and N800.  Additional CORE DVFS
testing run on BeagleBoard rev C2.


- Paul

---

size:
   text	   data	    bss	    dec	    hex	filename
3451158	 197824	 104656	3753638	 3946a6	vmlinux.beagle.orig
3452322	 198592	 104656	3755570	 394e32	vmlinux.beagle


Jean Pihet (2):
      OMAP3 SDRC: add support for 2 SDRAM chip selects
      OMAP3: Setup MUX settings for SDRC CKE signals

Paul Walmsley (4):
      OMAP2/3 SDRC: don't set SDRC_POWER.PWDENA on boot
      OMAP2/3 clock: split, rename omap2_wait_clock_ready()
      OMAP2 clock: 2430 I2CHS uses non-standard CM_IDLEST register
      OMAP3 clock: correct module IDLEST bits: SSI; DSS; USBHOST; HSOTGUSB

Rajendra Nayak (2):
      OMAP3 SDRC: Fix freeze when scaling CORE dpll to < 83Mhz
      OMAP3 SDRC: Move the clk stabilization delay to the right place


 arch/arm/mach-omap2/board-2430sdp.c      |    2 
 arch/arm/mach-omap2/board-3430sdp.c      |    2 
 arch/arm/mach-omap2/board-4430sdp.c      |    2 
 arch/arm/mach-omap2/board-apollon.c      |    2 
 arch/arm/mach-omap2/board-generic.c      |    2 
 arch/arm/mach-omap2/board-h4.c           |    2 
 arch/arm/mach-omap2/board-ldp.c          |    2 
 arch/arm/mach-omap2/board-omap3beagle.c  |    7 +
 arch/arm/mach-omap2/board-omap3evm.c     |    2 
 arch/arm/mach-omap2/board-omap3pandora.c |    8 +-
 arch/arm/mach-omap2/board-overo.c        |    8 +-
 arch/arm/mach-omap2/board-rx51.c         |    6 +
 arch/arm/mach-omap2/board-zoom2.c        |    2 
 arch/arm/mach-omap2/clock.c              |  156 +++++++++++++++---------------
 arch/arm/mach-omap2/clock.h              |    6 +
 arch/arm/mach-omap2/clock24xx.c          |   37 +++++++
 arch/arm/mach-omap2/clock24xx.h          |    4 -
 arch/arm/mach-omap2/clock34xx.c          |  155 +++++++++++++++++++++++++++---
 arch/arm/mach-omap2/clock34xx.h          |   85 ++++++++++++++--
 arch/arm/mach-omap2/io.c                 |    5 +
 arch/arm/mach-omap2/mux.c                |    6 +
 arch/arm/mach-omap2/prcm.c               |   43 ++++++++
 arch/arm/mach-omap2/sdrc.c               |   68 +++++++++----
 arch/arm/mach-omap2/sram34xx.S           |  143 +++++++++++++++++++++-------
 arch/arm/plat-omap/include/mach/clock.h  |    2 
 arch/arm/plat-omap/include/mach/io.h     |    3 -
 arch/arm/plat-omap/include/mach/mux.h    |    4 +
 arch/arm/plat-omap/include/mach/prcm.h   |    1 
 arch/arm/plat-omap/include/mach/sdrc.h   |   11 ++
 arch/arm/plat-omap/include/mach/sram.h   |   23 ++--
 arch/arm/plat-omap/sram.c                |   30 +++---
 31 files changed, 623 insertions(+), 206 deletions(-)


