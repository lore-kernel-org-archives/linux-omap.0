From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/25] OMAPDSS: DT preparation patches v2
Date: Thu,  3 May 2012 16:57:36 +0300
Message-ID: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:55129 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754293Ab2ECN6S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:18 -0400
Received: by lahm13 with SMTP id m13so1280886lah.9
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

I started cleaning up and restructuring omapdss for device tree, and here's the
first set of patches from that ordeal. There's nothing DT specific in these
patches, but they are mostly generic cleanups that make sense even without DT.

This is the second version of these patches, the previous version can be found
from: http://www.spinics.net/lists/linux-fbdev/msg05667.html

The first 21 patches, which were in the previous version, have only gotten
minor cleanups (and, of course, more testing). The last 4 patches are new. The
most important of those patches is the DSI pin config patch, which makes it
possible for the panel driver to configure the DSI pins it needs.

This series can also be found from:
git://gitorious.org/linux-omap-dss2/linux.git work/devtree-base

 Tomi

Tomi Valkeinen (25):
  OMAPDSS: panel-dvi: add PD gpio handling
  OMAP: board-files: remove custom PD GPIO handling for DVI output
  OMAPDSS: TFP410: rename dvi -> tfp410
  OMAPDSS: TFP410: rename dvi files to tfp410
  OMAPDSS: TFP410: pdata rewrite
  OMAPDSS: DSI: use dsi_get_dsidev_id(dsidev) instead of dsidev->id
  OMAPDSS: Taal: move reset gpio handling to taal driver
  OMAPDSS: clean up the omapdss platform data mess
  OMAPDSS: remove return from platform_driver_unreg
  OMAPDSS: use platform_driver_probe for core/dispc/dss
  OMAPDSS: create custom pdevs for DSS omap_devices
  OMAPDSS: create DPI & SDI devices
  OMAPDSS: create DPI & SDI drivers
  OMAPDSS: remove uses of dss_runtime_get/put
  OMAPDSS: handle output-driver reg/unreg more dynamically
  OMAPDSS: move the creation of debugfs files
  OMAPDSS: use platform_driver_probe for dsi/hdmi/rfbi/venc/dpi/sdi
  OMAPDSS: add __init & __exit
  OMAPFB: add __init & __exit
  OMAPDSS: change default_device handling
  OMAPDSS: interface drivers register their panel devices
  OMAPDSS: init omap_dss_devices internally
  OMAPDSS: DSI: implement generic DSI pin config
  OMAPDSS: DSI: improve DSI module id handling
  OMAPDSS: separate pdata based initialization

 arch/arm/mach-omap2/board-3430sdp.c         |   38 +--
 arch/arm/mach-omap2/board-4430sdp.c         |   37 +--
 arch/arm/mach-omap2/board-am3517evm.c       |   25 +-
 arch/arm/mach-omap2/board-cm-t35.c          |   30 +--
 arch/arm/mach-omap2/board-devkit8000.c      |   30 +--
 arch/arm/mach-omap2/board-igep0020.c        |   32 +--
 arch/arm/mach-omap2/board-omap3beagle.c     |   37 +--
 arch/arm/mach-omap2/board-omap3evm.c        |   29 +-
 arch/arm/mach-omap2/board-omap3stalker.c    |   29 +-
 arch/arm/mach-omap2/board-omap4panda.c      |   39 +--
 arch/arm/mach-omap2/board-overo.c           |   25 +-
 arch/arm/mach-omap2/display.c               |  175 ++++++++++--
 drivers/video/omap2/displays/Kconfig        |    8 +-
 drivers/video/omap2/displays/Makefile       |    2 +-
 drivers/video/omap2/displays/panel-dvi.c    |  363 -------------------------
 drivers/video/omap2/displays/panel-taal.c   |   22 ++
 drivers/video/omap2/displays/panel-tfp410.c |  385 +++++++++++++++++++++++++++
 drivers/video/omap2/dss/core.c              |  239 ++++++++++-------
 drivers/video/omap2/dss/dispc.c             |   50 ++--
 drivers/video/omap2/dss/display.c           |   40 ---
 drivers/video/omap2/dss/dpi.c               |   68 +++--
 drivers/video/omap2/dss/dsi.c               |  281 ++++++++++---------
 drivers/video/omap2/dss/dss.c               |   44 ++-
 drivers/video/omap2/dss/dss.h               |  113 ++------
 drivers/video/omap2/dss/hdmi.c              |   86 +++---
 drivers/video/omap2/dss/rfbi.c              |   60 +++--
 drivers/video/omap2/dss/sdi.c               |   61 ++++-
 drivers/video/omap2/dss/venc.c              |   62 +++--
 drivers/video/omap2/omapfb/omapfb-main.c    |    9 +-
 include/video/omap-panel-dvi.h              |   37 ---
 include/video/omap-panel-nokia-dsi.h        |    3 +
 include/video/omap-panel-tfp410.h           |   35 +++
 include/video/omapdss.h                     |   33 +--
 33 files changed, 1220 insertions(+), 1307 deletions(-)
 delete mode 100644 drivers/video/omap2/displays/panel-dvi.c
 create mode 100644 drivers/video/omap2/displays/panel-tfp410.c
 delete mode 100644 include/video/omap-panel-dvi.h
 create mode 100644 include/video/omap-panel-tfp410.h

-- 
1.7.9.5

