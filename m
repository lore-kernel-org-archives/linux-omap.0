From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks, OMAP2xxx
Date: Tue, 15 Feb 2011 23:52:39 -0700
Message-ID: <20110216065030.22089.61217.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47503 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1BPGyD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 01:54:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This patch series adds clock framework-controlled autoidle support for
the OMAP2xxx DPLL, APLLs, and OMAP2/3 interface clocks.  The old
direct register writes in the PM code to enable clock autoidle have been
removed.  

This series also ensures that all clock autoidle is disabled during
boot and only re-enabled if CONFIG_PM is enabled.

The series applies on the 'clk_autoidle_a_2.6.39' branch of
git://git.pwsan.com/linux-2.6.

Boot-tested on N800, and dynamic idle-tested on OMAP3430 Beagleboard.
Compile-tested with omap1_defconfig, omap2plus_defconfig, a 5912
OSK-only config, an N8x0-only config, an OMAP3-only config, and an OMAP4-only
config.


- Paul

---

clk_autoidle_b_2.6.39
   text	   data	    bss	    dec	    hex	filename
5530703	 330544	5594520	11455767	 aecd17	vmlinux.omap2plus_defconfig.orig
5531167	 330544	5594520	11456231	 aecee7	vmlinux.omap2plus_defconfig.patched

Paul Walmsley (11):
      OMAP2+: clock: disable autoidle on all clocks during clock init
      OMAP2: clock: add DPLL autoidle support
      OMAP2xxx: clock: add clockfw autoidle support for APLLs
      OMAP2+: clock: comment that osc_ck/osc_sys_ck should use clockfw autoidle control
      OMAP2+: clock: add interface clock type code with autoidle support
      OMAP2420: clock: add sdrc_ick
      OMAP2420: clock: use autoidle clkops for all autoidle-controllable interface clocks
      OMAP2430/3xxx: clock: add modem clock autoidle support
      OMAP2430: clock: use autoidle clkops for all autoidle-controllable interface clocks
      OMAP3: clock: use autoidle clkops for all autoidle-controllable interface clocks
      OMAP2/3: PM: remove manual CM_AUTOIDLE bit setting in mach-omap2/pm*xx.c


 arch/arm/mach-omap2/Makefile          |    7 +
 arch/arm/mach-omap2/clkt2xxx_apll.c   |   24 +++++
 arch/arm/mach-omap2/clkt2xxx_dpll.c   |   63 +++++++++++++
 arch/arm/mach-omap2/clkt2xxx_osc.c    |   14 +++
 arch/arm/mach-omap2/clkt_iclk.c       |   82 +++++++++++++++++
 arch/arm/mach-omap2/clock.h           |   11 ++
 arch/arm/mach-omap2/clock2420_data.c  |  130 +++++++++++++++++-----------
 arch/arm/mach-omap2/clock2430_data.c  |  130 ++++++++++++++++------------
 arch/arm/mach-omap2/clock34xx.c       |   29 ++++++
 arch/arm/mach-omap2/clock34xx.h       |    5 +
 arch/arm/mach-omap2/clock3517.c       |    4 +
 arch/arm/mach-omap2/clock3xxx.c       |    3 -
 arch/arm/mach-omap2/clock3xxx_data.c  |  155 +++++++++++++++++----------------
 arch/arm/mach-omap2/clock44xx_data.c  |    3 +
 arch/arm/mach-omap2/cm-regbits-24xx.h |    3 +
 arch/arm/mach-omap2/cm2xxx_3xxx.c     |   69 +++++++++++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h     |    8 ++
 arch/arm/mach-omap2/pm24xx.c          |   69 +--------------
 arch/arm/mach-omap2/pm34xx.c          |  105 ----------------------
 19 files changed, 557 insertions(+), 357 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_dpll.c
 create mode 100644 arch/arm/mach-omap2/clkt_iclk.c

