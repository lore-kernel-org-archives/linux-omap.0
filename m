From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] staging: omap/drm: dmm should return proper errors
Date: Wed, 21 Mar 2012 16:40:23 -0500
Message-ID: <1332366023-23218-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45995 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240Ab2CUVk0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 17:40:26 -0400
Received: by obbeh20 with SMTP id eh20so971154obb.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 14:40:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Minor error path clean-up.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_dmm_tiler.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/staging/omapdrm/omap_dmm_tiler.c
index 852d944..33c1d54 100644
--- a/drivers/staging/omapdrm/omap_dmm_tiler.c
+++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
@@ -345,7 +345,7 @@ struct tiler_block *tiler_reserve_2d(enum tiler_fmt fmt, uint16_t w,
 	ret = tcm_reserve_2d(containers[fmt], w, h, align, &block->area);
 	if (ret) {
 		kfree(block);
-		return 0;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	/* add to allocation list */
@@ -369,7 +369,7 @@ struct tiler_block *tiler_reserve_1d(size_t size)
 	if (tcm_reserve_1d(containers[TILFMT_PAGE], num_pages,
 				&block->area)) {
 		kfree(block);
-		return 0;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	spin_lock(&omap_dmm->list_lock);
-- 
1.7.5.4

