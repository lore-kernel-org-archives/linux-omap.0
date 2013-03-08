From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/20] OMAPDSS: misc improvements
Date: Fri, 8 Mar 2013 13:51:35 +0200
Message-ID: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33506 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809Ab3CHLwH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Here are a bunch of misc patches, created when working on improving DSS device
model. Most notable is the recommended_channel stuff, which removes the need to
pass LCD channel from the board file, which has been rather problematic.

Two of the patches are marked LATER, as they affect the board files. They're
pure cleanups, and can be sent after the rest are merged.

 Tomi

Tomi Valkeinen (20):
  OMAPDSS: DSI: remove DSI & DISPC clk divisors from dssdev
  OMAPDSS: HDMI: remove HDMI clk divisors from dssdev
  OMAPDSS: DPI: remove omap_dss_device uses
  OMAPDSS: DSI: remove omap_dss_device uses
  OMAPDSS: Taal: remove multi-panel support
  OMAPDSS: APPLY: remove dssdev from dss_mgr_wait_for_vsync
  OMAPDSS: add missing export for omap_dss_get_output()
  OMAPDSS: HDMI: init output earlier
  OMAPDSS: add output->name
  OMAPDSS: Resolve channels for outputs
  OMAPDSS: add output->recommended_channel
  OMAPDSS: DPI: use output->recommended_channel
  OMAPFB: use output->recommended_channel
  OMAPDSS: remove dssdev->channel assignments
  OMAP: dss-common.c: remove uses of dss channel (LATER)
  OMAPDSS: omapdss.h: remove channel field from omap_dss_device (LATER)
  OMAPDSS: add pdata->default_display_name
  OMAPDSS: DSI: delay dispc initialization
  OMAPDSS: DSI: fix DSI channel source initialization
  OMAPDSS: Taal: remove rotate & mirror support

 arch/arm/mach-omap2/dss-common.c          |    6 -
 drivers/video/omap2/displays/panel-taal.c |  279 ++---------------------------
 drivers/video/omap2/dss/apply.c           |   15 +-
 drivers/video/omap2/dss/core.c            |    2 +
 drivers/video/omap2/dss/dpi.c             |   74 +++++---
 drivers/video/omap2/dss/dsi.c             |  219 +++++++++++++---------
 drivers/video/omap2/dss/hdmi.c            |   19 +-
 drivers/video/omap2/dss/output.c          |    1 +
 drivers/video/omap2/dss/rfbi.c            |    2 +
 drivers/video/omap2/dss/sdi.c             |    2 +
 drivers/video/omap2/dss/venc.c            |    4 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |    2 +-
 include/video/omapdss.h                   |   38 +---
 13 files changed, 235 insertions(+), 428 deletions(-)

-- 
1.7.10.4

