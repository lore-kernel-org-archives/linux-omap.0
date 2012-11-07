From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 00/14] ARM: OMAP: DMTIMER fixes
Date: Wed, 7 Nov 2012 13:01:16 -0600
Message-ID: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36351 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab2KGTBk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 14:01:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

This series includes several fixes for the OMAP DMTIMER driver. This is
based upon 3.7-rc4 with the two series adding device-tree support for
DMTIMERs [1] and the 32kHz Counter [2]

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

This has also been boot tested on the AM335x Beagle Bone.

[1] http://marc.info/?l=linux-omap&m=135065875808614&w=2
[2] http://marc.info/?l=linux-omap&m=135119308123513&w=2

Jon Hunter (14):
  ARM: OMAP: Add DMTIMER definitions for posted mode
  ARM: OMAP2+: Disable posted mode for the clocksource timer
  ARM: OMAP3+: Implement timer workaround for errata i103 and i767
  ARM: OMAP: Fix timer posted mode support
  ARM: OMAP3: Correct HWMOD DMTIMER SYSC register declarations
  ARM: OMAP2/3: Define HWMOD software reset status for DMTIMERs
  ARM: OMAP2+: Don't use __omap_dm_timer_reset()
  ARM: OMAP: Fix dmtimer reset for timer1
  ARM: OMAP: Don't restore of DMTIMER TISTAT register
  ARM: OMAP: Don't restore DMTIMER interrupt status register
  ARM: OMAP: Fix spurious interrupts when using timer match feature
  ARM: OMAP: Add dmtimer interrupt disable function
  ARM: OMAP: Remove unnecessary call to clk_get()
  ARM: OMAP: Remove __omap_dm_timer_set_source function

 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   15 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   41 +++---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    4 +
 arch/arm/mach-omap2/timer.c                        |   73 ++++++++---
 arch/arm/plat-omap/dmtimer.c                       |  132 +++++++++++++++-----
 arch/arm/plat-omap/include/plat/dmtimer.h          |   47 ++++---
 6 files changed, 215 insertions(+), 97 deletions(-)

-- 
1.7.9.5

