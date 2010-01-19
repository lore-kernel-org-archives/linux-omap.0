From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 00/18] OMAP2/3/4 clock: split out code for clock types and
	clean up
Date: Tue, 19 Jan 2010 16:35:45 -0700
Message-ID: <20100119232900.26047.98263.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58589 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab0ASXib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 18:38:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This second version of this series improves the patch changelogs
and adds some code comments.

This patch series splits clock2xxx.c and clock34xx.c by
clock "type", e.g., DPLLs, APLLs, clksel clocks, etc.  The point
is to make the code easier to read and easier to debug (by
restricting the scope of DEBUG defines).  This also lays the
groundwork for further generalization of the clock code and prepares
for a multi-OMAP2/3/4 kernel.

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

Thanks to Alexander Shishkin <virtuoso@slind.org> for his comments.


- Paul

---

size:
   text    data     bss     dec     hex filename
2338183	 126432	  64056	2528671	 26959f	vmlinux.n8x0.orig
2338299	 126432	  64056	2528787	 269613	vmlinux.n8x0.patched
3427989	 179488	 146848	3754325	 394955	vmlinux.2430sdp.orig
3428069	 179488	 146848	3754405	 3949a5	vmlinux.2430sdp.patched
3635559	 199232	 102984	3937775	 3c15ef	vmlinux.beagle.orig
3635443	 199232	 102984	3937659	 3c157b	vmlinux.beagle.patched
2038356	 169664	  65380	2273400	 22b078	vmlinux.4430sdp.orig
2038448	 169664	  65380	2273492	 22b0d4	vmlinux.4430sdp.patched

Paul Walmsley (18):
      OMAP3 clock: move OMAP3-specific DPLL functions to dpll3xxx.c
      OMAP2/3/4 clock: move DPLL clock functions into mach-omap2/clkt_dpll.c
      OMAP2/3/4 clock: move clksel clock functions into mach-omap2/clkt_clksel.c
      OMAP2 clock: move all static functions to the top of the file
      OMAP2/3/4 clock: combine all omap2_clk_functions
      OMAP2xxx clock: move the DPLL+CORE composite clock code into mach-omap2/clkt2xxx_dpllcore.c
      OMAP2xxx clock: move the DVFS virtual clock code into mach-omap2/clkt2xxx_virt_prcm_set.c
      OMAP2xxx clock: move the APLL clock code into mach-omap2/clkt2xxx_apll.c
      OMAP2xxx clock: move osc_clk code into mach-omap2/clkt2xxx_osc.c
      OMAP2xxx clock: move sys_clk code into mach-omap2/clkt2xxx_sys.c
      OMAP2 clock: don't compile OMAP2430-only functions on non-2430 builds
      OMAP3 clock: split out DPLL3 M2 divider functions into mach-omap2/clkt3xxx_dpll3m2.c
      OMAP2/3 clock: clean up omap*_clk_arch_init()
      OMAP2/3 clock: remove unnecessary includes and clean up header
      OMAP2/3/4 clock: omap2_clk_prepare_for_reboot() is OMAP2xxx-only
      OMAP3 DPLL: reorganize static functions
      OMAP clock: resolve all remaining sparse warnings
      OMAP2/3/4 clock: rename and clean the omap2_clk_init() functions


 arch/arm/mach-omap2/Makefile                 |   18 -
 arch/arm/mach-omap2/clkt2xxx_apll.c          |  120 ++++
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |  173 +++++
 arch/arm/mach-omap2/clkt2xxx_osc.c           |   62 ++
 arch/arm/mach-omap2/clkt2xxx_sys.c           |   50 ++
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |  254 ++++++++
 arch/arm/mach-omap2/clkt3xxx_dpll3m2.c       |  120 ++++
 arch/arm/mach-omap2/clkt_clksel.c            |  417 +++++++++++++
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
 25 files changed, 1788 insertions(+), 1543 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_apll.c
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_dpllcore.c
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_osc.c
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_sys.c
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
 create mode 100644 arch/arm/mach-omap2/clkt3xxx_dpll3m2.c
 create mode 100644 arch/arm/mach-omap2/clkt_clksel.c
 create mode 100644 arch/arm/mach-omap2/clkt_dpll.c
 rename arch/arm/mach-omap2/{dpll.c => dpll3xxx.c} (98%)

