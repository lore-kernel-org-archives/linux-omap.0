From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/4] drm/omap: Misc fixes and improvements
Date: Tue, 5 Mar 2013 19:47:46 +0530
Message-ID: <1362493070-17706-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39429 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847Ab3CEOSl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Mar 2013 09:18:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com, tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

These are misc fixes and improvements within omapdrm. There is one minor
omapdss fix here too, we get problems in omapdrm without it. The fixes do the
following:

- Make omapdrm smarter to choose the right overlay managers as it's crtcs. This
  makes sure that omapdrm is functional for OMAP platforms with different
  combinations of panels connected to it.

- Fix certain areas in omapdrm which allow fixed resolution panels to work.

Archit Taneja (4):
  drm/omap: Don't return from modeset_init if a panel doesn't satisfy
    omapdrm requirements
  drm/omap: Fix and improve crtc and overlay manager correlation
  drm/omap: Make fixed resolution panels work
  omapdss: features: fixed supported outputs for OMAP4

 drivers/gpu/drm/omapdrm/omap_connector.c |   10 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c      |   21 ++--
 drivers/gpu/drm/omapdrm/omap_drv.c       |  196 +++++++++++++++++++++++++-----
 drivers/gpu/drm/omapdrm/omap_drv.h       |   38 +-----
 drivers/gpu/drm/omapdrm/omap_encoder.c   |   13 +-
 drivers/gpu/drm/omapdrm/omap_irq.c       |   17 ++-
 drivers/video/omap2/dss/dss_features.c   |    6 +-
 7 files changed, 218 insertions(+), 83 deletions(-)

-- 
1.7.10.4

