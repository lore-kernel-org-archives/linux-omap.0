From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH D 00/11] OMAP clock, D of F: clock code cleanup
Date: Wed, 28 Jan 2009 12:18:07 -0700
Message-ID: <20090128191638.16688.33452.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60899 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZA1U1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:27:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org

This series is the fourth of six to bring the mainline kernel OMAP
clock code up-to-date with the linux-omap tree.  This series cleans up
the omap2_clk_wait_ready() function, gets rid of the OMAP2 PRCM
register rewrite code, and does some cleanup on OMAP1 clock code.

Some patches have been "compressed" together, as requested by rmk.
Original commit IDs are in the patch descriptions.

Compile-tested on OSK5912 (OMAP1), H4 and 2430SDP (OMAP2), and
BeagleBoard (OMAP3).  Boot-tested on 2430SDP and BeagleBoard.

Applies on top of series C, posted earlier.


- Paul

---

Mans Rullgard (1):
      OMAP: Add clk_get_parent() for OMAP2/3

Paul Walmsley (9):
      OMAP2/3 clock: clean up omap2_clk_wait_ready()
      OMAP2/3 clock: encode target IDLEST bits
      OMAP2/3 clock: use clk->prcm_mod for all struct clk register addressing
      OMAP2/3 clock: add _omap2_clk_{read,write}_reg()
      OMAP3 clock: add "prcm_mod" field to OMAP3xxx clocks
      OMAP2 clock: add clk.prcm_mod field; annotate OMAP2xxx clocks
      OMAP3 clock: split mcbspX_src_fck from mcbspX_fck
      OMAP2 PRCM: clean up CM_IDLEST bits
      OMAP2/3 clock: clean up mach-omap2/clock.c

Tony Lindgren (1):
      Fix omap1 clock issues


 arch/arm/mach-omap1/clock.c             |   77 +-
 arch/arm/mach-omap1/clock.h             |   76 +-
 arch/arm/mach-omap2/clock.c             |  262 ++++---
 arch/arm/mach-omap2/clock.h             |    4 
 arch/arm/mach-omap2/clock24xx.c         |   59 --
 arch/arm/mach-omap2/clock24xx.h         |  646 ++++++++++++------
 arch/arm/mach-omap2/clock34xx.c         |   28 -
 arch/arm/mach-omap2/clock34xx.h         | 1104 +++++++++++++++++++++----------
 arch/arm/mach-omap2/cm-regbits-24xx.h   |   81 ++
 arch/arm/mach-omap2/cm-regbits-34xx.h   |   96 ++-
 arch/arm/mach-omap2/cm.h                |    3 
 arch/arm/mach-omap2/prcm-common.h       |  198 ++++--
 arch/arm/plat-omap/common.c             |    1 
 arch/arm/plat-omap/include/mach/clock.h |   31 +
 14 files changed, 1659 insertions(+), 1007 deletions(-)

   text    data     bss     dec     hex filename
3241515  163680  100912 3506107  357fbb vmlinux.beagle.orig
3241643  164672  100912 3507227  35841b vmlinux.beagle

