From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP clock, SDRC, PM, hwmod updates for 2.6.33
Date: Wed, 9 Dec 2009 00:50:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912090035280.5316@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34014 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbZLIHuY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 02:50:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hello Tony,

The following changes since commit 9a01609e1885b827b979d6d9dd86f43208a9e5fc:
  Olof Johansson (1):
        arm: omap: Add omap3_defconfig

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 for_2_6_33

Kevin Hilman (6):
      OMAP: omap_device: add to_omap_device() macro
      OMAP: omap_device: use UINT_MAX for default wakeup latency limit
      OMAP: omap_device: use read_persistent_clock() instead of getnstimeofday()
      OMAP: hwmod: warn on missing clockdomain
      OMAP: omap_device: fix nsec/usec conversion in latency calculations
      OMAP: omap_device: track latency in nanoseconds

Paul Walmsley (19):
      OMAP1/2/3 clock: remove paranoid checks in preparation for clock{,2xxx,3xxx}_data.c
      OMAP2 clock: APLL code shouldn't rely on static clocks in its local namespace
      OMAP2/3: move SDRC macros to mach-omap2/sdrc.h
      OMAP2xxx clock: remove implicit dependency between rate CPU flag and clkdev_omap CPU flag
      OMAP3 clock: convert clock34xx.h to clock34xx_data.c
      OMAP2 clock: convert clock24xx.h to clock2xxx_data.c, opp2xxx*
      OMAP1 clock: convert test in disable_unused() to use ENABLE_ON_INIT
      OMAP1 clock: convert mach-omap1/clock.h to mach-omap1/clock_data.c
      OMAP2/3 PRCM: don't export prm_*(), cm_*() functions
      OMAP clockdomain/powerdomain: remove CONFIG_OMAP_DEBUG_{CLOCK,POWER}DOMAIN
      OMAP clockdomain/powerdomain: optimize out sleepdep code on OMAP24xx
      OMAP powerdomain/PM: use symbolic constants for the max number of power states
      OMAP powerdomain: rearrange struct powerdomain to save some memory
      OMAP3: SDRC: Place SDRC AC timing and MR changes in CORE DVFS SRAM code behind Kconfig
      OMAP clock/hwmod: fix off-by-one errors
      OMAP3 hwmod: reprogram OCP_SYSCONFIG register after setting SOFTRESET
      OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE handling
      OMAP hwmod: add names to module MPU IRQ lines
      OMAP3 hwmod: drop most of the OCP_SYSCONFIG.CLOCKACTIVITY code

Rajendra Nayak (11):
      ARM: OMAP4: PM: Fix the PRM and CM base addresses
      ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
      ARM: OMAP4: PM: Adds CM1/2 register defs for OMAP4
      ARM: OMAP4: PM: Adds PRM register defs for OMAP4
      ARM: OMAP4: PM: Adds PRM register shift and mask bits
      ARM: OMAP4: PM: Adds CM1/2 register field masks
      ARM: OMAP4: PM: OMAP4 clock tree and clkdev registration
      ARM: OMAP4: PM: Add dummy hooks for OMAP4 dpll api's
      ARM: OMAP4: PM: Move DPLL control apis to dpll.c
      ARM: OMAP4: PM: Add support for OMAP4 dpll api's
      ARM: OMAP4: PM: Add init api for DPLL nodes

Roel Kluin (1):
      OMAP2/3 powerdomain: return errors rather than returning the output of IS_ERR()

