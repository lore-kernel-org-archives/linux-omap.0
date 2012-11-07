From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/3] OMAPDSS: APPLY: Remove unnecessary call to mg_clear_shadow_dirty
Date: Wed, 7 Nov 2012 14:47:24 +0530
Message-ID: <1352279844-10494-4-git-send-email-archit@ti.com>
References: <n>
 <1352279844-10494-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37207 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab2KGJR5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 04:17:57 -0500
In-Reply-To: <1352279844-10494-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

When doing a manual update in dss_mgr_start_update, we clear the shadow dirty
flags. Although there isn't any harm in clearing them. The need to clear them
out here should never arrive.

When applying configurations for a manual update manager, we never do any
register writes, i.e, calls to dss_mgr_write_regs and dss_mgr_write_regs_extra
never happen while applying. We do all these writes only when we call
dss_mgr_start_update. Hence, there is never a time when the shadow registers
are dirty.

Remove the call to mg_clear_shadow_dirty.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 37a5d22..7a7b820 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -772,8 +772,6 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 
 	dispc_mgr_enable_sync(mgr->id);
 
-	mgr_clear_shadow_dirty(mgr);
-
 	spin_unlock_irqrestore(&data_lock, flags);
 }
 
-- 
1.7.9.5

