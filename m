From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 00/23] OMAP clock: bug fixes, cleanup, optimization
Date: Sun, 04 Jan 2009 19:34:44 -0700
Message-ID: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42858 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbZAEDWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:22:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

This is version 2 of the clock updates series sent earlier.  Changes
in v2:

1. Missing structure documentation for struct clk_child added

2. .clk_register function pointer added to struct clk_functions;
   OMAP2/3 clock code now does clock->clockdomain association there


Revised summary below.  Happy new year, everyone.

- Paul

------------------

Hello,

this 23-patch series updates the OMAP1/2/3 clock code.  Highlights:

- Rate recalculation functions are now no longer responsible for
  rate propagation - now handled by plat-omap/clock.c (patches 2, 3,
  4)

- Parent-to-child traversals of the clock tree are now much faster -
  these occur during rate propagation and clock notifiers (patch 5)

- Many superfluous clock flags have been dropped (patches 6, 7, 8, 9)

- struct clk has been streamlined by removing unused members and
  rearranging the structure to reduce padding (patches 10, 11)

- MPU barriers have been either removed or converted to OCP barriers
  (patches 12, 13, 14)

- clk_get_usecount() has been dropped (patch 15)

- OMAP clock code can now specify an OMAP chip family-specific 
  clk_enable() function - used on OMAP2/3 (patch 16)

- omap2_clk_enable() has been overhauled: two bugs were fixed and
  the function body itself is now understandable (patches 17, 18, 19,
  20, 21)

- Unnecessary custom clocks in smartreflex.c have been removed
  (patch 23)

- Miscellaneous bug fixes (patches 1, 22)


Compile-tested on OMAP1.  Boot-tested on N800 and 3430SDP GP ES2.1.

---

size:
   text    data     bss     dec     hex filename
3596322  192368  109912 3898602  3b7cea vmlinux.3430sdp.orig
3595941  193016  109912 3898869  3b7df5 vmlinux.3430sdp.patched

3167222  152232   86176 3405630  33f73e vmlinux.n800.orig
3167501  152792   86176 3406469  33fa85 vmlinux.n800.patched

2682806  120120   96940 2899866  2c3f9a vmlinux.osk5912.orig
2683397  120528   96940 2900865  2c4381 vmlinux.osk5912.patched

diffstat:
 arch/arm/mach-omap1/clock.c             |   87 +++++++----
 arch/arm/mach-omap1/clock.h             |   64 ++++----
 arch/arm/mach-omap2/clock.c             |  167 +++++++++++---------
 arch/arm/mach-omap2/clock.h             |    9 +
 arch/arm/mach-omap2/clock24xx.c         |  128 ++++++++++------
 arch/arm/mach-omap2/clock24xx.h         |   89 ++++-------
 arch/arm/mach-omap2/clock34xx.c         |   52 +++---
 arch/arm/mach-omap2/clock34xx.h         |  228 ++++++++++------------------
 arch/arm/mach-omap2/pm-debug.c          |    2 
 arch/arm/mach-omap2/pm24xx.c            |    2 
 arch/arm/mach-omap2/smartreflex.c       |   89 ++---------
 arch/arm/plat-omap/clock.c              |  256 +++++++++++++++++++++++++------
 arch/arm/plat-omap/include/mach/clock.h |   78 ++++++---
 13 files changed, 693 insertions(+), 558 deletions(-)

manifest:
Paul Walmsley (20):
      OMAP3 SmartReflex: get rid of custom clocks
      OMAP2/3 clock: don't tinker with hardirqs when they are supposed to be disabled
      OMAP2/3 clock: omap2_clk_enable(): fix logic
      OMAP2/3 clock: omap2_clk_enable(): fix usecount decrement bug
      OMAP2/3 clock: omap2_clk_enable(): fix bugs in clockdomain handling
      OMAP2/3 clock: omap2_clk_enable(): refactor usecount check
      OMAP2/3 clock: every clock must have a clkdm
      OMAP clock: add OMAP chip family-specific clk_register() option
      OMAP clock: drop clk_get_usecount()
      OMAP2/3 clock: convert remaining MPU barriers into OCP barriers
      OMAP2xxx clock: consolidate DELAYED_APP clock commits; fix barrier
      OMAP2/3 clock: don't use a barrier after clk_disable()
      OMAP2 clock: drop CONFIG_PARTICIPANT clock flag
      OMAP clock: drop RATE_FIXED
      OMAP clock: drop the RATE_PROPAGATES flag
      OMAP clock: track child clocks
      OMAP clock: support "dry run" rate and parent changes
      OMAP2/3 clock: drop recalc function pointers from fixed rate clocks
      OMAP clock: move rate recalc, propagation code up to plat-omap/clock.c
      OMAP2/3 clock: use standard set_rate fn in omap2_clk_arch_init()

Russell King (3):
      OMAP clock: rearrange clock.h structure order
      OMAP2/3 clock: remove clk->owner
      OMAP clock: remove VIRTUAL_CLOCK


