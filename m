From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 00/14] omapdrm: DSI command mode panel support
Date: Mon, 24 Jul 2017 19:32:57 +0200
Message-ID: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

This adds support for command mode DSI panels to
omapdrm. I tested the patches on Nokia N950 (omap3)
and Motorola Droid 4 (omap4). This is basically
PATCHv3 of my series adding N950 display support,
but I started from scratch without reverting the
removal of manual display update support.

Tested:
 * Framebuffer Console
 * Display blanking
 * kmstest
 * Xorg with omap and modesetting driver
 * No updates send when nothing needs to be sent

Known issues:
 * Proper display rotation support
 * N950 (and N9) has first and last few lines
   covered by plastic, so we should expose a
   smaller screen

I plan to look into these issues once basic support
has been merged.

-- Sebastian

Sebastian Reichel (13):
  drm/omap: remove unused function defines
  drm/omap: drop incorrect comment
  drm/omap: plane: update fifo size on ovl setup
  drm/omap: add framedone interrupt support
  drm/omap: add manual update detection helper
  drm/omap: add support for manually updated displays
  drm/omap: add support for physical size hints from display drivers
  drm/omap: panel-dsi-cm: add regulator support
  drm/omap: panel-dsi-cm: add physical size support
  drm/omap: panel-dsi-cm: add external backlight support
  drm/omap: panel-dsi-cm: switch to gpiod
  ARM: dts: omap4-droid4: improve LCD description
  ARM: dts: n950: add display support

Tony Lindgren (1):
  drm/omap: panel-dsi-cm: fix driver

 arch/arm/boot/dts/omap3-n950.dts                |  88 ++++++++
 arch/arm/boot/dts/omap4-droid4-xt894.dts        |   6 +-
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 289 +++++++++++++++++-------
 drivers/gpu/drm/omapdrm/dss/dispc.c             |  16 ++
 drivers/gpu/drm/omapdrm/dss/omapdss.h           |   5 +-
 drivers/gpu/drm/omapdrm/omap_connector.c        |  14 ++
 drivers/gpu/drm/omapdrm/omap_crtc.c             | 158 ++++++++++++-
 drivers/gpu/drm/omapdrm/omap_drv.h              |   4 +
 drivers/gpu/drm/omapdrm/omap_fb.c               |  20 ++
 drivers/gpu/drm/omapdrm/omap_fbdev.c            |   3 -
 drivers/gpu/drm/omapdrm/omap_irq.c              |  24 ++
 11 files changed, 529 insertions(+), 98 deletions(-)

-- 
2.13.2
