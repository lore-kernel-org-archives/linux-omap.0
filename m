From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/4] OMAP2PLUS: DSS2: Clock configuration enhancements and fixes
Date: Tue, 12 Apr 2011 13:52:22 +0530
Message-ID: <1302596546-14888-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45249 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747Ab1DLIRe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Apr 2011 04:17:34 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3C8HXcn028054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 03:17:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Currently, the clock sources for internal DSS clocks are hardcoded in DSS2, this
causes issues when displays want to configure clocks differently, or when there
are multiple displays trying to configure the clock sources for the same clocks.

Move the clock sources to dssdev.clocks struct, and perform cleanup related to
this.

Note: Patches apply over:
https://gitorious.org/linux-omap-dss2/linux/commits/master

Archit Taneja (4):
  OMAP2PLUS: DSS2: Change enum "dss_clk_source" to
    "omap_dss_clk_source"
  OMAP2PLUS: DSS2: Add clock sources to dss device clock configuration
  OMAP: DSS2: HDMI: Use dss_device clock configuration for HDMI PLL
    parameters
  OMAP2PLUS: DSS2: Remove hack config "CONFIG_OMAP2_DSS_USE_DSI_PLL"

 arch/arm/mach-omap2/board-4430sdp.c       |   18 ++++++-
 arch/arm/plat-omap/include/plat/display.h |   24 ++++++++-
 drivers/video/omap2/dss/Kconfig           |    8 ---
 drivers/video/omap2/dss/dispc.c           |   12 ++--
 drivers/video/omap2/dss/dpi.c             |   83 +++++++++++++++--------------
 drivers/video/omap2/dss/dsi.c             |   49 +++++++----------
 drivers/video/omap2/dss/dss.c             |   50 +++++++++---------
 drivers/video/omap2/dss/dss.h             |   23 +++------
 drivers/video/omap2/dss/dss_features.c    |   20 ++++----
 drivers/video/omap2/dss/dss_features.h    |    2 +-
 drivers/video/omap2/dss/hdmi.c            |   27 +++++-----
 11 files changed, 164 insertions(+), 152 deletions(-)

