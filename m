From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/21] drm/omap: fix plane's channel selection
Date: Thu, 26 Feb 2015 15:20:19 +0200
Message-ID: <1424956829-22892-12-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38332 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932317AbbBZNVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:16 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_plane_pre_apply() sets the plane's output channel too late, only
after the plane has already been otherwise configured and enabled. This
causes problems, as at the configuration stage we need to make decisions
based on the output channel.

This may lead to bad plane settings or failing to setup the plane.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index bedd6f7af0f1..8e94694ba8a3 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -153,6 +153,8 @@ static void omap_plane_pre_apply(struct omap_drm_apply *apply)
 	ilace = false;
 	replication = false;
 
+	dispc_ovl_set_channel_out(omap_plane->id, channel);
+
 	/* and finally, update omapdss: */
 	ret = dispc_ovl_setup(omap_plane->id, info,
 			replication, omap_crtc_timings(crtc), false);
@@ -162,7 +164,6 @@ static void omap_plane_pre_apply(struct omap_drm_apply *apply)
 	}
 
 	dispc_ovl_enable(omap_plane->id, true);
-	dispc_ovl_set_channel_out(omap_plane->id, channel);
 }
 
 static void omap_plane_post_apply(struct omap_drm_apply *apply)
-- 
2.3.0

