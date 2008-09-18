From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 0/7] OMAP2/3 clock: revise DPLL bypass handling in clock
	tree
Date: Thu, 18 Sep 2008 10:29:53 -0600
Message-ID: <20080918162835.9452.71873.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58229 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbYIRQ4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 12:56:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This second version fixes bypass handling for DPLL1 and DPLL2 to
use the high-frequency bypass clocks.  This came to light
courtesy of Kevin Hilman <khilman@deeprootsystems.com>.

---

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

- Paul

---

   text    data     bss     dec     hex filename
3443780  158320  105504 3707604  3892d4 vmlinux.3430sdp.orig
3443344  158160  105504 3707008  389080 vmlinux.3430sdp

 arch/arm/mach-omap2/clock.c             |   45 ++++++-
 arch/arm/mach-omap2/clock24xx.c         |    4 -
 arch/arm/mach-omap2/clock24xx.h         |    2 
 arch/arm/mach-omap2/clock34xx.c         |   70 ++++++++----
 arch/arm/mach-omap2/clock34xx.h         |  188 +++++--------------------------
 arch/arm/plat-omap/include/mach/clock.h |    5 -
 6 files changed, 125 insertions(+), 189 deletions(-)

