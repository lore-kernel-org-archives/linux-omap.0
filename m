From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 61/65] OMAPDSS: APPLY: add dss_ovl_simple_check()
Date: Tue, 22 Nov 2011 11:22:00 +0200
Message-ID: <1321953724-6350-62-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40541 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758237Ab1KVJYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:50 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dss_ovl_simple_check() which is used to check the validity of
certain overlay attributes. Only attributes that can be checked
independently, without knowing the display being used, is done here
(thus "simple").

We can use this function in dss_ovl_set_info().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   40 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 6a50ee0..c1c4597 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -928,12 +928,52 @@ err:
 }
 
 
+static int dss_ovl_simple_check(struct omap_overlay *ovl,
+		const struct omap_overlay_info *info)
+{
+	if (info->paddr == 0) {
+		DSSERR("check_overlay: paddr cannot be 0\n");
+		return -EINVAL;
+	}
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0) {
+		if (info->out_width != 0 && info->width != info->out_width) {
+			DSSERR("check_overlay: overlay %d doesn't support "
+					"scaling\n", ovl->id);
+			return -EINVAL;
+		}
+
+		if (info->out_height != 0 && info->height != info->out_height) {
+			DSSERR("check_overlay: overlay %d doesn't support "
+					"scaling\n", ovl->id);
+			return -EINVAL;
+		}
+	}
+
+	if ((ovl->supported_modes & info->color_mode) == 0) {
+		DSSERR("check_overlay: overlay %d doesn't support mode %d\n",
+				ovl->id, info->color_mode);
+		return -EINVAL;
+	}
+
+	if (info->zorder >= omap_dss_get_num_overlays()) {
+		DSSERR("check_overlay: zorder %d too high\n", info->zorder);
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
+	int r;
+
+	r = dss_ovl_simple_check(ovl, info);
+	if (r)
+		return r;
 
 	spin_lock_irqsave(&data_lock, flags);
 
-- 
1.7.4.1

