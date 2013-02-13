From: Archit Taneja <archit@ti.com>
Subject: [PATCH 00/11] OMAPDSS: Misc cleanups
Date: Wed, 13 Feb 2013 19:37:03 +0530
Message-ID: <1360764434-18788-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163Ab3BMOHy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:07:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

These patches perform cleanups which will help the omapdss driver to migrate
to DT more easily:

- omapdss panel drivers call platform specific backlight functions defined in
  board files. These callbacks are removed. Setting of max backlight level
  in the board file is also removed.
- other misc changes which thin down the omap_dss_device struct by removing
  some unnecessary fields.
- usage of devm_kzalloc in panel drivers.

Reference branch:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git for-3.9/misc_cleanups 

Archit Taneja (7):
  OMAPDSS: ZOOM/NEC-nl8048hl11: remove platform backlight support
  OMAPDSS: Generic DPI Panel: use devm_kzalloc for allocating driver
    data
  OMAPDSS: lb035q02: use devm_kzalloc for allocating driver data
  OMAPDSS: picodlp: use devm_kzalloc for allocating driver data
  OMAPDSS: remove unnecessary DSI external TE pin platform info from
    omap_dss_device
  OMAPDSS: panel acx565akm: remove omap_dss_device maximum backlight
    level usage
  OMAPDSS: Remove max_backlight_level form omap_dss_device

Tomi Valkeinen (4):
  OMAPDSS: acx565akm: remove platform backlight calls
  OMAPDSS: ls037v7dw01: remove platform backlight calls
  OMAPDSS: n8x0: remove platform backlight calls
  OMAPDSS: remove set_backlight/get_backlight function ptrs

 arch/arm/mach-omap2/board-zoom-display.c           |    2 -
 drivers/video/omap2/displays/panel-acx565akm.c     |   11 +--
 drivers/video/omap2/displays/panel-generic-dpi.c   |    6 +-
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   16 ++---
 drivers/video/omap2/displays/panel-n8x0.c          |   74 --------------------
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   74 --------------------
 drivers/video/omap2/displays/panel-picodlp.c       |   16 ++---
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   62 ----------------
 include/video/omap-panel-n8x0.h                    |    2 -
 include/video/omapdss.h                            |    7 --
 10 files changed, 14 insertions(+), 256 deletions(-)

-- 
1.7.9.5

