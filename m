From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/26] OMAPDSS: add omap_dss_find_output_by_node()
Date: Tue, 26 Mar 2013 15:33:33 +0200
Message-ID: <1364304836-18134-4-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55851 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934241Ab3CZNeg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:36 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add a support function to find a DSS output by given DT node. This is
used in later patches to link the panels to DSS outputs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/output.c |   13 +++++++++++++
 include/video/omapdss.h          |    1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 3274628..4d01001 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -128,6 +128,19 @@ struct omap_dss_output *omap_dss_find_output(const char *name)
 }
 EXPORT_SYMBOL(omap_dss_find_output);
 
+struct omap_dss_output *omap_dss_find_output_by_node(struct device_node *node)
+{
+	struct omap_dss_output *out;
+
+	list_for_each_entry(out, &output_list, list) {
+		if (out->pdev->dev.of_node == node)
+			return out;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(omap_dss_find_output_by_node);
+
 static const struct dss_mgr_ops *dss_mgr_ops;
 
 int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index aad47a2..7fe6144 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -780,6 +780,7 @@ struct omap_overlay *omap_dss_get_overlay(int num);
 
 struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id);
 struct omap_dss_output *omap_dss_find_output(const char *name);
+struct omap_dss_output *omap_dss_find_output_by_node(struct device_node *node);
 int omapdss_output_set_device(struct omap_dss_output *out,
 		struct omap_dss_device *dssdev);
 int omapdss_output_unset_device(struct omap_dss_output *out);
-- 
1.7.10.4

