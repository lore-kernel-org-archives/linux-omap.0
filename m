From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 0/2] drm/omap: properties patches
Date: Wed, 15 Aug 2012 15:18:00 -0500
Message-ID: <1345061882-9743-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35087 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2HOUSS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 16:18:18 -0400
Received: by obbuo13 with SMTP id uo13so2563161obb.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 13:18:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Re-sending the earlier rotation property patch, plus Andre's z-order
property patch rebased on latest staging-next.

Andre Renaud (1):
  Expose the OMAP Z-Order property through DRM

Rob Clark (1):
  staging: drm/omap: add rotation properties

 drivers/staging/omapdrm/omap_crtc.c      |   10 +++
 drivers/staging/omapdrm/omap_dmm_tiler.c |   47 +++++++++++--
 drivers/staging/omapdrm/omap_dmm_tiler.h |   17 ++++-
 drivers/staging/omapdrm/omap_drv.c       |   17 +++++
 drivers/staging/omapdrm/omap_drv.h       |   33 ++++++++-
 drivers/staging/omapdrm/omap_fb.c        |   99 ++++++++++++++++++++++----
 drivers/staging/omapdrm/omap_gem.c       |   43 +++++++++++-
 drivers/staging/omapdrm/omap_plane.c     |  111 ++++++++++++++++++++++++------
 8 files changed, 331 insertions(+), 46 deletions(-)

-- 
1.7.9.5

