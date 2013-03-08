From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/14] OMAPDSS: DSS: add new clock calculation code
Date: Fri, 8 Mar 2013 13:52:43 +0200
Message-ID: <1362743569-10289-9-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56493 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933870Ab3CHLxY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:53:24 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add new way to iterate over DSS clock divisors. dss_div_calc() provides
a generic way to go over all the divisors, within given clock range.
dss_div_calc() will call a callback function for each divider set,
making the function reusable for all use cases.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h |    3 +++
 2 files changed, 39 insertions(+)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 054c2a2..21a3dc8 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -473,6 +473,42 @@ int dss_calc_clock_rates(struct dss_clock_info *cinfo)
 	return 0;
 }
 
+bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
+{
+	int fckd, fckd_start, fckd_stop;
+	unsigned long fck;
+	unsigned long fck_hw_max;
+	unsigned long fckd_hw_max;
+	unsigned long prate;
+
+	if (dss.dpll4_m4_ck == NULL) {
+		/* XXX can we change the clock on omap2? */
+		fck = clk_get_rate(dss.dss_clk);
+		fckd = 1;
+
+		return func(fckd, fck, data);
+	}
+
+	fck_hw_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+	fckd_hw_max = dss.feat->fck_div_max;
+
+	prate = dss_get_dpll4_rate() * dss.feat->dss_fck_multiplier;
+
+	fck_min = fck_min ? fck_min : 1;
+
+	fckd_start = min(prate / fck_min, fckd_hw_max);
+	fckd_stop = max(DIV_ROUND_UP(prate, fck_hw_max), 1ul);
+
+	for (fckd = fckd_start; fckd >= fckd_stop; --fckd) {
+		fck = prate / fckd;
+
+		if (func(fckd, fck, data))
+			return true;
+	}
+
+	return false;
+}
+
 int dss_set_clock_div(struct dss_clock_info *cinfo)
 {
 	if (dss.dpll4_m4_ck) {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 0ff41dd..4180302 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -271,6 +271,9 @@ int dss_set_clock_div(struct dss_clock_info *cinfo);
 int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 		struct dispc_clock_info *dispc_cinfo);
 
+typedef bool (*dss_div_calc_func)(int fckd, unsigned long fck, void *data);
+bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data);
+
 /* SDI */
 int sdi_init_platform_driver(void) __init;
 void sdi_uninit_platform_driver(void) __exit;
-- 
1.7.10.4

