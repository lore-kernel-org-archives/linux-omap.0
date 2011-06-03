From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/27] OMAP DSS runtime PM adaptation
Date: Fri,  3 Jun 2011 13:00:10 +0300
Message-ID: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:56789 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752215Ab1FCKBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This patch set implements runtime PM adaptation for OMAP DSS driver.

The bulk of the code is in the "OMAP: DSS2: Use PM runtime & HWMOD support"
patch, which is a bit too large for comfort, but I haven't found out ways to
split it up.

All DSS HW modules now handle enabling and disabling of the HW block
independently via pm_runtime calls. Some DSS modules also require other DSS
modules, and for that we have functions like dispc_runtime_get/put() which can
be used to enable that module.

Due to DSS' peculiar clock setup the code is not as elegant as I'd like. The
problem is that on OMAP4 we have to enable an optional clock before calling
pm_runtime_get(), and similarly we need to keep the optional clock enabled
until after pm_runtime_put() has been called.

This causes some extra complications. For example, we can't use runtime_resume
callback to enable the opt clocks, as they are required before calling
pm_runtime_get().

Previously DSS driver did reset the HW every time before taking it into use.
This can no longer be done, as HWMOD framework handles the reset. While the
driver works without resetting the HW, an error could render the HW inoperable
and currently the driver may not be able to recover. So these patches may make
the driver more unreliable on error cases.

If a way to reset the HWMOD is added to the HWMOD framework, DSS driver can
take it into use and the above mentioned problem should go away.

Tested on OMAP4 Blaze, OMAP3 Overo, OMAP2420 N800. (However, N800 needs extra
patches to get it and DSS2 running, can be found from n800 branch in my tree).

These patches can be found from:

git://gitorious.org/linux-omap-dss2/linux.git pmruntime

 Tomi

Tomi Valkeinen (27):
  OMAP: change get_context_loss_count ret value to int
  OMAP: DSS2: Taal: Make driver more fault tolerant
  OMAP: DSS2: Reset LANEx_ULPS_SIG2 bits after use
  OMAP: DSS2: Handle dpll4_m4_ck in dss_get/put_clocks
  OMAP: DSS2: Clean up probe for DSS & DSI
  OMAP: DSS2: Init dispc first before other components
  OMAP: DSS2: Remove clk optimization at dss init
  OMAP: DSS2: rewrite use of context_loss_count
  OMAP: DSS2: Use omap_pm_get_dev_context_loss_count to get ctx loss
    count
  OMAP: DSS2: DPI: remove unneeded SYSCK enable/disable
  OMAP: DSS2: Add FEAT_VENC_REQUIRES_TV_DAC_CLK
  OMAP: DSS2: Add new FEAT definitions for features missing from OMAP2
  OMAP: DSS2: Remove core_dump_clocks
  OMAP: DSS2: Remove CONFIG_OMAP2_DSS_SLEEP_BEFORE_RESET
  OMAP4: HWMOD: Modify DSS opt clocks
  OMAP3: HWMOD: Add DSS opt clocks
  OMAP2420: HWMOD: Add DSS opt clocks
  OMAP2430: HWMOD: Add DSS opt clocks
  OMAP: DSS2: Use PM runtime & HWMOD support
  OMAP4: HWMOD: Remove unneeded DSS opt clocks
  OMAP: DSS2: Remove unused opt_clock_available
  OMAP: DSS2: DISPC: remove finegrained clk enables/disables
  OMAP: DSS2: Remove unused code from display.c
  OMAP: DSS2: Remove ctx loss count from dss.c
  OMAP4: CLKDEV: Remove omapdss clock aliases
  OMAP: DSS2: DISPC: Fix context save/restore
  OMAP: DSS2: DSS: Fix context save/restore

 arch/arm/mach-omap2/clock44xx_data.c          |   10 +-
 arch/arm/mach-omap2/display.c                 |   26 +-
 arch/arm/mach-omap2/omap_hwmod.c              |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |   19 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |   19 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   37 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |   43 ++-
 arch/arm/mach-omap2/powerdomain.c             |   14 +-
 arch/arm/mach-omap2/powerdomain.h             |    2 +-
 arch/arm/plat-omap/include/plat/omap-pm.h     |    4 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |   24 +-
 arch/arm/plat-omap/omap_device.c              |    2 +-
 drivers/video/omap2/displays/panel-taal.c     |   33 +-
 drivers/video/omap2/dss/Kconfig               |   12 -
 drivers/video/omap2/dss/core.c                |   15 +-
 drivers/video/omap2/dss/dispc.c               |  496 ++++++++++++----------
 drivers/video/omap2/dss/dpi.c                 |   73 ++--
 drivers/video/omap2/dss/dsi.c                 |  284 ++++++++-----
 drivers/video/omap2/dss/dss.c                 |  564 ++++++-------------------
 drivers/video/omap2/dss/dss.h                 |   34 +-
 drivers/video/omap2/dss/dss_features.c        |   13 +-
 drivers/video/omap2/dss/dss_features.h        |    4 +
 drivers/video/omap2/dss/hdmi.c                |  149 +++++--
 drivers/video/omap2/dss/manager.c             |    8 +-
 drivers/video/omap2/dss/overlay.c             |   27 +-
 drivers/video/omap2/dss/rfbi.c                |   97 ++++-
 drivers/video/omap2/dss/sdi.c                 |   40 ++-
 drivers/video/omap2/dss/venc.c                |  171 +++++++-
 include/video/omapdss.h                       |    4 +-
 31 files changed, 1207 insertions(+), 1023 deletions(-)

-- 
1.7.4.1

