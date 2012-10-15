From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] ARM: OMAP2+: PRM/CM cleanup series for 3.8
Date: Mon, 15 Oct 2012 17:05:38 -0600
Message-ID: <20121015224455.18306.89030.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42498 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab2JOXG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 19:06:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Consolidate and remove some PRM/CM code in preparation for a future move
into drivers/:

- Remove some obsolete weak functions that allowed old OMAP4 code to
  reference OMAP2/3 PRM functions

- Split many of the functions in prm2xxx_3xxx.c and cm2xxx_3xxx.c into
  2xxx- and 3xxx-specific PRM/CM C files

- Move low-level powerdomain and clockdomain register access into the
  appropriate 2xxx- and 3xxx-specific PRM/CM files, and remove
  {power,clock}domainXXXX.c

This series shouldn't have any functional impact.


- Paul

---

prm_cm_split_cleanup_3.8
   text	   data	    bss	    dec	    hex	filename
7515444	 696732	5613932	13826108	 d2f83c	vmlinux.omap2plus_defconfig.orig
7515308	 696724	5613932	13825964	 d2f7ac	vmlinux.omap2plus_defconfig

Paul Walmsley (5):
      ARM: OMAP2+: PRM: remove PRM weak functions
      ARM: OMAP2+: PRM: split PRM functions into OMAP2, OMAP3-specific files
      ARM: OMAP2+: powerdomain/PRM: move the low-level powerdomain functions into PRM
      ARM: OMAP2+: CM/hwmod: split CM functions into OMAP2, OMAP3-specific files
      ARM: OMAP2/3: clockdomain/PRM/CM: move the low-level clockdomain functions into PRM/CM


 arch/arm/mach-omap2/Makefile               |  108 +++++----
 arch/arm/mach-omap2/clkt2xxx_apll.c        |    2 
 arch/arm/mach-omap2/clkt2xxx_dpll.c        |    2 
 arch/arm/mach-omap2/clock.c                |    3 
 arch/arm/mach-omap2/clock2420_data.c       |    2 
 arch/arm/mach-omap2/clock2430.c            |    2 
 arch/arm/mach-omap2/clock2430_data.c       |    2 
 arch/arm/mach-omap2/clock34xx.c            |    2 
 arch/arm/mach-omap2/clock3517.c            |    2 
 arch/arm/mach-omap2/clock3xxx_data.c       |    2 
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |  339 ----------------------------
 arch/arm/mach-omap2/clockdomain33xx.c      |   74 ------
 arch/arm/mach-omap2/clockdomain44xx.c      |  151 ------------
 arch/arm/mach-omap2/cm2xxx.c               |  253 +++++++++++++++++++++
 arch/arm/mach-omap2/cm2xxx.h               |   68 ++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h          |  118 +++-------
 arch/arm/mach-omap2/cm33xx.c               |   56 +++++
 arch/arm/mach-omap2/cm3xxx.c               |  303 ++++++++++++++-----------
 arch/arm/mach-omap2/cm3xxx.h               |   86 +------
 arch/arm/mach-omap2/cminst44xx.c           |  139 +++++++++++
 arch/arm/mach-omap2/control.c              |    4 
 arch/arm/mach-omap2/omap_hwmod.c           |   51 +++-
 arch/arm/mach-omap2/pm24xx.c               |    4 
 arch/arm/mach-omap2/pm34xx.c               |    5 
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |  242 --------------------
 arch/arm/mach-omap2/powerdomain33xx.c      |  229 -------------------
 arch/arm/mach-omap2/powerdomain44xx.c      |  285 ------------------------
 arch/arm/mach-omap2/prm-regbits-24xx.h     |    2 
 arch/arm/mach-omap2/prm-regbits-34xx.h     |    2 
 arch/arm/mach-omap2/prm2xxx.c              |   57 +++++
 arch/arm/mach-omap2/prm2xxx.h              |  128 +++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c         |  332 +++++++++------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.h         |  275 ++++++-----------------
 arch/arm/mach-omap2/prm33xx.c              |  202 +++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.c              |  268 ++++++++++------------
 arch/arm/mach-omap2/prm3xxx.h              |  158 +++++++++++++
 arch/arm/mach-omap2/prm44xx.c              |  275 ++++++++++++++++++++++-
 arch/arm/mach-omap2/prm_common.c           |   62 -----
 arch/arm/mach-omap2/sdrc2xxx.c             |    2 
 arch/arm/mach-omap2/sleep34xx.S            |    4 
 arch/arm/mach-omap2/sram242x.S             |    4 
 arch/arm/mach-omap2/sram243x.S             |    4 
 arch/arm/mach-omap2/sram34xx.S             |    2 
 43 files changed, 1973 insertions(+), 2338 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
 delete mode 100644 arch/arm/mach-omap2/clockdomain33xx.c
 delete mode 100644 arch/arm/mach-omap2/clockdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/cm2xxx.c
 create mode 100644 arch/arm/mach-omap2/cm2xxx.h
 rename arch/arm/mach-omap2/{cm2xxx_3xxx.c => cm3xxx.c} (72%)
 copy arch/arm/mach-omap2/{cm2xxx_3xxx.h => cm3xxx.h} (50%)
 delete mode 100644 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
 delete mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 delete mode 100644 arch/arm/mach-omap2/powerdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/prm2xxx.c
 create mode 100644 arch/arm/mach-omap2/prm2xxx.h
 copy arch/arm/mach-omap2/{prm2xxx_3xxx.c => prm3xxx.c} (58%)
 create mode 100644 arch/arm/mach-omap2/prm3xxx.h

