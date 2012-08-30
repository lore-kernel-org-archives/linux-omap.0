From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 21/23] OMAPDSS: MANAGER: Get device via output
Date: Thu, 30 Aug 2012 17:10:43 +0530
Message-ID: <1346326845-16583-22-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34311 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab2H3Lnd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:43:33 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

A manager is not connected to a device directly any more. It first connects
to an output, and then to the display. Update the manager's get_device op to
return the device via the connected output.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/manager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index d808ce2..d14ffc5 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -509,7 +509,7 @@ static struct kobj_type manager_ktype = {
 
 static inline struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_manager *mgr)
 {
-	return mgr->device;
+	return mgr->output ? mgr->output->device : NULL;
 }
 
 static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
-- 
1.7.9.5

