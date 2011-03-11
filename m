From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP PM updates for 2.6.39
Date: Thu, 10 Mar 2011 16:59:27 -0800
Message-ID: <87k4g6eakw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:53005 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753051Ab1CKA7a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 19:59:30 -0500
Received: by mail-qw0-f50.google.com with SMTP id 3so2271683qwk.23
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 16:59:29 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

Please pull the following OMAP PM related changes for the upcoming
2.6.39 merge window.

Kevin

The following changes since commit a5abba989deceb731047425812d268daf7536575:

  Linux 2.6.38-rc8 (2011-03-07 21:09:37 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.39/pm-misc

Anand S Sawant (1):
      OMAP2+: smartreflex: remove SR debug directory in omap_sr_remove()

Dave Martin (5):
      ARM: omap4: Provide do_wfi() for Thumb-2
      ARM: omap4: Convert END() to ENDPROC() for correct linkage with CONFIG_THUMB2_KERNEL
      ARM: omap3: Remove hand-encoded SMC instructions
      ARM: omap3: Thumb-2 compatibility for sram34xx.S
      ARM: omap3: Thumb-2 compatibility for sleep34xx.S

Kevin Hilman (2):
      MAINTAINERS: update Kevin's email for OMAP PM section
      OMAP2+: remove unused UART base addresses from omap_globals

Menon, Nishanth (1):
      OMAP3|4: OPP: make omapx_opp_init non-static

Nishanth Menon (1):
      OMAP3: beagle xm: enable up to 800MHz OPP

Paul Walmsley (1):
      OMAP2/3: PM: remove unnecessary wakeup/sleep dependency clear

Ricardo Salveti de Araujo (1):
      OMAP3630: PM: don't warn the user with a trace in case of PM34XX_ERRATUM

Sanjeev Premi (1):
      OMAP3: PM: Initialize IVA only if available

Santosh Shilimkar (7):
      omap3: pm: Use exported set_cr() instead of a custom one.
      omap3: cpuidle: Add description field to each C-state.
      OMAP3: PM: Use ARMv7 supported instructions instead of legacy CP15 ones
      OMAP3: PM: Fix the MMU on sequence in the asm code
      OMAP3: PM: Allow the cache clean when L1 is lost.
      OMAP3: PM: Remove un-necessary cp15 registers form low power cpu context
      OMAP3: PM: Clear the SCTLR C bit in asm code to prevent data cache allocation

Thara Gopinath (1):
      OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL

Vasiliy Kulikov (1):
      OMAP: PM: SmartReflex: fix potential NULL dereference

 MAINTAINERS                                     |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c         |   50 ++++
 arch/arm/mach-omap2/common.c                    |   14 --
 arch/arm/mach-omap2/cpuidle34xx.c               |   11 +-
 arch/arm/mach-omap2/include/mach/omap4-common.h |    4 +
 arch/arm/mach-omap2/omap-headsmp.S              |    2 +-
 arch/arm/mach-omap2/omap44xx-smc.S              |    8 +-
 arch/arm/mach-omap2/omap_twl.c                  |   60 +++++
 arch/arm/mach-omap2/opp3xxx_data.c              |    3 +-
 arch/arm/mach-omap2/opp4xxx_data.c              |    3 +-
 arch/arm/mach-omap2/pm.c                        |    4 +-
 arch/arm/mach-omap2/pm.h                        |    1 +
 arch/arm/mach-omap2/pm24xx.c                    |    8 +-
 arch/arm/mach-omap2/pm34xx.c                    |   25 +--
 arch/arm/mach-omap2/sleep34xx.S                 |  282 +++++++++++------------
 arch/arm/mach-omap2/smartreflex.c               |   31 ++-
 arch/arm/mach-omap2/sram34xx.S                  |   36 +++-
 arch/arm/plat-omap/include/plat/common.h        |    4 -
 18 files changed, 320 insertions(+), 228 deletions(-)
