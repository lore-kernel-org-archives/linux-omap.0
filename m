From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap clean-up for v3.1 merge window
Date: Thu, 30 Jun 2011 02:10:20 -0700
Message-ID: <20110630091019.GJ23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12292 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751431Ab1F3JKZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 05:10:25 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

Hi Arnd & Nico,

Please pull omap clean-up patches from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-cleanup

This branch contains little bit more of omap code shrinkage
for regulators and PM debug.

It also contains cleanup of irq and timer init code, and some
fixes.

I have not added this into linux next assuming that you will
do it. If not, please let me know and I will add it.

Regards,

Tony


The following changes since commit b0af8dfdd67699e25083478c63eedef2e72ebd85:
  Linus Torvalds (1):
        Linux 3.0-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-cleanup

Grazvydas Ignotas (1):
      omap: cleanup NAND platform data

Jarkko Nikula (2):
      omap: mcbsp: Drop SPI mode support
      omap: mcbsp: Drop in-driver transfer support

Kevin Hilman (3):
      OMAP3: PM debug: remove sleep_while_idle feature
      OMAP2: PM debug: remove register dumping
      OMAP3: PM debug: remove register dumping

Nishanth Menon (4):
      OMAP3+: SR: make notify independent of class
      OMAP3+: SR: disable interrupt by default
      OMAP3+: SR: enable/disable SR only on need
      OMAP3+: SR: fix cosmetic indentation

Oleg Drokin (2):
      cleanup regulator supply definitions in mach-omap2
      Remove old-style supply.dev assignments common in hsmmc init

Peter Ujfalusi (1):
      omap: board-omap3evm: Fix compilation error

Sanjeev Premi (1):
      OMAP2+: PM: fix section mismatch in pm_dbg_init()

Tony Lindgren (12):
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
      Merge branch 'devel-timer' into devel-cleanup
      Merge branch 'for_3.1/pm-misc' of git://git.kernel.org/.../khilman/linux-omap-pm into devel-cleanup

 arch/arm/mach-omap1/board-ams-delta.c        |    4 +-
 arch/arm/mach-omap1/board-fsample.c          |    4 +-
 arch/arm/mach-omap1/board-generic.c          |    4 +-
 arch/arm/mach-omap1/board-h2.c               |    4 +-
 arch/arm/mach-omap1/board-h3.c               |    4 +-
 arch/arm/mach-omap1/board-htcherald.c        |    4 +-
 arch/arm/mach-omap1/board-innovator.c        |    4 +-
 arch/arm/mach-omap1/board-nokia770.c         |    4 +-
 arch/arm/mach-omap1/board-osk.c              |    4 +-
 arch/arm/mach-omap1/board-palmte.c           |    4 +-
 arch/arm/mach-omap1/board-palmtt.c           |    4 +-
 arch/arm/mach-omap1/board-palmz71.c          |    4 +-
 arch/arm/mach-omap1/board-perseus2.c         |    4 +-
 arch/arm/mach-omap1/board-sx1.c              |    4 +-
 arch/arm/mach-omap1/board-voiceblue.c        |    4 +-
 arch/arm/mach-omap1/irq.c                    |    2 +-
 arch/arm/mach-omap1/time.c                   |    6 +-
 arch/arm/mach-omap1/timer32k.c               |    4 -
 arch/arm/mach-omap2/Makefile                 |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c          |    4 +-
 arch/arm/mach-omap2/board-3430sdp.c          |    4 +-
 arch/arm/mach-omap2/board-3630sdp.c          |    4 +-
 arch/arm/mach-omap2/board-4430sdp.c          |   19 +-
 arch/arm/mach-omap2/board-am3517crane.c      |    4 +-
 arch/arm/mach-omap2/board-am3517evm.c        |    4 +-
 arch/arm/mach-omap2/board-apollon.c          |    4 +-
 arch/arm/mach-omap2/board-cm-t35.c           |   44 +-
 arch/arm/mach-omap2/board-cm-t3517.c         |    5 +-
 arch/arm/mach-omap2/board-devkit8000.c       |   36 +-
 arch/arm/mach-omap2/board-flash.c            |    4 -
 arch/arm/mach-omap2/board-generic.c          |    4 +-
 arch/arm/mach-omap2/board-h4.c               |    4 +-
 arch/arm/mach-omap2/board-igep0020.c         |   35 +-
 arch/arm/mach-omap2/board-ldp.c              |   14 +-
 arch/arm/mach-omap2/board-n8x0.c             |   12 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |   37 +-
 arch/arm/mach-omap2/board-omap3evm.c         |   51 ++--
 arch/arm/mach-omap2/board-omap3logic.c       |   19 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |   67 ++--
 arch/arm/mach-omap2/board-omap3stalker.c     |   37 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |   44 +-
 arch/arm/mach-omap2/board-omap4panda.c       |   19 +-
 arch/arm/mach-omap2/board-overo.c            |   32 +-
 arch/arm/mach-omap2/board-rm680.c            |    4 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   29 +-
 arch/arm/mach-omap2/board-rx51.c             |    4 +-
 arch/arm/mach-omap2/board-ti8168evm.c        |    9 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |   49 +--
 arch/arm/mach-omap2/board-zoom.c             |    8 +-
 arch/arm/mach-omap2/common-board-devices.c   |    6 +-
 arch/arm/mach-omap2/gpmc-nand.c              |   10 +-
 arch/arm/mach-omap2/io.c                     |   17 +-
 arch/arm/mach-omap2/irq.c                    |   32 +-
 arch/arm/mach-omap2/omap4-common.c           |   10 +-
 arch/arm/mach-omap2/pm-debug.c               |  372 +----------------
 arch/arm/mach-omap2/pm.h                     |   16 -
 arch/arm/mach-omap2/pm24xx.c                 |    6 +-
 arch/arm/mach-omap2/pm34xx.c                 |    6 -
 arch/arm/mach-omap2/smartreflex.c            |   38 +-
 arch/arm/mach-omap2/timer-gp.c               |  266 ------------
 arch/arm/mach-omap2/timer-gp.h               |   16 -
 arch/arm/mach-omap2/timer.c                  |  342 +++++++++++++++
 arch/arm/plat-omap/counter_32k.c             |    2 +-
 arch/arm/plat-omap/dmtimer.c                 |  209 ++--------
 arch/arm/plat-omap/include/plat/common.h     |    6 +-
 arch/arm/plat-omap/include/plat/dmtimer.h    |  250 +++++++++++-
 arch/arm/plat-omap/include/plat/irqs.h       |    6 +-
 arch/arm/plat-omap/include/plat/mcbsp.h      |   62 ---
 arch/arm/plat-omap/include/plat/nand.h       |    6 +-
 arch/arm/plat-omap/mcbsp.c                   |  596 +-------------------------
 70 files changed, 1016 insertions(+), 1942 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/timer-gp.c
 delete mode 100644 arch/arm/mach-omap2/timer-gp.h
 create mode 100644 arch/arm/mach-omap2/timer.c
