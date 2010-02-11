From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/13] OMAP: clock: cleanup series for 2.6.34
Date: Thu, 11 Feb 2010 11:16:19 -0700
Message-ID: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35508 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463Ab0BKSUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:20:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

this series, targeted for 2.6.34,

- fixes several OMAP clock bugs,

- removes several unnecessary clock structure fields and clock flags,

- splits the OMAP2420 and OMAP2430 clock trees in preparation for
  multi-OMAP 2 kernels,

- and modularizes the OMAP3 chip family-specific clock code so
  some code and data that is not applicable to a targeted build
  can be elided during compilation.

The series has been boot-tested on the OMAP2430 SDP.  Further testing
is now being undertaken on OMAP5912 OSK, N800 and OMAP3530 Beagle.


- Paul

---

size:
   text	   data	    bss	    dec	    hex	filename
3420642	 179744	 146880	3747266	 392dc2	vmlinux.2430sdp.orig
3420170	 176928	 146880	3743978	 3920ea	vmlinux.2430sdp.patched


Paul Walmsley (13):
      OMAP2/3/4 clock: fix DPLL multiplier value errors; also copyrights, includes, documentation
      OMAP4 clock: drop the CLOCK_IN_OMAP4430 clock flag
      OMAP2xxx clock: GFX functional clock rates are not independently changeable
      OMAP2xxx clock: drop DELAYED_APP flag from non-clksel clocks
      OMAP2 clock: drop CONFIG_PARTICIPANT clock flag
      OMAP clock: compress clock flags down to a u8
      OMAP clock: drop .id field; ensure each clock has a unique name
      OMAP3/4 clock: split into per-chip family files
      OMAP2 clock: split OMAP2420, OMAP2430 clock data into their own files
      OMAP2430 clock: make func_96m_ck parent-selectable
      OMAP2 clock: drop DELAYED_APP clock flag
      OMAP clock: drop RATE_FIXED clock flag
      OMAP4 clock: drop the ALWAYS_ENABLED clock flag


 arch/arm/mach-omap1/clock.c             |    5 
 arch/arm/mach-omap1/clock_data.c        |   35 +-
 arch/arm/mach-omap2/Makefile            |   38 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c     |    4 
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c  |    1 
 arch/arm/mach-omap2/clkt_clksel.c       |    8 
 arch/arm/mach-omap2/clkt_dpll.c         |    2 
 arch/arm/mach-omap2/clock.c             |   50 +-
 arch/arm/mach-omap2/clock.h             |    2 
 arch/arm/mach-omap2/clock2420_data.c    |  697 +++++++------------------------
 arch/arm/mach-omap2/clock2430.c         |   59 +++
 arch/arm/mach-omap2/clock2430_data.c    |  637 +++++++---------------------
 arch/arm/mach-omap2/clock2xxx.c         |   38 --
 arch/arm/mach-omap2/clock2xxx.h         |   26 +
 arch/arm/mach-omap2/clock34xx.c         |  260 ------------
 arch/arm/mach-omap2/clock34xx.h         |   27 -
 arch/arm/mach-omap2/clock3517.c         |  124 ++++++
 arch/arm/mach-omap2/clock3517.h         |   14 +
 arch/arm/mach-omap2/clock36xx.c         |   72 +++
 arch/arm/mach-omap2/clock36xx.h         |   13 +
 arch/arm/mach-omap2/clock3xxx.c         |  145 ++++++
 arch/arm/mach-omap2/clock3xxx.h         |   21 +
 arch/arm/mach-omap2/clock3xxx_data.c    |  112 ++---
 arch/arm/mach-omap2/clock44xx.c         |   19 -
 arch/arm/mach-omap2/clock44xx.h         |   13 -
 arch/arm/mach-omap2/clock44xx_data.c    |  127 ------
 arch/arm/mach-omap2/dpll3xxx.c          |    4 
 arch/arm/mach-omap2/io.c                |    8 
 arch/arm/plat-omap/clock.c              |    2 
 arch/arm/plat-omap/include/plat/clock.h |   82 ++--
 30 files changed, 964 insertions(+), 1681 deletions(-)
 copy arch/arm/mach-omap2/{clock2xxx_data.c => clock2420_data.c} (72%)
 create mode 100644 arch/arm/mach-omap2/clock2430.c
 rename arch/arm/mach-omap2/{clock2xxx_data.c => clock2430_data.c} (75%)
 create mode 100644 arch/arm/mach-omap2/clock3517.c
 create mode 100644 arch/arm/mach-omap2/clock3517.h
 create mode 100644 arch/arm/mach-omap2/clock36xx.c
 create mode 100644 arch/arm/mach-omap2/clock36xx.h
 create mode 100644 arch/arm/mach-omap2/clock3xxx.c
 create mode 100644 arch/arm/mach-omap2/clock3xxx.h
 rename arch/arm/mach-omap2/{clock34xx_data.c => clock3xxx_data.c} (98%)
 delete mode 100644 arch/arm/mach-omap2/clock44xx.c

