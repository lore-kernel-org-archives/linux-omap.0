From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/10] OMAP PRCM, clock: some cleanup patches for 2.6.35
Date: Mon, 26 Apr 2010 01:04:20 -0600
Message-ID: <20100426070217.9743.92728.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52226 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab0DZHHd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 03:07:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

these patches undertake some cleanup on the OMAP2/3 PRCM macros and the
OMAP clock code.  Nothing too earthshattering in this series -


- Paul

---

size:
   text    data     bss     dec     hex filename
3665327  200160  103840 3969327  3c912f vmlinux.omap3beagle.orig
3663919  200576  103392 3967887  3c8b8f vmlinux.omap3beagle.patched

Felipe Balbi (1):
      OMAP1 clock: fix section mismatch on clk_init

Paul Walmsley (9):
      OMAP2 PRCM: convert OMAP2 PRCM macros to the _SHIFT/_MASK suffixes
      OMAP3 PRCM: convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes
      OMAP2+ PRCM: convert remaining PRCM macros to the _SHIFT/_MASK suffixes
      OMAP3: PM: PM_MPUGRPSEL writes should use GRPSEL macros, not EN macros
      OMAP2+ clock: remove DEFAULT_RATE clksel_rate flag
      OMAP2+ clock: clean up clkt_clksel.c
      OMAP3 clock: rename RATE_IN_343X, RATE_IN_3430ES2 to match reality
      OMAP3 clock: remove unnecessary duplicate of dpll4_m2_ck, added for 36xx
      OMAP clock: resolve old checkpatch and CodingStyle issues with plat-omap/clock.c


 arch/arm/mach-omap1/clock.c             |    2 
 arch/arm/mach-omap1/clock.h             |    2 
 arch/arm/mach-omap2/clkt2xxx_apll.c     |    4 
 arch/arm/mach-omap2/clkt_clksel.c       |  472 +++++++++++++++++++------------
 arch/arm/mach-omap2/clock.c             |    9 +
 arch/arm/mach-omap2/clock.h             |   11 -
 arch/arm/mach-omap2/clock2420_data.c    |   50 ++-
 arch/arm/mach-omap2/clock2430_data.c    |   54 ++--
 arch/arm/mach-omap2/clock3xxx_data.c    |  406 ++++++++++-----------------
 arch/arm/mach-omap2/clock_common_data.c |   12 -
 arch/arm/mach-omap2/clockdomain.c       |    4 
 arch/arm/mach-omap2/cm-regbits-24xx.h   |  236 ++++++++--------
 arch/arm/mach-omap2/cm-regbits-34xx.h   |  222 +++++++--------
 arch/arm/mach-omap2/cm.h                |    5 
 arch/arm/mach-omap2/control.c           |    7 
 arch/arm/mach-omap2/pm24xx.c            |  126 ++++----
 arch/arm/mach-omap2/pm34xx.c            |  202 +++++++------
 arch/arm/mach-omap2/powerdomain.c       |   26 +-
 arch/arm/mach-omap2/prcm-common.h       |  146 +++++-----
 arch/arm/mach-omap2/prcm.c              |    4 
 arch/arm/mach-omap2/prm-regbits-24xx.h  |  120 ++++----
 arch/arm/mach-omap2/prm-regbits-34xx.h  |  360 ++++++++++++------------
 arch/arm/mach-omap2/prm.h               |   18 +
 arch/arm/plat-omap/clock.c              |   28 +-
 arch/arm/plat-omap/include/plat/clock.h |   14 -
 25 files changed, 1288 insertions(+), 1252 deletions(-)


