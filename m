From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 0/5] OMAP3: PM: Fixes for low power code
Date: Thu, 10 Mar 2011 12:37:12 +0530
Message-ID: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48972 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab1CJHHZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 02:07:25 -0500
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

V2:
- Rebased series on top of pm-core branch where the Dave Martin's
  Thumb2 patches are merged.
- Dropped set_cr() patch since it's already merged in pm-core branch
- Fixed the hang issue reported by Kevin Hilman with OMAP3630

It's generated against latest pm-core branch and tested suspend
and cpuilde on OMAP3630 ZOOM.

The following changes since commit 7d6d079fbd46aee85e9b5de1d67de15b85e50b04:
  Kevin Hilman (1):
        Merge branch 'for_2.6.39/pm-voltage' into pm-reset

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
pm-core-omap3-asm_v2

Santosh Shilimkar (5):
  OMAP3: PM: Use ARMv7 supported instructions instead of legacy CP15
    ones
  OMAP3: PM: Fix the MMU on sequence in the asm code
  OMAP3: PM: Allow the cache clean when L1 is lost.
  OMAP3: PM: Remove un-necessary cp15 registers form low power cpu
    context
  OMAP3: PM: Clear the SCTLR C bit in asm code to prevent data cache
    allocation

 arch/arm/mach-omap2/sleep34xx.S |  224 +++++++++++++++------------------------
 1 files changed, 85 insertions(+), 139 deletions(-)

