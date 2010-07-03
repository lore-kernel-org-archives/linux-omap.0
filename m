From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: clock, hwmod, omap_device, PM constraints: patches
 for 2.6.36
Date: Sat, 3 Jul 2010 15:50:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007031548010.16344@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36864 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab0GCVuI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jul 2010 17:50:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Tony,

here's the pull request for some clock, hwmod, omap_device, PM constraints 
patches for 2.6.36.


- Paul

The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:

  Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 for_2.6.36

Anand Gadiyar (1):
      OMAP3: wait on IDLEST after enabling USBTLL fclk

Benoit Cousson (1):
      OMAP2&3: hwmod: Remove _hwmod prefix in name string

Kevin Hilman (8):
      OMAP24xx: CM: fix mask used for checking IDLEST status
      OMAP2/3: hwmod: L3 and L4 CORE/PER/WKUP hwmods don't have IDLEST
      OMAP: hwmod: add non-locking versions of enable and idle functions
      OMAP: omap_device: ensure hwmod tracks attached omap_device pointer
      OMAP: PM: create omap_devices for MPU, DSP, L3
      OMAP: hwmod data: add class for IVA hwmods
      OMAP2&3: hwmod: Replace l3 -> l3_main
      OMAP3: hwmod data: add data for OMAP3 IVA2

Paul Walmsley (9):
      OMAP: clock: add kerneldoc for structures; move flags closer to structs
      OMAP1: OPP: add KConfig entry for 96MHz ARM rate (using a 12MHz oscillator)
      OMAP1: clock: some cleanup
      OMAP: hwmod: allow omap_hwmod_late_init() caller to skip module idle in _setup()
      OMAP2: hwmod data: add IVA1 (2420), IVA2 (2430) hwmods
      OMAP: hwmod/device: add omap_{device,hwmod}_get_mpu_rt_va
      OMAP2+: hwmod/device: update documentation and copyright
      OMAP: PM constraints: add return values; add requesting device param to omap_pm_set_max_dev_wakeup_lat()
      OMAP: PM constraints: add omap_pm_set_min_clk_rate()

Rajendra Nayak (1):
      OMAP4: hwmod: Enable omap_device build for OMAP4

 arch/arm/mach-omap1/Kconfig                   |    6 +
 arch/arm/mach-omap1/clock.c                   |   22 +++--
 arch/arm/mach-omap1/clock.h                   |    2 +-
 arch/arm/mach-omap1/clock_data.c              |  129 +++++++++++++++++++-----
 arch/arm/mach-omap2/Makefile                  |    4 +-
 arch/arm/mach-omap2/clock3xxx_data.c          |    2 +-
 arch/arm/mach-omap2/cm.c                      |    6 +-
 arch/arm/mach-omap2/io.c                      |   11 ++-
 arch/arm/mach-omap2/omap_hwmod.c              |  106 +++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |   79 +++++++++++-----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |   81 +++++++++++-----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   92 ++++++++++++------
 arch/arm/mach-omap2/omap_hwmod_common_data.c  |    3 +
 arch/arm/mach-omap2/omap_hwmod_common_data.h  |    1 +
 arch/arm/mach-omap2/pm.c                      |   84 ++++++++++++++++
 arch/arm/plat-omap/Makefile                   |    1 +
 arch/arm/plat-omap/i2c.c                      |   12 ++-
 arch/arm/plat-omap/include/plat/clock.h       |  130 ++++++++++++++++++++-----
 arch/arm/plat-omap/include/plat/common.h      |    4 +
 arch/arm/plat-omap/include/plat/omap-pm.h     |  130 +++++++++++++++++++------
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |   14 ++-
 arch/arm/plat-omap/omap-pm-noop.c             |   61 +++++++++---
 arch/arm/plat-omap/omap_device.c              |   33 ++++++-
 24 files changed, 790 insertions(+), 225 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm.c
