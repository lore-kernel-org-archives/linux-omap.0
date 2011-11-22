From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 62/65] OMAPDSS: APPLY: add dss_mgr_simple_check()
Date: Tue, 22 Nov 2011 11:22:01 +0200
Message-ID: <1321953724-6350-63-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56560 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758246Ab1KVJYw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:52 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dss_mgr_simple_check() which is used to check the validity of
certain manager attributes. Only attributes that can be checked
independently, without knowing the display being used, is done here
(thus "simple").

We can use this function in dss_mgr_set_info().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index c1c4597..5d933b9 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -834,11 +834,35 @@ out:
 	mutex_unlock(&apply_lock);
 }
 
+static int dss_mgr_simple_check(struct omap_overlay_manager *mgr,
+		const struct omap_overlay_manager_info *info)
+{
+	if (dss_has_feature(FEAT_ALPHA_FIXED_ZORDER)) {
+		/*
+		 * OMAP3 supports only graphics source transparency color key
+		 * and alpha blending simultaneously. See TRM 15.4.2.4.2.2
+		 * Alpha Mode.
+		 */
+		if (info->partial_alpha_enabled && info->trans_enabled
+			&& info->trans_key_type != OMAP_DSS_COLOR_KEY_GFX_DST) {
+			DSSERR("check_manager: illegal transparency key\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
+	int r;
+
+	r = dss_mgr_simple_check(mgr, info);
+	if (r)
+		return r;
 
 	spin_lock_irqsave(&data_lock, flags);
 
-- 
1.7.4.1

