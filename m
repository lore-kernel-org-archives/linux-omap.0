From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/12] OMAPDSS: add dss_calc_clock_rates() back
Date: Tue, 30 Oct 2012 18:10:04 +0200
Message-ID: <1351613409-21186-8-git-send-email-tomi.valkeinen@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52999 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933955Ab2J3QKb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 12:10:31 -0400
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_calc_clock_rates() was removed earlier as it was not used, but it is
needed for DSI PLL calculations, so this patch adds it back.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   23 +++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h |    1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index a85bd05..5affa86 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -432,6 +432,29 @@ enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
 	}
 }
 
+/* calculate clock rates using dividers in cinfo */
+int dss_calc_clock_rates(struct dss_clock_info *cinfo)
+{
+	if (dss.dpll4_m4_ck) {
+		unsigned long prate;
+
+		if (cinfo->fck_div > dss.feat->fck_div_max ||
+				cinfo->fck_div == 0)
+			return -EINVAL;
+
+		prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
+
+		cinfo->fck = prate / cinfo->fck_div *
+			dss.feat->dss_fck_multiplier;
+	} else {
+		if (cinfo->fck_div != 0)
+			return -EINVAL;
+		cinfo->fck = clk_get_rate(dss.dss_clk);
+	}
+
+	return 0;
+}
+
 int dss_set_clock_div(struct dss_clock_info *cinfo)
 {
 	if (dss.dpll4_m4_ck) {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index fb89165..ae4e618 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -297,6 +297,7 @@ void dss_set_venc_output(enum omap_dss_venc_type type);
 void dss_set_dac_pwrdn_bgz(bool enable);
 
 unsigned long dss_get_dpll4_rate(void);
+int dss_calc_clock_rates(struct dss_clock_info *cinfo);
 int dss_set_clock_div(struct dss_clock_info *cinfo);
 int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 		struct dispc_clock_info *dispc_cinfo);
-- 
1.7.10.4

