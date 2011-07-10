From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: SoC data/core: cleanups for 3.1
Date: Sat, 9 Jul 2011 20:37:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107092031400.15984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42524 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab1GJChY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 22:37:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Tony,

The following changes since commit ecba3287b4121dcf3ca7607fe71c205913edec06:

  Merge branch 'cleanup-part-2' of git+ssh://master.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6 into omap/cleanup (2011-07-08 15:01:45 +0000)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 prcm-cleanup-3.1

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
 arch/arm/plat-omap/include/plat/clock.h            |    2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
 arch/arm/plat-omap/include/plat/omap-pm.h          |    8 -
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   20 +-
 arch/arm/plat-omap/omap_device.c                   |   15 +-
 27 files changed, 2117 insertions(+), 3176 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c

omap2plus_defconfig
   text	   data	    bss	    dec	    hex	filename
6353285	 528944	5591048	12473277	 be53bd	vmlinux.orig
6351345	 529296	5591048	12471689	 be4d89	vmlinux.patched

