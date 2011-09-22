From: <mythripk@ti.com>
Subject: [PATCH v2 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Thu, 22 Sep 2011 13:37:46 +0530
Message-ID: <1316678866-17749-6-git-send-email-mythripk@ti.com>
References: <1316678866-17749-1-git-send-email-mythripk@ti.com>
 <1316678866-17749-2-git-send-email-mythripk@ti.com>
 <1316678866-17749-3-git-send-email-mythripk@ti.com>
 <1316678866-17749-4-git-send-email-mythripk@ti.com>
 <1316678866-17749-5-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33483 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab1IVIPv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Sep 2011 04:15:51 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8M8FmKX028491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 03:15:50 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8M8FmBs011477
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 13:45:48 +0530 (IST)
In-Reply-To: <1316678866-17749-5-git-send-email-mythripk@ti.com>
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
 drivers/video/omap2/dss/hdmi.c |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 3e09726..76e2bcd 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -732,6 +732,9 @@ void dss_debug_dump_clocks(struct seq_file *s)
 #ifdef CONFIG_OMAP2_DSS_DSI
 	dsi_dump_clocks(s);
 #endif
+#ifdef CONFIG_OMAP4_DSS_HDMI
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
index 3262f0f..8930998 100644
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
@@ -454,6 +456,39 @@ void hdmi_dump_regs(struct seq_file *s)
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
+	seq_printf(s, "- HDMI PLL -\n");
+
+	seq_printf(s, "regm\t%u\n", hdmi.ip_data.pll_data.regm);
+
+	seq_printf(s, "regmf\t%u\n", hdmi.ip_data.pll_data.regmf);
+
+	seq_printf(s, "dcofreq\t%u\n", hdmi.ip_data.pll_data.dcofreq);
+
+	seq_printf(s, "regsd\t%u\n", hdmi.ip_data.pll_data.regsd);
+
+	seq_printf(s, "DISPC clock source %s (%s)\t(%s)\n",
+			dss_get_generic_clk_source_name(dispc_clk_src),
+			dss_feat_get_clk_source_name(dispc_clk_src),
+			dispc_clk_src == OMAP_DSS_CLK_SRC_FCK ?
+			"off" : "on");
+
+	seq_printf(s, "hdmi %s source rate = %lu\n",
+			hdmi.ip_data.pll_data.refsel == HDMI_REFSEL_SYSCLK ?
+			"sysclk" : "pclk/ref1/ref2",
+			clk_get_rate(hdmi.sys_clk));
+
+	hdmi_runtime_put();
+}
+
 int omapdss_hdmi_read_edid(u8 *buf, int len)
 {
 	int r;
-- 
1.7.5.4

