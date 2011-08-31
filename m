From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/12] OMAP: DSS2: EDID & detect support
Date: Wed, 31 Aug 2011 16:23:11 +0300
Message-ID: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:46583 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755392Ab1HaNXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Implement EDID reading and monitor detection support for HDMI and DVI outputs.

This set is based on the previously sent "OMAP: DSS2: misc improvements" set.

 Tomi

Tomi Valkeinen (12):
  OMAP: DSS2: add read_edid() to omap_dss_driver struct
  OMAP: DSS2: add detect() to omap_dss_driver struct
  OMAP: DSS2: HDMI: make set_timing saner
  OMAP: DSS2: HDMI: implement read_edid()
  OMAP: DSS2: HDMI: remove edid parsing
  OMAP: DSS2: HDMI: split hdmi_core_ddc_edid
  OMAP: DSS2: HDMI: clean up edid reading & fix checksum
  OMAP: DSS2: HDMI: remove error prints in check_timings
  OMAP: DSS2: HDMI: implement detect()
  OMAP: DSS2: Generic-dpi: add detect & read_edid support
  OMAP: Panda & Beagle: DVI: Add i2c_bus_num
  OMAPFB: find best mode from edid

 arch/arm/mach-omap2/board-omap3beagle.c          |    1 +
 arch/arm/mach-omap2/board-omap4panda.c           |    1 +
 drivers/video/omap2/displays/panel-generic-dpi.c |   92 ++++++
 drivers/video/omap2/dss/dss.h                    |    2 +
 drivers/video/omap2/dss/hdmi.c                   |  323 +++++++++-------------
 drivers/video/omap2/dss/hdmi_omap4_panel.c       |   66 ++++-
 drivers/video/omap2/omapfb/omapfb-main.c         |  109 +++++++-
 include/video/omap-panel-generic-dpi.h           |    2 +
 include/video/omapdss.h                          |    3 +
 9 files changed, 378 insertions(+), 221 deletions(-)

-- 
1.7.4.1

