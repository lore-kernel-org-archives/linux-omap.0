From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 00/27] OMAPDSS: DT support v2
Date: Mon, 16 Dec 2013 16:56:07 +0200
Message-ID: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54774 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466Ab3LPO6U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

Hi,

Here's version 2 of the DSS DT series. Hopefully I have fixed all the issues
that were found with v1
(http://article.gmane.org/gmane.linux.ports.arm.omap/108249), except missing
binding documentation and lacking patch descriptions.

The main changes are:

- DPI and SDI are no longer dummy devices, but ports on the DSS node. This
  reflects better the actual hardware.
- Pinmuxing
- Labels for displays

Additionally smaller changes, like using symbolic names in the .dts files,
fixing endpoint numbering, etc.

This series can also be found from:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt-review-2

 Tomi

Javier Martinez Canillas (1):
  ARM: omap3-igep0020.dts: add display information

Tomi Valkeinen (26):
  ARM: OMAP: remove DSS DT hack
  OMAPDSS: remove DT hacks for regulators
  ARM: OMAP2+: add omapdss_init_of()
  OMAPDSS: add 'label' support for DT
  OMAPDSS: get dssdev->alias from DT alias
  OMAPFB: clean up default display search
  OMAPFB: search for default display with DT alias
  OMAPDSS: add of helpers
  OMAPDSS: Add DT support to DSS, DISPC, DPI and SDI.
  OMAPDSS: Add DT support to HDMI
  OMAPDSS: Add DT support to VENC
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

 arch/arm/boot/dts/omap3-beagle-xm.dts              | 118 ++++++++++
 arch/arm/boot/dts/omap3-beagle.dts                 | 115 +++++++++
 arch/arm/boot/dts/omap3-igep0020.dts               |  64 ++++-
 arch/arm/boot/dts/omap3-tobi.dts                   |  47 ++++
 arch/arm/boot/dts/omap3.dtsi                       |  35 +++
 arch/arm/boot/dts/omap4-panda-common.dtsi          | 121 +++++++++-
 arch/arm/boot/dts/omap4-sdp.dts                    | 116 +++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  54 +++++
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
 drivers/video/omap2/dss/display.c                  |  28 ++-
 drivers/video/omap2/dss/dpi.c                      |  47 ++++
 drivers/video/omap2/dss/dsi.c                      | 141 ++++++++++-
 drivers/video/omap2/dss/dss-of.c                   | 162 +++++++++++++
 drivers/video/omap2/dss/dss.c                      |  63 +++++
 drivers/video/omap2/dss/dss.h                      |   6 +
 drivers/video/omap2/dss/hdmi4.c                    |  10 +-
 drivers/video/omap2/dss/sdi.c                      |  45 ++++
 drivers/video/omap2/dss/venc.c                     |  34 +++
 drivers/video/omap2/omapfb/omapfb-main.c           |  67 ++++--
 include/video/omapdss.h                            |  14 ++
 35 files changed, 1685 insertions(+), 322 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/dss-common.c
 delete mode 100644 arch/arm/mach-omap2/dss-common.h
 create mode 100644 drivers/video/omap2/dss/dss-of.c

-- 
1.8.3.2

