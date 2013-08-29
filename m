From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/15] OMAPDSS: remove old panel model code
Date: Thu, 29 Aug 2013 16:31:45 +0300
Message-ID: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56359 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab3H2NcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 09:32:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Here's a series removing all the old panel model code from the omapdss driver.
This series depends on the series that changes the board files to use the new
panel drivers.

There's nothing much special in this series, as it's mostly removing code that
is not used. There are also related cleanups, like making functions static if
they are no longer called from outside the file, and such.

Tested on OMAP4 SDP, OMAP4 Panda, OMAP3 Beagle, OMAP3 Beagle xM.

This series can also be found from:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.12/dss-legacy-removal

 Tomi

Tomi Valkeinen (15):
  OMAPDSS: RFBI: Mark RFBI as broken
  OMAPDSS: remove omap_dss_device->channel field
  OMAPDSS: fix DPI and SDI device ids
  OMAPDSS: SDI: change regulator handling
  OMAPDSS: DPI: change regulator handling
  OMAPDSS: remove all old panel drivers
  OMAPDSS: DPI: remove code related to old panel model
  OMAPDSS: HDMI: remove code related to old panel model
  OMAPDSS: DSI: remove code related to old panel model
  OMAPDSS: SDI: remove code related to old panel model
  OMAPDSS: VENC: remove code related to old panel model
  OMAPDSS: RFBI: remove code related to old panel model
  OMAPDSS: DSS: remove legacy dss bus support
  OMAPDSS: rename omap_dss_device's 'output' to 'src'
  OMAPDSS: rename omap_dss_device's 'device' field to 'dst'

 arch/arm/mach-omap2/display.c                      |    4 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             |    2 +-
 drivers/video/omap2/Kconfig                        |    1 -
 drivers/video/omap2/Makefile                       |    1 -
 drivers/video/omap2/displays-new/encoder-tfp410.c  |   14 +-
 .../video/omap2/displays-new/encoder-tpd12s015.c   |   14 +-
 drivers/video/omap2/displays/Kconfig               |   75 -
 drivers/video/omap2/displays/Makefile              |   11 -
 drivers/video/omap2/displays/panel-acx565akm.c     |  798 ----------
 drivers/video/omap2/displays/panel-generic-dpi.c   |  744 ----------
 .../omap2/displays/panel-lgphilips-lb035q02.c      |  262 ----
 drivers/video/omap2/displays/panel-n8x0.c          |  616 --------
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |  290 ----
 drivers/video/omap2/displays/panel-picodlp.c       |  559 -------
 drivers/video/omap2/displays/panel-picodlp.h       |  288 ----
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |  198 ---
 drivers/video/omap2/displays/panel-taal.c          | 1551 --------------------
 drivers/video/omap2/displays/panel-tfp410.c        |  353 -----
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |  596 --------
 drivers/video/omap2/dss/Kconfig                    |    1 +
 drivers/video/omap2/dss/Makefile                   |    5 +-
 drivers/video/omap2/dss/apply.c                    |    4 +-
 drivers/video/omap2/dss/core.c                     |  312 +---
 drivers/video/omap2/dss/dpi.c                      |  121 +-
 drivers/video/omap2/dss/dsi.c                      |  275 +---
 drivers/video/omap2/dss/dss.h                      |   45 -
 drivers/video/omap2/dss/hdmi.c                     |  307 +---
 drivers/video/omap2/dss/hdmi_panel.c               |  414 ------
 drivers/video/omap2/dss/output.c                   |   22 +-
 drivers/video/omap2/dss/rfbi.c                     |  135 +-
 drivers/video/omap2/dss/sdi.c                      |  119 +-
 drivers/video/omap2/dss/venc.c                     |  122 +-
 include/video/omap-panel-data.h                    |  118 --
 include/video/omapdss.h                            |  106 +-
 34 files changed, 185 insertions(+), 8298 deletions(-)
 delete mode 100644 drivers/video/omap2/displays/Kconfig
 delete mode 100644 drivers/video/omap2/displays/Makefile
 delete mode 100644 drivers/video/omap2/displays/panel-acx565akm.c
 delete mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
 delete mode 100644 drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
 delete mode 100644 drivers/video/omap2/displays/panel-n8x0.c
 delete mode 100644 drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
 delete mode 100644 drivers/video/omap2/displays/panel-picodlp.c
 delete mode 100644 drivers/video/omap2/displays/panel-picodlp.h
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
 delete mode 100644 drivers/video/omap2/displays/panel-taal.c
 delete mode 100644 drivers/video/omap2/displays/panel-tfp410.c
 delete mode 100644 drivers/video/omap2/displays/panel-tpo-td043mtea1.c
 delete mode 100644 drivers/video/omap2/dss/hdmi_panel.c

-- 
1.8.1.2

