From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 00/18] First set of unreviewed patches
Date: Wed, 16 Dec 2009 20:15:45 -0600
Message-ID: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43910 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763896AbZLQCIr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 21:08:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

These patches need to be reviewed to be included into dspbridge-baseline.

v2:
- Added to series, because of priority fix:
	DSPBRIDGE: Fix compile break for WCD debug mask
	DSPBRIDGE: enable smart/autoidle for mailbox sysconfig
- Fixed a bracket missing for else (code style):
	DSPBRIDGE: Enable peripheral clocks on wake up
- Updated commit message for:
	DSPBRIDGE: Implemented Trampoline support for dynamic loader
	DSPBRIDGE: Enable/Disable MCBSP_CLOCKS for MCBSP2
- Dropped for rework:
	DSPBRIDGE: Avoid REGistry if pDevContext is available

Ernest Ramos Falcon (1):
  DSPBRIDGE: check pointer before calling Proc_Detach

Ernesto Ramos Falcon (1):
  DSPBRIDGE: Memory leak in Node Register Notify

Fernando Guzman Lugo (3):
  DSPBRIDGE: Implemented Trampoline support for dynamic loader
  DSPBRIDGE: Enable/Disable MCBSP_CLOCKS for MCBSP2
  DSPBRIDGE: support loading 4 dependent DLL

Hiroshi DOYU (1):
  DSPBRIDGE: enable smart/autoidle for mailbox sysconfig

Omar Ramirez Luna (11):
  DSPBRIDGE: Fix compile break for WCD debug mask
  DSPBRIDGE: set PWRERROR notifications as an option
  DSPBRIDGE: Enable peripheral clocks on wake up
  DSPBRIDGE: Remove long busy-wait loops on PWRST transitions
  DSPBRIDGE: Rename usCount to timeout
  DSPBRIDGE: Trivial cleanup on DBDCD
  DSPBRIDGE: Do not panic on bad page count
  DSPBRIDGE: check the status of DMM_GetHandle
  DSPBRIDGE: KFILE_Seek & KFILE_Tell, u32 replaced with loff_t
  DSPBRIDGE: Delete unused files
  DSPBRIDGE: Compilation fixes 2.6.31

Rebecca Schultz Zavin (1):
  DSPBRIDGE: Remove preproessor condition that could never work

 arch/arm/mach-omap2/dspbridge.c                |    2 +
 arch/arm/plat-omap/include/dspbridge/dbl.h     |  354 ------
 arch/arm/plat-omap/include/dspbridge/dbof.h    |  117 --
 drivers/dsp/bridge/Kconfig                     |   11 +
 drivers/dsp/bridge/Makefile                    |    3 +-
 drivers/dsp/bridge/dynload/cload.c             |  148 ++-
 drivers/dsp/bridge/dynload/dlclasses_hdr.h     |   41 -
 drivers/dsp/bridge/dynload/dload_internal.h    |  125 +++-
 drivers/dsp/bridge/dynload/reloc.c             |   81 ++-
 drivers/dsp/bridge/dynload/tramp.c             | 1110 +++++++++++++++++++
 drivers/dsp/bridge/dynload/tramp_table_c6000.c |  164 +++
 drivers/dsp/bridge/hw/hw_mbox.c                |   14 +-
 drivers/dsp/bridge/hw/hw_mbox.h                |   22 +
 drivers/dsp/bridge/pmgr/cod.c                  |    4 +-
 drivers/dsp/bridge/pmgr/dbl.c                  | 1385 ------------------------
 drivers/dsp/bridge/pmgr/wcd.c                  |   85 +-
 drivers/dsp/bridge/rmgr/dbdcd.c                |  345 +++---
 drivers/dsp/bridge/rmgr/drv_interface.c        |   11 +-
 drivers/dsp/bridge/rmgr/proc.c                 |   20 +-
 drivers/dsp/bridge/wmd/_tiomap_util.h          |    6 +
 drivers/dsp/bridge/wmd/io_sm.c                 |    1 +
 drivers/dsp/bridge/wmd/tiomap3430.c            |   18 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |  110 ++-
 drivers/dsp/bridge/wmd/tiomap_sm.c             |    3 +
 drivers/dsp/bridge/wmd/ue_deh.c                |    2 +
 25 files changed, 1982 insertions(+), 2200 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/dbl.h
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/dbof.h
 delete mode 100644 drivers/dsp/bridge/dynload/dlclasses_hdr.h
 create mode 100644 drivers/dsp/bridge/dynload/tramp.c
 create mode 100644 drivers/dsp/bridge/dynload/tramp_table_c6000.c
 delete mode 100644 drivers/dsp/bridge/pmgr/dbl.c

