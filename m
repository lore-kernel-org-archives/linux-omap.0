From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] Second set of OMAP clock/hwmod patches for 2.6.34
 (rebased)
Date: Wed, 24 Feb 2010 16:36:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002241635070.2701@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55333 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758572Ab0BXXgc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 18:36:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

The following changes since commit 80c20d543d142ee54ec85259b77aaf0b83c32db5:
  Tony Lindgren (1):
        Merge branch 'omap-fixes-for-linus' into omap-for-linus

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 for_2.6.34_b

Abhijit Pagare (1):
      ARM: OMAP4 clock domain: Add check for avoiding dependency related update.

Kevin Hilman (4):
      OMAP: omap_device: add omap_device_is_valid()
      OMAP: omap_device: when 'called from invalid state', print state
      OMAP3: clock: use std _MASK suffix for CM_FCLKEN_IVA2 defines
      OMAP2/3: PRCM: fix misc. compiler warnings

Mike Turquette (1):
      OMAP3630: Clock: Workaround for DPLL HS divider limitation

Paul Walmsley (20):
      OMAP2/3/4 clock: fix DPLL multiplier value errors; also copyrights, includes, documentation
      OMAP4 clock: drop the CLOCK_IN_OMAP4430 clock flag
      OMAP2xxx clock: GFX functional clock rates are not independently changeable
      OMAP2xxx clock: drop DELAYED_APP flag from non-clksel clocks
      OMAP2 clock: drop CONFIG_PARTICIPANT clock flag
      OMAP clock: compress clock flags down to a u8
      OMAP clock: drop .id field; ensure each clock has a unique name
      OMAP3/4 clock: split into per-chip family files
      OMAP2 clock: split OMAP2420, OMAP2430 clock data into their own files
      OMAP2430 clock: make func_96m_ck parent-selectable
      OMAP2 clock: drop DELAYED_APP clock flag
      OMAP clock: drop RATE_FIXED clock flag
      OMAP4 clock: drop the ALWAYS_ENABLED clock flag
      OMAP clock: add omap_clk_get_by_name() for use by OMAP hwmod core code
      OMAP hwmod: convert hwmod to use hardware clock names rather than clkdev dev+con
      OMAP hwmod: convert header files with static allocations into C files
      OMAP hwmod: add hwmod class support
      OMAP clockdomain: if no autodeps exist, don't try to add or remove them
      OMAP2/3 clock: combine OMAP2 & 3 boot-time MPU rate change code
      OMAP2+ clock: revise omap2_clk_{disable,enable}()

Rajendra Nayak (1):
      OMAP4: clock: Rename leaf clock nodes to end with a _ick or _fck

Ranjith Lohithakshan (2):
      OMAP2/3 clock: Extend find_idlest() to pass back idle state value
      AM35xx: Add clock support for new modules on AM35xx

Richard Woodruff (1):
      OMAP3 clock: introduce DPLL4 Jtype

Sanjeev Premi (1):
      OMAP3 clock: Check return values for clk_get()

Santosh Shilimkar (2):
      OMAP4: clock: Add dummy clock nodes for interface clocks
      OMAP4: clock: Remove clock hacks from timer-gp.c

Tero Kristo (1):
      OMAP3: Clock: Added IDLEST definitions for SGX

Thara Gopinath (5):
      OMAP2/3 PM: Adding powerdomain APIs for reading the next logic and mem state
      OMAP3 PM: Defining .pwrsts_logic_ret field for core power domain structure
      OMAP3 PM: Adding counters for power domain logic off and mem off during retention.
      OMAP3: hwmod: support to specify the offset position of various SYSCONFIG register bits.
      OMAP: HWMOD: Add support for early device register into omap device layer

Vimarsh Zutshi (1):
      OMAP3: clock: add capability to change rate of dpll4_m5_ck_3630

