From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/6] OMAP2/3 clock: revise DPLL bypass handling in clock tree
Date: Tue, 16 Sep 2008 06:16:15 -0600
Message-ID: <20080916121521.4666.61245.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58330 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbYIPMRi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:17:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Previously, the OMAP3 clock tree handled DPLL bypass rate
recalculation by dynamically switching clock parents depending on the
DPLL bypass state.  It used the clksel mechanism for this.
Unfortunately, this does not actually work.  The clock code expects
the clock's parent to be the one set in the struct clk, causing kernel
messages similar to:

clock: Could not find fieldval 0 for clock iva2_ck parent dpll2_m2_ck

This patch series moves DPLL bypass rate computation into
omap2_get_dpll_rate(), and removes most of the bypass clocks in the clock tree.
It also converts the bypass tests in the code to use the DPLL IDLEST bits
rather than the DPLL CLKEN bits.

Problem reported by Ramesh Gupta Guntha <x0023949@ti.com>.

Bypass rate recalculation verified with DPLL1 on 3430SDP, which
has bypass support built into its clock code.  Boot-tested on 2430SDP.

---

  text    data     bss     dec     hex filename
3458200  160384  106600 3725184  38d780 vmlinux.3430sdp.orig
3457748  160200  106600 3724548  38d504 vmlinux.3430sdp

 arch/arm/mach-omap2/clock.c             |   45 +++++++-
 arch/arm/mach-omap2/clock24xx.c         |    4 +
 arch/arm/mach-omap2/clock24xx.h         |    2 
 arch/arm/mach-omap2/clock34xx.c         |   60 +++++++---
 arch/arm/mach-omap2/clock34xx.h         |  179 +++----------------------------
 arch/arm/plat-omap/include/mach/clock.h |    4 -
 6 files changed, 105 insertions(+), 189 deletions(-)

