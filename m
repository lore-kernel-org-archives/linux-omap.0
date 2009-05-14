From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] More omap header clean-up for the merge window after
	2.6.30
Date: Thu, 14 May 2009 16:21:42 -0700
Message-ID: <20090514231820.19331.65419.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61616 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbZENXVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 19:21:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

This series removes defines that are included from hardware.h via
various processor specific headers. The series makes the defines
processor specific where possible so they don't trigger recompile
and cause blocks for multi-omap booting.

After this series, pretty much the only remaining problem code
is the clock24xx.h that should have clock registers set dynamically
for 2420 and 2430. This series just makes the problem defines
local to clock24xx.h.

Regards,

Tony

---

Tony Lindgren (5):
      ARM: OMAP2/3: Remove OMAP_CM_REGADDR
      ARM: OMAP2/3: Remove OMAP2_PRCM_BASE
      ARM: OMAP2/3: Move define of OMAP2_VA_IC_BASE to be local to entry-macro.S
      ARM: OMAP2/3: Remove OMAP_PRM_REGADDR and OMAP2_PRM_BASE
      ARM: OMAP2/3: Remove OMAP2_32KSYNCT_BASE


 arch/arm/mach-omap2/clock.c                   |    4 
 arch/arm/mach-omap2/clock24xx.c               |   21 +--
 arch/arm/mach-omap2/clock24xx.h               |   11 +
 arch/arm/mach-omap2/clock34xx.h               |    2 
 arch/arm/mach-omap2/cm.h                      |    6 -
 arch/arm/mach-omap2/prm.h                     |  205 +++++++++++++++----------
 arch/arm/mach-omap2/sdrc2xxx.c                |    5 -
 arch/arm/mach-omap2/sram242x.S                |   10 +
 arch/arm/mach-omap2/sram243x.S                |   10 +
 arch/arm/plat-omap/common.c                   |   69 +++++++-
 arch/arm/plat-omap/include/mach/entry-macro.S |    9 +
 arch/arm/plat-omap/include/mach/omap24xx.h    |   18 --
 arch/arm/plat-omap/include/mach/omap34xx.h    |    9 -
 13 files changed, 232 insertions(+), 147 deletions(-)

-- 
Signature
