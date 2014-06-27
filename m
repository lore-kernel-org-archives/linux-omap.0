From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 04/13] OMAPDSS: hdmi: Make hdmi structure public
Date: Fri, 27 Jun 2014 21:38:46 +0300
Message-ID: <536afa4069bd73195b05aee3097c86d7e517ae7e.1403894190.git.jsarha@ti.com>
References: <cover.1403894190.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60855 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbaF0SjT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 14:39:19 -0400
In-Reply-To: <cover.1403894190.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

Name the anonymous hdmi struct as omap_hdmi. Move the struct definition to
hdmi.h and turn core member into a pointer to deal with it's different
definitions for omap4 and omap5. Make associated changes to hdmi4.c
and hdmi5.c.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h  |   24 +++++++++++++++++++
 drivers/video/fbdev/omap2/dss/hdmi4.c |   41 +++++++++++----------------------
 drivers/video/fbdev/omap2/dss/hdmi5.c |   30 +++++++-----------------
 3 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 9e85b86..075357e 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -349,5 +349,29 @@ static inline bool hdmi_mode_has_audio(int mode)
 {
 	return mode == HDMI_HDMI ? true : false;
 }
+
+/* HDMI DRV data */
+struct omap_hdmi {
+	struct mutex lock;
+	struct platform_device *pdev;
+
+	struct hdmi_wp_data	wp;
+	struct hdmi_pll_data	pll;
+	struct hdmi_phy_data	phy;
+	struct hdmi_core_data	*core;
+
+	struct hdmi_config cfg;
+
+	struct clk *sys_clk;
+	struct regulator *vdda_reg;
+
+#if defined(CONFIG_OMAP_DSS_HDMI_AUDIO)
+	struct hdmi_audio_data audio;
+#endif
+	bool core_enabled;
+
+	struct omap_dss_device output;
+};
+
 #endif
 #endif
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 6a8550c..58f1295 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -37,25 +37,10 @@
 #include "hdmi4_core.h"
 #include "dss.h"
 #include "dss_features.h"
+#include "hdmi.h"
 
-static struct {
-	struct mutex lock;
-	struct platform_device *pdev;
-
-	struct hdmi_wp_data	wp;
-	struct hdmi_pll_data	pll;
-	struct hdmi_phy_data	phy;
-	struct hdmi_core_data	core;
-
-	struct hdmi_config cfg;
-
-	struct clk *sys_clk;
-	struct regulator *vdda_hdmi_dac_reg;
-
-	bool core_enabled;
-
-	struct omap_dss_device output;
-} hdmi;
+static struct omap_hdmi hdmi;
+static struct hdmi_core_data hdmi4_core;
 
 static int hdmi_runtime_get(void)
 {
@@ -117,7 +102,7 @@ static int hdmi_init_regulator(void)
 	int r;
 	struct regulator *reg;
 
-	if (hdmi.vdda_hdmi_dac_reg != NULL)
+	if (hdmi.vdda_reg != NULL)
 		return 0;
 
 	reg = devm_regulator_get(&hdmi.pdev->dev, "vdda");
@@ -137,7 +122,7 @@ static int hdmi_init_regulator(void)
 		}
 	}
 
-	hdmi.vdda_hdmi_dac_reg = reg;
+	hdmi.vdda_reg = reg;
 
 	return 0;
 }
@@ -146,7 +131,7 @@ static int hdmi_power_on_core(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	r = regulator_enable(hdmi.vdda_hdmi_dac_reg);
+	r = regulator_enable(hdmi.vdda_reg);
 	if (r)
 		return r;
 
@@ -162,7 +147,7 @@ static int hdmi_power_on_core(struct omap_dss_device *dssdev)
 	return 0;
 
 err_runtime_get:
-	regulator_disable(hdmi.vdda_hdmi_dac_reg);
+	regulator_disable(hdmi.vdda_reg);
 
 	return r;
 }
@@ -172,7 +157,7 @@ static void hdmi_power_off_core(struct omap_dss_device *dssdev)
 	hdmi.core_enabled = false;
 
 	hdmi_runtime_put();
-	regulator_disable(hdmi.vdda_hdmi_dac_reg);
+	regulator_disable(hdmi.vdda_reg);
 }
 
 static int hdmi_power_on_full(struct omap_dss_device *dssdev)
