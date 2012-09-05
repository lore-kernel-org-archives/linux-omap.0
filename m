From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 00/10] ARM: OMAP: DMTIMER fixes and clean-up
Date: Wed, 5 Sep 2012 14:04:22 -0500
Message-ID: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:61000 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643Ab2IETEq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 15:04:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

This series includes several fixes for the OMAP DMTIMER driver and a few
clean-ups to simplify some of the code. This series is based upon 3.6-rc4.

Tested on OMAP5912 OSK, OMAP2420 H4, OMAP3430 Beagle and OMAP4430 Panda.
Testing includes ...
1. Booting kernel on above boards
2. Set date and ensuring time of day is correct after 24 hours
3. Checking the timer counter is incrementing when configuring and starting
   a timer
4. Checking the timer overflow interrupt when timer expires.
5. Using different clock sources to operate the timer with.
6. Running a loop test overnight that continually runs test #3 and #4 for
   each available timer

Jon Hunter (10):
  ARM: OMAP3+: Implement timer workaround for errata i103 and i767
  ARM: OMAP: Fix timer posted mode support
  ARM: OMAP3: Correct HWMOD DMTIMER SYSC register declarations
  ARM: OMAP2/3: Define HWMOD software reset status for DMTIMERs
  ARM: OMAP2+: Don't use __omap_dm_timer_reset()
  ARM: OMAP: Fix dmtimer reset for timer1
  ARM: OMAP: Clean-up dmtimer reset code
  ARM: OMAP: Clean-up timer posted mode support
  ARM: OMAP: Add dmtimer interrupt disable function
  ARM: OMAP: Remove unnecessary call to clk_get()

 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   15 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   41 ++++----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    4 +
 arch/arm/mach-omap2/timer.c                        |   27 +++--
 arch/arm/plat-omap/dmtimer.c                       |  109 +++++++++++++-------
 arch/arm/plat-omap/include/plat/dmtimer.h          |   95 ++++++++++-------
 6 files changed, 184 insertions(+), 107 deletions(-)

-- 
1.7.9.5

