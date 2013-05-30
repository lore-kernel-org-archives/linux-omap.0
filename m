From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/27] OMAPDSS: dss-dev-model (Part 2/2)
Date: Thu, 30 May 2013 12:35:53 +0300
Message-ID: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41428 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030397Ab3E3Jgr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:36:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Igor Grinberg <grinberg@compulab.co.il>

Hi,

Here's are the first sets of patches targeting towards enabling DT for DSS and
changing the DSS device model to be more versatile. The exact division of the
sets of patches is still a bit open, and some splitting up for arch/driver
changes is needed, but most likely there will be at least the following major
sets, each based on the former one:

- base, containing cleanups and changes that do not yet really bring bigger new
  features
- dev-model, implements the new DSS device model, including new panel drivers
- dt, adds DSS DT support (not at all ready yet, although works for a few boards)

The patches can be found from the following branches:

git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model-base
git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model
git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model-dt

The set you are looking at is the "dev-model" set.

The "dev-model" implements a new model for display drivers. The model is very
much in the direction of CDF (Common Display Framework) as has been discussed
on the mailing lists. However, it's still OMAP specific, and, for example, the
display ops have not been improved but they were just copied from the old DSS
API to make the conversion simpler.

The first main change with the "dev-model" is that display devices/drivers are
no longer special omapdss device/driver types, but they are (usually)
devices/drivers of their control bus. This means that many devices/drivers are
platform devices/drivers, but some are i2c or spi devices/drivers.

The other main change is the use of "ops" instead of direct function calls.
This allows us to create "chains" of display entities, which allows us to
(finally) create proper drivers for external encoders. As an example, a board
with an external DSI-to-LVDS encoder chip and an LVDS panel was previously
modelled with a single display driver, handling both the encoder and the panel.
Now we can have separate drivers for the encoder and for the panel.

Note that to keep the old drivers and board files working, the old drivers and
the omapdss support needed for those is not removed yet. This makes the code
quite messy in a few places. The old code can be removed after all the panels
and board files have been converted.

In this set, the following board files have been converted so far:
- OMAP4 Blaze
- OMAP4 Panda
- Overo
- Beagle
- RX51 (not tested)

The panel drivers needed for the above have been converted, but there's still a
bunch of panel drivers not converted. Also, DSS RFBI driver has not been
converted.

The "dev-model" set brings back the support to have multiple panel devices
connected to the same video output, of which only one can be enabled at a time.
For example, DVI and a panel connected to OMAP's DPI output.

Overo board has an added difficulty to support the above: Overo board file adds
two panel devices, lcd43 and lcd35 (in reality those panels are not attached at
the same time, as they are located in add-on boards). Both panels have the same
GPIO used for reset. This causes a problem as when the panel drivers are
loaded, both drivers try to acquire the same GPIO, and the latter one fails.

To solve the problem, I added kernel boot command line parsing to Overo's board
file. The code looks for "default display" parameter for omapdss, and uses that
to decide which panel device to add.

Note that the above is not Overo specific, but as far as I know, Overo is the
only board having such a setup.

 Tomi


