From: Archit Taneja <archit@ti.com>
Subject: [PATCH 00/17] OMAPDSS: Misc DSS clean ups
Date: Tue, 26 Jun 2012 15:06:36 +0530
Message-ID: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43200 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547Ab2FZJiH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:38:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This series does the following things:

- Remove passive matrix LCD support: There are no panel drivers with passive
  matrix LCD drivers in DSS2. There are no passive matrix panels even available
  to test with DSS. Since no one is using passive matrix panels, stop trying to
  support it. It cleans up the DSS driver.

- Add some new fields to omap_video_timings: There were some standard panel
  timing fields missing from omap_video_timings. Namely Hsync/Vsync/DE levels
  and interlace. Add these to omap_video_timings to align it more with xorg
  modeline. Add some other OMAP DSS specific fields to omap_video_timings.

- Remove some hacks done because omap_video_timings didn't have the above
  fields.

A branch with the patch set:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git dss_cleanup

This tree is based on:

git://gitorious.org/linux-omap-dss2/linux.git work/dss-rework-base

Tested on 3430sdp, 4430spd, Pandaboard ES.

Archit Taneja (17):
  OMAPDSS: Remove passive matrix LCD support (part 1)
  OMAPDSS: Remove passive matrix LCD support (part 2)
  OMAPDSS: Remove passive matrix LCD support (part 3)
  OMAPDSS: Remove passive matrix LCD support (part 4)
  OMAPDSS: Add some new fields to omap_video_timings
  OMAPDSS: DISPLAY: Ignore newly added omap_video_timings fields for
    display timings sysfs file
  OMAPDSS: DISPC: Configure newly added omap_video_timing fields
  OMAPDSS: DISPC: Remove dispc_mgr_set_pol_freq()
  OMAPFB: Map the newly added omap_video_timings fields with fb sync
    flags
  OMAPDRM: Map the newly added omap_video_timings fields with drm mode
    flags
  OMAPDSS: Remove omap_panel_config enum from omap_dss_device
  OMAPDSS: Add interlace parameter to omap_video_timings
  OMAPDSS: DISPC/APPLY: Use interlace info in manager timings for
    dispc_ovl_setup()
  OMAPFB: Map interlace field in omap_video_timings with fb vmode flags
  OMAPDRM: Map interlace field in omap_video_timings with drm mode
    flags
  OMAPDSS: HDMI: Remove custom hdmi_video_timings struct
  OMAPDSS: DSI: Remove redundant fields in omap_dss_dsi_videomode_data

 drivers/staging/omapdrm/omap_connector.c           |   27 ++-
 drivers/video/omap2/displays/panel-acx565akm.c     |    6 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |  118 +++++-----
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    5 +-
 drivers/video/omap2/displays/panel-n8x0.c          |    1 -
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    7 +-
 drivers/video/omap2/displays/panel-picodlp.c       |    7 +-
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    6 +-
 drivers/video/omap2/displays/panel-taal.c          |    1 -
 drivers/video/omap2/displays/panel-tfp410.c        |    1 -
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    6 +-
 drivers/video/omap2/dss/apply.c                    |    6 +-
 drivers/video/omap2/dss/dispc.c                    |  114 ++++-----
 drivers/video/omap2/dss/display.c                  |    6 +-
 drivers/video/omap2/dss/dpi.c                      |   39 ++--
 drivers/video/omap2/dss/dsi.c                      |   28 ++-
 drivers/video/omap2/dss/dss.c                      |    7 +-
 drivers/video/omap2/dss/dss.h                      |   17 +-
 drivers/video/omap2/dss/hdmi.c                     |  241 +++++++++++++++++---
 drivers/video/omap2/dss/hdmi_panel.c               |    8 +-
 drivers/video/omap2/dss/rfbi.c                     |    3 +-
 drivers/video/omap2/dss/sdi.c                      |   11 +-
 drivers/video/omap2/dss/ti_hdmi.h                  |   19 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c          |    8 +-
 drivers/video/omap2/dss/venc.c                     |    4 +
 drivers/video/omap2/omapfb/omapfb-main.c           |   32 ++-
 include/video/omapdss.h                            |   55 +++--
 27 files changed, 474 insertions(+), 309 deletions(-)

-- 
1.7.9.5

