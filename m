From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 08/41] OMAPDSS: Improve regulator names for DT
Date: Tue, 21 Jan 2014 12:56:40 +0200
Message-ID: <1390301833-24944-9-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34834 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbaAUK72 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 05:59:28 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The regulator names used for DSS components are somewhat ugly for DT
use. As we're just adding DT support, it's simple to change the
regulator names.

This patch makes the DSS driver get the regulators with somewhat cleaner
names. For example, this allows us to define HDMI's VDDA regulator in
the DT data as:

vdda-supply = <...>;

instead of

vdda_hdmi_dac-supply = <...>;

The code also still tries to get the regulators with the old names, if
the regulator_get with the new names fail. This keep backward
compatibility, and can be removed after we have moved to DT.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c   | 5 ++++-
 drivers/video/omap2/dss/hdmi4.c | 5 ++++-
 drivers/video/omap2/dss/venc.c  | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a820c37e323e..b7c92705fb54 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1151,7 +1151,10 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 	if (dsi->vdds_dsi_reg != NULL)
 		return 0;
 
-	vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "vdds_dsi");
+	vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "vdd");
+
+	if (IS_ERR(vdds_dsi))
+		vdds_dsi = devm_regulator_get(&dsi->pdev->dev, "vdds_dsi");
 
 	/* DT HACK: try VCXIO to make omapdss work for o4 sdp/panda */
 	if (IS_ERR(vdds_dsi))
diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index 4a74538f9ea5..11e7500197c1 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -88,7 +88,10 @@ static int hdmi_init_regulator(void)
 	if (hdmi.vdda_hdmi_dac_reg != NULL)
 		return 0;
 
-	reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
+	reg = devm_regulator_get(&hdmi.pdev->dev, "vdda");
+
+	if (IS_ERR(reg)
+		reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
 
 	/* DT HACK: try VDAC to make omapdss work for o4 sdp/panda */
 	if (IS_ERR(reg))
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 2cd7f7e42105..c0e4def29795 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -636,7 +636,10 @@ static int venc_init_regulator(void)
 	if (venc.vdda_dac_reg != NULL)
 		return 0;
 
-	vdda_dac = devm_regulator_get(&venc.pdev->dev, "vdda_dac");
+	vdda_dac = devm_regulator_get(&venc.pdev->dev, "vdda");
+
+	if (IS_ERR(vdda_dac))
+		vdda_dac = devm_regulator_get(&venc.pdev->dev, "vdda_dac");
 
 	if (IS_ERR(vdda_dac)) {
 		if (PTR_ERR(vdda_dac) != -EPROBE_DEFER)
-- 
1.8.3.2

