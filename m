From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/5] OMAP: DSS: add __inits and __exits
Date: Fri,  1 Apr 2011 13:00:25 +0300
Message-ID: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37603 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755256Ab1DAKAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 06:00:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

These patches add __inits and __exits to multiple functions in omapdss and
panel drivers. Also omap_dss_register_driver_probe() is added which allows us
to define panel driver probe functions as __init.

This moved almost 7kB from .text section to .init section on my configuration.

Tomi Valkeinen (5):
  OMAP: DSS2: make omap_dss_(un)register_device static
  OMAP: DSS2: add __inits to omapdss driver
  OMAP: DSS2: use __exit for selected panel drivers
  OMAP: DSS2: Add omap_dss_register_driver_probe()
  OMAP: DSS2: use omap_dss_register_driver_probe() in selected drivers

 arch/arm/plat-omap/include/plat/display.h          |    5 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |   10 ++--
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   10 ++--
 drivers/video/omap2/displays/panel-taal.c          |    9 +--
 drivers/video/omap2/dss/core.c                     |   64 +++++++++++++++++---
 drivers/video/omap2/dss/dispc.c                    |    7 +-
 drivers/video/omap2/dss/dpi.c                      |    2 +-
 drivers/video/omap2/dss/dsi.c                      |    7 +-
 drivers/video/omap2/dss/dss.c                      |    9 +--
 drivers/video/omap2/dss/dss_features.c             |    2 +-
 drivers/video/omap2/dss/hdmi.c                     |    8 +-
 drivers/video/omap2/dss/manager.c                  |    2 +-
 drivers/video/omap2/dss/overlay.c                  |    2 +-
 drivers/video/omap2/dss/rfbi.c                     |    7 +-
 drivers/video/omap2/dss/sdi.c                      |    2 +-
 drivers/video/omap2/dss/venc.c                     |    7 +-
 16 files changed, 96 insertions(+), 57 deletions(-)

