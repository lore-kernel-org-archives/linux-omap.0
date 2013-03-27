From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 00/14] Add DT support to OMAPDSS
Date: Wed, 27 Mar 2013 10:45:07 +0200
Message-ID: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47661 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729Ab3C0IqR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 04:46:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This is an RFC for OMAPDSS DT support. I've only added support for a few boards
and a few DSS outputs, but they should give quite a good range of different use
cases. If these work well, I think the rest of the outputs and panels will be
ok too.

The purpose of this series is to get comments about the dts changes. There are
still work to be done, like adding DT binding documentation.

Some notes:

* DSS Submodules

The DSS submodules are children of the dss_core node. This is done because the
submodules require the dss_core to be alive and initialized to work, even if
the submodules are not really behind dss_core. Having the submodules as
children will make runtime PM automatically handle the dependency to dss_core.
I think usually a node being a child means that it's on the parent's bus, which
is not the case here. I'm not sure if that's an issue or not.

* ti,dsi-module-id

There's a ti,dsi-module-id property in the dsi node. The reason for this
module-id property is that we have muxes in the dss_core that route clocks
to/from a particular DSI module. So we need some way to index the DSI modules.
Another option would be to have a list of DSI modules (phandles) in the
dss_core. Both options feel a bit wrong to me, but I went for the module-id
approach as that is already used when not using DT.

* Display chains

Currently omapdss driver can handle only one display device connected to one
OMAP SoC output. This is not right in many cases, as there may be multiple
display devices in a chain, like first an external encoder and then a panel.
However, I tried to model this right in the dts. 

So, for example, for Panda HDMI output we have the following display "entities"
in a chain: OMAP SoC HDMI output, TPD12S015 ESD/level shifter, and HDMI
connector. These are connected using the "video-source" property, which tells
where the component in question gets its video data.

You could ask why there's a separate node for HDMI connector. It's true it's
not really a proper device, but we need some kind of terminator for the display
chains. For HDMI we could as well have an embedded solution, having a chain
like this: SoC HDMI, TPD12S015, hardwired embedded HDMI panel. So the connector
marks the end of the chain, and acts as a panel in a sense.

* DSI lanes

The DSI panels contain "lanes" property, which tells how the SoCs DSI pins are
connected to the DSI panel. I'm not sure if the panel data is the proper place
for this, or should the data be separately for the OMAP DSI node.

 Tomi

Tomi Valkeinen (14):
  ARM: OMAP: remove DSS DT hack
  ARM: OMAP2+: add omapdss_init_of()
  OMAPDSS: Add DT support to DSS, DISPC, DPI
  OMAPDSS: Add DT support to DSI
  OMAPDSS: Add DT support to HDMI
  OMAPDSS: Taal: Add DT support
  OMAPDSS: TFP410: Add DT support
  OMAPDSS: panel-generic-dpi: add DT support
  ARM: omap3.dtsi: add omapdss information
  ARM: omap4.dtsi: add omapdss information
  ARM: omap4-panda.dts: add display information
  ARM: omap4-sdp.dts: add display information
  ARM: omap3-tobi.dts: add lcd (TEST)
  ARM: omap3-beagle.dts: add TFP410

 arch/arm/boot/dts/omap3-beagle.dts               |   20 +++++
 arch/arm/boot/dts/omap3-tobi.dts                 |   13 ++++
 arch/arm/boot/dts/omap3.dtsi                     |   49 ++++++++++++
 arch/arm/boot/dts/omap4-panda.dts                |   44 +++++++++++
 arch/arm/boot/dts/omap4-sdp.dts                  |   64 ++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                     |   71 +++++++++++++++++
 arch/arm/mach-omap2/board-generic.c              |    9 +--
 arch/arm/mach-omap2/common.h                     |    2 +
 arch/arm/mach-omap2/display.c                    |   34 +++++++++
 arch/arm/mach-omap2/dss-common.c                 |   24 ------
 arch/arm/mach-omap2/dss-common.h                 |    2 -
 drivers/video/omap2/displays/panel-generic-dpi.c |   47 ++++++++++++
 drivers/video/omap2/displays/panel-taal.c        |   89 ++++++++++++++++++++++
 drivers/video/omap2/displays/panel-tfp410.c      |   71 +++++++++++++++++
 drivers/video/omap2/dss/dispc.c                  |    7 ++
 drivers/video/omap2/dss/dpi.c                    |    8 ++
 drivers/video/omap2/dss/dsi.c                    |   24 +++++-
 drivers/video/omap2/dss/dss.c                    |    7 ++
 drivers/video/omap2/dss/hdmi.c                   |    7 ++
 drivers/video/omap2/dss/hdmi_panel.c             |   86 ++++++++++++++++++++-
 20 files changed, 641 insertions(+), 37 deletions(-)

-- 
1.7.10.4

