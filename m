From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/19] OMAP: DSS2: ULPS support
Date: Tue, 19 Apr 2011 12:22:03 +0300
Message-ID: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43087 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422Ab1DSJWf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

ULPS (Ultra-Low Power State) is a power saving method for DSI bus. When the
ULPS is entered, the host sends an ULPS entry sequence and pulls the DSI lines
down. On ULPS exit, the host sends an exit sequence and continues normal
operation. This allows both the host and the DSI peripheral to save some power
while in ULPS.

This patch set implements ULPS support for DSS2. ULPS can be used with DSI
command mode displays, and as command mode displays can refresh the panel
independently using its own framebuffer, entering ULPS allows OMAP DSS HW to be
totally turned off while the image on the display stays. This in turn may allow
OMAP to enter deep sleep.

Taal panel driver implements an inactivity timer which is used to enter ULPS
after a certain period. The period can configured via sysfs, "ulps_timeout"
file. A good value for the ulps_timeout depends on the use case and board, but
is most likely around 100-500ms. 

The patch set does not enable the ULPS timeout, but it has to be enabled either
manually via sysfs or from the board file.

Tested on OMAP 4430 Blaze board. The patches are based on the current DSS2
master branch.

 Tomi

Tomi Valkeinen (19):
  OMAP: DSS2: DSI: Add lane override functions
  OMAP: DSS2: DSI: Remove CIO LDO status check
  OMAP: DSS2: DSI: implement ULPS enter and exit
  OMAP: DSS2: DSI: add option to leave DSI lanes powered on
  OMAP: DSS2: DSI: rename complexio related functions
  OMAP: DSS2: Add FEAT_DSI_REVERSE_TXCLKESC
  OMAP: DSS2: DSI: fix _dsi_print_reset_status
  OMAP: DSS2: DSI: implement enable/disable SCP clk
  OMAP: DSS2: DSI: fix CIO init and uninit
  OMAP: DSS2: DSI: wait for TXCLKESC domain to come out of reset
  OMAP: DSS2: DSI: add parameter to enter ulps on disable
  OMAP: DSS2: DSI: Add DSI pad muxing support
  OMAP: DSS2: DSI: ensure VDDS_DSI is disabled on exit
  OMAP: DSS2: Taal: Implement configurable ESD interval
  OMAP: DSS2: Taal: Clean up ESD queueing
  OMAP: DSS2: Taal: Add sysfs file for ESD interval
  OMAP: DSS2: Taal: Separate panel reset
  OMAP: DSS2: Taal: Rename esd_wq to workqueue
  OMAP: DSS2: Taal: Implement ULPS functionality

 arch/arm/mach-omap2/board-4430sdp.c               |    2 +-
 arch/arm/plat-omap/include/plat/display.h         |    4 +-
 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h |    6 +-
 drivers/video/omap2/displays/panel-taal.c         |  420 +++++++++++++++++++--
 drivers/video/omap2/dss/dpi.c                     |    4 +-
 drivers/video/omap2/dss/dsi.c                     |  427 +++++++++++++++++----
 drivers/video/omap2/dss/dss.h                     |    2 +-
 drivers/video/omap2/dss/dss_features.c            |    4 +-
 drivers/video/omap2/dss/dss_features.h            |    6 +-
 9 files changed, 764 insertions(+), 111 deletions(-)

