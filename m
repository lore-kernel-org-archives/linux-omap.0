From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv3 0/8] omapdrm: DSI command mode panel support
Date: Fri, 30 Mar 2018 19:18:14 +0200
Message-ID: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

These are the remaining patches from my previous patchset to get
Droid 4 (OMAP4) display working. The patches have been rebased to
linux-next tag next-20180329. I skipped the OMAP3 support patches.
They should get their own series, once this patchset has landed.

Working on Droid 4:
 * Framebuffer Console, updated at 1Hz due to blinking cursor
 * kmstest (static image)
 * Display blanking
 * Xorg with omap and modesetting driver
 * No updates send when nothing needs to be sent
 * Orientation DRM property is attached to the DSI panel

Known issues:
 * OMAP3 support is missing

Changes since PATCHv2:
 * Drop omap3 quirk patch (OMAP3 should get its own mini-series)
 * Rebase to current linux-next
 * Use existing 'rotation' DT property to set DRM orientation hint
 * Add Tested-by from Tony

Changes since PATCHv1:
 * Drop patches, that were queued by Tomi
 * Rebase to current master
 * Rework the omap3 workaround patch to only affect omap3
 * Add orientation DRM property support

-- Sebastian

Sebastian Reichel (8):
  drm/omap: add framedone interrupt support
  drm/omap: add manual update detection helper
  drm/omap: add support for manually updated displays
  drm/omap: make omap_framebuffer_get_next_connector static
  dt-bindings: panel: common: document orientation property
  drm/omap: add support for rotation hints from display drivers
  drm/omap: panel-dsi-cm: add rotation support
  ARM: dts: omap4-droid4: Add LCD panel rotation property

 .../bindings/display/panel/panel-common.txt        |  12 ++
 .../devicetree/bindings/display/panel/panel.txt    |   4 -
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   1 +
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |  13 ++
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |   2 +
 drivers/gpu/drm/omapdrm/omap_connector.c           |  42 +++++-
 drivers/gpu/drm/omapdrm/omap_connector.h           |   1 +
 drivers/gpu/drm/omapdrm/omap_crtc.c                | 155 +++++++++++++++++++--
 drivers/gpu/drm/omapdrm/omap_crtc.h                |   2 +
 drivers/gpu/drm/omapdrm/omap_fb.c                  |  74 ++++++----
 drivers/gpu/drm/omapdrm/omap_fb.h                  |   2 -
 drivers/gpu/drm/omapdrm/omap_irq.c                 |  25 ++++
 drivers/gpu/drm/omapdrm/omap_irq.h                 |   1 +
 13 files changed, 292 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel.txt

-- 
2.16.2
