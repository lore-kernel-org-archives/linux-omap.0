From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/5] OMAPDSS: apply: wait pending updates on manager disable
Date: Thu, 16 Oct 2014 12:39:45 +0300
Message-ID: <1413452387-25452-3-git-send-email-tomi.valkeinen@ti.com>
References: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45704 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbaJPJj5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2014 05:39:57 -0400
In-Reply-To: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

We should wait for any pending updates when an overlay manager is
about to be disabled, because the updates will never be finished if the
manager is disabled too early.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/apply.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/apply.c b/drivers/video/fbdev/omap2/dss/apply.c
index 0a0b084ce65d..663ccc3bf4e5 100644
--- a/drivers/video/fbdev/omap2/dss/apply.c
+++ b/drivers/video/fbdev/omap2/dss/apply.c
@@ -1132,6 +1132,8 @@ static void dss_mgr_disable_compat(struct omap_overlay_manager *mgr)
 	if (!mp->enabled)
 		goto out;
 
+	wait_pending_extra_info_updates();
+
 	if (!mgr_manual_update(mgr))
 		dispc_mgr_disable_sync(mgr->id);
 
-- 
2.1.1

