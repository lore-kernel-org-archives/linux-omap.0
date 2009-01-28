From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH F 00/12] OMAP clock, F of F: more clock cleanup
Date: Wed, 28 Jan 2009 12:34:56 -0700
Message-ID: <20090128193326.2396.9437.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47770 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419AbZA1UcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:32:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org

This series is the sixth of six to bring the mainline kernel OMAP
clock code up-to-date with the linux-omap tree.  This series fixes
several bugs and cleans up some of the clock code.

Some patches have been "compressed" together, as requested by rmk.
Original commit IDs are in the patch descriptions.

Compile-tested on OSK5912 (OMAP1), H4 and 2430SDP (OMAP2), and
BeagleBoard (OMAP3).  Boot-tested on 2430SDP and BeagleBoard.

Applies on top of series E, posted earlier.


- Paul

---

Paul Walmsley (12):
      OMAP2/3 McBSP: add temporary clockdomain fix for McBSP virtual clocks
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


 arch/arm/mach-omap2/clock.c             |  102 +++++++++++++++++++------------
 arch/arm/mach-omap2/clock.h             |    1 
 arch/arm/mach-omap2/clock24xx.c         |   15 +----
 arch/arm/mach-omap2/clock34xx.c         |    7 +-
 arch/arm/mach-omap2/clockdomains.h      |    2 -
 arch/arm/mach-omap2/mcbsp.c             |    5 ++
 arch/arm/plat-omap/clock.c              |   27 +++-----
 arch/arm/plat-omap/include/mach/clock.h |    2 -
 8 files changed, 85 insertions(+), 76 deletions(-)

   text    data     bss     dec     hex filename
3241435  165504  100880 3507819  35866b vmlinux.beagle.orig
3241418  165504  100880 3507802  35865a vmlinux.beagle

