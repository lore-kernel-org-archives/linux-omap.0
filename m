From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/7] ARM: OMAP: second set of PRM/CM/CGRM cleanup patches for 3.8
Date: Mon, 15 Oct 2012 19:32:03 -0600
Message-ID: <20121016012448.21844.92339.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42848 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab2JPBe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:34:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This series removes the omap_prcm_get_reset_sources() function.  This
was exported from arch/arm/mach-omap2/prcm.c for use by the OMAP
watchdog driver to report the "boot reason".  This series reimplements
this using a platform_data function pointer for the time being, but
after the upcoming PRM/CM drivers are merged, the watchdog driver can be
patched to use an exported function from the drivers.

This series will also be used as a base for other PRM/CM cleanup during the
3.8 time frame, since it adds the prm_register() and prm_unregister() functions.
These are called by SoC-specific PRM IP block drivers to register function
pointers with the PRM subsystem.

This series changes the format of the watchdog's boot reason data to conform
with the watchdog subsystem standard (the WDIOF_* flags).  If users need
more detail than that interface provides, either the watchdog interface can
be patched, or those users can get that information from the upcoming PRM
drivers.


- Paul

---

prcm_cleanup_b_3.8
   text	   data	    bss	    dec	    hex	filename
7519295	 696796	5613996	13830087	 d307c7	vmlinux.omap2plus_defconfig.orig
7520203	 696868	5613996	13831067	 d30b9b	vmlinux.omap2plus_defconfig

Paul Walmsley (7):
      ARM: OMAP2+: PRM: prepare for use of prm_ll_data function pointers
      ARM: OMAP2+: CM: prepare for use of cm_ll_data function pointers
      ARM: OMAP1: create read_reset_sources() function (for initial use by watchdog)
      ARM: OMAP2+: PRM: create PRM reset source API for the watchdog timer driver
      ARM: OMAP2+: WDT: move init; add read_reset_sources pdata function pointer
      watchdog: OMAP: use standard GETBOOTSTATUS interface; use platform_data fn ptr
      ARM: OMAP2+: PRCM: remove omap_prcm_get_reset_sources()


 arch/arm/mach-omap1/common.h                |    2 +
 arch/arm/mach-omap1/devices.c               |   21 ++++++-
 arch/arm/mach-omap1/reset.c                 |   39 +++++++++++++
 arch/arm/mach-omap2/Makefile                |    2 -
 arch/arm/mach-omap2/cm.h                    |   12 ++++
 arch/arm/mach-omap2/cm_common.c             |   71 +++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c               |   26 --------
 arch/arm/mach-omap2/prcm.c                  |   12 ----
 arch/arm/mach-omap2/prm-regbits-24xx.h      |    4 +
 arch/arm/mach-omap2/prm-regbits-34xx.h      |   10 +++
 arch/arm/mach-omap2/prm.h                   |   53 +++++++++++++++++
 arch/arm/mach-omap2/prm2xxx.c               |   68 ++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx.h               |    4 +
 arch/arm/mach-omap2/prm2xxx_3xxx.h          |    2 +
 arch/arm/mach-omap2/prm3xxx.c               |   65 +++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h               |    2 +
 arch/arm/mach-omap2/prm44xx.c               |   83 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm44xx.h               |    2 +
 arch/arm/mach-omap2/prm_common.c            |   78 +++++++++++++++++++++++++
 arch/arm/mach-omap2/wd_timer.c              |   33 +++++++++++
 arch/arm/plat-omap/include/plat/prcm.h      |    1 
 drivers/watchdog/omap_wdt.c                 |   26 ++++----
 include/linux/platform_data/omap-wd-timer.h |   38 ++++++++++++
 23 files changed, 594 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm_common.c
 create mode 100644 include/linux/platform_data/omap-wd-timer.h

