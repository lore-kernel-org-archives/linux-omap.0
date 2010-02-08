From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 00/13] OMAP DSS2 patches
Date: Mon,  8 Feb 2010 17:55:59 +0200
Message-ID: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64910 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab0BHPxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:53:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Here are some smallish patches for DSS2 for review. Some fixes, couple of new
ioctls, and DSI changes.

They can also be found from
http://gitorious.org/linux-omap-dss2/linux master branch

Aaro Koskinen (1):
  OMAP: DSS: Taal: fix error returns in taal_probe()

Tomi Valkeinen (12):
  OMAP: DSS2: enable VDDS_DSI when using DPI
  OMAP: 3430SDP: remove vdvi regulator
  OMAP: DSS2: OMAPFB: implement OMAPFB_RESERVE_BUFFER
  OMAP: DSS2: OMAPFB: implement OMAPFB_GET_DISPLAY_INFO
  OMAP: DSS2: fix irq-stats compilation
  OMAP: DSS2: OMAPFB: Add omapfb_update_window prototype
  OMAP: DSS2: improve DSS clk src selection
  OMAP: DSS2: DSI: add dsi_bus_is_locked()
  OMAP: DSS2: DSI: add helpers for DCS read/write
  OMAP: DSS2: DSI: export dsi_vc_enable_hs()
  OMAP: DSS2: DSI: configure all DSI VCs
  OMAP: DSS2: DSI: remove dsi_vc_print_status()

 arch/arm/mach-omap2/board-3430sdp.c                |    4 -
 arch/arm/plat-omap/include/plat/display.h          |    5 +
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   35 ------
 drivers/video/omap2/displays/panel-taal.c          |    4 +-
 drivers/video/omap2/dss/core.c                     |   70 ++++++++++-
 drivers/video/omap2/dss/dispc.c                    |    2 -
 drivers/video/omap2/dss/dpi.c                      |   59 +++++++--
 drivers/video/omap2/dss/dsi.c                      |  129 +++++++++++---------
 drivers/video/omap2/dss/dss.c                      |   42 +++++--
 drivers/video/omap2/dss/dss.h                      |   19 +++-
 drivers/video/omap2/dss/venc.c                     |    4 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |   71 +++++++++++
 drivers/video/omap2/omapfb/omapfb-sysfs.c          |   13 ++-
 drivers/video/omap2/omapfb/omapfb.h                |    3 +
 include/linux/omapfb.h                             |   19 +++
 15 files changed, 347 insertions(+), 132 deletions(-)

