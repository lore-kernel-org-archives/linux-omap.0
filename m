From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/17] Misc OMAP DSS patches part 2
Date: Wed,  5 Sep 2012 11:25:38 +0300
Message-ID: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:35209 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754621Ab2IEI0L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:11 -0400
Received: by lbbgj3 with SMTP id gj3so189731lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

This series contains miscellaneous patches for omapdss. These are based on the
previous misc patches series
(http://www.mail-archive.com/linux-omap@vger.kernel.org/msg74279.html).

Some cleanups, but three a bit more important things:

* vram.c no longer uses OMAP's sDMA to clear the memory
* fifomerge has been reverted
* Swap GFX and WB fifos to avoid underflows

 Tomi

Tomi Valkeinen (17):
  OMAPDSS: Taal: use devm_* functions
  OMAPFB1: remove unnecessary includes
  OMAPFB1: remove a non-used table
  OMAPDSS: remove unnecessary includes
  OMAPFB: clear framebuffers with CPU
  OMAPDSS: VRAM: Remove clearing with sDMA
  OMAPDSS: Taal: Reogranize for device tree
  OMAPDSS: TFP410: use devm_gpio_request_one
  OMAPDSS: split overlay sysfs code
  OMAPDSS: split manager sysfs code
  OMAPDSS: clean up dss_mgr_set_lcd_config
  OMAPDSS: clean up dss_mgr_set_timings
  Revert "OMAPDSS: APPLY: add fifo-merge support"
  Revert "OMAPDSS: APPLY: add fifo merge support funcs"
  OMAPDSS: remove extra_info completion code
  OMAPDSS: Improve fifo management code
  OMAPDSS: Use WB fifo for GFX overlay

 drivers/video/omap/hwa742.c                 |    1 -
 drivers/video/omap/lcd_ams_delta.c          |    1 -
 drivers/video/omap/lcd_palmte.c             |    1 -
 drivers/video/omap/omapfb_main.c            |    9 -
 drivers/video/omap2/displays/panel-taal.c   |  215 ++++++------
 drivers/video/omap2/displays/panel-tfp410.c |   14 +-
 drivers/video/omap2/dss/Makefile            |    2 +-
 drivers/video/omap2/dss/apply.c             |  298 +---------------
 drivers/video/omap2/dss/dispc.c             |   68 +++-
 drivers/video/omap2/dss/dispc.h             |    4 +
 drivers/video/omap2/dss/dpi.c               |    1 -
 drivers/video/omap2/dss/dsi.c               |    1 -
 drivers/video/omap2/dss/dss.c               |    1 -
 drivers/video/omap2/dss/dss.h               |    7 +
 drivers/video/omap2/dss/manager-sysfs.c     |  499 +++++++++++++++++++++++++++
 drivers/video/omap2/dss/manager.c           |  462 +------------------------
 drivers/video/omap2/dss/overlay-sysfs.c     |  456 ++++++++++++++++++++++++
 drivers/video/omap2/dss/overlay.c           |  421 +---------------------
 drivers/video/omap2/dss/venc.c              |    1 -
 drivers/video/omap2/omapfb/omapfb-main.c    |   26 ++
 drivers/video/omap2/vram.c                  |   56 ---
 include/video/omapdss.h                     |    1 +
 22 files changed, 1180 insertions(+), 1365 deletions(-)
 create mode 100644 drivers/video/omap2/dss/manager-sysfs.c
 create mode 100644 drivers/video/omap2/dss/overlay-sysfs.c

-- 
1.7.9.5

