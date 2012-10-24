From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/20] OMAPDSS: Misc cleanups/fixes
Date: Wed, 24 Oct 2012 12:28:51 +0300
Message-ID: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48069 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756319Ab2JXJ30 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Here's another series with miscellaneous omapdss cleanups and fixes. I've made
these during my work with various bigger projects, like using DSI PLL for DVI
and omapdrm cooperation work.

The patches are based on current omapdss master, and can also be found from:

git://gitorious.org/linux-omap-dss2/linux.git 3.8/misc-2

 Tomi

Tomi Valkeinen (20):
  OMAPDSS: remove omap_dss_device's suspend/resume
  OMAPDSS: get the dss version from core pdev
  OMAPDSS: remove dispc_irq_handler declaration
  OMAPDSS: DISPC: fix dispc_mgr_lclk_rate for DIGIT output
  OMAPDSS: remove initial display code from omapdss
  OMAPDSS: DISPC: use dss_feat_get_num_ovls()
  OMAPDSS: DISPC: rename dispc_mgr_enable/disable to _sync
  OMAPDSS: DISPC: make _enable_mgr_out public as "dispc_mgr_enable"
  OMAPDSS: add dispc_ovl_enabled()
  OMAPDSS: DISPC: Add IRQ enable/status helpers
  OMAPDSS: HDMI: split power_on/off to two parts
  OMAPDSS: HDMI: use core power on/off with edid & detect
  OMAPDSS: HDMI: add 1920x1200 video mode
  OMAPDSS: HDMI: make hdmi pclk check more permissive
  OMAPFB: remove use of extended edid block
  OMAPFB: improve mode selection from EDID
  OMAPDSS: fix DSI2 PLL clk names
  OMAPDSS: DISPC: fix loop in error handler
  OMAPDSS: DISPC: remove dssdev depependency from error handler
  OMAPDSS: split hdmi muxing function

 arch/arm/mach-omap2/display.c                      |   15 +-
 drivers/video/omap2/displays/panel-acx565akm.c     |   23 ----
 drivers/video/omap2/displays/panel-generic-dpi.c   |   36 -----
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   34 -----
 drivers/video/omap2/displays/panel-n8x0.c          |   50 -------
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   24 ----
 drivers/video/omap2/displays/panel-picodlp.c       |   44 ------
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   17 ---
 drivers/video/omap2/displays/panel-taal.c          |   72 ----------
 drivers/video/omap2/displays/panel-tfp410.c        |   33 -----
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   20 ---
 drivers/video/omap2/dss/apply.c                    |    6 +-
 drivers/video/omap2/dss/core.c                     |   10 +-
 drivers/video/omap2/dss/dispc.c                    |  143 +++++++++++---------
 drivers/video/omap2/dss/display.c                  |   93 ++-----------
 drivers/video/omap2/dss/dss.c                      |    5 +-
 drivers/video/omap2/dss/dss.h                      |   13 +-
 drivers/video/omap2/dss/hdmi.c                     |  122 ++++++++++++-----
 drivers/video/omap2/dss/hdmi_panel.c               |   78 ++---------
 drivers/video/omap2/dss/venc_panel.c               |   19 ---
 drivers/video/omap2/omapfb/omapfb-main.c           |  101 ++++++++++----
 include/video/omapdss.h                            |    6 +-
 22 files changed, 308 insertions(+), 656 deletions(-)

-- 
1.7.9.5

