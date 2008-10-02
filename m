From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/10] OMAP clock updates for post 2.6.27
Date: Thu, 02 Oct 2008 10:37:46 -0600
Message-ID: <20081002163508.15385.43247.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51880 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbYJBQrB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 12:47:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hello,

This patch series updates the OMAP2/3 clock tree. Some patches are
from Tony's previous omap2-upstream series, and were already posted to
linux-arm-kernel and reviewed[1].  The remaining patches are mostly
clockdomain updates.

The series can be pulled from:

   git://git.pwsan.com/linux-2.6 omap-clock-upstream

The branch is based on rmk/devel, since powerdomain and clockdomain
changes are not yet in mainline.


- Paul

1. http://lists.arm.linux.org.uk/lurker/message/20080823.233712.c5e3bf4e.en.html

---

Kevin Hilman (1):
      ARM: OMAP2: Implement CPUfreq frequency table based on PRCM table

Paul Walmsley (8):
      OMAP2/3 clock: add clockdomains to all remaining clocks; remove superfluous init
      OMAP3 PRCM: add DPLL1-5 powerdomains, clockdomains; mark clocks
      OMAP2/3 clockdomains: add CM, PRM, virt_opp_clkdm clockdomains
      OMAP2/3 clockdomains: combine pwrdm, pwrdm_name into union in struct clockdomain
      OMAP2/3 clock: combine clkdm, clkdm_name into union in struct clk
      ARM: OMAP: Clock tree updates for OMAP2/3
      ARM: OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
      ARM: OMAP2: Add non-CORE DPLL rate set code and M,N programming

Tony Lindgren (1):
      ARM: OMAP2: Remove OMAP_PRM_REGADDR, OMAP_CM_REGADDR


 arch/arm/mach-omap2/clock.c                   |  143 ++--
 arch/arm/mach-omap2/clock.h                   |    2 
 arch/arm/mach-omap2/clock24xx.c               |  145 +++-
 arch/arm/mach-omap2/clock24xx.h               |  611 +++++++++---------
 arch/arm/mach-omap2/clock34xx.c               |  141 ++++
 arch/arm/mach-omap2/clock34xx.h               |  850 ++++++++++++++-----------
 arch/arm/mach-omap2/clockdomain.c             |   58 +-
 arch/arm/mach-omap2/clockdomains.h            |  119 +++-
 arch/arm/mach-omap2/cm-regbits-34xx.h         |   15 
 arch/arm/mach-omap2/cm.h                      |   17 -
 arch/arm/mach-omap2/memory.c                  |    3 
 arch/arm/mach-omap2/pm.c                      |    2 
 arch/arm/mach-omap2/powerdomains.h            |    5 
 arch/arm/mach-omap2/powerdomains34xx.h        |   31 +
 arch/arm/mach-omap2/prm-regbits-34xx.h        |    9 
 arch/arm/mach-omap2/prm.h                     |  166 ++---
 arch/arm/mach-omap2/sram242x.S                |    5 
 arch/arm/mach-omap2/sram243x.S                |    5 
 arch/arm/plat-omap/common.c                   |    1 
 arch/arm/plat-omap/cpu-omap.c                 |   58 ++
 arch/arm/plat-omap/include/mach/clock.h       |   17 -
 arch/arm/plat-omap/include/mach/clockdomain.h |   24 -
 arch/arm/plat-omap/include/mach/common.h      |    5 
 arch/arm/plat-omap/include/mach/powerdomain.h |    5 
 arch/arm/plat-omap/include/mach/prcm.h        |    5 
 arch/arm/plat-omap/include/mach/system.h      |    4 
 26 files changed, 1484 insertions(+), 962 deletions(-)


