From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/20] OMAP: clock, hwmod, omap_device,
 PM constraints: patches for 2.6.36
Date: Fri, 02 Jul 2010 09:29:06 -0600
Message-ID: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45249 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758763Ab0GBPbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Here are some OMAP clock, hwmod, omap_device, and PM constraint patches
for the 2.6.36 merge window.

Notable changes include:

- a fix for sporadic USBTLL clk_enable() crashes on OMAP3

- many hwmod fixes and improvements

- kerneldoc documentation for OMAP clock-related structures

- a minimum clock rate power management constraint interface


This series has been compile-tested with omap_osk_5912_defconfig,
n8x0_defconfig, omap_2430sdp_defconfig, omap3_defconfig,
omap3_beagle_defconfig, omap_3630sdp_defconfig, and
omap_4430sdp_defconfig.  Boot-tested on N800 and OMAP3530 Beagle.


- Paul

---

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


size:
   text    data     bss     dec     hex filename
6104613 1919040 5708833 13732486         d18a86 vmlinux.omap3defconfig.orig
6106345 1919424 5708833 13734602         d192ca vmlinux.omap3defconfig.patched


 arch/arm/mach-omap1/Kconfig                   |    6 +
 arch/arm/mach-omap1/clock.c                   |   22 ++--
 arch/arm/mach-omap1/clock.h                   |    2 
 arch/arm/mach-omap1/clock_data.c              |  129 ++++++++++++++++++++-----
 arch/arm/mach-omap2/Makefile                  |    4 -
 arch/arm/mach-omap2/clock3xxx_data.c          |    2 
 arch/arm/mach-omap2/cm.c                      |    6 +
 arch/arm/mach-omap2/io.c                      |   11 ++
 arch/arm/mach-omap2/omap_hwmod.c              |  106 +++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |   79 +++++++++++----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |   81 +++++++++++-----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   92 ++++++++++++------
 arch/arm/mach-omap2/omap_hwmod_common_data.c  |    3 +
 arch/arm/mach-omap2/omap_hwmod_common_data.h  |    1 
 arch/arm/mach-omap2/pm.c                      |   84 ++++++++++++++++
 arch/arm/plat-omap/Makefile                   |    1 
 arch/arm/plat-omap/i2c.c                      |   12 ++
 arch/arm/plat-omap/include/plat/clock.h       |  130 +++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/common.h      |    4 +
 arch/arm/plat-omap/include/plat/omap-pm.h     |  130 +++++++++++++++++++------
 arch/arm/plat-omap/include/plat/omap_device.h |    2 
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |   14 ++-
 arch/arm/plat-omap/omap-pm-noop.c             |   61 +++++++++---
 arch/arm/plat-omap/omap_device.c              |   33 ++++++
 24 files changed, 790 insertions(+), 225 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm.c