Thara Gopinath (1):
      OMAP3: PM: Fix for MPU power domain MEM BANK position

 arch/arm/mach-omap1/Makefile                       |    3 +-
 arch/arm/mach-omap1/clock.c                        |  499 +---
 arch/arm/mach-omap1/clock.h                        |  647 +----
 arch/arm/mach-omap1/clock_data.c                   |  843 +++++
 arch/arm/mach-omap1/io.c                           |    3 +-
 arch/arm/mach-omap1/opp.h                          |   28 +
 arch/arm/mach-omap1/opp_data.c                     |   59 +
 arch/arm/mach-omap2/Kconfig                        |   13 +
 arch/arm/mach-omap2/Makefile                       |   14 +-
 arch/arm/mach-omap2/clock.c                        |   47 +-
 arch/arm/mach-omap2/clock.h                        |   50 +-
 arch/arm/mach-omap2/clock24xx.c                    |  805 -----
 .../mach-omap2/{clock24xx.h => clock2xxx_data.c}   |  836 ++----
 arch/arm/mach-omap2/clock34xx.c                    |  953 +------
 arch/arm/mach-omap2/clock34xx.h                    | 2999 +------------------
 arch/arm/mach-omap2/clock34xx_data.c               | 3289 ++++++++++++++++++++
 arch/arm/mach-omap2/clock44xx.c                    |   33 +
 arch/arm/mach-omap2/clock44xx.h                    |   15 +
 arch/arm/mach-omap2/clock44xx_data.c               | 2766 ++++++++++++++++
 arch/arm/mach-omap2/clockdomain.c                  |    6 +-
 arch/arm/mach-omap2/cm-regbits-44xx.h              | 1474 +++++++++
 arch/arm/mach-omap2/cm.c                           |    7 +-
 arch/arm/mach-omap2/cm.h                           |   15 +-
 arch/arm/mach-omap2/cm44xx.h                       |  358 +++
 arch/arm/mach-omap2/dpll.c                         |  538 ++++
 arch/arm/mach-omap2/gpmc.c                         |    2 +-
 arch/arm/mach-omap2/io.c                           |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  164 +-
 arch/arm/mach-omap2/pm-debug.c                     |    4 +-
 arch/arm/mach-omap2/powerdomain.c                  |   36 +-
 arch/arm/mach-omap2/powerdomains34xx.h             |    1 +
 arch/arm/mach-omap2/prcm-common.h                  |   73 +-
 arch/arm/mach-omap2/prcm.c                         |   13 +-
 arch/arm/mach-omap2/prm-regbits-44xx.h             | 2205 +++++++++++++
 arch/arm/mach-omap2/prm.h                          |    8 +-
 arch/arm/mach-omap2/prm44xx.h                      |  411 +++
 arch/arm/mach-omap2/sdrc.h                         |   19 +
 arch/arm/mach-omap2/sram34xx.S                     |   19 +-
 arch/arm/plat-omap/Kconfig                         |   63 +-
 arch/arm/plat-omap/clock.c                         |   26 -
 arch/arm/plat-omap/common.c                        |    2 +
 arch/arm/plat-omap/include/plat/clkdev_omap.h      |   41 +
 arch/arm/plat-omap/include/plat/clock.h            |    5 +
 arch/arm/plat-omap/include/plat/common.h           |   21 +
 arch/arm/plat-omap/include/plat/omap44xx.h         |    6 +-
 arch/arm/plat-omap/include/plat/omap_device.h      |    8 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   26 +-
 arch/arm/plat-omap/include/plat/powerdomain.h      |   17 +-
 arch/arm/plat-omap/omap_device.c                   |   18 +-
 49 files changed, 12947 insertions(+), 6545 deletions(-)
 create mode 100644 arch/arm/mach-omap1/clock_data.c
 create mode 100644 arch/arm/mach-omap1/opp.h
 create mode 100644 arch/arm/mach-omap1/opp_data.c
 delete mode 100644 arch/arm/mach-omap2/clock24xx.c
 rename arch/arm/mach-omap2/{clock24xx.h => clock2xxx_data.c} (73%)
 create mode 100644 arch/arm/mach-omap2/clock34xx_data.c
 create mode 100644 arch/arm/mach-omap2/clock44xx.c
 create mode 100644 arch/arm/mach-omap2/clock44xx.h
 create mode 100644 arch/arm/mach-omap2/clock44xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-44xx.h
 create mode 100644 arch/arm/mach-omap2/cm44xx.h
 create mode 100644 arch/arm/mach-omap2/dpll.c
 create mode 100644 arch/arm/mach-omap2/prm-regbits-44xx.h
 create mode 100644 arch/arm/mach-omap2/prm44xx.h
 create mode 100644 arch/arm/plat-omap/include/plat/clkdev_omap.h


- Paul

