From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/6] OMAPDSS: HACK: look for regulators with omap4 names
Date: Mon, 5 Nov 2012 15:14:16 +0200
Message-ID: <1352121259-5836-4-git-send-email-tomi.valkeinen@ti.com>
References: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56876 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932301Ab2KENOk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 08:14:40 -0500
In-Reply-To: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: b-cousson@ti.com, s-guiriec@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Normally the omapdss driver gets the regulators using the regulator
names assigned for omapdss. However, in an effort to get a minimal DSS
support for DT enabled kernel on selected boards, we will add omapdss
devices and platform data the old way even for DT kernel. This causes
the problem that omapdss cannot find the regulators using omapdss's
regulator names.

This patch creates a temporary workaround for DSI and HDMI by trying to
get the regulators also using native OMAP4 regulator names.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c  |    8 ++++++++
 drivers/video/omap2/dss/hdmi.c |    4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index d64ac38..738f3c4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1753,6 +1753,10 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 
 		vdds_dsi = regulator_get(&dsi->pdev->dev, "vdds_dsi");
 
+		/* DT HACK: try VCXIO to make omapdss work for o4 sdp/panda */
+		if (IS_ERR(vdds_dsi))
+			vdds_dsi = regulator_get(&dsi->pdev->dev, "VCXIO");
+
 		if (IS_ERR(vdds_dsi)) {
 			DSSERR("can't get VDDS_DSI regulator\n");
 			return PTR_ERR(vdds_dsi);
@@ -4972,6 +4976,10 @@ static int __init dsi_init_display(struct omap_dss_device *dssdev)
 
 		vdds_dsi = regulator_get(&dsi->pdev->dev, "vdds_dsi");
 
+		/* DT HACK: try VCXIO to make omapdss work for o4 sdp/panda */
+		if (IS_ERR(vdds_dsi))
+			vdds_dsi = regulator_get(&dsi->pdev->dev, "VCXIO");
+
 		if (IS_ERR(vdds_dsi)) {
 			DSSERR("can't get VDDS_DSI regulator\n");
 			return PTR_ERR(vdds_dsi);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index a48a7dd..deaeb6c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -340,6 +340,10 @@ static int __init hdmi_init_display(struct omap_dss_device *dssdev)
 
 		reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
 
+		/* DT HACK: try VDAC to make omapdss work for o4 sdp/panda */
+		if (IS_ERR(reg))
+			reg = devm_regulator_get(&hdmi.pdev->dev, "VDAC");
+
 		if (IS_ERR(reg)) {
 			DSSERR("can't get VDDA_HDMI_DAC regulator\n");
 			return PTR_ERR(reg);
-- 
1.7.10.4

