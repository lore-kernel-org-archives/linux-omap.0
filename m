From: <mythripk@ti.com>
Subject: [PATCH 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Tue, 20 Sep 2011 18:19:14 +0530
Message-ID: <1316522954-16594-6-git-send-email-mythripk@ti.com>
References: <1316522954-16594-1-git-send-email-mythripk@ti.com>
 <1316522954-16594-2-git-send-email-mythripk@ti.com>
 <1316522954-16594-3-git-send-email-mythripk@ti.com>
 <1316522954-16594-4-git-send-email-mythripk@ti.com>
 <1316522954-16594-5-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53933 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024Ab1ITM5U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 08:57:20 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8KCvHab029550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 07:57:19 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8KCvGp4005709
	for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 18:27:16 +0530 (IST)
In-Reply-To: <1316522954-16594-5-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add support to dump the HDMI regm, regn, and other clock parameters.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.c  |    3 +++
 drivers/video/omap2/dss/dss.h  |    1 +
 drivers/video/omap2/dss/hdmi.c |   31 +++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 3e09726..816daef 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -732,6 +732,9 @@ void dss_debug_dump_clocks(struct seq_file *s)
 #ifdef CONFIG_OMAP2_DSS_DSI
 	dsi_dump_clocks(s);
 #endif
+#ifdef CONFIG_OMAP2_DSS_HDMI
+	hdmi_dump_clocks(s);
+#endif
 }
 #endif
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8652007..ef8770a 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -473,6 +473,7 @@ void hdmi_uninit_platform_driver(void);
 int hdmi_init_display(struct omap_dss_device *dssdev);
 unsigned long hdmi_get_pixel_clock(void);
 void hdmi_dump_regs(struct seq_file *s);
+void hdmi_dump_clocks(struct seq_file *s);
 #else
 static inline int hdmi_init_display(struct omap_dss_device *dssdev)
 {
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 3262f0f..6751b1a 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -33,6 +33,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <video/omapdss.h>
+#include <linux/seq_file.h>
+
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 #include <sound/soc.h>
@@ -454,6 +456,35 @@ void hdmi_dump_regs(struct seq_file *s)
 	mutex_unlock(&hdmi.lock);
 }
 
+void hdmi_dump_clocks(struct seq_file *s)
+{
+	enum omap_dss_clk_source dispc_clk_src;
+
+	dispc_clk_src = dss_get_dispc_clk_source();
+
+	if (hdmi_runtime_get())
+		return;
+
+	seq_printf(s, "HDMI Clock Info\n");
+
+	seq_printf(s, "regm\t\t%dregmf %u\n",
+			hdmi.ip_data.pll_data.regm, hdmi.ip_data.pll_data.regm);
+
+	seq_printf(s, "dcofreq\t%dregsd %u\n",
+			hdmi.ip_data.pll_data.dcofreq,
+			hdmi.ip_data.pll_data.regsd);
+
+	seq_printf(s, "%s (%s)\t(%s)\n",
+			dss_get_generic_clk_source_name(dispc_clk_src),
+			dss_feat_get_clk_source_name(dispc_clk_src),
+			dispc_clk_src == OMAP_DSS_CLK_SRC_FCK ?
+			"off" : "on");
+
+	seq_printf(s, "hdmi fclk source = %d\n", hdmi.ip_data.pll_data.refsel);
+
+	hdmi_runtime_put();
+}
+
 int omapdss_hdmi_read_edid(u8 *buf, int len)
 {
 	int r;
-- 
1.7.5.4

