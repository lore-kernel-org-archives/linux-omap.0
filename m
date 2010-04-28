From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] generic clk module removal
Date: Tue, 27 Apr 2010 20:29:08 -0500
Message-ID: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44927 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295Ab0D1BYa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:24:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This set of patches remove clk module from the services layer.

Now:
- GPT 5-8 are controlled through DM Timer framework.
- MCBSP clocks are enabled by requesting the proper mcbsp device.
- WDT is left for bridge driver to control rather than on request from dsp.
- SSI is controlled by enabling/disabling its sst, ssr and ick clocks.

v2:
- rebased
- keep iva2 handling as it is advised to turn off the clocks for iva reset
  sources.
- release all the clocks (disable & free) if driver is uninstalled.


Omar Ramirez Luna (5):
  DSPBRIDGE: iva2 clock handling
  DSPBRIDGE: dsp interface to enable ssi clocks
  DSPBRIDGE: Balance the number of enable/disable
  DSPBRIDGE: move clk to dsp-clock
  DSPBRIDGE: reorganize the code to handle peripheral clocks
  DSPBRIDGE: remove clk_handle from drv interface
  DSPBRIDGE: fail if clk handle is NULL
  DSPBRIDGE: Now actually fail if a clk handle is wrong
  DSPBRIDGE: Rename services_clk_* to dsp_clk_*
  DSPBRIDGE: remove unused clock sys_ck
  DSPBRIDGE: remove function clk_set32k_hz
  DSPBRIDGE: remove clk_get_use_cnt
  DSPBRIDGE: trivial clock cleanup for unused code
  DSPBRIDGE: function to get the type of clock requested by dsp
  DSPBRIDGE: use dm timer framework for gpt timers
  DSPBRIDGE: use omap mcbsp to enable mcbsp clocks
  DSPBRIDGE: remove wdt3 from dsp control
  DSPBRIDGE: use one call for both ick and fck clocks
  DSPBRIDGE: Move MCBSP_CLOCKS code to a common place

 arch/arm/plat-omap/include/dspbridge/clk.h |  103 ++------
 drivers/dsp/bridge/Makefile                |    4 +-
 drivers/dsp/bridge/rmgr/drv_interface.c    |   12 +-
 drivers/dsp/bridge/services/clk.c          |  323 ------------------------
 drivers/dsp/bridge/services/services.c     |   10 +-
 drivers/dsp/bridge/wmd/_tiomap.h           |   25 +-
 drivers/dsp/bridge/wmd/_tiomap_pwr.h       |   17 --
 drivers/dsp/bridge/wmd/dsp-clock.c         |  377 ++++++++++++++++++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430.c        |   62 +-----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |  147 +----------
 drivers/dsp/bridge/wmd/tiomap_io.c         |    4 +-
 drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
 12 files changed, 440 insertions(+), 646 deletions(-)
 delete mode 100644 drivers/dsp/bridge/services/clk.c
 create mode 100644 drivers/dsp/bridge/wmd/dsp-clock.c

