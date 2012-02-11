From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 4/5] OMAPDSS: Export functions to enable dynamic linking
Date: Sat, 11 Feb 2012 17:55:29 -0600
Message-ID: <1329004530-28029-5-git-send-email-ricardo.neri@ti.com>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37990 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289Ab2BKX4C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Feb 2012 18:56:02 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1BNu1qq017203
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:01 -0600
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1BNu1XV019805
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:01 -0600 (CST)
In-Reply-To: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

The functions dss_init_hdmi_ip_ops and dss_has_feature are used by
the ASoC HDMI codec. Both the ASoC codec and DSS may be built
as separate kernel modules. Hence, these two functions need to be
available for dynamic linking.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 004d34b..d5707b5 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/export.h>
 
 #include <video/omapdss.h>
 #include <plat/cpu.h>
@@ -514,6 +515,7 @@ void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data)
 	if (cpu_is_omap44xx())
 		ip_data->ops = &omap4_hdmi_functions;
 }
+EXPORT_SYMBOL(dss_init_hdmi_ip_ops);
 #endif
 
 /* Functions returning values related to a DSS feature */
@@ -579,6 +581,7 @@ bool dss_has_feature(enum dss_feat_id id)
 {
 	return omap_current_dss_features->has_feature & id;
 }
+EXPORT_SYMBOL(dss_has_feature);
 
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end)
 {
-- 
1.7.0.4

