From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] OMAP: clock: miscellaneous fixes and dead code removal
	for 2.6.39
Date: Wed, 16 Feb 2011 21:17:49 -0700
Message-ID: <20110217041437.16009.52336.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55840 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab1BQES3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 23:18:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series contains some OMAP clock patches for 2.6.39.  The patches
in this series fix some long-standing inaccuracies in the OMAP2xxx clock trees,
prepare for some clock framework locking changes, and remove some
DPLL rate rounding code that I don't think anyone is using.

Dynamic idle entry and exit has been tested on an OMAP3530 Beagleboard, and
the "before" and "after" clock trees have been verified on an N800.


- Paul

---

clk_b_2.6.39
   text	   data	    bss	    dec	    hex	filename
3697449	 229488	5390028	9316965	 8e2a65	vmlinux.n800.orig
3697325	 229584	5390028	9316937	 8e2a49	vmlinux.n800.patched

Paul Walmsley (5):
      OMAP2xxx: clock: fix parents for L3-derived clocks
      OMAP2xxx: clock: fix low-frequency oscillator clock rate
      OMAP2xxx: clock: fix interface clocks and clockdomains for modules in the WKUP domain
      OMAP: clock: bail out early if arch_clock functions not implemented
      OMAP2+: clock: remove the DPLL rate tolerance code


 arch/arm/mach-omap2/clkt_dpll.c         |   91 ++++++++-----------------------
 arch/arm/mach-omap2/clock.h             |    4 -
 arch/arm/mach-omap2/clock2420_data.c    |   38 ++++++++-----
 arch/arm/mach-omap2/clock2430_data.c    |   46 +++++++++-------
 arch/arm/mach-omap2/clock3xxx_data.c    |    6 --
 arch/arm/plat-omap/clock.c              |   66 +++++++++++++---------
 arch/arm/plat-omap/include/plat/clock.h |    7 --
 7 files changed, 112 insertions(+), 146 deletions(-)

