From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/5] ARM: OMAP: Fix OMAP1 dmtimer support
Date: Tue, 22 May 2012 15:17:09 -0500
Message-ID: <1337717829-20535-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60116 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932318Ab2EVURP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 16:17:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tarun Kanti <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

OMAP1 dmtimer support is currently broken. When a dmtimer is requested by the
omap_dm_timer_request() function fails to allocate a dmtimer because the call
to clk_get() inside omap_dm_timer_prepare fails. The clk_get() fails simply
because the clock data for the OMAP1 dmtimers is not present.

Although we can simply fix the OMAP1 dmtimers by adding the clock data for the
dmtimers, this is simply the tip of the iceberg. The OMAP1 devices do not
currently support clk_set_parent to dynamically change the clock source. So if
we just add the clock data for the dmtimers, when the dmtimer clock source is
changed by the existing omap1_dm_timer_set_src() function, the clock framework
will not be updated to reflect the current parent clock.

This patch set addresses these issues by ...
1. Making the code to set a parent clock common between OMAP1 and OMAP2+
2. Adds the OMAP1 dmtimer clock data
3. Removes architecture specific code to set the dmtimer clock source and adds
   a common function that uses the clock framework

This series has been tested on an OMAP5912 OSK, OMAP2430 SDP, OMAP3430 Beagle
and OMAP4460 Panda.

Jon Hunter (5):
  ARM: OMAP: Move clkt_clksel.c to plat-omap directory
  ARM: OMAP2+: Remove omap2_clk_set_parent function
  ARM: OMAP2+: Simplify dmtimer clock aliases
  ARM: OMAP1: Add dmtimer clock data
  ARM: OMAP: For all OMAP devices use clock framework to set dmtimer
    clock source

 arch/arm/mach-omap1/clock.h               |    3 -
 arch/arm/mach-omap1/clock_data.c          |  142 +++++++-
 arch/arm/mach-omap1/timer.c               |   15 +-
 arch/arm/mach-omap2/Makefile              |    2 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c    |    2 +-
 arch/arm/mach-omap2/clkt_clksel.c         |  510 -----------------------------
 arch/arm/mach-omap2/clock.c               |   15 +-
 arch/arm/mach-omap2/clock.h               |   11 -
 arch/arm/mach-omap2/clock2420_data.c      |  177 ++++------
 arch/arm/mach-omap2/clock2430_data.c      |  175 ++++------
 arch/arm/mach-omap2/clock3xxx_data.c      |  252 +++++++-------
 arch/arm/mach-omap2/clock44xx_data.c      |  498 ++++++++++++++--------------
 arch/arm/mach-omap2/timer.c               |   61 ----
 arch/arm/plat-omap/Makefile               |    2 +-
 arch/arm/plat-omap/clkt_clksel.c          |  508 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/clock.c                |    1 +
 arch/arm/plat-omap/dmtimer.c              |   43 ++-
 arch/arm/plat-omap/include/plat/clock.h   |   16 +-
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 19 files changed, 1211 insertions(+), 1223 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clkt_clksel.c
 create mode 100644 arch/arm/plat-omap/clkt_clksel.c

-- 
1.7.9.5

