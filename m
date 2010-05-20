From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP clock/powerdomain/hwmod/omap_device patches for
 2.6.35
Date: Wed, 19 May 2010 18:07:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005191804450.27473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36433 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab0ETAHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 20:07:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Tony,

Here are some patches for 2.6.35.  This branch is based on your 
omap-for-linus branch.

regards,

- Paul

The following changes since commit 0b088e693d0f2126444b9e97ec7e716602d884e3:

  AM3517: rename the i2c boardinfo to make it more readable (2010-05-14 14:15:30 -0700)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 for_2.6.35

Benoit Cousson (13):
      OMAP4: hwmod: Replace module & device offsets by absolute clkctrl address
      OMAP: CM: Move MAX_MODULE_READY_TIME to cm.h
      OMAP4: hwmod & CM: Implement the omap4_cm_wait_module_ready function
      OMAP4: hwmod: Replace OCPIF_HAS_IDLEST by HWMOD_NO_IDLEST
      OMAP: hwmod: Fix wrong pointer iteration in oh->slaves
      OMAP: hwmod: Remove IS_ERR check with omap_clk_get_by_name return value
      OMAP: hwmod: Replace WARN by pr_warning if clock lookup failed
      OMAP: hwmod: Do not exit the iteration if one clock init failed
      OMAP: hwmod: Rename hwmod name for the MPU
      OMAP: hwmod: Replace WARN by pr_warning for clockdomain check
      OMAP4: CM: Remove non-functional registers in ES1.0
      OMAP4: PRM: Remove MPU internal code name and apply PRCM naming convention
      OMAP4: PRCM: Remove duplicate definition of base addresses

Felipe Balbi (1):
      OMAP1 clock: fix section mismatch on clk_init

Laine Walker-Avina (1):
      OMAP3 clock: add support for setting the divider for sys_clkout2 using clk_set_rate

Paul Walmsley (11):
      OMAP2 PRCM: convert OMAP2 PRCM macros to the _SHIFT/_MASK suffixes
      OMAP3 PRCM: convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes
      OMAP2+ PRCM: convert remaining PRCM macros to the _SHIFT/_MASK suffixes
      OMAP3: PM: PM_MPUGRPSEL writes should use GRPSEL macros, not EN macros
      OMAP2+ clock: remove DEFAULT_RATE clksel_rate flag
      OMAP2+ clock: clean up clkt_clksel.c
      OMAP3 clock: rename RATE_IN_343X, RATE_IN_3430ES2 to match reality
      OMAP3 clock: remove unnecessary duplicate of dpll4_m2_ck, added for 36xx
      OMAP clock: resolve old checkpatch and CodingStyle issues with plat-omap/clock.c
      OMAP powerdomain, hwmod, omap_device: add some credits
      OMAP2 clock: fix recursive spinlock attempt when CONFIG_CPU_FREQ=y

Rajendra Nayak (6):
      OMAP4: PRCM: Add offset defines for all PRM registers
      OMAP4: PRCM: Add offset defines for all CM registers
      Remove the hack put in place while clock framework was still not in
      OMAP: timers: Fix clock source names for OMAP4
      OMAP4 powerdomain: Fix pwrsts flags for ALWAYS ON domains
      OMAP4 powerdomain: Support LOWPOWERSTATECHANGE for powerdomains

 arch/arm/mach-omap1/clock.c                   |    2 +-
 arch/arm/mach-omap1/clock.h                   |    2 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c           |    4 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c  |   17 +-
 arch/arm/mach-omap2/clkt_clksel.c             |  472 +++++++++++++++----------
 arch/arm/mach-omap2/clock.c                   |    9 +
 arch/arm/mach-omap2/clock.h                   |   11 +-
 arch/arm/mach-omap2/clock2420_data.c          |   50 ++--
 arch/arm/mach-omap2/clock2430_data.c          |   54 ++--
 arch/arm/mach-omap2/clock3xxx_data.c          |  408 +++++++++-------------
 arch/arm/mach-omap2/clock_common_data.c       |   12 +-
 arch/arm/mach-omap2/clockdomain.c             |    4 +-
 arch/arm/mach-omap2/clockdomains44xx.h        |    4 +-
 arch/arm/mach-omap2/cm-regbits-24xx.h         |  236 ++++++------
 arch/arm/mach-omap2/cm-regbits-34xx.h         |  222 ++++++------
 arch/arm/mach-omap2/cm.c                      |    3 -
 arch/arm/mach-omap2/cm.h                      |   16 +-
 arch/arm/mach-omap2/cm44xx.h                  |  301 ++++++++++++++--
 arch/arm/mach-omap2/cm4xxx.c                  |   54 ++--
 arch/arm/mach-omap2/control.c                 |    7 +-
 arch/arm/mach-omap2/omap_hwmod.c              |  121 ++++---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
 arch/arm/mach-omap2/pm24xx.c                  |  126 ++++----
 arch/arm/mach-omap2/pm34xx.c                  |  205 ++++++-----
 arch/arm/mach-omap2/powerdomain.c             |   56 +++-
 arch/arm/mach-omap2/powerdomains44xx.h        |   23 +-
 arch/arm/mach-omap2/prcm-common.h             |  164 ++++-----
 arch/arm/mach-omap2/prcm.c                    |    4 +-
 arch/arm/mach-omap2/prm-regbits-24xx.h        |  120 ++++----
 arch/arm/mach-omap2/prm-regbits-34xx.h        |  360 ++++++++++----------
 arch/arm/mach-omap2/prm.h                     |   22 +-
 arch/arm/mach-omap2/prm44xx.h                 |  389 +++++++++++++++++++--
 arch/arm/plat-omap/clock.c                    |   25 +-
 arch/arm/plat-omap/dmtimer.c                  |    4 +-
 arch/arm/plat-omap/include/plat/clock.h       |   14 +-
 arch/arm/plat-omap/include/plat/omap44xx.h    |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |   16 +-
 arch/arm/plat-omap/include/plat/powerdomain.h |    7 +
 arch/arm/plat-omap/omap_device.c              |    4 +-
 41 files changed, 2099 insertions(+), 1456 deletions(-)

