From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 00/13] OMAPDSS: Change way of passing timings from panel driver to interface
Date: Thu, 9 Aug 2012 17:19:36 +0530
Message-ID: <1344512989-4071-1-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59743 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab2HILvR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 07:51:17 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This is a follow up series. The orginal one can be seen here:

http://marc.info/?l=linux-omap&m=134381744304672&w=2

Changes in v2:
- Removed misc fixes out of this set
- Not trying to optimize SDI when setting new timings, using the old strategy
- Added a function for setting size for DSI command mode panels
- Added a fix which ensures the manager sizes is correctly set for rotation in
  command mode panels.

The tree/branch can be found here:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git pass_timings_interface_2

Archit Taneja (13):
  OMAPDSS: DPI: Maintain our own timings field in driver data
  OMAPDSS: DPI displays: Take care of panel timings in the driver
    itself
  OMAPDSS: DSI: Maintain own copy of timings in driver data
  OMAPDSS: DSI: Add function to set panel size for command mode panels
  OMAPDSS: DSI: Update manager timings on a manual update
  OMAPDSS: HDMI: Use our own omap_video_timings field when setting
    interface timings
  OMAPDSS: HDMI: Add a get_timing function for HDMI interface
  OMAPDSS: HDMI: Add locking for hdmi interface get/set timing
    functions
  OMAPDSS: SDI: Create a function to set timings
  OMAPDSS: SDI: Maintain our own timings field in driver data
  OMAPDSS: VENC: Split VENC into interface and panel driver
  OMAPDSS: VENC: Maintain our own timings field in driver data
  OMAPDSS: VENC: Add a get_timing function for VENC interface

 drivers/video/omap2/displays/panel-acx565akm.c     |   13 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |    6 +-
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    2 +
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    2 +
 drivers/video/omap2/displays/panel-picodlp.c       |    3 +
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    2 +
 drivers/video/omap2/displays/panel-taal.c          |   14 ++
 drivers/video/omap2/displays/panel-tfp410.c        |    5 +-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    6 +-
 drivers/video/omap2/dss/Makefile                   |    2 +-
 drivers/video/omap2/dss/dpi.c                      |   12 +-
 drivers/video/omap2/dss/dsi.c                      |   86 +++++---
 drivers/video/omap2/dss/dss.h                      |   17 +-
 drivers/video/omap2/dss/hdmi.c                     |   55 +++--
 drivers/video/omap2/dss/hdmi_panel.c               |   12 +-
 drivers/video/omap2/dss/sdi.c                      |   20 +-
 drivers/video/omap2/dss/venc.c                     |  233 ++++++--------------
 drivers/video/omap2/dss/venc_panel.c               |  231 +++++++++++++++++++
 include/video/omapdss.h                            |    9 +-
 19 files changed, 490 insertions(+), 240 deletions(-)
 create mode 100644 drivers/video/omap2/dss/venc_panel.c

-- 
1.7.9.5

