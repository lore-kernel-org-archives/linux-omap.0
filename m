From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/20] OMAPDSS: add missing export for omap_dss_get_output()
Date: Fri, 8 Mar 2013 13:51:42 +0200
Message-ID: <1362743515-10152-8-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57870 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756697Ab3CHLwQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:16 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_dss_get_output() is a public function, but was missing
EXPORT_SYMBOL().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/output.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 79dea1a..5214df6 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -113,6 +113,7 @@ struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id)
 
 	return NULL;
 }
+EXPORT_SYMBOL(omap_dss_get_output);
 
 static const struct dss_mgr_ops *dss_mgr_ops;
 
-- 
1.7.10.4

