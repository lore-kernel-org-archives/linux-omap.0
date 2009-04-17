From: Tony Lindgren <tony@atomide.com>
Subject: git pull request for omap fixes (Re: [PATCH 00/11] Omap fixes for
	2.6.30-rc1)
Date: Thu, 16 Apr 2009 18:23:02 -0700
Message-ID: <20090417012301.GB8316@atomide.com>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64724 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054AbZDQBXQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 21:23:16 -0400
Content-Disposition: inline
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090414 14:48]:
> Hi all,
> 
> Here are some omap fixes for review.

Also merged in Paul's clock fixes posted here earlier.

Russell, here's the pull request for you.

Regards,

Tony

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit 0882e8dd3aad33eca41696d463bb896e6c8817eb:
  Linus Torvalds (1):
        Linux 2.6.30-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Arun KS (1):
      OMAP1: clock: Typo fix for clock in omap1

Huang Weiyi (1):
      ARM: OMAP3: remove duplicated #include

Jarkko Nikula (1):
      ARM: OMAP2: Remove defines and resource init for OMAP24XX EAC

Kevin Hilman (2):
      OMAP: dmtimer: enable all timers to be wakeup events
      ARM: OMAP2/3: GPIO: do not attempt to wake-enable

Ladislav Michl (3):
      ARM: OMAP: MMC: Remove unused power_pin
      ARM: OMAP1: Simplify board-h2 MMC setup
      ARM: OMAP1: Fix mmc_set_power GPIO usage

Paul Walmsley (4):
      OMAP2xxx clock: init osc_ck, sys_ck internal lists early
      OMAP2xxx clock: fix broken cpu_mask code
      OMAP3 GPTIMER: fix GPTIMER12 IRQ
      OMAP2/3 GPTIMER: allow system tick GPTIMER to be changed in board-*.c files

Roel Kluin (1):
      ARM: OMAP2: possible division by 0

Roger Quadros (2):
      ARM: OMAP3: Fixed spurious IRQ issue for GPIO interrupts
      ARM: OMAP3: Clean up spurious interrupt check logic

Santosh Shilimkar (1):
      ARM: OMAP: Fix for possible race condition in omap_free_dma()

Sergio Aguirre (1):
      OMAP3: clock: Camera module doesn't have IDLEST bit

Tony Lindgren (2):
      ARM: OMAP: Remove old dead gpio expander code
      Merge branch 'omap-clock-fixes' of git://git.pwsan.com/linux-2.6 into omap-fixes

 arch/arm/mach-omap1/board-h2-mmc.c             |   14 +---
 arch/arm/mach-omap1/board-h3-mmc.c             |    6 +-
 arch/arm/mach-omap1/board-h3.c                 |  101 ------------------------
 arch/arm/mach-omap1/board-nokia770.c           |    6 +-
 arch/arm/mach-omap1/mcbsp.c                    |    4 +-
 arch/arm/mach-omap2/board-h4.c                 |   95 ----------------------
 arch/arm/mach-omap2/board-omap3beagle.c        |    4 +
 arch/arm/mach-omap2/board-rx51.c               |    1 -
 arch/arm/mach-omap2/clock24xx.c                |   15 ++--
 arch/arm/mach-omap2/clock24xx.h                |   10 ++-
 arch/arm/mach-omap2/clock34xx.h                |    7 +-
 arch/arm/mach-omap2/devices.c                  |   33 --------
 arch/arm/mach-omap2/irq.c                      |    4 +-
 arch/arm/mach-omap2/timer-gp.c                 |   48 +++++++++++-
 arch/arm/mach-omap2/usb-tusb6010.c             |    2 +-
 arch/arm/plat-omap/dma.c                       |   13 ++--
 arch/arm/plat-omap/dmtimer.c                   |   28 ++++---
 arch/arm/plat-omap/gpio.c                      |   20 ++---
 arch/arm/plat-omap/include/mach/dmtimer.h      |    2 +-
 arch/arm/plat-omap/include/mach/eac.h          |  100 -----------------------
 arch/arm/plat-omap/include/mach/gpioexpander.h |   35 --------
 arch/arm/plat-omap/include/mach/irda.h         |    4 -
 arch/arm/plat-omap/include/mach/mmc.h          |    1 -
 arch/arm/plat-omap/include/mach/timer-gp.h     |   17 ++++
 drivers/mmc/host/omap.c                        |    2 -
 25 files changed, 128 insertions(+), 444 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/eac.h
 delete mode 100644 arch/arm/plat-omap/include/mach/gpioexpander.h
 create mode 100644 arch/arm/plat-omap/include/mach/timer-gp.h

--82I3+IH0IqGh5yIs--
