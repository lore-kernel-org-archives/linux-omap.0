From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/14] OMAPDSS: DISPC: add new clock calculation code
Date: Fri, 8 Mar 2013 13:52:42 +0200
Message-ID: <1362743569-10289-8-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44144 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933886Ab3CHLxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 06:53:22 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add new way to iterate over DISPC clock divisors. dispc_div_calc()
provides a generic way to go over all the divisors, within given pixel
clock range. dispc_div_calc() will call a callback function for each
divider set, making the function reusable for all use cases.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   60 +++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h   |    6 ++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f564955..cd54e8f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3374,6 +3374,66 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 	return 0;
 }
 
+bool dispc_div_calc(unsigned long dispc,
+		unsigned long pck_min, unsigned long pck_max,
+		dispc_div_calc_func func, void *data)
+{
+	int lckd, lckd_start, lckd_stop;
+	int pckd, pckd_start, pckd_stop;
+	unsigned long pck, lck;
+	unsigned long lck_max;
+	unsigned long pckd_hw_min, pckd_hw_max;
+	unsigned min_fck_per_pck;
+	unsigned long fck;
+
+#ifdef CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK
+	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
+#else
+	min_fck_per_pck = 0;
+#endif
+
+	pckd_hw_min = dss_feat_get_param_min(FEAT_PARAM_DSS_PCD);
+	pckd_hw_max = dss_feat_get_param_max(FEAT_PARAM_DSS_PCD);
+
+	lck_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+
+	pck_min = pck_min ? pck_min : 1;
+	pck_max = pck_max ? pck_max : ULONG_MAX;
+
+	lckd_start = max(DIV_ROUND_UP(dispc, lck_max), 1ul);
+	lckd_stop = min(dispc / pck_min, 255ul);
+
+	for (lckd = lckd_start; lckd <= lckd_stop; ++lckd) {
+		lck = dispc / lckd;
+
+		pckd_start = max(DIV_ROUND_UP(lck, pck_max), pckd_hw_min);
+		pckd_stop = min(lck / pck_min, pckd_hw_max);
+
+		for (pckd = pckd_start; pckd <= pckd_stop; ++pckd) {
+			pck = lck / pckd;
+
+			/*
+			 * For OMAP2/3 the DISPC fclk is the same as LCD's logic
+			 * clock, which means we're configuring DISPC fclk here
+			 * also. Thus we need to use the calculated lck. For
+			 * OMAP4+ the DISPC fclk is a separate clock.
+			 */
+			if (dss_has_feature(FEAT_CORE_CLK_DIV))
+				fck = dispc_core_clk_rate();
+			else
+				fck = lck;
+
+			if (fck < pck * min_fck_per_pck)
+				continue;
+
+			if (func(lckd, pckd, lck, pck, data))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 void dispc_mgr_set_clock_div(enum omap_channel channel,
 		const struct dispc_clock_info *cinfo)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 610c8e5..0ff41dd 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -376,6 +376,12 @@ void dispc_enable_fifomerge(bool enable);
 void dispc_enable_gamma_table(bool enable);
 void dispc_set_loadmode(enum omap_dss_load_mode mode);
 
+typedef bool (*dispc_div_calc_func)(int lckd, int pckd, unsigned long lck,
+		unsigned long pck, void *data);
+bool dispc_div_calc(unsigned long dispc,
+		unsigned long pck_min, unsigned long pck_max,
+		dispc_div_calc_func func, void *data);
+
 bool dispc_mgr_timings_ok(enum omap_channel channel,
 		const struct omap_video_timings *timings);
 unsigned long dispc_fclk_rate(void);
-- 
1.7.10.4

