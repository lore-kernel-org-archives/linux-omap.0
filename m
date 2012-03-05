From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 08/10] staging: drm/omap: Validate debugfs device
Date: Mon,  5 Mar 2012 10:48:38 -0600
Message-ID: <1330966120-28582-9-git-send-email-rob.clark@linaro.org>
References: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35311 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab2CEQtV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 11:49:21 -0500
Received: by mail-gx0-f174.google.com with SMTP id e5so973465ggh.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 08:49:21 -0800 (PST)
In-Reply-To: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Andy Gross <andy.gross@ti.com>

Added check for valid device information before dumping debugfs
information.

Signed-off-by: Andy Gross <andy.gross@ti.com>
Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_dmm_tiler.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/staging/omapdrm/omap_dmm_tiler.c
index 852d944..e4c7bb6 100644
--- a/drivers/staging/omapdrm/omap_dmm_tiler.c
+++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
@@ -766,10 +766,18 @@ int tiler_map_show(struct seq_file *s, void *arg)
 	const char *a2d = special;
 	const char *m2dp = m2d, *a2dp = a2d;
 	char nice[128];
-	int h_adj = omap_dmm->lut_height / ydiv;
-	int w_adj = omap_dmm->lut_width / xdiv;
+	int h_adj;
+	int w_adj;
 	unsigned long flags;
 
+	if (!omap_dmm) {
+		/* early return if dmm/tiler device is not initialized */
+		return 0;
+	}
+
+	h_adj = omap_dmm->lut_height / ydiv;
+	w_adj = omap_dmm->lut_width / xdiv;
+
 	map = kzalloc(h_adj * sizeof(*map), GFP_KERNEL);
 	global_map = kzalloc((w_adj + 1) * h_adj, GFP_KERNEL);
 
-- 
1.7.5.4

