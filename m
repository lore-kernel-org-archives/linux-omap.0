From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] staging: drm/omap: update TODO
Date: Wed, 27 Jun 2012 15:11:38 -0500
Message-ID: <1340827898-7959-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34293 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab2F0ULx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 16:11:53 -0400
Received: by obbuo13 with SMTP id uo13so1926935obb.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 13:11:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Update TODO file, which had been neglected.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/TODO |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/omapdrm/TODO b/drivers/staging/omapdrm/TODO
index 55b1837..938c788 100644
--- a/drivers/staging/omapdrm/TODO
+++ b/drivers/staging/omapdrm/TODO
@@ -1,9 +1,7 @@
 TODO
-. check error handling/cleanup paths
-. add drm_plane / overlay support
 . add video decode/encode support (via syslink3 + codec-engine)
-. still some rough edges with flipping.. event back to userspace should
-  really come after VSYNC interrupt
+  . NOTE: with dmabuf this probably could be split into different driver
+    so perhaps this TODO doesn't belong here
 . where should we do eviction (detatch_pages())?  We aren't necessarily
   accessing the pages via a GART, so maybe we need some other threshold
   to put a cap on the # of pages that can be pin'd.  (It is mostly only
@@ -27,7 +25,6 @@ TODO
   CRTC's should be disabled, and on resume the LUT should be reprogrammed
   before CRTC's are re-enabled, to prevent DSS from trying to DMA from a
   buffer mapped in DMM/TILER before LUT is reloaded.
-. Add debugfs information for DMM/TILER
 
 Userspace:
 . git://github.com/robclark/xf86-video-omap.git
-- 
1.7.9.5

