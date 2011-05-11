From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3] OMAP: DSS2: Move header files to include/video/
Date: Wed, 11 May 2011 15:26:27 +0300
Message-ID: <1305116790-24067-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36023 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755958Ab1EKQ2f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 12:28:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP Display Subsystem driver header files are currently located in
arch/arm/plat-omap/include/plat/ which is not a good place for driver headers.

This patch set moves the headers to a more suitable location at include/video/
and renaming the files as follows:

display.h -> omapdss.h
panel-generic-dpi.h -> omap-panel-generic-dpi.h
nokia-dsi-panel.h -> omap-panel-nokia-dsi.h

 Tomi

Tomi Valkeinen (3):
  OMAP: DSS2: Move display.h to include/video/
  OMAP: DSS2: Move panel-generic-dpi.h to include/video/
  OMAP: DSS2: Move nokia-dsi-panel.h to include/video/

 arch/arm/mach-omap2/board-3430sdp.c                |    4 ++--
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c              |    4 ++--
 arch/arm/mach-omap2/board-cm-t35.c                 |    4 ++--
 arch/arm/mach-omap2/board-devkit8000.c             |    4 ++--
 arch/arm/mach-omap2/board-igep0020.c               |    4 ++--
 arch/arm/mach-omap2/board-omap3beagle.c            |    4 ++--
 arch/arm/mach-omap2/board-omap3evm.c               |    4 ++--
 arch/arm/mach-omap2/board-omap3pandora.c           |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |    4 ++--
 arch/arm/mach-omap2/board-omap4panda.c             |    4 ++--
 arch/arm/mach-omap2/board-overo.c                  |    4 ++--
 arch/arm/mach-omap2/board-rx51-video.c             |    2 +-
 arch/arm/mach-omap2/board-zoom-display.c           |    2 +-
 arch/arm/mach-omap2/display.c                      |    2 +-
 arch/arm/mach-omap2/include/mach/board-zoom.h      |    2 +-
 drivers/media/video/omap/omap_vout.c               |    2 +-
 drivers/media/video/omap/omap_voutdef.h            |    2 +-
 drivers/video/omap2/displays/panel-acx565akm.c     |    2 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |    3 ++-
 .../omap2/displays/panel-lgphilips-lb035q02.c      |    2 +-
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    2 +-
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    2 +-
 drivers/video/omap2/displays/panel-taal.c          |    4 ++--
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    2 +-
 drivers/video/omap2/dss/core.c                     |    2 +-
 drivers/video/omap2/dss/dispc.c                    |    2 +-
 drivers/video/omap2/dss/display.c                  |    2 +-
 drivers/video/omap2/dss/dpi.c                      |    2 +-
 drivers/video/omap2/dss/dsi.c                      |    2 +-
 drivers/video/omap2/dss/dss.c                      |    2 +-
 drivers/video/omap2/dss/dss_features.c             |    2 +-
 drivers/video/omap2/dss/hdmi.c                     |    2 +-
 drivers/video/omap2/dss/hdmi.h                     |    2 +-
 drivers/video/omap2/dss/hdmi_omap4_panel.c         |    2 +-
 drivers/video/omap2/dss/manager.c                  |    2 +-
 drivers/video/omap2/dss/overlay.c                  |    2 +-
 drivers/video/omap2/dss/rfbi.c                     |    2 +-
 drivers/video/omap2/dss/sdi.c                      |    2 +-
 drivers/video/omap2/dss/venc.c                     |    2 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |    2 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c          |    2 +-
 drivers/video/omap2/omapfb/omapfb.h                |    2 +-
 .../video/omap-panel-generic-dpi.h                 |    8 ++++----
 .../video/omap-panel-nokia-dsi.h                   |    8 ++++----
 .../plat/display.h => include/video/omapdss.h      |    6 ++----
 47 files changed, 66 insertions(+), 67 deletions(-)
 rename arch/arm/plat-omap/include/plat/panel-generic-dpi.h => include/video/omap-panel-generic-dpi.h (86%)
 rename arch/arm/plat-omap/include/plat/nokia-dsi-panel.h => include/video/omap-panel-nokia-dsi.h (79%)
 rename arch/arm/plat-omap/include/plat/display.h => include/video/omapdss.h (99%)

-- 
1.7.4.1