Tomi Valkeinen (27):
  OMAPDSS: public omapdss_register_output()
  OMAPDSS: modify get/find functions to go through the device chain
  OMAPDSS: add platform data structs for new panel drivers
  ARM: OMAP: dss-common: use new display drivers
  ARM: OMAP: overo: use new display drivers
  ARM: OMAP: rx51: use new display drivers
  ARM: OMAP: beagle: use new display drivers
  OMAPDSS: add OMAP_DISPLAY_TYPE_DVI
  drm/omap: DVI connector fix
  OMAPDSS: DPI: Add ops
  OMAPDSS: SDI: Add ops
  OMAPDSS: DVI: Add ops
  OMAPDSS: AnalogTV: Add ops
  OMAPDSS: HDMI: Add ops
  OMAPDSS: DSI: Add ops
  OMAPDSS: Add new TFP410 Encoder driver
  OMAPDSS: Add new TPD12S015 Encoder driver
  OMAPDSS: Add new DVI Connector driver
  OMAPDSS: Add new HDMI Connector driver
  OMAPDSS: Add new Analog TV Connector driver
  OMAPDSS: Add new simple DPI panel driver
  OMAPDSS: Add new DSI Command Mode panel  driver
  OMAPDSS: Add Sony ACX565AKM panel driver
  OMAPDSS: Add LG.Philips LB035Q02 panel driver
  ARM: OMAP: fix dsi regulator names
  ARM: OMAP: add vdds_dsi supply for dpi.0
  ARM: OMAP: add vdds_sdi supply for sdi.0

 arch/arm/mach-omap2/board-cm-t35.c                 |    3 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    1 +
 arch/arm/mach-omap2/board-ldp.c                    |    3 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   56 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    1 +
 arch/arm/mach-omap2/board-overo.c                  |  160 ++-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |   13 +
 arch/arm/mach-omap2/board-rx51-video.c             |   35 +-
 arch/arm/mach-omap2/dss-common.c                   |  185 +--
 arch/arm/mach-omap2/twl-common.c                   |    1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    6 +-
 drivers/video/omap2/Kconfig                        |    1 +
 drivers/video/omap2/Makefile                       |    1 +
 drivers/video/omap2/displays-new/Kconfig           |   52 +
 drivers/video/omap2/displays-new/Makefile          |    9 +
 .../video/omap2/displays-new/connector-analog-tv.c |  265 ++++
 drivers/video/omap2/displays-new/connector-dvi.c   |  351 +++++
 drivers/video/omap2/displays-new/connector-hdmi.c  |  375 ++++++
 drivers/video/omap2/displays-new/encoder-tfp410.c  |  270 ++++
 .../video/omap2/displays-new/encoder-tpd12s015.c   |  395 ++++++
 drivers/video/omap2/displays-new/panel-dpi.c       |  270 ++++
 drivers/video/omap2/displays-new/panel-dsi-cm.c    | 1336 ++++++++++++++++++++
 .../omap2/displays-new/panel-lgphilips-lb035q02.c  |  358 ++++++
 .../omap2/displays-new/panel-sony-acx565akm.c      |  864 +++++++++++++
 drivers/video/omap2/dss/apply.c                    |   14 +-
 drivers/video/omap2/dss/display.c                  |    1 +
 drivers/video/omap2/dss/dpi.c                      |   74 +-
 drivers/video/omap2/dss/dsi.c                      |   97 +-
 drivers/video/omap2/dss/dss.h                      |    4 -
 drivers/video/omap2/dss/hdmi.c                     |  252 +++-
 drivers/video/omap2/dss/output.c                   |   15 +-
 drivers/video/omap2/dss/rfbi.c                     |    4 +-
 drivers/video/omap2/dss/sdi.c                      |   82 +-
 drivers/video/omap2/dss/venc.c                     |   76 +-
 include/video/omap-panel-data.h                    |  150 +++
 include/video/omapdss.h                            |  195 ++-
 36 files changed, 5758 insertions(+), 217 deletions(-)
 create mode 100644 drivers/video/omap2/displays-new/Kconfig
 create mode 100644 drivers/video/omap2/displays-new/Makefile
 create mode 100644 drivers/video/omap2/displays-new/connector-analog-tv.c
 create mode 100644 drivers/video/omap2/displays-new/connector-dvi.c
 create mode 100644 drivers/video/omap2/displays-new/connector-hdmi.c
 create mode 100644 drivers/video/omap2/displays-new/encoder-tfp410.c
 create mode 100644 drivers/video/omap2/displays-new/encoder-tpd12s015.c
 create mode 100644 drivers/video/omap2/displays-new/panel-dpi.c
 create mode 100644 drivers/video/omap2/displays-new/panel-dsi-cm.c
 create mode 100644 drivers/video/omap2/displays-new/panel-lgphilips-lb035q02.c
 create mode 100644 drivers/video/omap2/displays-new/panel-sony-acx565akm.c

-- 
1.8.1.2

