From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/26] DSS device model change
Date: Tue, 26 Mar 2013 15:33:30 +0200
Message-ID: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35046 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932781Ab3CZNed (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 09:34:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

Hi,

To make it possible to add DT support to DSS, and later use the Common Display
Framework, we need to change the DSS device model. We currently have a custom
dss bus, and omap_dss_devices on that bus, and the aim is to get rid of that
bus.

The panel devices will be converted occording to the control bus of the panel.
For many panels this means that the panel device will become a platform_device.
For some, it means the panel devices become i2c or spi devices.

This series takes the first step toward that goal. This series:

* Converts DPI, HDMI and DSI outputs to work with new style panels
* Converts TFP410, Taal and generic-dpi panels to new model
* Converts Panda, 4430SDP and Overo boards to use the new panels

The non-converted outputs and panels still work, so they can be converted in
stages.

Note about board files: I only convert a few board files here for example. I
have a branch with board file changes for all the affected board files. I did
not include them as they are more or less identical. If this series looks good,
I will create an independent branch for the arch/arm stuff, so it can be pulled
separately.

This series can also be found from:

git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model-review

 Tomi

Tomi Valkeinen (26):
  OMAPDSS: only probe pdata if there's one
  OMAPDSS: add omap_dss_find_output()
  OMAPDSS: add omap_dss_find_output_by_node()
  OMAPDSS: fix dss_get_ctx_loss_count for DT
  OMAPDSS: DPI: fix regulators
  OMAPDSS: SDI: fix regulators
  OMAPDSS: add panel list
  OMAPDSS: use the panel list in omap_dss_get_next_device
  OMAPDSS: don't use dss bus in suspend/resume
  OMAPDSS: implement display sysfs without dss bus
  OMAPDSS: Add panel_dev pointer to dssdev
  OMAPDSS: DPI: new panel registration
  OMAPDSS: DSI: new panel registration
  OMAPDSS: HDMI: new panel registration
  OMAPDSS: TFP410 platform_data changes
  OMAPDSS: TFP410: convert to platform device
  OMAPDSS: generic-dpi-panel platform_data changes
  OMAPDSS: panel-generic-dpi: convert to platform device
  OMAPDSS: HDMI: convert to platform device
  OMAPDSS: Taal platform_data changes
  OMAPDSS: Taal: convert to platform device
  ARM: OMAP: Panda: use new TFP410 platform driver
  ARM: OMAP: Panda & SDP: use new HDMI driver
  ARM: OMAP: 4430SDP: use new Taal driver
  ARM: OMAP: Overo: use new TFP410 platform driver
  ARM: OMAP: Overo: use new generic-dpi-panel platform driver

 arch/arm/mach-omap2/board-overo.c                |   95 +++----
 arch/arm/mach-omap2/dss-common.c                 |   96 +++----
 drivers/video/omap2/displays/panel-generic-dpi.c |  141 +++++++----
 drivers/video/omap2/displays/panel-taal.c        |  294 +++++++++++++---------
 drivers/video/omap2/displays/panel-tfp410.c      |  205 +++++++++------
 drivers/video/omap2/dss/apply.c                  |   15 +-
 drivers/video/omap2/dss/core.c                   |   32 +--
 drivers/video/omap2/dss/display-sysfs.c          |  126 ++++++----
 drivers/video/omap2/dss/display.c                |  166 +++++++-----
 drivers/video/omap2/dss/dpi.c                    |   59 ++++-
 drivers/video/omap2/dss/dsi.c                    |   58 ++++-
 drivers/video/omap2/dss/dss.c                    |    3 +-
 drivers/video/omap2/dss/dss.h                    |   11 +-
 drivers/video/omap2/dss/hdmi.c                   |   44 +++-
 drivers/video/omap2/dss/hdmi_panel.c             |   48 +++-
 drivers/video/omap2/dss/output.c                 |   26 ++
 drivers/video/omap2/dss/rfbi.c                   |    3 +-
 drivers/video/omap2/dss/sdi.c                    |   23 +-
 drivers/video/omap2/dss/venc.c                   |    3 +-
 include/video/omap-panel-generic-dpi.h           |    3 +
 include/video/omap-panel-nokia-dsi.h             |    1 +
 include/video/omap-panel-tfp410.h                |    5 +
 include/video/omapdss.h                          |   16 ++
 23 files changed, 940 insertions(+), 533 deletions(-)

-- 
1.7.10.4

