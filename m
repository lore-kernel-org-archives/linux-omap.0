From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/32] OMAPDSS: HDMI: add hdmi_init_regulator
Date: Thu, 30 May 2013 12:34:37 +0300
Message-ID: <1369906493-27538-17-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41388 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030337Ab3E3Jfn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:43 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate regulator init code into its own function for clarity.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 99f4ab5..960083b 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -328,6 +328,29 @@ static void hdmi_runtime_put(void)
 	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
+static int hdmi_init_regulator(void)
+{
+	struct regulator *reg;
+
+	if (hdmi.vdda_hdmi_dac_reg != NULL)
+		return 0;
+
+	reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
+
+	/* DT HACK: try VDAC to make omapdss work for o4 sdp/panda */
+	if (IS_ERR(reg))
+		reg = devm_regulator_get(&hdmi.pdev->dev, "VDAC");
+
+	if (IS_ERR(reg)) {
+		DSSERR("can't get VDDA_HDMI_DAC regulator\n");
+		return PTR_ERR(reg);
+	}
+
+	hdmi.vdda_hdmi_dac_reg = reg;
+
+	return 0;
+}
+
 static int hdmi_init_display(struct omap_dss_device *dssdev)
 {
 	int r;
@@ -342,22 +365,9 @@ static int hdmi_init_display(struct omap_dss_device *dssdev)
 
 	dss_init_hdmi_ip_ops(&hdmi.ip_data, omapdss_get_version());
 
-	if (hdmi.vdda_hdmi_dac_reg == NULL) {
-		struct regulator *reg;
-
-		reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
-
-		/* DT HACK: try VDAC to make omapdss work for o4 sdp/panda */
-		if (IS_ERR(reg))
-			reg = devm_regulator_get(&hdmi.pdev->dev, "VDAC");
-
-		if (IS_ERR(reg)) {
-			DSSERR("can't get VDDA_HDMI_DAC regulator\n");
-			return PTR_ERR(reg);
-		}
-
-		hdmi.vdda_hdmi_dac_reg = reg;
-	}
+	r = hdmi_init_regulator();
+	if (r)
+		return r;
 
 	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
 	if (r)
-- 
1.8.1.2

