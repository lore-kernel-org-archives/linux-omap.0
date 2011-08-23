From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: clock/powerdomain/clockdomain/hwmod: fixes for
 3.1-rc
Date: Mon, 22 Aug 2011 23:35:53 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108222319310.28226@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43225 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1HWFfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Aug 2011 01:35:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, santosh.shilimkar@ti.com, tomi.valkeinen@ti.com

Hi Tony,

The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 prcm-fixes-a-3.1rc

Note that for these changes to boot successfully on 3.1-rc3, the following 
patch is needed:

  http://marc.info/?l=linux-omap&m=131407622527432&w=2

The changes have been boot-tested on N800, OMAP3530 Beagle, and 
OMAP4430ES2 Panda.  They've also passed compile tests with a few different 
configs here.

Paul Walmsley (4):
      OMAP4: clock: re-enable previous clockdomain enable/disable sequence
      OMAP4: clock: fix compile warning
      OMAP3: clock: indicate that gpt12_fck and wdt1_fck are in the WKUP clockdomain
      Merge branches 'pwrdm_clkdm_fixes_3.1rc', 'omap2_3_hwmod_dss_fixes_3.1rc', 'non_hwmod_compliant_fix_3.1rc', 'omap4_clock_fixes_3.1rc' and 'omap3_clock_fixes_3.1rc' into prcm-fixes-a-3.1rc

Rajendra Nayak (1):
      OMAP: powerdomains: Make all powerdomain target states as ON at init

Santosh Shilimkar (1):
      OMAP: clockdomain: Wait for powerdomain to be ON when using clockdomain force wakeup

Tomi Valkeinen (5):
      OMAP2xxx: HWMOD: fix DSS opt clocks
      OMAP3: HWMOD: fix DSS opt clocks
      OMAP4: HWMOD: fix DSS opt clocks
      OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
      OMAP: HWMOD: Unify DSS resets for all OMAPs

 arch/arm/mach-omap2/Makefile                       |    5 +--
 arch/arm/mach-omap2/clock3xxx_data.c               |    2 +
 arch/arm/mach-omap2/clock44xx_data.c               |   10 +++++-
 arch/arm/mach-omap2/clockdomain.c                  |    2 +
 arch/arm/mach-omap2/display.c                      |   35 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   15 +++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   15 +++++++-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   35 +++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   19 ++++-------
 arch/arm/mach-omap2/pm.c                           |    2 -
 arch/arm/mach-omap2/powerdomain.c                  |   25 +++++++++-----
 arch/arm/plat-omap/include/plat/common.h           |    3 ++
 include/video/omapdss.h                            |    7 ----
 14 files changed, 136 insertions(+), 44 deletions(-)
