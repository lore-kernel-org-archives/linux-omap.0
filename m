From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/21] OMAPDSS: DT preparation patches
Date: Wed,  7 Mar 2012 14:44:29 +0200
Message-ID: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:33432 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752336Ab2CGMpI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:08 -0500
Received: by mail-lpp01m010-f53.google.com with SMTP id c1so8038032lah.12
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:07 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

I started cleaning up and restructuring omapdss for device tree, and here's the
first set of patches from that ordeal. There's nothing DT specific in these
patches, but they are mostly generic cleanups that make sense even without DT.

The custom pdev creation depends on the following patches posted on l-o:

ARM: OMAP: remove omap_device_parent
ARM: OMAP: omap_device: Expose omap_device_{alloc, delete, register}

This series can also be found from:
git://gitorious.org/linux-omap-dss2/linux.git work/devtree-base

 Tomi

Tomi Valkeinen (21):
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
  OMAPDSS: register dss drivers in module init
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

 arch/arm/mach-omap2/board-3430sdp.c                |   38 +---
 arch/arm/mach-omap2/board-4430sdp.c                |   16 --
 arch/arm/mach-omap2/board-am3517evm.c              |   25 +--
 arch/arm/mach-omap2/board-cm-t35.c                 |   30 +--
 arch/arm/mach-omap2/board-devkit8000.c             |   30 +--
 arch/arm/mach-omap2/board-igep0020.c               |   32 +--
 arch/arm/mach-omap2/board-omap3beagle.c            |   37 +---
 arch/arm/mach-omap2/board-omap3evm.c               |   29 +--
 arch/arm/mach-omap2/board-omap3stalker.c           |   29 +--
 arch/arm/mach-omap2/board-omap4panda.c             |   39 +---
 arch/arm/mach-omap2/board-overo.c                  |   25 +--
 arch/arm/mach-omap2/display.c                      |  172 +++++++++++--
 drivers/video/omap2/displays/Kconfig               |    8 +-
 drivers/video/omap2/displays/Makefile              |    2 +-
 drivers/video/omap2/displays/panel-taal.c          |   15 ++
 .../omap2/displays/{panel-dvi.c => panel-tfp410.c} |  186 ++++++++------
 drivers/video/omap2/dss/core.c                     |  260 +++++++++++++-------
 drivers/video/omap2/dss/dispc.c                    |   50 ++---
 drivers/video/omap2/dss/dpi.c                      |   38 ++--
 drivers/video/omap2/dss/dsi.c                      |   86 ++-----
 drivers/video/omap2/dss/dss.c                      |   46 ++---
 drivers/video/omap2/dss/dss.h                      |   76 +-----
 drivers/video/omap2/dss/hdmi.c                     |   55 +----
 drivers/video/omap2/dss/rfbi.c                     |   31 +--
 drivers/video/omap2/dss/sdi.c                      |   31 ++-
 drivers/video/omap2/dss/venc.c                     |   31 +--
 drivers/video/omap2/omapfb/omapfb-main.c           |    9 +-
 .../{omap-panel-dvi.h => omap-panel-tfp410.h}      |   18 +-
 include/video/omapdss.h                            |    5 -
 29 files changed, 628 insertions(+), 821 deletions(-)
 rename drivers/video/omap2/displays/{panel-dvi.c => panel-tfp410.c} (56%)
 rename include/video/{omap-panel-dvi.h => omap-panel-tfp410.h} (63%)

-- 
1.7.4.1

