From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap late timer clean-up (and a warning fix) for v3.8 merge window
Date: Mon, 26 Nov 2012 17:06:11 -0800
Message-ID: <20626.7015696087$1353978400@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46860 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757679Ab2K0BGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 20:06:19 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 9dc57643738f9fbe45c10cc062903d5dfda5bdd9:

  Merge branch 'fixes-timer' of github.com:jonhunter/linux into omap-for-v3.8/timer (2012-11-13 13:52:38 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-timer-signed

for you to fetch changes up to 26f01998b0657a61167a819f1c37cb9f9e9d674b:

  ARM: OMAP3: cm-t3517: use GPTIMER for system clock (2012-11-21 10:20:43 -0800)

----------------------------------------------------------------
Timer clean-up to get us closer to moving timer code to drivers,
and to get rid of CONFIG_OMAP_32K_TIMER and rely on the board
or devicetree provided timer configuration.

Note that these changes are on top of the recent timer fixes.

----------------------------------------------------------------
Igor Grinberg (2):
      ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
      ARM: OMAP3: cm-t3517: use GPTIMER for system clock

Jon Hunter (8):
      ARM: OMAP: Clean-up dmtimer reset code
      ARM: OMAP: Define omap_dm_timer_prepare function as static
      ARM: OMAP: Don't store timers physical address
      ARM: OMAP2+: Remove unnecessary local variable in timer code
      ARM: OMAP: Remove unnecessary omap_dm_timer structure declaration
      ARM: OMAP: Add platform data header for DMTIMERs
      ARM: OMAP: Remove unnecessary inclusion of dmtimer.h
      ARM: OMAP2+: Fix compiler warning for 32k timer

Tony Lindgren (1):
      Merge branch 'cleanup-timer' of git://github.com/jonhunter/linux into omap-for-v3.8/timer

 arch/arm/mach-omap1/timer.c                |   1 +
 arch/arm/mach-omap1/timer32k.c             |   1 -
 arch/arm/mach-omap2/board-cm-t3517.c       |   2 +-
 arch/arm/mach-omap2/common.h               |   1 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   1 -
 arch/arm/mach-omap2/pm-debug.c             |   1 -
 arch/arm/mach-omap2/timer.c                | 167 +++++++++++++----------------
 arch/arm/plat-omap/Kconfig                 |   6 ++
 arch/arm/plat-omap/dmtimer.c               |  54 ++++++----
 arch/arm/plat-omap/include/plat/dmtimer.h  |  80 ++++----------
 drivers/staging/tidspbridge/core/ue_deh.c  |   1 -
 include/linux/platform_data/dmtimer-omap.h |  31 ++++++
 13 files changed, 168 insertions(+), 179 deletions(-)
 create mode 100644 include/linux/platform_data/dmtimer-omap.h
