From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 3/6] OMAPDSS: DSS: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 13:58:04 +0530
Message-ID: <19a46cc15dc7add0671dd8c32f5398249c0420ab.1343912533.git.cmahapatra@ti.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44873 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab2HGIaN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Aug 2012 04:30:13 -0400
In-Reply-To: <cover.1343912532.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The cpu_is checks have been removed from dss.c providing it a much generic and
cleaner interface. The OMAP version and revision specific functions are
initialized by dss_ops structure in dss features.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dss.c          |  114 ++++++++++++++++++++++----------
 drivers/video/omap2/dss/dss.h          |   23 ++++++-
 drivers/video/omap2/dss/dss_features.c |   40 +++++++++++
 drivers/video/omap2/dss/dss_features.h |    1 +
 4 files changed, 141 insertions(+), 37 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7b1c6ac..c263da7 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -83,6 +83,8 @@ static struct {
 
 	bool		ctx_valid;
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
+
+	const struct dss_ops *ops;
 } dss;
 
 static const char * const dss_generic_clk_source_names[] = {
@@ -236,6 +238,15 @@ const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src)
 	return dss_generic_clk_source_names[clk_src];
 }
 
+char *set_dump_clk_str_24_34(void)
+{
+	return "%s (%s) = %lu / %lu * 2  = %lu\n";
+}
+
+char *set_dump_clk_str(void)
+{
+	return "%s (%s) = %lu / %lu  = %lu\n";
+}
 
 void dss_dump_clocks(struct seq_file *s)
 {
@@ -254,23 +265,15 @@ void dss_dump_clocks(struct seq_file *s)
 	fclk_rate = clk_get_rate(dss.dss_clk);
 
 	if (dss.dpll4_m4_ck) {
+		char *str = dss.ops->set_str();
+
 		dpll4_ck_rate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
 		dpll4_m4_ck_rate = clk_get_rate(dss.dpll4_m4_ck);
 
 		seq_printf(s, "dpll4_ck %lu\n", dpll4_ck_rate);
 
-		if (cpu_is_omap3630() || cpu_is_omap44xx())
-			seq_printf(s, "%s (%s) = %lu / %lu  = %lu\n",
-					fclk_name, fclk_real_name,
-					dpll4_ck_rate,
-					dpll4_ck_rate / dpll4_m4_ck_rate,
-					fclk_rate);
-		else
-			seq_printf(s, "%s (%s) = %lu / %lu * 2 = %lu\n",
-					fclk_name, fclk_real_name,
-					dpll4_ck_rate,
-					dpll4_ck_rate / dpll4_m4_ck_rate,
-					fclk_rate);
+		seq_printf(s, str, fclk_name, fclk_real_name, dpll4_ck_rate,
+				dpll4_ck_rate / dpll4_m4_ck_rate, fclk_rate);
 	} else {
 		seq_printf(s, "%s (%s) = %lu\n",
 				fclk_name, fclk_real_name,
@@ -461,6 +464,35 @@ unsigned long dss_get_dpll4_rate(void)
 		return 0;
 }
 
+u16 get_dss_fck_div_max_24_34(void)
+{
+	return 16;
+}
+
+u16 get_dss_fck_div_max(void)
+{
+	return 32;
+}
+
+bool set_dss_clock_info_34xx(void)
+{
+	unsigned long prate = dss_get_dpll4_rate();
+	unsigned long fck = clk_get_rate(dss.dss_clk);
+
+	if (prate == dss.cache_prate || dss.cache_dss_cinfo.fck == fck)
+		return true;
+	return false;
+}
+
+bool set_dss_clock_info(void)
+{
+	unsigned long fck = clk_get_rate(dss.dss_clk);
+
+	if (dss.cache_dss_cinfo.fck == fck)
+		return true;
+	return false;
+}
+
 int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 		struct dispc_clock_info *dispc_cinfo)
 {
@@ -470,7 +502,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 
 	unsigned long fck, max_dss_fck;
 
-	u16 fck_div, fck_div_max = 16;
+	u16 fck_div, fck_div_max;
 
 	int match = 0;
 	int min_fck_per_pck;
@@ -479,10 +511,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
-	fck = clk_get_rate(dss.dss_clk);
-	if (req_pck == dss.cache_req_pck &&
-			((cpu_is_omap34xx() && prate == dss.cache_prate) ||
-			 dss.cache_dss_cinfo.fck == fck)) {
+	if (req_pck == dss.cache_req_pck && dss.ops->set_dss_cinfo()) {
 		DSSDBG("dispc clock info found from cache.\n");
 		*dss_cinfo = dss.cache_dss_cinfo;
 		*dispc_cinfo = dss.cache_dispc_cinfo;
@@ -519,8 +548,7 @@ retry:
 
 		goto found;
 	} else {
-		if (cpu_is_omap3630() || cpu_is_omap44xx())
-			fck_div_max = 32;
+		fck_div_max = dss.ops->get_fck_div_max();
 
 		for (fck_div = fck_div_max; fck_div > 0; --fck_div) {
 			struct dispc_clock_info cur_dispc;
@@ -619,6 +647,32 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
 	return REG_GET(DSS_CONTROL, 15, 15);
 }
 
+int dss_get_clk_24xx(struct clk *clk)
+{
+	clk = NULL;
+	return true;
+}
+
+int dss_get_clk_3xxx(struct clk *clk)
+{
+	clk = clk_get(NULL, "dpll4_m4_ck");
+	if (IS_ERR(clk)) {
+		DSSERR("Failed to get dpll4_m4_ck\n");
+		return PTR_ERR(clk);
+	}
+	return true;
+}
+
+int dss_get_clk_44xx(struct clk *clk)
+{
+	clk = clk_get(NULL, "dpll_per_m5x2_ck");
+	if (IS_ERR(clk)) {
+		DSSERR("Failed to get dpll_per_m5x2_ck\n");
+		return PTR_ERR(clk);
+	}
+	return true;
+}
+
 static int dss_get_clocks(void)
 {
 	struct clk *clk;
@@ -633,23 +687,9 @@ static int dss_get_clocks(void)
 
 	dss.dss_clk = clk;
 
-	if (cpu_is_omap34xx()) {
-		clk = clk_get(NULL, "dpll4_m4_ck");
-		if (IS_ERR(clk)) {
-			DSSERR("Failed to get dpll4_m4_ck\n");
-			r = PTR_ERR(clk);
-			goto err;
-		}
-	} else if (cpu_is_omap44xx()) {
-		clk = clk_get(NULL, "dpll_per_m5x2_ck");
-		if (IS_ERR(clk)) {
-			DSSERR("Failed to get dpll_per_m5x2_ck\n");
-			r = PTR_ERR(clk);
-			goto err;
-		}
-	} else { /* omap24xx */
-		clk = NULL;
-	}
+	r = dss.ops->get_clk(clk);
+	if (r != true)
+		goto err;
 
 	dss.dpll4_m4_ck = clk;
 
@@ -750,6 +790,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
+	dss_init_ops(dss.ops);
+
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5773c86..b756ae1 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -19,7 +19,6 @@
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-
 #ifndef __OMAP2_DSS_H
 #define __OMAP2_DSS_H
 
@@ -186,6 +185,15 @@ struct dispc_ops {
 			int hbp, int vsw, int vfp, int vbp);
 };
 
+struct clk;
+
+struct dss_ops {
+	u16 (*get_fck_div_max) (void);
+	bool (*set_dss_cinfo) (void);
+	int (*get_clk) (struct clk *clk);
+	char *(*set_str) (void);
+};
+
 struct seq_file;
 struct platform_device;
 
@@ -315,6 +323,19 @@ int dss_set_clock_div(struct dss_clock_info *cinfo);
 int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 		struct dispc_clock_info *dispc_cinfo);
 
+u16 get_dss_fck_div_max_24_34(void);
+u16 get_dss_fck_div_max(void);
+
+bool set_dss_clock_info(void);
+bool set_dss_clock_info_34xx(void);
+
+int dss_get_clk_24xx(struct clk *clk);
+int dss_get_clk_3xxx(struct clk *clk);
+int dss_get_clk_44xx(struct clk *clk);
+
+char *set_dump_clk_str_24_34(void);
+char *set_dump_clk_str(void);
+
 /* SDI */
 int sdi_init_platform_driver(void) __init;
 void sdi_uninit_platform_driver(void) __exit;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b8d5095..6b35200 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -609,6 +609,46 @@ void dispc_init_ops(const struct dispc_ops *ops)
 	}
 }
 
+static const struct dss_ops omap2_dss_ops = {
+	.get_fck_div_max	=	get_dss_fck_div_max_24_34,
+	.set_dss_cinfo		=	set_dss_clock_info,
+	.get_clk		=	dss_get_clk_24xx,
+	.set_str		=	set_dump_clk_str_24_34,
+};
+
+static const struct dss_ops omap34_dss_ops = {
+	.get_fck_div_max	=	get_dss_fck_div_max_24_34,
+	.set_dss_cinfo		=	set_dss_clock_info_34xx,
+	.get_clk		=	dss_get_clk_3xxx,
+	.set_str		=	set_dump_clk_str_24_34,
+};
+
+static const struct dss_ops omap36_dss_ops = {
+	.get_fck_div_max	=	get_dss_fck_div_max,
+	.set_dss_cinfo		=	set_dss_clock_info,
+	.get_clk		=	dss_get_clk_3xxx,
+	.set_str		=	set_dump_clk_str,
+};
+
+static const struct dss_ops omap4_dss_ops = {
+	.get_fck_div_max	=	get_dss_fck_div_max,
+	.set_dss_cinfo		=	set_dss_clock_info,
+	.get_clk		=	dss_get_clk_44xx,
+	.set_str		=	set_dump_clk_str,
+};
+
+void dss_init_ops(const struct dss_ops *ops)
+{
+	if (cpu_is_omap24xx())
+		ops = &omap2_dss_ops;
+	else if (cpu_is_omap34xx())
+		ops = &omap34_dss_ops;
+	else if (cpu_is_omap3630())
+		ops = &omap36_dss_ops;
+	else
+		ops = &omap4_dss_ops;
+}
+
 #if defined(CONFIG_OMAP4_DSS_HDMI)
 /* HDMI OMAP4 Functions*/
 static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index d03777a..aa1e4b6 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -122,4 +122,5 @@ void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data);
 #endif
 
 void dispc_init_ops(const struct dispc_ops *ops);
+void dss_init_ops(const struct dss_ops *ops);
 #endif
-- 
1.7.10

