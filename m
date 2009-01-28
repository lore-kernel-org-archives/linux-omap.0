From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH E 00/14] OMAP clock, E of F: SDRAM fixes, clock optimization
Date: Wed, 28 Jan 2009 12:27:25 -0700
Message-ID: <20090128192551.29333.82943.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32859 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbZA1U3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:29:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org

This series is the fifth of six to bring the mainline kernel OMAP
clock code up-to-date with the linux-omap tree.  This series updates
the SDRAM controller timing code, which is dependent on the clock framework;
and optimizes the clock code.

Some patches have been "compressed" together, as requested by rmk.
Original commit IDs are in the patch descriptions.

Compile-tested on OSK5912 (OMAP1), H4 and 2430SDP (OMAP2), and
BeagleBoard (OMAP3).  Boot-tested on 2430SDP and BeagleBoard.

Applies on top of series D, posted earlier.


- Paul

---

Paul Walmsley (11):
      OMAP clock: unnecessary clock flag removal fiesta
      OMAP clock: track child clocks
      OMAP clock: support "dry run" rate and parent changes
      OMAP2/3 clock: drop recalc function pointers from fixed rate clocks
      OMAP clock: move rate recalc, propagation code up to plat-omap/clock.c
      OMAP2/3 clock: use standard set_rate fn in omap2_clk_arch_init()
      OMAP3 clock: add omap3_core_dpll_m2_set_rate()
      OMAP2 SDRC: add SDRAM timing parameter infrastructure
      OMAP2 SDRC: separate common OMAP2/3 code from OMAP2xxx code
      OMAP2 SDRC: rename memory.c to sdrc2xxx.c
      OMAP2 SDRC: move mach-omap2/memory.h into include/asm-arm/arch-omap/sdrc.h

Russell King (2):
      OMAP clock: rearrange clock.h structure order
      OMAP2/3 clock: remove clk->owner

Tero Kristo (1):
      PM: OMAP3: Make sure clk_disable_unused() order is correct


 arch/arm/mach-omap1/clock.c              |   87 +++++++----
 arch/arm/mach-omap1/clock.h              |   60 ++++----
 arch/arm/mach-omap2/Makefile             |    6 +
 arch/arm/mach-omap2/board-2430sdp.c      |    2 
 arch/arm/mach-omap2/board-apollon.c      |    2 
 arch/arm/mach-omap2/board-generic.c      |    2 
 arch/arm/mach-omap2/board-h4.c           |    2 
 arch/arm/mach-omap2/board-ldp.c          |    2 
 arch/arm/mach-omap2/board-omap3beagle.c  |    2 
 arch/arm/mach-omap2/clock.c              |   73 ++++-----
 arch/arm/mach-omap2/clock.h              |    8 +
 arch/arm/mach-omap2/clock24xx.c          |  138 +++++++++++------
 arch/arm/mach-omap2/clock24xx.h          |   89 ++++-------
 arch/arm/mach-omap2/clock34xx.c          |  106 +++++++++++--
 arch/arm/mach-omap2/clock34xx.h          |  237 +++++++++++-------------------
 arch/arm/mach-omap2/io.c                 |    8 +
 arch/arm/mach-omap2/memory.c             |  194 -------------------------
 arch/arm/mach-omap2/memory.h             |   43 -----
 arch/arm/mach-omap2/sdrc.c               |   93 ++++++++++++
 arch/arm/mach-omap2/sdrc2xxx.c           |  166 +++++++++++++++++++++
 arch/arm/plat-omap/clock.c               |  229 +++++++++++++++++++++++++----
 arch/arm/plat-omap/common.c              |    2 
 arch/arm/plat-omap/include/mach/clock.h  |   76 ++++++----
 arch/arm/plat-omap/include/mach/common.h |    2 
 arch/arm/plat-omap/include/mach/gpmc.h   |    2 
 arch/arm/plat-omap/include/mach/io.h     |    4 -
 arch/arm/plat-omap/include/mach/sdrc.h   |   64 +++++++-
 27 files changed, 1014 insertions(+), 685 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/memory.c
 delete mode 100644 arch/arm/mach-omap2/memory.h
 create mode 100644 arch/arm/mach-omap2/sdrc.c
 create mode 100644 arch/arm/mach-omap2/sdrc2xxx.c

   text    data     bss     dec     hex filename
3241643  164672  100912 3507227  35841b vmlinux.beagle.old
3241435  165504  100880 3507819  35866b vmlinux.beagle

