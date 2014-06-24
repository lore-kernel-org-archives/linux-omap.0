From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/15] OMAPDSS: HDMI infoframe & cleanup
Date: Tue, 24 Jun 2014 13:03:45 +0300
Message-ID: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46980 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbaFXKEI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

This series makes OMAP HDMI drivers use the common infoframe functionality and
makes the drivers get the infoframe from the upper layer, instead of using
hardcoded infoframes.

This allows us to remove quite a bit of ugly code from the drivers.

The downside is that the infoframe functionality is only there for DRM, not for
FB. So when using omapfb, the HDMI output will always use DVI mode, i.e.
without sound support and without the HDMI features like color ranges.
Considering that the HDMI audio hasn't been working for some time, and the
other features were always hardcoded, this doesn't sound like a big issue.

 Tomi

Tomi Valkeinen (15):
  OMAPDSS: DISPC: fix debugfs reg dump
  OMAPDSS: DISPC: reject interlace for lcd out
  OMAPDSS: DISPC: clean up dispc_mgr_timings_ok
  OMAPDSS: HDMI: fix name conflict
  OMAPDSS: Kconfig: select HDMI
  OMAPDSS: HDMI4: use common AVI infoframe support
  OMAPDSS: HDMI5: use common AVI infoframe support
  OMAPDSS: HDMI: remove custom avi infoframe
  OMAPDSS: add hdmi ops to hdmi_ops and omap_dss_driver
  OMAPDSS: add hdmi ops to hdmi-connector and tpd12s015
  OMAPDSS: HDMI: add infoframe and hdmi_dvi_mode fields
  OMAPDSS: HDMI4: add support to set infoframe & HDMI mode
  OMAPDSS: HDMI5: add support to set infoframe & HDMI mode
  OMAPDSS: HDMI: remove the unused code
  drm/omap: Add infoframe & dvi/hdmi mode support

 drivers/gpu/drm/omapdrm/omap_connector.c           |  12 +
 drivers/gpu/drm/omapdrm/omap_drv.h                 |   1 +
 drivers/gpu/drm/omapdrm/omap_encoder.c             |  27 ++
 .../fbdev/omap2/displays-new/connector-hdmi.c      |  19 ++
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |  20 ++
 drivers/video/fbdev/omap2/dss/Kconfig              |   1 +
 drivers/video/fbdev/omap2/dss/dispc.c              |  22 +-
 drivers/video/fbdev/omap2/dss/hdmi.h               | 107 +------
 drivers/video/fbdev/omap2/dss/hdmi4.c              |  47 ++-
 drivers/video/fbdev/omap2/dss/hdmi4_core.c         | 164 ++---------
 drivers/video/fbdev/omap2/dss/hdmi4_core.h         |   1 +
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  47 ++-
 drivers/video/fbdev/omap2/dss/hdmi5_core.c         | 124 ++++----
 drivers/video/fbdev/omap2/dss/hdmi_common.c        | 316 ---------------------
 include/video/omapdss.h                            |   9 +
 15 files changed, 231 insertions(+), 686 deletions(-)

-- 
1.9.1

