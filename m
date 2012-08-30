From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 00/23] OMAPDSS: Create output entities
Date: Thu, 30 Aug 2012 17:10:22 +0530
Message-ID: <1346326845-16583-1-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57616 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab2H3LmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 07:42:25 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a new entity in OMAPDSS called outputs. These represent the
interfaces/outputs like DSI, HDMI etc. that a panel connects to. An output
sits in between an overlay manager and a panel. More details about outputs
are explained in the first patch of the series.

This series adds omap_dss_output as an entity along with omap_overlay,
omap_overlay_manager and omap_dss_device. It changes the code to establish
links between managers and outputs, and outputs and devices.

Changes since v1:
- Output drivers private data structs hold the output struct rather than
  output.c allocating it. This struct is added to a list when
  dss_register_output()is called.
- Outputs are not passed from panel driver to output driver anymore. We are
  sticking to passing omap_dss_device for now till we get a clearer picture on
  how common panel framework turns out. Outputs are still used within the output
  driver, rather than passing dssdev everywhere.

Reference tree:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 2-add-outputs

Archit Taneja (23):
  OMAPDSS: outputs: Create a new entity called outputs
  OMAPDSS: outputs: Create and register output instances
  OMAPDSS: output: Add set/unset device ops for omap_dss_output
  OMAPDSS: APPLY: Add manager set/unset output ops for
    omap_overlay_manager
  OMAPDSS: Remove manager->device references
  OMAP_VOUT: Remove manager->device references
  OMAPFB: remove manager->device references
  OMAPDRM: Remove manager->device references
  OMAPDSS: Create links between managers, outputs and devices
  OMAPDSS: DPI: Pass omap_dss_output within the driver
  OMAPDSS: DSI: Remove dsi_pdev_map global struct
  OMAPDSS: DSI: Pass omap_dss_output within the driver
  OMAPDSS: SDI: Pass omap_dss_output within the driver
  OMAPDSS: RFBI: Pass omap_dss_output within the driver
  OMAPDSS: RFBI: Add dssdev pointers as arguments to all exported
    functions
  OMAPDSS: VENC: Pass omap_dss_output within the driver
  OMAPDSS: HDMI: Pass omap_dss_output within the driver
  OMAPDSS: HDMI: Add dssdev pointer as an argument to all functions
    used by hdmi panel driver
  OMAPDSS/OMAPFB: Change dssdev->manager references
  OMAPDSS: MANAGER: Update display sysfs store
  OMAPDSS: MANAGER: Get device via output
  OMAPDSS: APPLY: Remove omap_dss_device references from
    dss_ovl_enable/disable
  OMAPDSS: Remove old way of setting manager and device links

 drivers/media/video/omap/omap_vout.c      |   81 +++++++---
 drivers/staging/omapdrm/omap_drv.c        |    5 +-
 drivers/video/omap2/displays/panel-n8x0.c |   55 ++++---
 drivers/video/omap2/dss/Makefile          |    2 +-
 drivers/video/omap2/dss/apply.c           |   52 +++---
 drivers/video/omap2/dss/dispc.c           |   10 +-
 drivers/video/omap2/dss/display.c         |   11 +-
 drivers/video/omap2/dss/dpi.c             |   70 +++++---
 drivers/video/omap2/dss/dsi.c             |  249 ++++++++++++++++++-----------
 drivers/video/omap2/dss/dss.h             |   23 ++-
 drivers/video/omap2/dss/dss_features.c    |   52 ++++++
 drivers/video/omap2/dss/dss_features.h    |    1 +
 drivers/video/omap2/dss/hdmi.c            |   72 ++++++---
 drivers/video/omap2/dss/hdmi_panel.c      |   20 +--
 drivers/video/omap2/dss/manager.c         |   48 ++++--
 drivers/video/omap2/dss/output.c          |  110 +++++++++++++
 drivers/video/omap2/dss/overlay.c         |   96 ++++++-----
 drivers/video/omap2/dss/rfbi.c            |   66 +++++---
 drivers/video/omap2/dss/sdi.c             |   35 ++--
 drivers/video/omap2/dss/venc.c            |   47 ++++--
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    7 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |    7 +-
 drivers/video/omap2/omapfb/omapfb.h       |    5 +-
 include/video/omapdss.h                   |   72 +++++++--
 24 files changed, 848 insertions(+), 348 deletions(-)
 create mode 100644 drivers/video/omap2/dss/output.c

-- 
1.7.9.5

