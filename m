From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/10] OMAPDSS: Basic deferred probe support
Date: Mon, 29 Apr 2013 13:22:27 +0300
Message-ID: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37169 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758031Ab3D2KXB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:23:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

omapdss, omapfb and the panel drivers do not currently support deferred probe,
which is causing the display drivers fail when booting with DT.

This series adds very basic support for deferred probing, which hopefully fixes
the issues for omap4 panda and sdp boards with the current kernel.

Limitations:

* Deferred probe support for omap_vout and omapdrm is still totally missing.
* If it so happens that at omapfb probe time one panel has been probed, but
  another has been deferred, only the probed one will be used.
* Only DPI, DSI and HDMI outputs have been fixed.
* Some panel drivers may need modifications to support EPROBE_DEFER

Patches based on linux-next, i.e. the latest omapdss stuff.

 Tomi

Tomi Valkeinen (10):
  OMAPDSS: Makefile: move omapfb after panels
  OMAPFB: use module_platform_driver()
  OMAPFB: defer probe if no displays
  OMAPDSS: DSI: use platform_driver_register()
  OMAPDSS: DSI: Add error handling for dsi_probe_pdata
  OMAPDSS: DPI: use platform_driver_register()
  OMAPDSS: DPI: Add error handling for dpi_probe_pdata
  OMAPDSS: HDMI: use platform_driver_register()
  OMAPDSS: HDMI: Add error handling for hdmi_probe_pdata
  OMAPDSS: TFP410: return EPROBE_DEFER if the i2c adapter not found

 drivers/video/omap2/Makefile                |    2 +-
 drivers/video/omap2/displays/panel-tfp410.c |    2 +-
 drivers/video/omap2/dss/dpi.c               |   35 +++++++++++++++++----------
 drivers/video/omap2/dss/dsi.c               |   35 +++++++++++++++++----------
 drivers/video/omap2/dss/hdmi.c              |   33 ++++++++++++++++---------
 drivers/video/omap2/omapfb/omapfb-main.c    |   30 +++--------------------
 6 files changed, 71 insertions(+), 66 deletions(-)

-- 
1.7.10.4

