From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 56/65] OMAPDSS: APPLY: add dss_apply_ovl_enable()
Date: Tue, 22 Nov 2011 11:21:55 +0200
Message-ID: <1321953724-6350-57-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34074 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758213Ab1KVJYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:39 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add a helper function dss_apply_ovl_enable(), which is similar to the
main apply() function: dss_apply_ovl_enable() applies the given overlay
enable-status to ovl_priv_data, and sets the dirty flag.

The difference between the helper function and the previous direct use
of the fields is that the helper function will not do anything if the
enable state is already the same as given in the parameter.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 916acd7..cfc17c0 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -646,6 +646,19 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	return r;
 }
 
+static void dss_apply_ovl_enable(struct omap_overlay *ovl, bool enable)
+{
+	struct ovl_priv_data *op;
+
+	op = get_ovl_priv(ovl);
+
+	if (op->enabled == enable)
+		return;
+
+	op->enabled = enable;
+	op->extra_info_dirty = true;
+}
+
 static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
@@ -999,8 +1012,7 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	op->enabled = true;
-	op->extra_info_dirty = true;
+	dss_apply_ovl_enable(ovl, true);
 
 	dss_ovl_setup_fifo(ovl);
 
@@ -1031,8 +1043,7 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	op->enabled = false;
-	op->extra_info_dirty = true;
+	dss_apply_ovl_enable(ovl, false);
 
 	dss_write_regs();
 
-- 
1.7.4.1

