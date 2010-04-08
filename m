From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 00/19] generic clk module removal
Date: Thu,  8 Apr 2010 18:15:49 -0500
Message-ID: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933801Ab0DHW73 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This set of patches remove clk module from the services layer.

Now:
- GPT 5-8 are controlled through DM Timer framework.
- MCBSP clocks are enabled by requesting the proper mcbsp device.
- WDT is left for bridge driver to control rather than on request from dsp.
- SSI is controlled by enabling/disabling its sst, ssr and ick clocks.

Omar Ramirez Luna (19):
  DSPBRIDGE: rename generic clk_handle for iva2_clk
  DSPBRIDGE: remove iva2 clk control from custom framework
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
  DSPBRIDGE: ssi clock fixes
  DSPBRIDGE: use one call for both ick and fck clocks
  DSPBRIDGE: Move MCBSP_CLOCKS code to a common place
  DSPBRIDGE: Balance the number of enable/disable
  DSPBRIDGE: move clk to dsp-clock
  DSPBRIDGE: reorganize the code to handle peripheral clocks

 arch/arm/plat-omap/include/dspbridge/clk.h |  123 ++--------
 drivers/dsp/bridge/Makefile                |    4 +-
 drivers/dsp/bridge/rmgr/drv_interface.c    |   42 +++-
 drivers/dsp/bridge/services/clk.c          |  326 ---------------------------
 drivers/dsp/bridge/services/services.c     |    9 +-
 drivers/dsp/bridge/wmd/_tiomap.h           |   25 +-
 drivers/dsp/bridge/wmd/_tiomap_pwr.h       |   17 --
 drivers/dsp/bridge/wmd/dsp-clock.c         |  330 ++++++++++++++++++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430.c        |   67 +------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |  138 +-----------
 drivers/dsp/bridge/wmd/tiomap_io.c         |    4 +-
 drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
 12 files changed, 414 insertions(+), 673 deletions(-)
 delete mode 100644 drivers/dsp/bridge/services/clk.c
 create mode 100644 drivers/dsp/bridge/wmd/dsp-clock.c

