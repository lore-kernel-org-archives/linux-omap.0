From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 02/27] OMAPDSS: remove DT hacks for regulators
Date: Mon, 16 Dec 2013 16:56:09 +0200
Message-ID: <1387205794-32246-3-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42565 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab3LPO6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 09:58:02 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

For booting Panda and 4430SDP with DT, while DSS did not support DT, we
had to had small hacks in the omapdss driver to get the regulators. With
DT now supported in DSS, we can remove those hacks.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c   | 5 -----
 drivers/video/omap2/dss/hdmi4.c | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 1cd3e47fd43f..18b5e84165bb 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1124,11 +1124,6 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 		return 0;
 
 	vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "vdds_dsi");
-
-	/* DT HACK: try VCXIO to make omapdss work for o4 sdp/panda */
-	if (IS_ERR(vdds_dsi))
-		vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "VCXIO");
-
 	if (IS_ERR(vdds_dsi)) {
 		DSSERR("can't get VDDS_DSI regulator\n");
 		return PTR_ERR(vdds_dsi);
diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index e14009614338..16e598787522 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -90,10 +90,6 @@ static int hdmi_init_regulator(void)
 
 	reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
 
-	/* DT HACK: try VDAC to make omapdss work for o4 sdp/panda */
-	if (IS_ERR(reg))
-		reg = devm_regulator_get(&hdmi.pdev->dev, "VDAC");
-
 	if (IS_ERR(reg)) {
 		DSSERR("can't get VDDA_HDMI_DAC regulator\n");
 		return PTR_ERR(reg);
-- 
1.8.3.2