@@ -217,7 +202,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_phy_pwr;
 
-	hdmi4_configure(&hdmi.core, &hdmi.wp, &hdmi.cfg);
+	hdmi4_configure(hdmi.core, &hdmi.wp, &hdmi.cfg);
 
 	/* bypass TV gamma table */
 	dispc_enable_gamma_table(0);
@@ -308,7 +293,7 @@ static void hdmi_dump_regs(struct seq_file *s)
 	hdmi_wp_dump(&hdmi.wp, s);
 	hdmi_pll_dump(&hdmi.pll, s);
 	hdmi_phy_dump(&hdmi.phy, s);
-	hdmi4_core_dump(&hdmi.core, s);
+	hdmi4_core_dump(hdmi.core, s);
 
 	hdmi_runtime_put();
 	mutex_unlock(&hdmi.lock);
@@ -323,7 +308,7 @@ static int read_edid(u8 *buf, int len)
 	r = hdmi_runtime_get();
 	BUG_ON(r);
 
-	r = hdmi4_read_edid(&hdmi.core,  buf, len);
+	r = hdmi4_read_edid(hdmi.core,  buf, len);
 
 	hdmi_runtime_put();
 	mutex_unlock(&hdmi.lock);
@@ -678,6 +663,8 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	int irq;
 
 	hdmi.pdev = pdev;
+	hdmi.core = &hdmi4_core;
+	dev_set_drvdata(&pdev->dev, &hdmi);
 
 	mutex_init(&hdmi.lock);
 
@@ -699,7 +686,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	r = hdmi4_core_init(pdev, &hdmi.core);
+	r = hdmi4_core_init(pdev, hdmi.core);
 	if (r)
 		return r;
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 32d02ec..83925a9 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -43,24 +43,8 @@
 #include "dss.h"
 #include "dss_features.h"
 
-static struct {
-	struct mutex lock;
-	struct platform_device *pdev;
-
-	struct hdmi_wp_data	wp;
-	struct hdmi_pll_data	pll;
-	struct hdmi_phy_data	phy;
-	struct hdmi_core_data	core;
-
-	struct hdmi_config cfg;
-
-	struct clk *sys_clk;
-	struct regulator *vdda_reg;
-
-	bool core_enabled;
-
-	struct omap_dss_device output;
-} hdmi;
+static struct omap_hdmi hdmi;
+static struct hdmi_core_data hdmi5_core;
 
 static int hdmi_runtime_get(void)
 {
@@ -235,7 +219,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_phy_pwr;
 
-	hdmi5_configure(&hdmi.core, &hdmi.wp, &hdmi.cfg);
+	hdmi5_configure(hdmi.core, &hdmi.wp, &hdmi.cfg);
 
 	/* bypass TV gamma table */
 	dispc_enable_gamma_table(0);
@@ -326,7 +310,7 @@ static void hdmi_dump_regs(struct seq_file *s)
 	hdmi_wp_dump(&hdmi.wp, s);
 	hdmi_pll_dump(&hdmi.pll, s);
 	hdmi_phy_dump(&hdmi.phy, s);
-	hdmi5_core_dump(&hdmi.core, s);
+	hdmi5_core_dump(hdmi.core, s);
 
 	hdmi_runtime_put();
 	mutex_unlock(&hdmi.lock);
@@ -346,7 +330,7 @@ static int read_edid(u8 *buf, int len)
 	/* No-idle mode */
 	REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, 1, 3, 2);
 
-	r = hdmi5_read_edid(&hdmi.core,  buf, len);
+	r = hdmi5_read_edid(hdmi.core,  buf, len);
 
 	REG_FLD_MOD(hdmi.wp.base, HDMI_WP_SYSCONFIG, idlemode, 3, 2);
 
@@ -703,6 +687,8 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	int irq;
 
 	hdmi.pdev = pdev;
+	hdmi.core = &hdmi5_core;
+	dev_set_drvdata(&pdev->dev, &hdmi);
 
 	mutex_init(&hdmi.lock);
 
@@ -724,7 +710,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	r = hdmi5_core_init(pdev, &hdmi.core);
+	r = hdmi5_core_init(pdev, hdmi.core);
 	if (r)
 		return r;
 
-- 
1.7.9.5

