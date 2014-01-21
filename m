From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 00/41] OMAPDSS: DT support v3
Date: Tue, 21 Jan 2014 12:56:32 +0200
Message-ID: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Stefan Roese <stefan.roese@gmail.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Darren Etheridge <detheridge@ti.com>, Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Robert Nelson <robertcnelson@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

Hi,

Here's version 3 of the DSS DT series.

The previous version can be found from:

v1: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108249
v2: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108866

The main changes to v2 are:

- DT Binding documentation
- OMAP2 DSS support
- Split DSI register space
- DSS nodes disabled by default
- Hack to have generic DT bindings but OMAP specific drivers (for now)

This series can also be found from:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt-review-3

 Tomi

Javier Martinez Canillas (1):
  ARM: omap3-igep0020.dts: add display information

Sebastian Reichel (1):
  OMAPDSS: acx565akm: Add DT support

Tomi Valkeinen (39):
  ARM: OMAP2+: add omapdss_init_of()
  ARM: OMAP2+: DT 'compatible' tweak for displays
  OMAPDSS: add 'label' support for DT
  OMAPDSS: get dssdev->alias from DT alias
  OMAPFB: clean up default display search
  OMAPFB: search for default display with DT alias
  OMAPDSS: add of helpers
  OMAPDSS: Improve regulator names for DT
  OMAPDSS: Add DT support to DSS
  OMAPDSS: Add DT support to DISPC
  OMAPDSS: Add DT support to HDMI
  OMAPDSS: Add DT support to VENC
  OMAPDSS: Add DT support to DSI
  OMAPDSS: panel-dsi-cm: Add DT support
  OMAPDSS: encoder-tfp410: Add DT support
  OMAPDSS: connector-dvi: Add DT support
  OMAPDSS: encoder-tpd12s015: Add DT support
  OMAPDSS: hdmi-connector: Add DT support
  OMAPDSS: panel-dpi: Add DT support
  OMAPDSS: connector-analog-tv: Add DT support
  ARM: omap2.dtsi: add omapdss information
  ARM: omap3.dtsi: add omapdss information
  ARM: omap4.dtsi: add omapdss information
  ARM: omap4-panda.dts: add display information
  ARM: omap4-sdp.dts: add display information
  ARM: omap3-beagle.dts: add display information
  ARM: omap3-beagle-xm.dts: add display information
  ARM: omap3-n900.dts: add display information
  OMAPDSS: remove DT hacks for regulators
  ARM: OMAP2+: remove pdata quirks for displays
  Doc/DT: Add OMAP DSS DT Bindings
  Doc/DT: Add DT binding documentation for Analog TV Connector
  Doc/DT: Add DT binding documentation for DVI Connector
  Doc/DT: Add DT binding documentation for HDMI Connector
  Doc/DT: Add DT binding documentation for MIPI DPI Panel
  Doc/DT: Add DT binding documentation for MIPI DSI CM Panel
  Doc/DT: Add DT binding documentation for Sony acx565akm panel
  Doc/DT: Add DT binding documentation for TFP410 encoder
  Doc/DT: Add DT binding documentation for tpd12s015 encoder

 .../bindings/video/analog-tv-connector.txt         |  23 +++
 .../devicetree/bindings/video/dvi-connector.txt    |  26 +++
 .../devicetree/bindings/video/hdmi-connector.txt   |  23 +++
 .../devicetree/bindings/video/panel-dpi.txt        |  43 ++++
 .../devicetree/bindings/video/panel-dsi-cm.txt     |  26 +++
 .../devicetree/bindings/video/sony,acx565akm.txt   |  28 +++
 .../devicetree/bindings/video/ti,omap-dss.txt      | 197 ++++++++++++++++++
 .../devicetree/bindings/video/ti,omap2-dss.txt     |  54 +++++
 .../devicetree/bindings/video/ti,omap3-dss.txt     |  73 +++++++
 .../devicetree/bindings/video/ti,omap4-dss.txt     |  99 +++++++++
 .../devicetree/bindings/video/ti,tfp410.txt        |  41 ++++
 .../devicetree/bindings/video/ti,tpd12s015.txt     |  44 ++++
 .../devicetree/bindings/video/video-ports.txt      |  22 ++
 arch/arm/boot/dts/omap2.dtsi                       |  31 +++
 arch/arm/boot/dts/omap3-beagle-xm.dts              | 119 +++++++++++
 arch/arm/boot/dts/omap3-beagle.dts                 | 116 +++++++++++
 arch/arm/boot/dts/omap3-igep0020.dts               |  59 +++++-
 arch/arm/boot/dts/omap3-n900.dts                   |  70 ++++++-
 arch/arm/boot/dts/omap3.dtsi                       |  42 ++++
 arch/arm/boot/dts/omap4-panda-common.dtsi          | 119 ++++++++++-
 arch/arm/boot/dts/omap4-sdp.dts                    | 107 +++++++++-
 arch/arm/boot/dts/omap4.dtsi                       |  65 ++++++
 arch/arm/mach-omap2/board-generic.c                |   4 +
 arch/arm/mach-omap2/common.h                       |   3 +
 arch/arm/mach-omap2/display.c                      | 132 ++++++++++++
 arch/arm/mach-omap2/dss-common.c                   | 224 ---------------------
 arch/arm/mach-omap2/pdata-quirks.c                 |   3 -
 .../video/omap2/displays-new/connector-analog-tv.c |  43 +++-
 drivers/video/omap2/displays-new/connector-dvi.c   |  43 ++++
 drivers/video/omap2/displays-new/connector-hdmi.c  |  30 +++
 drivers/video/omap2/displays-new/encoder-tfp410.c  |  43 +++-
 .../video/omap2/displays-new/encoder-tpd12s015.c   |  56 ++++++
 drivers/video/omap2/displays-new/panel-dpi.c       |  64 +++++-
 drivers/video/omap2/displays-new/panel-dsi-cm.c    |  65 +++++-
 .../omap2/displays-new/panel-sony-acx565akm.c      |  33 ++-
 drivers/video/omap2/dss/Makefile                   |   2 +-
 drivers/video/omap2/dss/dispc.c                    |   8 +
 drivers/video/omap2/dss/display.c                  |  28 ++-
 drivers/video/omap2/dss/dpi.c                      |  47 +++++
 drivers/video/omap2/dss/dsi.c                      | 147 +++++++++++++-
 drivers/video/omap2/dss/dss-of.c                   | 159 +++++++++++++++
 drivers/video/omap2/dss/dss.c                      |  64 ++++++
 drivers/video/omap2/dss/dss.h                      |   6 +
 drivers/video/omap2/dss/hdmi4.c                    |  14 +-
 drivers/video/omap2/dss/sdi.c                      |  45 +++++
 drivers/video/omap2/dss/venc.c                     |  66 +++++-
 drivers/video/omap2/omapfb/omapfb-main.c           |  67 ++++--
 include/video/omapdss.h                            |  14 ++
 48 files changed, 2550 insertions(+), 287 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/analog-tv-connector.txt
 create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt
 create mode 100644 Documentation/devicetree/bindings/video/hdmi-connector.txt
 create mode 100644 Documentation/devicetree/bindings/video/panel-dpi.txt
 create mode 100644 Documentation/devicetree/bindings/video/panel-dsi-cm.txt
 create mode 100644 Documentation/devicetree/bindings/video/sony,acx565akm.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap2-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap3-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,omap4-dss.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,tfp410.txt
 create mode 100644 Documentation/devicetree/bindings/video/ti,tpd12s015.txt
 create mode 100644 Documentation/devicetree/bindings/video/video-ports.txt
 create mode 100644 drivers/video/omap2/dss/dss-of.c

-- 
1.8.3.2
