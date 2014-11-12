From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v7 08/20] OMAPDSS: hdmi: Make hdmi structure public
Date: Wed, 12 Nov 2014 12:49:10 +0200
Message-ID: <36360685d103030331ac82a87a82325c3dcbc482.1415786458.git.jsarha@ti.com>
References: <cover.1415786458.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36336 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbaKLKtm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 05:49:42 -0500
In-Reply-To: <cover.1415786458.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

Unify the private anonymous struct in hdmi4.c and hdmi5.c, name it as
struct omap_hdmi, and make it public in hdmi.h.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h  |   21 +++++++++++++++++++++
 drivers/video/fbdev/omap2/dss/hdmi4.c |   31 ++++++++-----------------------
 drivers/video/fbdev/omap2/dss/hdmi5.c |   20 ++------------------
 3 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 9ba7c1a..6bf077b 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -349,4 +349,25 @@ static inline bool hdmi_mode_has_audio(int mode)
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
+	struct hdmi_core_data	core;
+
+	struct hdmi_config cfg;
+
+	struct clk *sys_clk;
+	struct regulator *vdda_reg;
+
+	bool core_enabled;
+
+	struct omap_dss_device output;
+};
+
 #endif
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 9a8713c..764443e 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -37,25 +37,9 @@
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
 
 static int hdmi_runtime_get(void)
 {
@@ -117,7 +101,7 @@ static int hdmi_init_regulator(void)
 	int r;
 	struct regulator *reg;
 
-	if (hdmi.vdda_hdmi_dac_reg != NULL)
+	if (hdmi.vdda_reg != NULL)
 		return 0;
 
 	reg = devm_regulator_get(&hdmi.pdev->dev, "vdda");
@@ -137,7 +121,7 @@ static int hdmi_init_regulator(void)
 		}
 	}
 
-	hdmi.vdda_hdmi_dac_reg = reg;
+	hdmi.vdda_reg = reg;
 
 	return 0;
 }
@@ -146,7 +130,7 @@ static int hdmi_power_on_core(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	r = regulator_enable(hdmi.vdda_hdmi_dac_reg);
+	r = regulator_enable(hdmi.vdda_reg);
 	if (r)
 		return r;
 
@@ -162,7 +146,7 @@ static int hdmi_power_on_core(struct omap_dss_device *dssdev)
 	return 0;
 
 err_runtime_get:
-	regulator_disable(hdmi.vdda_hdmi_dac_reg);
+	regulator_disable(hdmi.vdda_reg);
 
 	return r;
 }
@@ -172,7 +156,7 @@ static void hdmi_power_off_core(struct omap_dss_device *dssdev)
 	hdmi.core_enabled = false;
 
 	hdmi_runtime_put();
-	regulator_disable(hdmi.vdda_hdmi_dac_reg);
+	regulator_disable(hdmi.vdda_reg);
 }
 
 static int hdmi_power_on_full(struct omap_dss_device *dssdev)
@@ -678,6 +662,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	int irq;
 
 	hdmi.pdev = pdev;
+	dev_set_drvdata(&pdev->dev, &hdmi);
 
 	mutex_init(&hdmi.lock);
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 169b764..694cdee 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -43,24 +43,7 @@
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
 
 static int hdmi_runtime_get(void)
 {
@@ -703,6 +686,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	int irq;
 
 	hdmi.pdev = pdev;
+	dev_set_drvdata(&pdev->dev, &hdmi);
 
 	mutex_init(&hdmi.lock);
 
-- 
1.7.9.5

