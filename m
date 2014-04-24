From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/23] OMAPDSS: OMAP5 display support
Date: Thu, 24 Apr 2014 13:16:56 +0300
Message-ID: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59009 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755017AbaDXKSx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:18:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

Hi,

This series implements OMAP5 display support. The series is based on -rc2.

Tested on OMAP5 uEVM with HDMI output, and OMAP5 uEVM with a custom DSI panel
(patches for the panel are not included here).

Tomi

Archit Taneja (4):
  ARM: OMAP: hwmod: OMAP5 DSS hwmod data
  OMAPDSS: HDMI: support larger register offsets for OMAP5 HDMI core
  OMAPDSS: HDMI: PHY changes for OMAP5
  OMAPDSS: HDMI: PLL changes for OMAP5

Tomi Valkeinen (19):
  OMAPDSS: HDMI: lane config support
  Doc/DT: ti,omap4-dss: hdmi lanes
  OMAPDSS: HDMI4: set regulator voltage to 1.8V
  OMAPDSS: DSI: set regulator voltage to 1.8V
  ARM: OMAP: add OMAP5 DSI muxing
  ARM: OMAP: add detection of omap5-dss
  ARM: dts: omap5-clocks.dtsi: add dss iclk
  ARM: dts: omap5-clocks.dtsi: add ti,set-rate-parent to dss_dss_clk
  ARM: dts: omap5.dtsi: add DSS nodes
  ARM: dts: omap5-uevm.dts: add tca6424a
  ARM: dts: omap5-uevm.dts: add display nodes
  OMAPDSS: DSS & DISPC DT support for OMAP5
  OMAPDSS: features: fix OMAP5 features
  OMAPDSS: DPI: fix LCD3 DSI source
  OMAPDSS: DSI: Add OMAP5 DSI module IDs
  OMAPDSS: HDMI: improve Makefile
  OMAPDSS: HDMI: move irq & phy pwr handling
  OMAPDSS: HDMI: Add OMAP5 HDMI support
  Doc/DT: Add OMAP5 DSS DT bindings

 .../devicetree/bindings/video/ti,omap4-dss.txt     |   4 +
 .../devicetree/bindings/video/ti,omap5-dss.txt     |  96 +++
 arch/arm/boot/dts/omap5-uevm.dts                   |  89 ++
 arch/arm/boot/dts/omap5.dtsi                       |  70 ++
 arch/arm/boot/dts/omap54xx-clocks.dtsi             |   9 +
 arch/arm/mach-omap2/display.c                      |  39 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         | 283 +++++++
 drivers/video/fbdev/omap2/dss/Kconfig              |  22 +-
 drivers/video/fbdev/omap2/dss/Makefile             |   6 +-
 drivers/video/fbdev/omap2/dss/core.c               |   6 +
 drivers/video/fbdev/omap2/dss/dispc.c              |   1 +
 drivers/video/fbdev/omap2/dss/dpi.c                |   2 +
 drivers/video/fbdev/omap2/dss/dsi.c                |  17 +
 drivers/video/fbdev/omap2/dss/dss.c                |   1 +
 drivers/video/fbdev/omap2/dss/dss.h                |   3 +
 drivers/video/fbdev/omap2/dss/dss_features.c       |   3 +-
 drivers/video/fbdev/omap2/dss/hdmi.h               |  17 +-
 drivers/video/fbdev/omap2/dss/hdmi4.c              | 113 ++-
 drivers/video/fbdev/omap2/dss/hdmi5.c              | 829 ++++++++++++++++++
 drivers/video/fbdev/omap2/dss/hdmi5_core.c         | 922 +++++++++++++++++++++
 drivers/video/fbdev/omap2/dss/hdmi5_core.h         | 306 +++++++
 drivers/video/fbdev/omap2/dss/hdmi_common.c        |  41 +
 drivers/video/fbdev/omap2/dss/hdmi_phy.c           | 231 ++++--
 drivers/video/fbdev/omap2/dss/hdmi_pll.c           |  81 +-
 drivers/video/fbdev/omap2/dss/hdmi_wp.c            |   2 +-
 25 files changed, 3111 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap5-dss.txt
 create mode 100644 drivers/video/fbdev/omap2/dss/hdmi5.c
 create mode 100644 drivers/video/fbdev/omap2/dss/hdmi5_core.c
 create mode 100644 drivers/video/fbdev/omap2/dss/hdmi5_core.h

-- 
1.9.1

