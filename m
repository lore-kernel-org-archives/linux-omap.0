From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 00/11] OMAP2/3 clock: encode prcm_mod for each struct clk
Date: Thu, 18 Sep 2008 11:46:49 -0600
Message-ID: <20080918174432.7146.21366.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55094 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbYIRRsH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:48:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This second revision splits up the final patch into several pieces
and fixes a bug previously introduced in the clksel code.

---

Add a new field, prcm_mod, to the OMAP2/3 struct clk.  Major effects
of this change include:

- the removal of the register rewriting code for OMAP2xxx clock framework,

- the resolution of gcc and sparse warnings for the clock code,

- the removal of many __force void __iomem * casts in the clock tree,

- and the reduction of the register address field size in struct clk by two
  bytes per clk.


This series applies on top of the second version of the 
"OMAP2/3 clock: revise DPLL bypass handling in clock tree"
series.  This series is a prerequisite for the IDLEST handling
revision patches, following shortly.

Boot-tested on 3430SDP and N800.

---

size:
   text    data     bss     dec     hex filename
3443344  158160  105504 3707008  389080 vmlinux.3430sdp.orig
3443440  157712  105504 3706656  388f20 vmlinux.3430sdp


 arch/arm/mach-omap2/clock.c             |  229 +++++------
 arch/arm/mach-omap2/clock.h             |    3 
 arch/arm/mach-omap2/clock24xx.c         |   58 ---
 arch/arm/mach-omap2/clock24xx.h         |  454 +++++++++++++--------
 arch/arm/mach-omap2/clock34xx.c         |   27 +
 arch/arm/mach-omap2/clock34xx.h         |  671 ++++++++++++++++++++-----------
 arch/arm/mach-omap2/cm.h                |    3 
 arch/arm/plat-omap/common.c             |    1 
 arch/arm/plat-omap/include/mach/clock.h |   25 +
 9 files changed, 875 insertions(+), 596 deletions(-)

