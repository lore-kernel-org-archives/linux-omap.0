From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/6] omap3: pm: Fixes for low power code
Date: Mon, 21 Feb 2011 18:49:19 +0530
Message-ID: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60850 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962Ab1BUNTe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 08:19:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The series does below fixes to the omap3 low power code.
	1. Use supported ARMv7 instructions instead of the legacy ones
	2. Fix the MMU on sequence
	3. Fix the cache flush scenario when only L1 lost.
	4. Remove all un-necessary context save registers
	5. Disable C-bit before cache clean
	6. Use set_cr() exported API instead of custom one. 

It's generated against mainline and tested with OMAP3630 ZOOM3.
	1. Renetion and off-mode mode in suspend - ok.
	2. Retention in idle - ok

The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:
  Linus Torvalds (1):
        Linux 2.6.38-rc5

Santosh Shilimkar (6):
  omap3: pm: Use amrv7 supported instructions instead of legacy cp15
    ones
  omap3: pm: Fix the mmu on sequence in the asm code
  omap3: pm: Allow the cache clean when L1 is lost.
  omap3: pm: Remove un-necessary cp15 registers form low power cpu
    context
  omap3: pm: Clear the SCTLR C bit in asm code to prevent data cache
    allocation
  omap3: pm: Use exported set_cr() instead of a custom one.

 arch/arm/mach-omap2/pm34xx.c    |    7 +-
 arch/arm/mach-omap2/sleep34xx.S |  223 ++++++++++++++-------------------------
 2 files changed, 78 insertions(+), 152 deletions(-)

