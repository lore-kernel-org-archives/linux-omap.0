From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/8] ARM: OMAP: Clean-up DMTIMER
Date: Tue, 13 Nov 2012 12:13:15 -0600
Message-ID: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58291 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab2KMSN3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 13:13:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

This series cleans-up the DMTIMER code and moves the DMTIMER header
from plat/dmtimer.h to plat-omap/dmtimer.h in preparation for single
zImage support.

This series in based upon DMTIMER fixes series [1].

Tested on OMAP5912 OSK, OMAP3430 Beagle and OMAP4430 Panda.
Testing includes ...
1. Booting kernel on above boards
2. Checking the timer counter is incrementing when configuring and starting
   a timer
3. Checking the timer overflow interrupt when timer expires.
4. Using different clock sources to operate the timer with.

This has also been boot tested on the AM335x Beagle Bone.

[1] http://marc.info/?l=linux-omap&m=135275633628412&w=2

Jon Hunter (8):
  ARM: OMAP: Clean-up dmtimer reset code
  ARM: OMAP: Define omap_dm_timer_prepare function as static
  ARM: OMAP: Don't store timers physical address
  ARM: OMAP2+: Remove unnecessary local variable in timer code
  ARM: OMAP: Remove unnecessary omap_dm_timer structure declaration
  ARM: OMAP: Add platform data header for DMTIMERs
  ARM: OMAP: Remove unnecessary inclusion of dmtimer.h
  ARM: OMAP: Move plat/dmtimer.h to plat-omap/dmtimer.h

 arch/arm/mach-omap1/pm.c                           |    2 +-
 arch/arm/mach-omap1/timer.c                        |    3 +-
 arch/arm/mach-omap1/timer32k.c                     |    1 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +-
 arch/arm/mach-omap2/pm-debug.c                     |    1 -
 arch/arm/mach-omap2/timer.c                        |   28 +-
 arch/arm/plat-omap/dmtimer.c                       |   56 ++-
 arch/arm/plat-omap/include/plat-omap/dmtimer.h     |  420 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h          |  450 --------------------
 drivers/staging/tidspbridge/core/dsp-clock.c       |    2 +-
 drivers/staging/tidspbridge/core/ue_deh.c          |    1 -
 include/linux/platform_data/dmtimer-omap.h         |   31 ++
 16 files changed, 506 insertions(+), 497 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat-omap/dmtimer.h
 delete mode 100644 arch/arm/plat-omap/include/plat/dmtimer.h
 create mode 100644 include/linux/platform_data/dmtimer-omap.h

-- 
1.7.9.5

