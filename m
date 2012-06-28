From: Archit Taneja <archit@ti.com>
Subject: [PATCH 09/12] OMAPDSS: APPLY: Remove usage of omap_dss_device from manual/auto update checks
Date: Thu, 28 Jun 2012 20:00:39 +0530
Message-ID: <1340893842-10626-11-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41742 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961Ab2F1Ock (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:32:40 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

APPLY needs to know at certain places whether an overlay manager is in manual
or auto update mode. The caps of the connected omap_dss_device were used to
check that.

A LCD manager is in manual update if stallmode is enabled for that manager. TV
managers for now always auto update.

Return the value of stallmode parameter in the private data 'lcd_confg' in
mgr_manual_update() and ovl_manual_update(), for TV managers stallmode field
will be false by default.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 95a6713..b9c6e75 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -182,14 +182,23 @@ void dss_apply_init(void)
 	mp->lcd_config.clock_info.pck_div = 1;
 }
 
+/*
+ * A LCD manager's stallmode decides whether it is in manual or auto update. TV
+ * manager is always auto update, stallmode field for TV manager is false by
+ * default
+ */
 static bool ovl_manual_update(struct omap_overlay *ovl)
 {
-	return ovl->manager->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
+	struct mgr_priv_data *mp = get_mgr_priv(ovl->manager);
+
+	return mp->lcd_config.stallmode;
 }
 
 static bool mgr_manual_update(struct omap_overlay_manager *mgr)
 {
-	return mgr->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+
+	return mp->lcd_config.stallmode;
 }
 
 static int dss_check_settings_low(struct omap_overlay_manager *mgr,
-- 
1.7.9.5

