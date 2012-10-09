From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/5] omap fixes for v3.7-rc1
Date: Tue, 9 Oct 2012 11:46:25 -0700
Message-ID: <30588.9501855292$1349808412@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:30012 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755078Ab2JISqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 14:46:32 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 5e090ed7af10729a396a25df43d69a236e789736:

  Merge tag 'soc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-10-07 20:55:16 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc1/fixes-signed

for you to fetch changes up to 224cd7115abb5b05a5d665551452c271449ce80b:

  arm/omap: Replace board_ref_clock with enum values (2012-10-08 18:09:30 -0700)

----------------------------------------------------------------
This branch contains one counter locking fix and an
alignment fix. Other fixes are warning fixes, fixes
for return value checks.

I've also included removal of some extra semicolons,
dropping of some duplicate includes, and an a change
for wl12xx enumeration that are not strictly fixes
but would be good to get out of the way for -rc1.

----------------------------------------------------------------
Afzal Mohammed (1):
      ARM: OMAP2+: gpmc: annotate exit sections properly

Axel Lin (1):
      ARM: OMAP: OMAP_DEBUG_LEDS needs to select LEDS_CLASS

Colin Cross (1):
      ARM: OMAP: counter: add locking to read_persistent_clock

Peter Senna Tschudin (3):
      arch/arm/mach-omap1/devices.c: Remove unecessary semicolon
      arch/arm/mach-omap2: Remove unecessary semicolon
      arch/arm/plat-omap/omap-pm-noop.c: Remove unecessary semicolon

R Sricharan (1):
      ARM: OMAP2+: Round of the carve out memory requested to section_size

Raphael Assenat (1):
      AM35xx: Add missing hwmod entry for the HDQ/1-Wire present in AM3505/3517 CPUs.

Shubhrajyoti D (1):
      ARM: OMAP: rx51: Fix a section mismatch warn

Vaibhav Hiremath (1):
      ARM: OMAP2+: Add am335x evm and bone targets to common Makefile

Vikram Narayanan (1):
      arm/omap: Replace board_ref_clock with enum values

Wei Yongjun (4):
      OMAPDSS: fix return value check in create_dss_pdev()
      ARM: OMAP: hsmmc: fix return value check in omap_hsmmc_init_one()
      ARM: OMAP: fix return value check in realtime_counter_init()
      ARM: OMAP2+: remove duplicated include from board-omap3stalker.c

Yegor Yefremov (1):
      arm: increase FORCE_MAX_ZONEORDER for TI AM33XX

 arch/arm/Kconfig                             |    1 +
 arch/arm/boot/dts/Makefile                   |    4 +++-
 arch/arm/mach-omap1/devices.c                |    2 +-
 arch/arm/mach-omap2/board-flash.c            |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |    5 -----
 arch/arm/mach-omap2/board-omap4panda.c       |    3 +--
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    3 +--
 arch/arm/mach-omap2/clkt_clksel.c            |    2 +-
 arch/arm/mach-omap2/display.c                |    2 +-
 arch/arm/mach-omap2/gpmc.c                   |    4 ++--
 arch/arm/mach-omap2/hsmmc.c                  |    2 +-
 arch/arm/mach-omap2/mux.c                    |    2 +-
 arch/arm/mach-omap2/omap-secure.c            |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    7 ++++---
 arch/arm/mach-omap2/pm-debug.c               |    2 +-
 arch/arm/mach-omap2/timer.c                  |    2 +-
 arch/arm/plat-omap/Kconfig                   |    1 +
 arch/arm/plat-omap/counter_32k.c             |   21 ++++++++++++++-------
 arch/arm/plat-omap/omap-pm-noop.c            |    8 ++++----
 20 files changed, 42 insertions(+), 37 deletions(-)
