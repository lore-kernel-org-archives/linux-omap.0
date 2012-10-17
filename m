From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/9] OMAPDSS: fix registering the vsync isr in apply
Date: Wed, 17 Oct 2012 14:20:28 +0300
Message-ID: <1350472835-28727-3-git-send-email-tomi.valkeinen@ti.com>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59174 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626Ab2JQLUn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 07:20:43 -0400
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When we enable an output we don't check if we need to register the vsync
isr. This causes us to miss vsync interrupts until somebody changes the
configuration of an overlay or an overlay manager.

Add the registration to dss_mgr_enable to fix the problem.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 19d66f4..29ce5a8 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1035,6 +1035,9 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
 	if (!mgr_manual_update(mgr))
 		mp->updating = true;
 
+	if (!dss_data.irq_enabled && need_isr())
+		dss_register_vsync_isr();
+
 	spin_unlock_irqrestore(&data_lock, flags);
 
 	if (!mgr_manual_update(mgr))
-- 
1.7.9.5

