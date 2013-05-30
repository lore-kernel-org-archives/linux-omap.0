From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/32] OMAPDSS: dss-dev-model "base" (Part 1/2)
Date: Thu, 30 May 2013 12:34:21 +0300
Message-ID: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49785 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968001Ab3E3JfV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Here's are the first sets of patches targeting towards enabling DT for DSS and
changing the DSS device model to be more versatile. The exact division of the
sets of patches is still a bit open, and some splitting up for arch/driver
changes is needed, but most likely there will be at least the following major
sets, each based on the former one:

- base, containing cleanups and changes that do not yet really bring bigger new
  features
- dev-model, implements the new DSS device model, including new panel drivers
- dt, adds DSS DT support (not at all ready yet, although works for a few boards)

The patches can be found from the following branches:

git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model-base
git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model
git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model-dt

The set you are looking at is the "base" set.

The "base" set shouldn't change anything from the user's point of view. It
contains patches that do not make much sense until "dev-model" and "dt" are
merged, but those patches should not cause any problems either. Most likely the
"base" set is quite stable, I don't expect any changes to it.

 Tomi


Tomi Valkeinen (32):
  OMAPDSS: add pdata->default_display_name
  OMAPDSS: only probe pdata if there's one
  OMAPDSS: add omap_dss_find_output()
  OMAPDSS: add omap_dss_find_output_by_node()
  OMAPDSS: fix dss_get_ctx_loss_count for DT
  OMAPDSS: DPI: fix regulators for DT
  OMAPDSS: SDI: fix regulators for DT
  OMAPDSS: clean up dss_[ovl|mgr]_get_device()
  OMAPDSS: add helpers to get mgr or output from display
  OMAPDSS: split overlay manager creation
  OMAPDRM: fix overlay manager handling
  OMAPDSS: Implement display (dis)connect support
  OMAPDSS: CORE: use devm_regulator_get
  OMAPDSS: DSI: cleanup regulator init
  OMAPDSS: DPI: cleanup pll & regulator init
  OMAPDSS: HDMI: add hdmi_init_regulator
  OMAPDSS: SDI: clean up regulator init
  OMAPDSS: VENC: clean up regulator init
  OMAPDSS: add videomode conversion support
  OMAPDSS: remove dssdev uses in trivial cases
  OMAPDSS: add panel list
  OMAPDSS: use the panel list in omap_dss_get_next_device
  OMAPDSS: don't use dss bus in suspend/resume
  OMAPDSS: implement display sysfs without dss bus
  OMAPDSS: Add panel dev pointer to dssdev
  OMAPDSS: remove omap_dss_start/stop_device()
  OMAPDSS: combine omap_dss_output into omap_dss_device
  OMAPDSS: omapdss.h: add owner field to omap_dss_device
  OMAPDSS: add module_get/put to omap_dss_get/put_device()
  OMAPDSS: add THIS_MODULE owner to DSS outputs
  OMAPDSS: output: increase refcount in find_output funcs
  OMAPFB: use EPROBE_DEFER if default display is not present

 drivers/gpu/drm/omapdrm/omap_crtc.c                |  46 +++-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |  21 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |   1 +
 drivers/video/omap2/displays/panel-acx565akm.c     |  16 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |  26 +--
 .../omap2/displays/panel-lgphilips-lb035q02.c      |  10 +-
 drivers/video/omap2/displays/panel-n8x0.c          |  30 +--
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   4 +-
 drivers/video/omap2/displays/panel-picodlp.c       |  32 +--
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |  10 +-
 drivers/video/omap2/displays/panel-taal.c          | 164 +++++++-------
 drivers/video/omap2/displays/panel-tfp410.c        |  32 +--
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |  36 +--
 drivers/video/omap2/dss/Kconfig                    |   1 +
 drivers/video/omap2/dss/apply.c                    |  47 ++--
 drivers/video/omap2/dss/core.c                     | 108 +++++----
 drivers/video/omap2/dss/dispc.c                    |   4 +
 drivers/video/omap2/dss/display-sysfs.c            | 154 +++++++------
 drivers/video/omap2/dss/display.c                  | 246 ++++++++++++++-------
 drivers/video/omap2/dss/dpi.c                      | 140 ++++++------
 drivers/video/omap2/dss/dsi.c                      | 124 ++++-------
 drivers/video/omap2/dss/dss.c                      |   3 +-
 drivers/video/omap2/dss/dss.h                      |  16 +-
 drivers/video/omap2/dss/hdmi.c                     |  87 ++++----
 drivers/video/omap2/dss/manager-sysfs.c            |  47 ++--
 drivers/video/omap2/dss/manager.c                  |  29 ++-
 drivers/video/omap2/dss/output.c                   |  78 ++++++-
 drivers/video/omap2/dss/rfbi.c                     |  39 ++--
 drivers/video/omap2/dss/sdi.c                      |  78 ++++---
 drivers/video/omap2/dss/venc.c                     |  74 +++----
 drivers/video/omap2/dss/venc_panel.c               |  16 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |   9 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |  27 +--
 include/video/omapdss.h                            | 103 ++++++---
 34 files changed, 1088 insertions(+), 770 deletions(-)

-- 
1.8.1.2

