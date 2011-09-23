From: <mythripk@ti.com>
Subject: [PATCHv3 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Fri, 23 Sep 2011 15:02:21 +0530
Message-ID: <1316770341-19140-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43592 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab1IWJk0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 05:40:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8N9eMOT027800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 04:40:25 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8N9eLVs011552
	for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 15:10:22 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add support to dump the HDMI PLL dividers such as regm, regn etc
and other clock dumps such as pixel clock rate, TMDS clock rate.

changes since V2:
Add pixel clock and TMDS clock dump and remove dcofreq and DISPC clock source
print.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.c  |    3 +++
 drivers/video/omap2/dss/dss.h  |    1 +
 drivers/video/omap2/dss/hdmi.c |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 0 deletions(-)

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
index 3262f0f..0510655 100644
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
@@ -454,6 +456,37 @@ void hdmi_dump_regs(struct seq_file *s)
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
+	seq_printf(s, "hdmi %s source rate = %lu\n",
+			hdmi.ip_data.pll_data.refsel == HDMI_REFSEL_SYSCLK ?
+			"sysclk" : "pclk/ref1/ref2",
+			clk_get_rate(hdmi.sys_clk));
+
+	seq_printf(s, "Pixel clock frequency = %u\n",
+			hdmi.ip_data.cfg.timings.timings.pixel_clock);
+
+	seq_printf(s, "TMDS clock frequency = %u\n",
+			10 * hdmi.ip_data.cfg.timings.timings.pixel_clock);
+
+	seq_printf(s, "regm\t%u\n", hdmi.ip_data.pll_data.regm);
+
+	seq_printf(s, "regmf\t%u\n", hdmi.ip_data.pll_data.regmf);
+
+	seq_printf(s, "regsd\t%u\n", hdmi.ip_data.pll_data.regsd);
+
+	hdmi_runtime_put();
+}
+
 int omapdss_hdmi_read_edid(u8 *buf, int len)
 {
 	int r;
-- 
1.7.5.4

