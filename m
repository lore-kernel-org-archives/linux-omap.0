From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 00/10] omapdrm patches for 3.4
Date: Mon,  5 Mar 2012 10:48:30 -0600
Message-ID: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59920 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662Ab2CEQs5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 11:48:57 -0500
Received: by yhmm54 with SMTP id m54so1741570yhm.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 08:48:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

This is the (potentially first) batch of patches for omapdrm for 3.4.
It includes some fixes for OMAP3 (without DMM), and change in how
the DMM code gets it's platform data based on review comments from
the first version of the patch which added the omapdrm platform dev.

Also, a few cleanups, a better solution for handling fbdev calls from
atomix context, deferred unpin until scanout completes, mmap of tiled
buffers w/ stride larger than PAGE_SIZE.

There is one additional patch to come after the platform device patch
is merged (in arch/arm/plat-omap) to remove some duplicated structs.
And I am still working on support for scanout and rotated scanout of
tiled buffers, which may or may not be ready in time for 3.4 merge
window.

Andy Gross (3):
  staging: drm/omap: Disable DMM debugfs for OMAP3
  staging: drm/omap: Validate debugfs device
  staging: drm/omap: Get DMM resources from hwmod

Rob Clark (7):
  staging: drm/omap: get supported color formats from ovl
  staging: drm/omap: add a workqueue
  staging: drm/omap: call omap_gem_roll() in non-atomic ctx
  staging: drm/omap: some minor fb cleanups
  staging: drm/omap: defer unpin until scanout completes
  staging: drm/omap: debugfs for object and fb tracking
  staging: drm/omap: mmap of tiled buffers with stride >4kb

 drivers/staging/omapdrm/omap_debugfs.c   |   97 +++++++++++++++++-
 drivers/staging/omapdrm/omap_dmm_tiler.c |   91 ++++++++++++----
 drivers/staging/omapdrm/omap_dmm_tiler.h |   15 ++--
 drivers/staging/omapdrm/omap_drv.c       |   16 +++
 drivers/staging/omapdrm/omap_drv.h       |   17 +++-
 drivers/staging/omapdrm/omap_fb.c        |  124 +++++++++++++++-------
 drivers/staging/omapdrm/omap_fbdev.c     |   26 ++++-
 drivers/staging/omapdrm/omap_gem.c       |  172 ++++++++++++++++++++++--------
 drivers/staging/omapdrm/omap_plane.c     |  161 +++++++++++++++++++++++-----
 9 files changed, 570 insertions(+), 149 deletions(-)

-- 
1.7.5.4

