From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] More header clean-up
Date: Thu, 07 May 2009 13:42:23 -0700
Message-ID: <20090507203552.7461.35051.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61107 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760689AbZEGUmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:42:25 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=[127.0.0.1])
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1M2AQD-0007GX-H1
	for linux-omap@vger.kernel.org; Thu, 07 May 2009 20:42:25 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

This series cleans up the conflicting defines a bit more.
Now the biggest problem is till in clock24xx.h, but at least the
conflict is local. Now changing the processors should not cause
everything to be rebuilt..

The first patch also fixes the CONFIG_SPINLOCK_DEBUG problem where
sched_clock was called before we have things initialized.

This series causes some updates to the other pending patch series,
like the PM series. But it would be nice to get in before we add
more code.

Kevin, the 2/5 is improved version of what I sent you earlier,
the earlier version had issues between 2420 vs 2430. Let me
know if the other patches cause big headaches for your PM
series.

Regards,

Tony

---

Tony Lindgren (5):
      ARM: OMAP2/3: Remove OMAP_CM_REGADDR
      ARM: OMAP2/3: Remove OMAP2_PRCM_BASE
      ARM: OMAP2/3: Move define of OMAP2_VA_IC_BASE to be local to entry-macro.S
      ARM: OMAP2/3: Remove OMAP_PRM_REGADDR and OMAP2_PRM_BASE
      ARM: OMAP2/3: Remove OMAP2_32KSYNCT_BASE


 arch/arm/mach-omap2/clock24xx.c               |   21 ++--
 arch/arm/mach-omap2/clock24xx.h               |   11 ++
 arch/arm/mach-omap2/clock34xx.h               |    2 
 arch/arm/mach-omap2/cm.h                      |    5 -
 arch/arm/mach-omap2/prm.h                     |  136 +++++++++++++------------
 arch/arm/mach-omap2/sdrc2xxx.c                |    5 +
 arch/arm/mach-omap2/sram242x.S                |    4 -
 arch/arm/mach-omap2/sram243x.S                |    4 -
 arch/arm/plat-omap/common.c                   |   69 +++++++++++--
 arch/arm/plat-omap/include/mach/entry-macro.S |    9 +-
 arch/arm/plat-omap/include/mach/omap24xx.h    |   18 ---
 arch/arm/plat-omap/include/mach/omap34xx.h    |    9 --
 12 files changed, 170 insertions(+), 123 deletions(-)

-- 
Signature
