From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/4] OMAP: DSS2: Add Color Phase Rotation support
Date: Wed, 22 Jun 2011 11:45:24 +0300
Message-ID: <1308732326-17278-3-git-send-email-tomi.valkeinen@ti.com>
References: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:56024 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753484Ab1FVIps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 04:45:48 -0400
In-Reply-To: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add Color Phase Rotation (CPR) support and sysfs files to enable CPR and
to set the CPR coefficient matrix.

CPR is enabled via manager?/cpr_enable file, and the coefficient matrix
is set via manager?/cpr_coef file. The values in cpr_coef are in the
following order:

RR RG RB GR GG GB BR BG BB

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   34 +++++++++++
 drivers/video/omap2/dss/dss.h     |    3 +
 drivers/video/omap2/dss/manager.c |  114 +++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h           |    9 +++
 4 files changed, 160 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index eac768f..0151f16 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1082,6 +1082,40 @@ void dispc_enable_gamma_table(bool enable)
 	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
 }
 
+void dispc_enable_cpr(enum omap_channel channel, bool enable)
+{
+	u16 reg;
+
+	if (channel == OMAP_DSS_CHANNEL_LCD)
+		reg = DISPC_CONFIG;
+	else if (channel == OMAP_DSS_CHANNEL_LCD2)
+		reg = DISPC_CONFIG2;
+	else
+		return;
+
+	REG_FLD_MOD(reg, enable, 15, 15);
+}
+
+void dispc_set_cpr_coef(enum omap_channel channel,
+		struct omap_dss_cpr_coefs *coefs)
+{
+	u32 coef_r, coef_g, coef_b;
+
+	if (channel != OMAP_DSS_CHANNEL_LCD && channel != OMAP_DSS_CHANNEL_LCD2)
+		return;
+
+	coef_r = FLD_VAL(coefs->rr, 31, 22) | FLD_VAL(coefs->rg, 20, 11) |
+		FLD_VAL(coefs->rb, 9, 0);
+	coef_g = FLD_VAL(coefs->gr, 31, 22) | FLD_VAL(coefs->gg, 20, 11) |
+		FLD_VAL(coefs->gb, 9, 0);
+	coef_b = FLD_VAL(coefs->br, 31, 22) | FLD_VAL(coefs->bg, 20, 11) |
+		FLD_VAL(coefs->bb, 9, 0);
+
+	dispc_write_reg(DISPC_CPR_COEF_R(channel), coef_r);
+	dispc_write_reg(DISPC_CPR_COEF_G(channel), coef_g);
+	dispc_write_reg(DISPC_CPR_COEF_B(channel), coef_b);
+}
+
 static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
 {
 	u32 val;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ce17a61..9dc5c00 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -398,6 +398,9 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high);
 void dispc_enable_fifomerge(bool enable);
 void dispc_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size);
+void dispc_enable_cpr(enum omap_channel channel, bool enable);
+void dispc_set_cpr_coef(enum omap_channel channel,
+		struct omap_dss_cpr_coefs *coefs);
 
 void dispc_set_plane_ba0(enum omap_plane plane, u32 paddr);
 void dispc_set_plane_ba1(enum omap_plane plane, u32 paddr);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 4691b81..ad76c5b 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -275,6 +275,108 @@ static ssize_t manager_alpha_blending_enabled_store(
 	return size;
 }
 
