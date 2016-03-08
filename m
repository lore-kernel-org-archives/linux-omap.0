From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 00/23] Nokia N950 display support
Date: Tue,  8 Mar 2016 17:39:32 +0100
Message-ID: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds support for the Nokia N950 display.
Since the panel is using DSI command mode, it involves
adding support for manually updated displays to
omapdrm.

The following patches, that are based on 4.5-rc7
were tested with fbcon and Xorg (from Debian sid)
on the N950.

-- Sebastian

Sebastian Reichel (22):
  ARM: dts: n9/n950: regulator configuration
  ARM: dts: n950: add display support
  drm: omapdrm: add DSI mapping
  Revert "drm: omapdrm: Remove manual update display support"
  drm: omapdrm: wait for pending operations before updating plane
  drm: omapdrm: crtc: switch pending variable to atomic bitset
  drm: omapdrm: crtc: add enabled bit to state
  drm: omapdrm: dss: method to get stallmode from lcd config
  drm: omapdrm: crtc: detect manually updated displays
  include: video: omapdss: provide fifo threshold methods
  drm: omapdrm: plane: update fifo size on atomic update
  drm: omapdrm: crtc: update plane fifos on lcd config change
  drm: omapdrm: crtc: save framedone callback from dss
  drm: omapdrm: crtc: add support for manual updated displays
  drm: omapdrm: update manual displays on dirty ioctl
  drm: omapdrm: panel-dsi-cm: add regulator support
  drm: omapdrm: panel-dsi-cm: use threaded irq handler
  drm: omapdrm: panel-dsi-cm: improve DT support
  drm: omapdrm: panel-dsi-cm: add offset support
  drm: omapdrm: panel-dsi-cm: block disable until update completed
  drm: omapdrm: panel-dsi-cm: ratelimit debug output in update path
  drm: omapdrm: panel-dsi-cm: provide timings methods for omapdrm

Tomi Valkeinen (1):
  drm: omapdrm: dss: reset dsi module during initialization

 arch/arm/boot/dts/omap3-n950-n9.dtsi            |  72 +++++++++
 arch/arm/boot/dts/omap3-n950.dts                |  71 +++++++++
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 163 ++++++++++++++++++---
 drivers/gpu/drm/omapdrm/dss/dsi.c               |  24 +++
 drivers/gpu/drm/omapdrm/dss/output.c            |   6 +
 drivers/gpu/drm/omapdrm/omap_crtc.c             | 185 +++++++++++++++++++++---
 drivers/gpu/drm/omapdrm/omap_drv.c              |   6 +
 drivers/gpu/drm/omapdrm/omap_drv.h              |   6 +
 drivers/gpu/drm/omapdrm/omap_fb.c               |  38 +++++
 drivers/gpu/drm/omapdrm/omap_fbdev.c            |  57 +++++++-
 drivers/gpu/drm/omapdrm/omap_plane.c            |  23 +++
 include/video/omapdss.h                         |   7 +
 12 files changed, 616 insertions(+), 42 deletions(-)

-- 
2.7.0
