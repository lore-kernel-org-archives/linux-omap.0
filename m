From: Archit Taneja <archit@ti.com>
Subject: [PATCH 00/33] OMAPDSS: platform_enable/disable callback removal from panel drivers
Date: Wed, 13 Feb 2013 19:51:52 +0530
Message-ID: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60064 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757048Ab3BMOXM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:23:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

init functions in omap board files request panel specific gpios, and provide
functions which omapdss panel drivers call to enable or disable them.

Instead of the board files requesting these gpios, they should just pass the
platform specific data(like the gpio numbers), the panel should retrieve the
platform data and request the gpios. Doing this prevents the need of the panel
driver calling platform functions in board files.

Panel drivers have their own platform data struct, and the board files populate
these structs and pass the pointer to the 'data' field of omap_dss_device. This
work will make it easier for the panel drivers be more adaptable to the
DT model.

There is also removal of passing panel reset_gpio numbers through
omap_dss_device struct directly, reset gpios are passed through platform data
only.

Reference tree:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git for-3.9/remove_enable_disable_callbacks

Archit Taneja (32):
  OMAPDSS: panels: keep platform data of all panels in a single header
  arm: omap: board-2430: use generic dpi panel's gpio handling
  arm: omap: board-devkit8000: use generic dpi panel's gpio handling
  arm: omap: board-cm-t35: use generic dpi panel's gpio handling
  arm: omap: board-apollon: use generic dpi panel's gpio handling
  arm: omap: board-am3517: use generic dpi panel's gpio handling
  arm: omap: board-ldp: use generic dpi panel's gpio handling
  OMAPDSS: lb035q02: handle gpios in panel driver
  arm: omap: board-overo: use lb035q02 dpi panel's gpio handling
  OMAPDSS: lb035q02 panel: remove platform_enable/disable callbacks
  OMAPDSS: generic dpi panel: remove platform_enable/disable ops from
    platform_data
  arm: omap: board-omap3evm: use sharp panel's gpio handling
  arm: omap: board-sdp3430: use sharp panel's gpio handling
  OMAPDSS: sharp-ls panel: remove platform_enable/disable callbacks
  OMAPDSS: acx565akm panel: handle gpios in panel driver
  arm: omap: board-rx-51: use acx565akm panel's gpio handling
  OMAPDSS: nec-nl8048 panel: handle gpios ins panel driver
  arm: omap: board-zoom: use NEC panel's gpio handling
  OMAPDSS: nec-nl8048 panel: remove platform_enable/disable callbacks
  OMAPDSS: tpo-td043 panel: handle gpios in panel driver
  arm: omap: board-omap3pandora: use tpo panel's gpio handling
  OMAPDSS: tpo-td043: remove platform_enable/disable callbacks
  OMAPDSS: picodlp panel: handle gpio data in panel driver
  arm: omap: dss-common: use picodlp panel's gpio handling
  OMAPDSS: picodlp panel: remove platform_enable/disable callbacks
  OMAPDSS: n8x0 panel: handle gpio data in panel driver
  OMAPDSS: n8x0 panel: remove platform_enable/disable callbacks
  arm: omap boards: Remove unnecessary platform_enable/disable
    callbacks for VENC devices
  OMAPDSS: VENC: remove platform_enable/disable calls
  OMAPDSS: remove platform_enable/disable callbacks from
    omap_dss_device
  arm: dss-common: don't use reset_gpio from omap4_panda_dvi_device
  OMAPDSS: remove reset_gpio field from omap_dss_device

Tomi Valkeinen (1):
  OMAPDSS: generic dpi panel: handle gpios in panel driver

 arch/arm/mach-omap2/board-2430sdp.c                |   45 +-----
 arch/arm/mach-omap2/board-3430sdp.c                |   55 +++-----
 arch/arm/mach-omap2/board-am3517evm.c              |   77 +----------
 arch/arm/mach-omap2/board-apollon.c                |   11 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |   60 +-------
 arch/arm/mach-omap2/board-devkit8000.c             |   30 +---
 arch/arm/mach-omap2/board-h4.c                     |    2 +-
 arch/arm/mach-omap2/board-igep0020.c               |    2 +-
 arch/arm/mach-omap2/board-ldp.c                    |   63 ++-------
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c               |   72 +++-------
 arch/arm/mach-omap2/board-omap3pandora.c           |    7 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   14 +-
 arch/arm/mach-omap2/board-overo.c                  |   61 ++-------
 arch/arm/mach-omap2/board-rx51-video.c             |   26 +---
 arch/arm/mach-omap2/board-zoom-display.c           |   38 ++----
 arch/arm/mach-omap2/dss-common.c                   |   58 +++-----
 drivers/video/omap2/displays/panel-acx565akm.c     |   48 +++++--
 drivers/video/omap2/displays/panel-generic-dpi.c   |   33 +++--
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   44 ++++--
 drivers/video/omap2/displays/panel-n8x0.c          |   29 ++--
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   53 ++++---
 drivers/video/omap2/displays/panel-picodlp.c       |   35 +++--
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   78 ++++++++---
 drivers/video/omap2/displays/panel-taal.c          |    2 +-
 drivers/video/omap2/displays/panel-tfp410.c        |    2 +-
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   45 +++---
 drivers/video/omap2/dss/venc.c                     |    9 --
 include/video/omap-panel-data.h                    |  144 ++++++++++++++++++++
 include/video/omap-panel-generic-dpi.h             |   37 -----
 include/video/omap-panel-n8x0.h                    |   13 --
 include/video/omap-panel-nokia-dsi.h               |   32 -----
 include/video/omap-panel-picodlp.h                 |   23 ----
 include/video/omap-panel-tfp410.h                  |   35 -----
 include/video/omapdss.h                            |    6 -
 35 files changed, 528 insertions(+), 763 deletions(-)
 create mode 100644 include/video/omap-panel-data.h
 delete mode 100644 include/video/omap-panel-generic-dpi.h
 delete mode 100644 include/video/omap-panel-n8x0.h
 delete mode 100644 include/video/omap-panel-nokia-dsi.h
 delete mode 100644 include/video/omap-panel-picodlp.h
 delete mode 100644 include/video/omap-panel-tfp410.h

-- 
1.7.9.5

