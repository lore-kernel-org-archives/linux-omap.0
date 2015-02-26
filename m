From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/21] drm/omap: misc fixes/improvements
Date: Thu, 26 Feb 2015 15:20:08 +0200
Message-ID: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50936 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbbBZNU7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:20:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Various small(ish) fixes and improvements for omapdrm.

Laurent, some of these may conflict with your work. I'm fine with dropping the
conflicting ones from this series, as long as the issue has been fixed in your
WIP branch. Or maybe some of these should be rebased on top of your work.

 Tomi

Tomi Valkeinen (21):
  drm/omap: fix encoder-crtc mapping
  drm/omap: page_flip: return -EBUSY if flip pending
  drm/omap: clear omap_obj->paddr in omap_gem_put_paddr()
  drm/omap: add pin refcounting to omap_framebuffer
  drm/omap: add a comment why locking is missing
  drm/omap: check CRTC color format earlier
  drm/omap: fix operation without fbdev
  drm/omap: fix error handling in omap_framebuffer_create()
  drm/omap: handle mismatching color format and buffer width
  drm/omap: fix TILER on OMAP5
  drm/omap: fix plane's channel selection
  drm/omap: tiler: fix race condition with engine->async
  drm/omap: remove dummy PM functions
  drm/omap: stop connector polling during suspend
  drm/omap: use DRM_ERROR_RATELIMITED() for error irqs
  drm/omap: fix race with error_irq
  drm/omap: only ignore DIGIT SYNC LOST for TV output
  drm/omap: do not use BUG_ON(!spin_is_locked(x))
  drm/omap: fix race condition with dev->obj_list
  drm/omap: fix race conditon in DMM
  drm/omap: keep ref to old_fb

 drivers/gpu/drm/omapdrm/omap_crtc.c      | 44 +++++++++++++++--------
 drivers/gpu/drm/omapdrm/omap_dmm_priv.h  |  8 ++++-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 54 +++++++++++++++++++++++-----
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.h |  1 +
 drivers/gpu/drm/omapdrm/omap_drv.c       | 60 +++++++++++++++++---------------
 drivers/gpu/drm/omapdrm/omap_drv.h       |  3 ++
 drivers/gpu/drm/omapdrm/omap_fb.c        | 26 ++++++++++++--
 drivers/gpu/drm/omapdrm/omap_gem.c       | 10 ++++--
 drivers/gpu/drm/omapdrm/omap_irq.c       |  2 +-
 drivers/gpu/drm/omapdrm/omap_plane.c     | 28 +++++++++++++--
 10 files changed, 176 insertions(+), 60 deletions(-)

-- 
2.3.0

