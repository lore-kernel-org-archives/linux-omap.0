From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 00/13] ARM: OMAP: DMTIMER fixes
Date: Mon, 12 Nov 2012 12:20:31 -0600
Message-ID: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56615 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab2KLSUw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 13:20:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

This series includes several fixes for the OMAP DMTIMER driver. This is
based upon Tony Lindgren's current master branch [1].

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

V3 changes:
- Combined patches #2 and #3 in version 2 series into single patch.
- Updated errata i103/i767 workaround to pass errata information via
  platform data to avoid using cpu_is_xxxx() macros in dmtimer driver.

[1] http://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git

Jon Hunter (13):
  ARM: OMAP: Add DMTIMER definitions for posted mode
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

 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   15 +++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   41 +++++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    4 +
 arch/arm/mach-omap2/timer.c                        |   70 +++++++++++++-----
 arch/arm/plat-omap/dmtimer.c                       |   77 ++++++++++++--------
 arch/arm/plat-omap/include/plat/dmtimer.h          |   72 +++++++++++++-----
 6 files changed, 188 insertions(+), 91 deletions(-)

-- 
1.7.9.5

