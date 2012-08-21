From: Archit Taneja <archit@ti.com>
Subject: [PATCH 00/23] OMAPDSS: Create output entities
Date: Tue, 21 Aug 2012 11:28:07 +0530
Message-ID: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57117 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab2HUGAK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:00:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

Create a new entity in OMAPDSS called outputs. These represent the
interfaces/outputs like DSI, HDMI etc. that a panel connects to. An output
sits in between an overlay manager and a panel. More details about outputs
are explained in the first patch of the series.

This series adds omap_dss_output as an entity along with omap_overlay,
omap_overlay_manager and omap_dss_device. It changes the code to establish
links between managers and outputs, and outputs and devices. The rest of the
patches replace omap_dss_device with omap_dss_output as the argument exposed
by interface driver functions(DSI, HDMI etc) for panel drivers.

Reference tree:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 2-add-outputs

Archit Taneja (23):
  OMAPDSS: outputs: Create a new entity called outputs
  OMAPDSS: outputs: Create and initialize output instances
  OMAPDSS: output: Add set/unset device ops for omap_dss_output
  OMAPDSS: APPLY: Add manager set/unset output ops for
    omap_overlay_manager
  OMAPDSS: Remove manager->device references
  OMAP_VOUT: Remove manager->device references
  OMAPFB: remove manager->device references
  OMAPDRM: Remove manager->device references
  OMAPDSS: Create links between managers, outputs and devices
  OMAPDSS: DPI: Pass outputs from panel driver to DPI interface driver
  OMAPDSS: DSI: Remove dsi_pdev_map global struct
  OMAPDSS: DSI: Pass outputs from panel driver to DSI interface driver
  OMAPDSS: SDI: Pass outputs from panel driver to SDI interface driver
  OMAPDSS: RFBI: Pass outputs from panel driver to RFBI interface
    driver
  OMAPDSS: RFBI: Add output pointers as arguments to all exported
    functions
  OMAPDSS: VENC: Pass outputs from panel driver to VENC interface
    driver
  OMAPDSS: HDMI: Pass outputs from panel driver to HDMI interface
    driver
  OMAPDSS: HDMI: Add output pointers as arguments to all functions used
    by hdmi panel driver
  OMAPDSS/OMAPFB: Change dssdev->manager references
  OMAPDSS: MANAGER: Update display sysfs store
  OMAPDSS: MANAGER: Get device via output
  OMAPDSS: APPLY: Remove omap_dss_device references from
    dss_ovl_enable/disable
  OMAPDSS: Remove old way of setting manager and device links

 drivers/media/video/omap/omap_vout.c               |   81 ++++--
 drivers/staging/omapdrm/omap_drv.c                 |    5 +-
 drivers/video/omap2/displays/panel-acx565akm.c     |   22 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |   27 +-
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   16 +-
 drivers/video/omap2/displays/panel-n8x0.c          |  114 +++++---
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   15 +-
 drivers/video/omap2/displays/panel-picodlp.c       |   15 +-
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   16 +-
 drivers/video/omap2/displays/panel-taal.c          |  201 ++++++++-----
 drivers/video/omap2/displays/panel-tfp410.c        |   17 +-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   29 +-
 drivers/video/omap2/dss/Makefile                   |    2 +-
 drivers/video/omap2/dss/apply.c                    |   52 ++--
 drivers/video/omap2/dss/core.c                     |    1 +
 drivers/video/omap2/dss/dispc.c                    |   10 +-
 drivers/video/omap2/dss/display.c                  |   11 +-
 drivers/video/omap2/dss/dpi.c                      |   84 ++++--
 drivers/video/omap2/dss/dsi.c                      |  307 +++++++++++---------
 drivers/video/omap2/dss/dss.h                      |   50 ++--
 drivers/video/omap2/dss/dss_features.c             |   52 ++++
 drivers/video/omap2/dss/dss_features.h             |    1 +
 drivers/video/omap2/dss/hdmi.c                     |   84 ++++--
 drivers/video/omap2/dss/hdmi_panel.c               |   85 ++++--
 drivers/video/omap2/dss/manager.c                  |   48 ++-
 drivers/video/omap2/dss/output.c                   |  125 ++++++++
 drivers/video/omap2/dss/overlay.c                  |   96 +++---
 drivers/video/omap2/dss/rfbi.c                     |   77 +++--
 drivers/video/omap2/dss/sdi.c                      |   54 ++--
 drivers/video/omap2/dss/venc.c                     |   78 +++--
 drivers/video/omap2/dss/venc_panel.c               |   53 +++-
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |    4 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |    7 +-
 drivers/video/omap2/omapfb/omapfb.h                |    5 +-
 include/video/omapdss.h                            |  172 ++++++-----
 35 files changed, 1350 insertions(+), 666 deletions(-)
 create mode 100644 drivers/video/omap2/dss/output.c

-- 
1.7.9.5

