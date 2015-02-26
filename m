From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/21] drm/omap: clear omap_obj->paddr in omap_gem_put_paddr()
Date: Thu, 26 Feb 2015 15:20:11 +0200
Message-ID: <1424956829-22892-4-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38305 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbbBZNVD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:03 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Clear omap_obj's paddr when unmapping the memory, so that it's easier to
catch bad use of the paddr.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index aeb91ed653c9..9b250c93b046 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -828,6 +828,7 @@ int omap_gem_put_paddr(struct drm_gem_object *obj)
 				dev_err(obj->dev->dev,
 					"could not release unmap: %d\n", ret);
 			}
+			omap_obj->paddr = 0;
 			omap_obj->block = NULL;
 		}
 	}
-- 
2.3.0

