From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 31/41] OMAPDSS: remove DT hacks for regulators
Date: Tue, 21 Jan 2014 12:57:03 +0200
Message-ID: <1390301833-24944-32-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39177 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547AbaAULBE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 06:01:04 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

For booting Panda and 4430SDP with DT, while DSS did not support DT, we
had to had small hacks in the omapdss driver to get the regulators. With
DT now supported in DSS, we can remove those hacks.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c   | 9 +--------
 drivers/video/omap2/dss/hdmi4.c | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 98bb2d68a462..f461fe015554 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1162,16 +1162,9 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 
 	vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "vdd");
 
-	if (IS_ERR(vdds_dsi))
-		vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "vdds_dsi");
-
-	/* DT HACK: try VCXIO to make omapdss work for o4 sdp/panda */
-	if (IS_ERR(vdds_dsi))
-		vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "VCXIO");
-
 	if (IS_ERR(vdds_dsi)) {
 		if (PTR_ERR(vdds_dsi) != -EPROBE_DEFER)
-			DSSERR("can't get VDDS_DSI regulator\n");
+			DSSERR("can't get DSI VDD regulator\n");
 		return PTR_ERR(vdds_dsi);
 	}
 
diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index 064bec4e08d4..17b24b26f6cd 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -90,16 +90,9 @@ static int hdmi_init_regulator(void)
 
 	reg = devm_regulator_get(&hdmi.pdev->dev, "vdda");
 
-	if (IS_ERR(reg)
-		reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
-
-	/* DT HACK: try VDAC to make omapdss work for o4 sdp/panda */
-	if (IS_ERR(reg))
-		reg = devm_regulator_get(&hdmi.pdev->dev, "VDAC");
-
 	if (IS_ERR(reg)) {
 		if (PTR_ERR(reg) != -EPROBE_DEFER)
-			DSSERR("can't get VDDA_HDMI_DAC regulator\n");
+			DSSERR("can't get VDDA regulator\n");
 		return PTR_ERR(reg);
 	}
 
-- 
1.8.3.2

