From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/18] OMAP2/3/4 clock: split out code for clock types and
	clean up
Date: Fri, 15 Jan 2010 02:06:50 -0700
Message-ID: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48712 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756763Ab0AOJIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This patch series splits clock2xxx.c and clock34xx.c by
clock "type", e.g., DPLLs, APLLs, clksel clocks, etc.  The point
is to make the code easier to read and easier to debug (by
restricting the scope of DEBUG defines).  This also lays the
groundwork for further generalization of the clock code.

The series also cleans up a few other minor aspects of the clock
code: the various struct omap2_clk_functions are combined; a
warning identified by sparse is resolved; unnecessary includes
have been trimmed; and some formerly-common code is now only
compiled for the chips that need it.

There are a few minor functional changes, documented in some of
the patch descriptions, but nothing significant.

Compile-tested with n8x0_defconfig, omap_2430sdp_defconfig, and
omap3_beagle_defconfig.  Boot-tested on Beagle and N800.

Applies on the "for_2.6.34" branch of git://git.pwsan.com/linux-2.6 


- Paul


---

size:
   text	   data	    bss	    dec	    hex	filename
2329525	 126400	  64056	2519981	 2673ad	vmlinux.n8x0.orig
2329585	 126400	  64056	2520041	 2673e9	vmlinux.n8x0.patched
3418395	 179456	 146848	3744699	 3923bb	vmlinux.2430sdp.orig
3418547	 179456	 146848	3744851	 392453	vmlinux.2430sdp.patched
3624493	 199200	 102984	3926677	 3bea95	vmlinux.beagle.orig
3624373	 199200	 102984	3926557	 3bea1d	vmlinux.beagle

Paul Walmsley (18):
      OMAP3 clock: move OMAP3-specific DPLL functions to dpll3xxx.c
      OMAP2/3/4 clock: move DPLL clock functions into clkt_dpll.c
      OMAP2/3/4 clock: move clksel clock functions into clkt_clksel.c
      OMAP2 clock: move all static functions to the top of the file
      OMAP2/3/4 clock: combine all omap2_clk_functions
      OMAP2xxx clock: move the DPLL+CORE composite clock code into clkt2xxx_dpllcore.c
      OMAP2xxx clock: move the DVFS virtual clock code into clkt2xxx_virt_prcm_set.c
      OMAP2xxx clock: move the APLL clock code into clkt2xxx_apll.c
      OMAP2xxx clock: move osc_clk code into clkt2xxx_osc.c
      OMAP2xxx clock: move sys_clk code into clkt2xxx_sys.c
      OMAP2 clock: don't compile OMAP2430-only functions on non-2430 builds
      OMAP3 clock: split out DPLL3 M2 divider functions into clkt3xxx_dpll3m2.c
      OMAP2/3 clock: clean up omap*_clk_arch_init()
      OMAP2/3 clock: remove unnecessary includes and clean up header
      OMAP2/3/4 clock: omap2_clk_prepare_for_reboot() is OMAP2xxx-only
      OMAP3 DPLL: reorganize static functions
      OMAP clock: resolve all remaining sparse warnings
      OMAP2/3/4 clock: rename and clean the omap2_clk_init() functions


 arch/arm/mach-omap2/Makefile                 |   18 -
 arch/arm/mach-omap2/clkt2xxx_apll.c          |  120 ++++
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |  172 +++++
 arch/arm/mach-omap2/clkt2xxx_osc.c           |   62 ++
 arch/arm/mach-omap2/clkt2xxx_sys.c           |   50 ++
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |  245 ++++++++
 arch/arm/mach-omap2/clkt3xxx_dpll3m2.c       |  120 ++++
 arch/arm/mach-omap2/clkt_clksel.c            |  413 +++++++++++++
 arch/arm/mach-omap2/clkt_dpll.c              |  386 ++++++++++++
 arch/arm/mach-omap2/clock.c                  |  825 ++------------------------
 arch/arm/mach-omap2/clock.h                  |   11 
 arch/arm/mach-omap2/clock2xxx.c              |  548 +----------------
 arch/arm/mach-omap2/clock2xxx.h              |    7 
 arch/arm/mach-omap2/clock2xxx_data.c         |    6 
 arch/arm/mach-omap2/clock34xx.c              |  154 -----
 arch/arm/mach-omap2/clock34xx.h              |    1 
 arch/arm/mach-omap2/clock34xx_data.c         |   19 -
 arch/arm/mach-omap2/clock44xx.c              |   14 
 arch/arm/mach-omap2/clock44xx.h              |    2 
 arch/arm/mach-omap2/clock44xx_data.c         |    4 
 arch/arm/mach-omap2/dpll3xxx.c               |  113 ++--
 arch/arm/mach-omap2/io.c                     |   15 
 arch/arm/mach-omap2/prcm.c                   |    8 
 arch/arm/plat-omap/clock.c                   |    2 
 arch/arm/plat-omap/include/plat/clock.h      |    2 
 25 files changed, 1774 insertions(+), 1543 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_apll.c
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_dpllcore.c
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_osc.c
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_sys.c
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
 create mode 100644 arch/arm/mach-omap2/clkt3xxx_dpll3m2.c
 create mode 100644 arch/arm/mach-omap2/clkt_clksel.c
 create mode 100644 arch/arm/mach-omap2/clkt_dpll.c
 rename arch/arm/mach-omap2/{dpll.c => dpll3xxx.c} (98%)

