From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 00/10] Nokia N950 basic display support
Date: Sun,  5 Mar 2017 00:50:11 +0100
Message-ID: <20170304235021.27055-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Some of you may remember, that I sent a series for the N950 display
some time ago. N950 has command mode DSI panel, so the main part of
the patchset takes care of adding manual display update support in
omapdrm.

The N950 also requires display rotation (the panel is mounted vertically
and bottom-up) and offset. The required bits will be sent separately.

The patchset is based on 2d62e0768d3c, which is the current commit
torvald's master branch points to. I tested the patches on N950
with kernel console (fbcon), Tomi's kmstest and Xorg from Debian sid.

Rough changelog, most of that work was done by Tony (thanks!)

 * lots of patches dropped for now
 * rebased to current omapdrm interface
 * added OMAP4 support
 * misc. cleanup

-- Sebastian

Sebastian Reichel (7):
  drm: omapdrm: panel-dsi-cm: add regulator support
  Revert "drm: omapdrm: Remove manual update display support"
  drm: omapdrm: crtc: save framedone callback from dss
  drm: omapdrm: crtc: detect manually updated displays
  drm: omapdrm: crtc: add support for manual updated displays
  drm: omapdrm: plane: update fifo size on atomic update
  ARM: dts: n950: add display support

Tony Lindgren (3):
  drm: omapdrm: panel-dsi-cm: Fix probe for device tree
  drm: omapdrm: crtc: handle framedone directly
  drm: omapdrm: crtc: get manual mode displays working

 arch/arm/boot/dts/omap3-n950.dts                |  89 +++++++++++++
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 120 ++++++++++++++---
 drivers/gpu/drm/omapdrm/dss/dispc.c             |   2 +
 drivers/gpu/drm/omapdrm/dss/omapdss.h           |   5 +
 drivers/gpu/drm/omapdrm/dss/output.c            |   6 +
 drivers/gpu/drm/omapdrm/omap_connector.c        |   7 +
 drivers/gpu/drm/omapdrm/omap_crtc.c             | 165 ++++++++++++++++++++++--
 drivers/gpu/drm/omapdrm/omap_drv.h              |   8 ++
 drivers/gpu/drm/omapdrm/omap_fb.c               |  28 ++++
 drivers/gpu/drm/omapdrm/omap_fbdev.c            |  57 +++++++-
 drivers/gpu/drm/omapdrm/omap_irq.c              |   7 +-
 drivers/gpu/drm/omapdrm/omap_plane.c            |  23 ++++
 12 files changed, 487 insertions(+), 30 deletions(-)

-- 
2.11.0