Vishwanath BS (3):
      OMAP3 clock: Remove FreqSel for 3630
      OMAP3 clock: Introduce 3630 DPLL4 HSDivider changes
      OMAP3 clock: add support for 192Mhz DPLL4M2 output

 arch/arm/configs/omap_4430sdp_defconfig            |    7 +-
 arch/arm/mach-omap1/clock.c                        |   19 +-
 arch/arm/mach-omap1/clock_data.c                   |   41 +-
 arch/arm/mach-omap2/Makefile                       |   47 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c                |    6 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |    1 +
 arch/arm/mach-omap2/clkt_clksel.c                  |    8 -
 arch/arm/mach-omap2/clkt_dpll.c                    |    2 +-
 arch/arm/mach-omap2/clock.c                        |  293 ++++++---
 arch/arm/mach-omap2/clock.h                        |   14 +-
 .../{clock2xxx_data.c => clock2420_data.c}         |  697 ++++---------------
 arch/arm/mach-omap2/clock2430.c                    |   59 ++
 .../{clock2xxx_data.c => clock2430_data.c}         |  637 +++++-------------
 arch/arm/mach-omap2/clock2xxx.c                    |   67 +--
 arch/arm/mach-omap2/clock2xxx.h                    |   26 +-
 arch/arm/mach-omap2/clock34xx.c                    |  123 +---
 arch/arm/mach-omap2/clock34xx.h                    |   20 +-
 arch/arm/mach-omap2/clock3517.c                    |  124 ++++
 arch/arm/mach-omap2/clock3517.h                    |   14 +
 arch/arm/mach-omap2/clock36xx.c                    |   72 ++
 arch/arm/mach-omap2/clock36xx.h                    |   13 +
 arch/arm/mach-omap2/clock3xxx.c                    |  104 +++
 arch/arm/mach-omap2/clock3xxx.h                    |   21 +
 .../{clock34xx_data.c => clock3xxx_data.c}         |  502 +++++++++++---
 arch/arm/mach-omap2/clock44xx.c                    |   19 -
 arch/arm/mach-omap2/clock44xx.h                    |   13 +-
 arch/arm/mach-omap2/clock44xx_data.c               |  724 +++++++++-----------
 arch/arm/mach-omap2/clockdomain.c                  |   46 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h              |   28 +-
 arch/arm/mach-omap2/cm.h                           |    3 +
 arch/arm/mach-omap2/dpll3xxx.c                     |   82 ++-
 arch/arm/mach-omap2/id.c                           |    3 +
 arch/arm/mach-omap2/io.c                           |   29 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  288 ++++++---
 .../{omap_hwmod_2420.h => omap_hwmod_2420_data.c}  |   38 +-
 .../{omap_hwmod_2430.h => omap_hwmod_2430_data.c}  |   38 +-
 arch/arm/mach-omap2/omap_hwmod_34xx.h              |  168 -----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  181 +++++
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |   68 ++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   24 +
 arch/arm/mach-omap2/pm-debug.c                     |    5 +
 arch/arm/mach-omap2/pm34xx.c                       |    2 +-
 arch/arm/mach-omap2/powerdomain.c                  |   98 +++
 arch/arm/mach-omap2/powerdomains34xx.h             |    2 +
 arch/arm/mach-omap2/prcm.c                         |   18 +-
 arch/arm/mach-omap2/timer-gp.c                     |    5 -
 arch/arm/plat-omap/clock.c                         |   39 +-
 arch/arm/plat-omap/include/plat/clock.h            |   91 ++-
 arch/arm/plat-omap/include/plat/cpu.h              |    2 +
 arch/arm/plat-omap/include/plat/omap_device.h      |    7 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |  136 +++-
 arch/arm/plat-omap/include/plat/powerdomain.h      |    4 +
 arch/arm/plat-omap/include/plat/prcm.h             |    3 +-
 arch/arm/plat-omap/omap_device.c                   |   61 ++-
 54 files changed, 2857 insertions(+), 2285 deletions(-)
 copy arch/arm/mach-omap2/{clock2xxx_data.c => clock2420_data.c} (72%)
 create mode 100644 arch/arm/mach-omap2/clock2430.c
 rename arch/arm/mach-omap2/{clock2xxx_data.c => clock2430_data.c} (75%)
 create mode 100644 arch/arm/mach-omap2/clock3517.c
 create mode 100644 arch/arm/mach-omap2/clock3517.h
 create mode 100644 arch/arm/mach-omap2/clock36xx.c
 create mode 100644 arch/arm/mach-omap2/clock36xx.h
 create mode 100644 arch/arm/mach-omap2/clock3xxx.c
 create mode 100644 arch/arm/mach-omap2/clock3xxx.h
 rename arch/arm/mach-omap2/{clock34xx_data.c => clock3xxx_data.c} (88%)
 delete mode 100644 arch/arm/mach-omap2/clock44xx.c
 rename arch/arm/mach-omap2/{omap_hwmod_2420.h => omap_hwmod_2420_data.c} (82%)
 rename arch/arm/mach-omap2/{omap_hwmod_2430.h => omap_hwmod_2430_data.c} (83%)
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_34xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_common_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_common_data.h


- Paul
