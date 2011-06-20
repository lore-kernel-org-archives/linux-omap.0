From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/10] init_early cleanup for omap init_irq and init_timer
Date: Mon, 20 Jun 2011 02:23:24 -0700
Message-ID: <20110620091754.357.56441.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54424 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751583Ab1FTJX1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 05:23:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here's an updated version of the init_irq and init_timer patches
against v3.0-rc3. This series sets up separate omap[123]_init_irq
functions and omap[1234]_timer sys_timer so we can get rid of
cpu_is_omap calls in the init_irq and init_timer.

This series also changes the dmtimer hardware init so we can
initialize most of the hardware timers later on and further
patch the dmtimer code so it eventually becomes just a regular
device driver.

Regards,

Tony

---

Tony Lindgren (10):
      omap: Use separate init_irq functions to avoid cpu_is_omap tests early
      omap: Set separate timer init functions to avoid cpu_is_omap tests
      omap: Move dmtimer defines to dmtimer.h
      omap: Make a subset of dmtimer functions into inline functions
      omap2+: Use dmtimer macros for clockevent
      omap2+: Remove gptimer_wakeup for now
      omap2+: Reserve clocksource and timesource and initialize dmtimer later
      omap2+: Use dmtimer macros for clocksource
      omap2+: Remove omap2_gp_clockevent_set_gptimer
      omap2+: Rename timer-gp.c into timer.c to combine timer init functions


 arch/arm/mach-omap1/board-ams-delta.c      |    4 
 arch/arm/mach-omap1/board-fsample.c        |    4 
 arch/arm/mach-omap1/board-generic.c        |    4 
 arch/arm/mach-omap1/board-h2.c             |    4 
 arch/arm/mach-omap1/board-h3.c             |    4 
 arch/arm/mach-omap1/board-htcherald.c      |    4 
 arch/arm/mach-omap1/board-innovator.c      |    4 
 arch/arm/mach-omap1/board-nokia770.c       |    4 
 arch/arm/mach-omap1/board-osk.c            |    4 
 arch/arm/mach-omap1/board-palmte.c         |    4 
 arch/arm/mach-omap1/board-palmtt.c         |    4 
 arch/arm/mach-omap1/board-palmz71.c        |    4 
 arch/arm/mach-omap1/board-perseus2.c       |    4 
 arch/arm/mach-omap1/board-sx1.c            |    4 
 arch/arm/mach-omap1/board-voiceblue.c      |    4 
 arch/arm/mach-omap1/irq.c                  |    2 
 arch/arm/mach-omap1/time.c                 |    6 
 arch/arm/mach-omap1/timer32k.c             |    4 
 arch/arm/mach-omap2/Makefile               |    2 
 arch/arm/mach-omap2/board-2430sdp.c        |    4 
 arch/arm/mach-omap2/board-3430sdp.c        |    4 
 arch/arm/mach-omap2/board-3630sdp.c        |    4 
 arch/arm/mach-omap2/board-4430sdp.c        |    6 
 arch/arm/mach-omap2/board-am3517crane.c    |    4 
 arch/arm/mach-omap2/board-am3517evm.c      |    4 
 arch/arm/mach-omap2/board-apollon.c        |    4 
 arch/arm/mach-omap2/board-cm-t35.c         |    4 
 arch/arm/mach-omap2/board-cm-t3517.c       |    4 
 arch/arm/mach-omap2/board-devkit8000.c     |    8 -
 arch/arm/mach-omap2/board-generic.c        |    4 
 arch/arm/mach-omap2/board-h4.c             |    4 
 arch/arm/mach-omap2/board-igep0020.c       |    8 -
 arch/arm/mach-omap2/board-ldp.c            |    4 
 arch/arm/mach-omap2/board-n8x0.c           |   12 -
 arch/arm/mach-omap2/board-omap3beagle.c    |    8 -
 arch/arm/mach-omap2/board-omap3evm.c       |    4 
 arch/arm/mach-omap2/board-omap3logic.c     |    9 -
 arch/arm/mach-omap2/board-omap3pandora.c   |    4 
 arch/arm/mach-omap2/board-omap3stalker.c   |    8 -
 arch/arm/mach-omap2/board-omap3touchbook.c |    8 -
 arch/arm/mach-omap2/board-omap4panda.c     |    3 
 arch/arm/mach-omap2/board-overo.c          |    4 
 arch/arm/mach-omap2/board-rm680.c          |    4 
 arch/arm/mach-omap2/board-rx51.c           |    4 
 arch/arm/mach-omap2/board-ti8168evm.c      |    9 -
 arch/arm/mach-omap2/board-zoom.c           |    8 -
 arch/arm/mach-omap2/io.c                   |   17 -
 arch/arm/mach-omap2/irq.c                  |   32 ++-
 arch/arm/mach-omap2/omap4-common.c         |   10 -
 arch/arm/mach-omap2/pm-debug.c             |   28 --
 arch/arm/mach-omap2/pm.h                   |    6 
 arch/arm/mach-omap2/pm34xx.c               |    4 
 arch/arm/mach-omap2/timer-gp.c             |  266 ----------------------
 arch/arm/mach-omap2/timer-gp.h             |   16 -
 arch/arm/mach-omap2/timer.c                |  342 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/counter_32k.c           |    2 
 arch/arm/plat-omap/dmtimer.c               |  207 ++---------------
 arch/arm/plat-omap/include/plat/common.h   |    6 
 arch/arm/plat-omap/include/plat/dmtimer.h  |  247 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h     |    6 
 60 files changed, 748 insertions(+), 666 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/timer-gp.c
 delete mode 100644 arch/arm/mach-omap2/timer-gp.h
 create mode 100644 arch/arm/mach-omap2/timer.c

-- 
Signature
