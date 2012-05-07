From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/6] OMAPDSS: Misc fixes and cleanups
Date: Mon, 7 May 2012 16:51:30 +0530
Message-ID: <1336389696-21636-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58533 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755567Ab2EGLWU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 07:22:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The first patch in this series is a follow up on the previously posted series
'OMAPDSS: APPLY: Treat overlay manager timings as shadow registers'. It is
required for HDMI and DPI interfaces to work properly, it ensures manager
timings are applied in the set_timing() ops for these interfaces.

The next 3 patches remove some unnecessary usage of omap_dss_device pointer in
DISPC and APPLY.

The last 2 patches are miscellaneous fixes and are self explanatory.

Reference tree containing this series:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git mgr_timing_and_fixes

Tested on OMAP4 SDP.

Archit Taneja (6):
  OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disabled
  OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
  OMAPDSS: DISPC: Remove omap_dss_device pointer usage from
    dispc_mgr_pclk_rate()
  OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()
  OMAPDSS: Fix DSI_FCLK clock source selection
  OMAPDSS: DISPC: Remove Fake VSYNC support

 drivers/video/omap2/dss/Kconfig |    9 ------
 drivers/video/omap2/dss/apply.c |    3 --
 drivers/video/omap2/dss/dispc.c |   61 +++++++++++++-------------------------
 drivers/video/omap2/dss/dpi.c   |    2 +
 drivers/video/omap2/dss/dsi.c   |    4 --
 drivers/video/omap2/dss/dss.c   |    5 ++-
 drivers/video/omap2/dss/dss.h   |    1 -
 drivers/video/omap2/dss/hdmi.c  |    2 +
 8 files changed, 28 insertions(+), 59 deletions(-)

-- 
1.7.5.4

