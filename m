From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 07/10] staging: drm/omap: Disable DMM debugfs for OMAP3
Date: Mon,  5 Mar 2012 10:48:37 -0600
Message-ID: <1330966120-28582-8-git-send-email-rob.clark@linaro.org>
References: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59920 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756326Ab2CEQtT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 11:49:19 -0500
Received: by mail-yw0-f46.google.com with SMTP id m54so1741570yhm.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 08:49:19 -0800 (PST)
In-Reply-To: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Andy Gross <andy.gross@ti.com>

OMAP3 does not contain a DMM/Tiler block.  As such, we should not
be exposing any DMM debugfs entries on OMAP3 platforms.

Added inline helper function to verify existence of DMM.

Signed-off-by: Andy Gross <andy.gross@ti.com>
Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_debugfs.c   |   15 +++++++--------
 drivers/staging/omapdrm/omap_dmm_tiler.h |    6 ++++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_debugfs.c b/drivers/staging/omapdrm/omap_debugfs.c
index e23f907..2f122e0 100644
--- a/drivers/staging/omapdrm/omap_debugfs.c
+++ b/drivers/staging/omapdrm/omap_debugfs.c
@@ -112,12 +112,10 @@ int omap_debugfs_init(struct drm_minor *minor)
 		return ret;
 	}
 
-	/* TODO: only do this if has_dmm.. but this fxn gets called before
-	 * dev_load() so we don't know this yet..
-	 */
-	ret = drm_debugfs_create_files(omap_dmm_debugfs_list,
-			ARRAY_SIZE(omap_dmm_debugfs_list),
-			minor->debugfs_root, minor);
+	if (dmm_is_available())
+		ret = drm_debugfs_create_files(omap_dmm_debugfs_list,
+				ARRAY_SIZE(omap_dmm_debugfs_list),
+				minor->debugfs_root, minor);
 
 	if (ret) {
 		dev_err(dev->dev, "could not install omap_dmm_debugfs_list\n");
@@ -131,8 +129,9 @@ void omap_debugfs_cleanup(struct drm_minor *minor)
 {
 	drm_debugfs_remove_files(omap_debugfs_list,
 			ARRAY_SIZE(omap_debugfs_list), minor);
-	drm_debugfs_remove_files(omap_dmm_debugfs_list,
-			ARRAY_SIZE(omap_dmm_debugfs_list), minor);
+	if (dmm_is_available())
+		drm_debugfs_remove_files(omap_dmm_debugfs_list,
+				ARRAY_SIZE(omap_dmm_debugfs_list), minor);
 }
 
 #endif
diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.h b/drivers/staging/omapdrm/omap_dmm_tiler.h
index f87cb65..55ab284 100644
--- a/drivers/staging/omapdrm/omap_dmm_tiler.h
+++ b/drivers/staging/omapdrm/omap_dmm_tiler.h
@@ -16,6 +16,7 @@
 #ifndef OMAP_DMM_TILER_H
 #define OMAP_DMM_TILER_H
 
+#include <plat/cpu.h>
 #include "omap_drv.h"
 #include "tcm.h"
 
@@ -132,4 +133,9 @@ struct omap_dmm_platform_data {
 	int irq;
 };
 
+static inline int dmm_is_available(void)
+{
+	return cpu_is_omap44xx();
+}
+
 #endif
-- 
1.7.5.4

