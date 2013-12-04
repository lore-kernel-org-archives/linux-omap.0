From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Wed, 4 Dec 2013 14:28:27 +0200
Message-ID: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52194 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755496Ab3LDMaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Dec 2013 07:30:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

Hi,

Here's a new version for DT support to OMAP Display Subsystem. See
http://article.gmane.org/gmane.linux.ports.arm.omap/102689 for the intro of the
previous version, which contains thoughts about the related problems.

The major change in this version is the use of V4L2 and CDF style port/endpoint
style in the DT data. However, note that even if the DT data contains proper
port & endpoint data, the drivers only use the first endpoint. This is to
simplify the patches, as adding full support for the ports and endpoints to the
drivers will be a big task. This approach still works with more or less all the
boards, as the only cases where the simpler model is an issue are the boards
with multiple display devices connected to a single output.

Laurent, I'd appreciate if you could have a look at the .dts changes, to see if
there's anything that's clearly not CDF compatible.

The patches can also be found from:
git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt

A few notes:

- The DT data are added separately in the end of .dts files for clarity. In the
  final version I will move them to appropriate places in the .dts files.

- No binding documentation. I will add them for the next version, if there are
  no major changes needed. Hopefully the bindings are quite self-explanatory
  for people with understanding of the hardware in question.

- The connectors' compatible strings are "ti,xxx". As there's nothing TI
  specific there, I think I will rename them to be without "ti".

 Tomi

Tomi Valkeinen (26):
  OMAPDSS: rename display-sysfs 'name' entry
  OMAPDSS: DSI: fix fifosize
  ARM: OMAP: remove DSS DT hack
  OMAPDSS: remove DT hacks for regulators
  ARM: OMAP2+: add omapdss_init_of()
  OMAPDSS: if dssdev->name==NULL, use alias
  OMAPDSS: get dssdev->alias from DT alias
  OMAPFB: clean up default display search
  OMAPFB: search for default display with DT alias
  OMAPDSS: add of helpers
  OMAPDSS: Add DT support to DSS, DISPC, DPI, HDMI, VENC
  OMAPDSS: Add DT support to DSI
  ARM: omap3.dtsi: add omapdss information
  ARM: omap4.dtsi: add omapdss information
  ARM: omap4-panda.dts: add display information
  ARM: omap4-sdp.dts: add display information
  ARM: omap3-tobi.dts: add lcd (TEST)
  ARM: omap3-beagle.dts: add display information
  ARM: omap3-beagle-xm.dts: add display information
  OMAPDSS: panel-dsi-cm: Add DT support
  OMAPDSS: encoder-tfp410: Add DT support
  OMAPDSS: connector-dvi: Add DT support
  OMAPDSS: encoder-tpd12s015: Add DT support
  OMAPDSS: hdmi-connector: Add DT support
  OMAPDSS: panel-dpi: Add DT support
  OMAPDSS: connector-analog-tv: Add DT support

 arch/arm/boot/dts/omap3-beagle-xm.dts              |  67 ++++++
 arch/arm/boot/dts/omap3-beagle.dts                 |  67 ++++++
 arch/arm/boot/dts/omap3-tobi.dts                   |  40 ++++
 arch/arm/boot/dts/omap3.dtsi                       |  43 ++++
 arch/arm/boot/dts/omap4-panda-common.dtsi          | 102 ++++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |  91 ++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  58 +++++
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/board-generic.c                |   2 +
 arch/arm/mach-omap2/common.h                       |   2 +
 arch/arm/mach-omap2/display.c                      |  62 +++++
 arch/arm/mach-omap2/dss-common.c                   | 259 ---------------------
 arch/arm/mach-omap2/dss-common.h                   |  13 --
 arch/arm/mach-omap2/pdata-quirks.c                 |   4 -
 .../video/omap2/displays-new/connector-analog-tv.c |  66 +++++-
 drivers/video/omap2/displays-new/connector-dvi.c   |  43 ++++
 drivers/video/omap2/displays-new/connector-hdmi.c  |  30 +++
 drivers/video/omap2/displays-new/encoder-tfp410.c  |  43 +++-
 .../video/omap2/displays-new/encoder-tpd12s015.c   |  56 +++++
 drivers/video/omap2/displays-new/panel-dpi.c       |  64 ++++-
 drivers/video/omap2/displays-new/panel-dsi-cm.c    |  65 +++++-
 drivers/video/omap2/dss/Makefile                   |   2 +-
 drivers/video/omap2/dss/dispc.c                    |   7 +
 drivers/video/omap2/dss/display-sysfs.c            |   4 +-
 drivers/video/omap2/dss/display.c                  |  23 +-
 drivers/video/omap2/dss/dpi.c                      |  50 ++++
 drivers/video/omap2/dss/dsi.c                      | 166 +++++++++++--
 drivers/video/omap2/dss/dss-of.c                   | 160 +++++++++++++
 drivers/video/omap2/dss/dss.c                      |  10 +
 drivers/video/omap2/dss/hdmi4.c                    |  10 +-
 drivers/video/omap2/dss/venc.c                     |  34 +++
 drivers/video/omap2/omapfb/omapfb-main.c           |  67 ++++--
 include/video/omapdss.h                            |   6 +
 33 files changed, 1390 insertions(+), 328 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/dss-common.c
 delete mode 100644 arch/arm/mach-omap2/dss-common.h
 create mode 100644 drivers/video/omap2/dss/dss-of.c

-- 
1.8.3.2

