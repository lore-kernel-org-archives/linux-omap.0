From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.6-rc4
Date: Thu, 6 Sep 2012 20:57:40 -0700
Message-ID: <20120907035740.GR1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63794 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab2IGD5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 23:57:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.6-rc4

for you to fetch changes up to 6ab019b62e0505289b26bd00d997dc7686192fa4:

  Merge tag 'omap-fixes-a-for-3.6rc' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into fixes (2012-09-05 10:09:31 -0700)

----------------------------------------------------------------

Fixes for timer, sram, memory corruption, and one board
file that affect booting on various omaps. Then some PM
related fixes for reset, sleep and wakeup.

----------------------------------------------------------------
Aaro Koskinen (2):
      ARM: OMAP: sram: fix OMAP4 errata handling
      ARM: OMAP: sram: skip the first 16K on OMAP3 HS

Igor Grinberg (1):
      ARM: OMAP: timer: obey the !CONFIG_OMAP_32K_TIMER

Misael Lopez Cruz (1):
      ARM: OMAP: hwmod code: Disable module when hwmod enable fails

Paul Walmsley (2):
      ARM: OMAP3xxx: clockdomain: fix software supervised wakeup/sleep
      Merge branches 'clkdev_fixes_3.6rc', 'clkdm_fixes_3.6rc' and 'hwmod_data_fixes_a_3.6rc' into omap_fixes_a_3.6rc

Radek Pilar (1):
      ARM: OMAP: Config fix for omap3-touchbook board

Tero Kristo (2):
      ARM: OMAP3: hwmod data: fix iva2 reset info
      ARM: OMAP4: hwmod data: temporarily comment out data for the sl2if IP block

Tony Lindgren (3):
      ARM: OMAP4: Fix array size for irq_target_cpu
      Merge branch 'fixes-wakeupgen' into fixes
      Merge tag 'omap-fixes-a-for-3.6rc' of git://git.kernel.org/.../pjw/omap-pending into fixes

Vaibhav Hiremath (1):
      ARM: OMAP2+: am33xx: Fix the timer fck clock naming convention

 arch/arm/mach-omap2/Kconfig                |    3 +-
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/clock33xx_data.c       |   14 ++++----
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   50 ++++++++++++++++++++++++++--
 arch/arm/mach-omap2/cm-regbits-34xx.h      |    1 +
 arch/arm/mach-omap2/omap-wakeupgen.c       |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c           |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   15 +++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   12 +++----
 arch/arm/mach-omap2/timer.c                |    7 ++++
 arch/arm/plat-omap/sram.c                  |   11 ++++--
 11 files changed, 94 insertions(+), 24 deletions(-)
