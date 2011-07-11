From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap cleanup for v3.1 merge window, part 3
Date: Mon, 11 Jul 2011 04:49:32 -0700
Message-ID: <20110711114931.GY5783@atomide.com>
References: <20110711114736.GX5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:44058 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754388Ab1GKLti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 07:49:38 -0400
Content-Disposition: inline
In-Reply-To: <20110711114736.GX5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

The following changes since commit ecba3287b4121dcf3ca7607fe71c205913edec06:
  Arnd Bergmann (1):
        Merge branch 'cleanup-part-2' of git+ssh://master.kernel.org/.../tmlind/linux-omap-2.6 into omap/cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git cleanup-part-3

Benoit Cousson (21):
      OMAP2+: hwmod: Fix smart-standby + wakeup support
      OMAP4: hwmod data: Add MSTANDBY_SMART_WKUP flag
      OMAP2+: hwmod: Do not write the enawakeup bit if SYSC_HAS_ENAWAKEUP is not set
      OMAP2+: hwmod: Remove _populate_mpu_rt_base warning
      OMAP2+: hwmod: Fix the HW reset management
      OMAP: hwmod: Add warnings if enable failed
      OMAP: hwmod: Move pr_debug to improve the readability
      OMAP4: hwmod data: Fix L3 interconnect data order and alignement
      OMAP4: hwmod data: Remove un-needed parens
      OMAP4: hwmod data: Fix bad alignement
      OMAP4: hwmod data: Align interconnect format with regular modules
      OMAP4: clock data: Add sddiv to USB DPLL
      OMAP4: clock data: Remove usb_host_fs clkdev with NULL dev
      OMAP4: clock data: Re-order some clock nodes and structure fields
      OMAP4: clock data: Fix max mult and div for USB DPLL
      OMAP4: prcm: Fix errors in few defines name
      OMAP4: prm: Remove wrong clockdomain offsets
      OMAP4: powerdomain data: Fix indentation
      OMAP4: cm: Remove RESTORE macros to avoid access from SW
      OMAP4: prcm_mpu: Fix indent in few macros
      OMAP4: clockdomain data: Fix data order and wrong name

Jean Pihet (1):
      OMAP PM: remove OMAP_PM_NONE config option

Jon Hunter (2):
      OMAP4: clock data: Remove McASP2, McASP3 and MMC6 clocks
      OMAP4: clock data: Remove UNIPRO clock nodes

Kevin Hilman (1):
      OMAP: omap_device: replace _find_by_pdev() with to_omap_device()

Miguel Vadillo (1):
      OMAP2+: hwmod: Enable module in shutdown to access sysconfig

Paul Walmsley (9):
      OMAP: dmtimer: add missing include
      omap_hwmod: use a null structure record to terminate omap_hwmod_addr_space arrays
      omap_hwmod: share identical omap_hwmod_addr_space arrays
      omap_hwmod: use a terminator record with omap_hwmod_mpu_irqs arrays
      omap_hwmod: share identical omap_hwmod_mpu_irqs arrays
      omap_hwmod: use a terminator record with omap_hwmod_dma_info arrays
      omap_hwmod: share identical omap_hwmod_dma_info arrays
      omap_hwmod: share identical omap_hwmod_class, omap_hwmod_class_sysconfig arrays
      Merge branches 'dmtimer_precleanup_3.1', 'hwmod_core_cleanup_a_3.1', 'combine_common_hwmod_3.1', 'omap4_hwmod_data_cleanup_a_3.1', 'clock_cleanup_a_3.1', 'prcm_cleanup_a_3.1', 'omap_pm_cleanup_3.1' and 'omap_device_cleanup_3.1' into prcm-cleanup-3.1

Russell King - ARM Linux (1):
      Convert OMAPs 32kHz clocksource implementation to use the generic MMIO clocksource support.  This achieves several things:

Tony Lindgren (1):
      Merge branch 'prcm-cleanup-3.1' of git://git.pwsan.com/linux-2.6 into cleanup-part-3

 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-omap2/Makefile                       |   16 +-
 arch/arm/mach-omap2/clock44xx.h                    |    7 -
 arch/arm/mach-omap2/clock44xx_data.c               |  237 ++----
 arch/arm/mach-omap2/clockdomains44xx_data.c        |  124 ++--
 arch/arm/mach-omap2/cm-regbits-44xx.h              |  623 ++++++--------
 arch/arm/mach-omap2/cm1_44xx.h                     |   64 +--
 arch/arm/mach-omap2/cm2_44xx.h                     |   73 +--
 arch/arm/mach-omap2/omap_hwmod.c                   |  223 ++++--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  832 +++----------------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  910 +++-----------------
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  173 ++++
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  322 +++++++
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  130 +++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  150 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  654 +++-----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  472 +++++-----
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |   20 -
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   93 ++-
 arch/arm/mach-omap2/powerdomains44xx_data.c        |   18 +-
 arch/arm/mach-omap2/prcm_mpu44xx.h                 |   69 +-
 arch/arm/mach-omap2/prm44xx.h                      |   34 +-
 arch/arm/plat-omap/Kconfig                         |    3 -
 arch/arm/plat-omap/counter_32k.c                   |  121 +--
 arch/arm/plat-omap/include/plat/clock.h            |    2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
 arch/arm/plat-omap/include/plat/omap-pm.h          |    8 -
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   20 +-
 arch/arm/plat-omap/omap_device.c                   |   15 +-
 29 files changed, 2152 insertions(+), 3263 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
