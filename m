From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] More OMAP clock/hwmod fixes for 2.6.33-rc
Date: Tue, 19 Jan 2010 17:33:55 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001191732330.3977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42652 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0ATAd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 19:33:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Tony,

The following changes since commit 7284ce6c9f6153d1777df5f310c959724d1bd446:
  Linus Torvalds (1):
        Linux 2.6.33-rc4

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 for_2.6.33rc_d

Paul Walmsley (1):
      OMAP1 clock: fix for "BUG: spinlock lockup on CPU#0"

Rajendra Nayak (3):
      OMAP4: PRCM: Fix the base address for CHIRONSS reg defines
      OMAP4: clocks: Fix the clksel_rate struct DPLL divs
      OMAP4: PRCM: Define shift macros as n instead of 1 << n

Russell King - ARM Linux (1):
      OMAP3: clock: Remove unnecessarily .init initializers from OMAP3 clocks

Thara Gopinath (1):
      OMAP3: hwmod: Adding flag to prevent caching of sysconfig register.

 arch/arm/mach-omap1/clock.c                  |    6 +-
 arch/arm/mach-omap2/clock34xx_data.c         |    4 -
 arch/arm/mach-omap2/clock44xx_data.c         |   62 +-
 arch/arm/mach-omap2/cm-regbits-44xx.h        |  536 +++++++-------
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +-
 arch/arm/mach-omap2/prm-regbits-44xx.h       | 1010 +++++++++++++-------------
 arch/arm/mach-omap2/prm.h                    |    2 +
 arch/arm/mach-omap2/prm44xx.h                |   32 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 9 files changed, 828 insertions(+), 828 deletions(-)


- Paul
