From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 22/23] OMAPDSS: APPLY: Remove omap_dss_device references from dss_ovl_enable/disable
Date: Thu, 30 Aug 2012 17:10:44 +0530
Message-ID: <1346326845-16583-23-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41051 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab2H3Lnh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:43:37 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

An overlay isn't allowed to be enabled/disabled if it isn't connected to an
omap_dss_device. This requirement isn't needed any more. An overlay can be
enabled/disabled as long as it has an output connected to it. The output may
not be connected to a device, but we can be assured that the connected
manager's output is in use by an output interface.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 8a05cbc..d584f0c 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1607,8 +1607,7 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 		goto err1;
 	}
 
-	if (ovl->manager == NULL ||
-			ovl->manager->get_device(ovl->manager) == NULL) {
+	if (ovl->manager == NULL || ovl->manager->output == NULL) {
 		r = -EINVAL;
 		goto err1;
 	}
@@ -1677,8 +1676,7 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 		goto err;
 	}
 
-	if (ovl->manager == NULL ||
-			ovl->manager->get_device(ovl->manager) == NULL) {
+	if (ovl->manager == NULL || ovl->manager->output == NULL) {
 		r = -EINVAL;
 		goto err;
 	}
-- 
1.7.9.5

