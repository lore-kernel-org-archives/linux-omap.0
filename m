From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] video: fbdev: omap2: dss: dss.c:  Remove unused function
Date: Thu,  1 Jan 2015 16:34:58 +0100
Message-ID: <1420126498-27648-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jg1.han@samsung.com>, Sathya Prakash M R <sathyap@ti.com>, Fabian Frederick <fabf@skynet.be>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Remove the function dss_get_hdmi_venc_clk_source() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/omap2/dss/dss.c |   14 --------------
 drivers/video/fbdev/omap2/dss/dss.h |    1 -
 2 files changed, 15 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 14bcd6c..d9482c8 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -550,20 +550,6 @@ void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select src)
 		REG_FLD_MOD(DSS_CONTROL, src, 15, 15);	/* VENC_HDMI_SWITCH */
 }
 
-enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
-{
-	enum omap_display_type displays;
-
-	displays = dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
-	if ((displays & OMAP_DISPLAY_TYPE_HDMI) == 0)
-		return DSS_VENC_TV_CLK;
-
-	if ((displays & OMAP_DISPLAY_TYPE_VENC) == 0)
-		return DSS_HDMI_M_PCLK;
-
-	return REG_GET(DSS_CONTROL, 15, 15);
-}
-
 static int dss_dpi_select_source_omap2_omap3(enum omap_channel channel)
 {
 	if (channel != OMAP_DSS_CHANNEL_LCD)
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 8ff22c1..f4bb25b 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -211,7 +211,6 @@ void dss_uninit_platform_driver(void);
 unsigned long dss_get_dispc_clk_rate(void);
 int dss_dpi_select_source(enum omap_channel channel);
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
-enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
-- 
1.7.10.4
