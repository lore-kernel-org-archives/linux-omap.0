From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 00/15] OMAP: DSS2: EDID & detect support
Date: Mon, 12 Sep 2011 12:13:23 +0300
Message-ID: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48201 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204Ab1ILJNu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:13:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Implement EDID reading and monitor detection support for HDMI and DVI outputs.

This set is based on the previously sent "OMAP: DSS2: misc improvements" set.

 Tomi

Changes in v2:
* Rebased on top of latest DSS changes
* Create a separate DVI driver with DDC support

Tomi Valkeinen (15):
  OMAP: DSS2: add read_edid() to omap_dss_driver struct
  OMAP: DSS2: add detect() to omap_dss_driver struct
  OMAP: DSS2: HDMI: make set_timing saner
  OMAP: DSS2: HDMI: implement read_edid()
  OMAP: DSS2: HDMI: remove edid parsing
  OMAP: DSS2: HDMI: split hdmi_core_ddc_edid
  OMAP: DSS2: HDMI: clean up edid reading & fix checksum
  OMAP: DSS2: HDMI: remove error prints in check_timings
  OMAP: DSS2: HDMI: implement detect()
  OMAP: DSS2: add panel-dvi driver
  OMAP: use dvi panel driver instead of generic-dpi
  OMAP: stalker: Remove LCD device from board file
  OMAP: DSS2: panel-generic-dpi: remove "generic" panel
  OMAP: Panda, Beagle, Overo: DVI: Add i2c_bus_num
  OMAPFB: find best mode from edid

 arch/arm/mach-omap2/board-3430sdp.c              |    7 +-
 arch/arm/mach-omap2/board-am3517evm.c            |    6 +-
 arch/arm/mach-omap2/board-cm-t35.c               |    6 +-
 arch/arm/mach-omap2/board-devkit8000.c           |    6 +-
 arch/arm/mach-omap2/board-igep0020.c             |    7 +-
 arch/arm/mach-omap2/board-omap3beagle.c          |    8 +-
 arch/arm/mach-omap2/board-omap3evm.c             |    7 +-
 arch/arm/mach-omap2/board-omap3stalker.c         |   40 +---
 arch/arm/mach-omap2/board-omap4panda.c           |    8 +-
 arch/arm/mach-omap2/board-overo.c                |    7 +-
 drivers/video/omap2/displays/Kconfig             |    7 +
 drivers/video/omap2/displays/Makefile            |    1 +
 drivers/video/omap2/displays/panel-dvi.c         |  363 ++++++++++++++++++++++
 drivers/video/omap2/displays/panel-generic-dpi.c |   24 --
 drivers/video/omap2/dss/dss.h                    |    2 +
 drivers/video/omap2/dss/dss_features.c           |    1 +
 drivers/video/omap2/dss/hdmi.c                   |  200 +++---------
 drivers/video/omap2/dss/hdmi_panel.c             |   66 +++-
 drivers/video/omap2/dss/ti_hdmi.h                |    9 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c        |  193 +++++++-----
 drivers/video/omap2/omapfb/omapfb-main.c         |  109 ++++++-
 include/video/omap-panel-dvi.h                   |   37 +++
 include/video/omapdss.h                          |    3 +
 23 files changed, 758 insertions(+), 359 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-dvi.c
 create mode 100644 include/video/omap-panel-dvi.h

-- 
1.7.4.1

