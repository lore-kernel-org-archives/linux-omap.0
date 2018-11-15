From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv4 0/6] omapdrm: DSI command mode panel support
Date: Fri, 16 Nov 2018 00:06:39 +0100
Message-ID: <20181115230645.15748-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

Hi,

It's time for a new revision of the DSI command mode panel
patchset. The patches have been rebased to 4.20-rc1 + fixes
from Laurent and Tony. I dropped the patches for OMAP3 support
(it needs a workaround for a hardware bug) and for automatic
display rotation. They should get their own series, once this
patchset has landed.

Tested on Droid 4:
 * Framebuffer Console, updated at 1Hz due to blinking cursor
 * Display blanking
 * Xorg 1.19 with modesetting driver
 * Weston 5.0 with DRM backend
 * kmstest (static image)
 * No updates send when nothing needs to be sent

Known issues:
 * OMAP3 is untested and most likely broken due to missing
   workaround(s) for hardware bugs.
 * Weston 5.0 with fbdev backend does not work, since it
   uses neither page flip nor dirty ioctl. You need to use
   the drm backend.

Changes since PATCHv3:
 * Drop all Tested/Acked-by tags
 * Drop the rotation patches for now
 * Rebase to 4.20-rc1 + fixes from Laurent and Tony
 * Add fixes for DSI regressions introduced in 4.20-rc1
 * Store info update manual update mode in omap_crtc_state
 * Lock modesetting in omap_framebuffer_dirty
 * Directly loop through CRTCs instead of connectors in dirty function
 * Properly refresh display during page flips and get Weston working
 * Add more comments about implementation details

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

Sebastian Reichel (6):
  drm/omap: use DRM_DEBUG_DRIVER instead of CORE
  drm/omap: populate DSI platform bus earlier
  drm/omap: don't check dispc timings for DSI
  drm/omap: fix incorrect union usage
  drm/omap: add framedone interrupt support
  drm/omap: add support for manually updated displays

 drivers/gpu/drm/omapdrm/dss/dsi.c        |  20 +--
 drivers/gpu/drm/omapdrm/omap_connector.c |   8 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c      | 166 ++++++++++++++++++++++-
 drivers/gpu/drm/omapdrm/omap_crtc.h      |   2 +
 drivers/gpu/drm/omapdrm/omap_drv.h       |   4 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c   |  16 ++-
 drivers/gpu/drm/omapdrm/omap_fb.c        |  41 ++++++
 drivers/gpu/drm/omapdrm/omap_irq.c       |  25 ++++
 drivers/gpu/drm/omapdrm/omap_irq.h       |   1 +
 9 files changed, 260 insertions(+), 23 deletions(-)

-- 
2.19.1