+static ssize_t manager_cpr_enable_show(struct omap_overlay_manager *mgr,
+		char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", mgr->info.cpr_enable);
+}
+
+static ssize_t manager_cpr_enable_store(struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	int v;
+	int r;
+	bool enable;
+
+	if (!dss_has_feature(FEAT_CPR))
+		return -ENODEV;
+
+	r = kstrtoint(buf, 0, &v);
+	if (r)
+		return r;
+
+	enable = !!v;
+
+	mgr->get_manager_info(mgr, &info);
+
+	if (info.cpr_enable == enable)
+		return size;
+
+	info.cpr_enable = enable;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_cpr_coef_show(struct omap_overlay_manager *mgr,
+		char *buf)
+{
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE,
+			"%d %d %d %d %d %d %d %d %d\n",
+			info.cpr_coefs.rr,
+			info.cpr_coefs.rg,
+			info.cpr_coefs.rb,
+			info.cpr_coefs.gr,
+			info.cpr_coefs.gg,
+			info.cpr_coefs.gb,
+			info.cpr_coefs.br,
+			info.cpr_coefs.bg,
+			info.cpr_coefs.bb);
+}
+
+static ssize_t manager_cpr_coef_store(struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	struct omap_dss_cpr_coefs coefs;
+	int r, i;
+	s16 *arr;
+
+	if (!dss_has_feature(FEAT_CPR))
+		return -ENODEV;
+
+	if (sscanf(buf, "%hd %hd %hd %hd %hd %hd %hd %hd %hd",
+				&coefs.rr, &coefs.rg, &coefs.rb,
+				&coefs.gr, &coefs.gg, &coefs.gb,
+				&coefs.br, &coefs.bg, &coefs.bb) != 9)
+		return -EINVAL;
+
+	arr = (s16[]){ coefs.rr, coefs.rg, coefs.rb,
+		coefs.gr, coefs.gg, coefs.gb,
+		coefs.br, coefs.bg, coefs.bb };
+
+	for (i = 0; i < 9; ++i) {
+		if (arr[i] < -512 || arr[i] > 511)
+			return -EINVAL;
+	}
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.cpr_coefs = coefs;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
 struct manager_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct omap_overlay_manager *, char *);
@@ -300,6 +402,12 @@ static MANAGER_ATTR(trans_key_enabled, S_IRUGO|S_IWUSR,
 static MANAGER_ATTR(alpha_blending_enabled, S_IRUGO|S_IWUSR,
 		manager_alpha_blending_enabled_show,
 		manager_alpha_blending_enabled_store);
+static MANAGER_ATTR(cpr_enable, S_IRUGO|S_IWUSR,
+		manager_cpr_enable_show,
+		manager_cpr_enable_store);
+static MANAGER_ATTR(cpr_coef, S_IRUGO|S_IWUSR,
+		manager_cpr_coef_show,
+		manager_cpr_coef_store);
 
 
 static struct attribute *manager_sysfs_attrs[] = {
@@ -310,6 +418,8 @@ static struct attribute *manager_sysfs_attrs[] = {
 	&manager_attr_trans_key_value.attr,
 	&manager_attr_trans_key_enabled.attr,
 	&manager_attr_alpha_blending_enabled.attr,
+	&manager_attr_cpr_enable.attr,
+	&manager_attr_cpr_coef.attr,
 	NULL
 };
 
@@ -858,6 +968,10 @@ static void configure_manager(enum omap_channel channel)
 	dispc_set_trans_key(channel, mi->trans_key_type, mi->trans_key);
 	dispc_enable_trans_key(channel, mi->trans_enabled);
 	dispc_enable_alpha_blending(channel, mi->alpha_enabled);
+	if (dss_has_feature(FEAT_CPR)) {
+		dispc_enable_cpr(channel, mi->cpr_enable);
+		dispc_set_cpr_coef(channel, &mi->cpr_coefs);
+	}
 }
 
 /* configure_dispc() tries to write values from cache to shadow registers.
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index e02823e..3b55ef2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -290,6 +290,12 @@ extern const struct omap_video_timings omap_dss_pal_timings;
 extern const struct omap_video_timings omap_dss_ntsc_timings;
 #endif
 
+struct omap_dss_cpr_coefs {
+	s16 rr, rg, rb;
+	s16 gr, gg, gb;
+	s16 br, bg, bb;
+};
+
 struct omap_overlay_info {
 	bool enabled;
 
@@ -349,6 +355,9 @@ struct omap_overlay_manager_info {
 	bool trans_enabled;
 
 	bool alpha_enabled;
+
+	bool cpr_enable;
+	struct omap_dss_cpr_coefs cpr_coefs;
 };
 
 struct omap_overlay_manager {
-- 
1.7.4.1

