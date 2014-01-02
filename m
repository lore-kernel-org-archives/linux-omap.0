From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 3/4] drm/omap: fix: disable encoder before destroying it
Date: Thu, 2 Jan 2014 14:49:53 +0530
Message-ID: <1388654394-5708-4-git-send-email-archit@ti.com>
References: <1388654394-5708-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32892 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbaABJUL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Jan 2014 04:20:11 -0500
In-Reply-To: <1388654394-5708-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, robdclark@gmail.com
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, Archit Taneja <archit@ti.com>

Currently, an encoder is disabled only when an apply work is queued for the
corresponding crtc. This works fine for the paths where userspace explicitly
disables crtc, this results in disabling the omapdss device in the crtc's
pre_apply function.

However, when the omapdrm module is removed, there is no work queued to ensure
that the encoder is disabled. This can result in an enabled omapdss device when
removing omapdrm. omapdss is left in an inconsistent state, and that prevents us
from using that omapdss device being used again.

Disable enabled encoders in omap_encoder_destroy, we could consider a better
place for doing this later.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_encoder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 6a12e89..5290a88 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -51,6 +51,9 @@ struct omap_dss_device *omap_encoder_get_dssdev(struct drm_encoder *encoder)
 static void omap_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
+
+	omap_encoder_set_enabled(encoder, false);
+
 	drm_encoder_cleanup(encoder);
 	kfree(omap_encoder);
 }
-- 
1.8.3.2

