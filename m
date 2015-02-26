From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/21] drm/omap: handle mismatching color format and buffer width
Date: Thu, 26 Feb 2015 15:20:17 +0200
Message-ID: <1424956829-22892-10-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33276 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076AbbBZNVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:13 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdrm doesn't check if the width of the framebuffer and the color
format's bits-per-pixel match.

For example, using a display with a width of 1280, and a buffer
allocated with using 32 bits per pixel (i.e. 1280*4 = 5120 bytes), with
a 24 bits per pixel color format, leads to the following mismatch:
5120/3 = 1706.666... bytes. This causes bad colors and a tilt on the
screen.

Add a check into omapdrm to return an error if the user tries to use
such a combination.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_fb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 2975096abdf5..bf98580223d0 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -463,6 +463,14 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 			goto fail;
 		}
 
+		if (mode_cmd->width % format->planes[i].stride_bpp != 0) {
+			dev_err(dev->dev,
+				"buffer width (%d) is not a multiple of pixel width (%d)\n",
+				mode_cmd->width, format->planes[i].stride_bpp);
+			ret = -EINVAL;
+			goto fail;
+		}
+
 		size = pitch * mode_cmd->height / format->planes[i].sub_y;
 
 		if (size > (omap_gem_mmap_size(bos[i]) - mode_cmd->offsets[i])) {
-- 
2.3.0

