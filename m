From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/15] OMAPDSS: SDI: change regulator handling
Date: Thu, 29 Aug 2013 16:31:49 +0300
Message-ID: <1377783120-14001-5-git-send-email-tomi.valkeinen@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49961 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584Ab3H2NcO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:32:14 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Regulator handling for DPI and SDI is currently handled in the core.c,
using the 'virtual' omapdss platform device. Nowadays we have proper
devices for both DPI and SDI, and so we can handle the regulators inside
the respective drivers.

This patch moves the regulator handling for SDI into sdi.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c | 15 ---------------
 drivers/video/omap2/dss/dss.h  |  1 -
 drivers/video/omap2/dss/sdi.c  | 10 +++-------
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 1aeb274..a07d626 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -44,7 +44,6 @@ static struct {
 	struct platform_device *pdev;
 
 	struct regulator *vdds_dsi_reg;
-	struct regulator *vdds_sdi_reg;
 
 	const char *default_display_name;
 } core;
@@ -95,20 +94,6 @@ struct regulator *dss_get_vdds_dsi(void)
 	return reg;
 }
 
-struct regulator *dss_get_vdds_sdi(void)
-{
-	struct regulator *reg;
-
-	if (core.vdds_sdi_reg != NULL)
-		return core.vdds_sdi_reg;
-
-	reg = devm_regulator_get(&core.pdev->dev, "vdds_sdi");
-	if (!IS_ERR(reg))
-		core.vdds_sdi_reg = reg;
-
-	return reg;
-}
-
 int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
 	struct omap_dss_board_info *board_data = core.pdev->dev.platform_data;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 50a2362..7d97de4 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -165,7 +165,6 @@ struct platform_device;
 struct platform_device *dss_get_core_pdev(void);
 struct bus_type *dss_get_bus(void);
 struct regulator *dss_get_vdds_dsi(void);
-struct regulator *dss_get_vdds_sdi(void);
 int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask);
 void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
 int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 856af2e..82b64e3 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -267,14 +267,10 @@ static int sdi_init_regulator(void)
 	if (sdi.vdds_sdi_reg)
 		return 0;
 
-	vdds_sdi = dss_get_vdds_sdi();
-
+	vdds_sdi = devm_regulator_get(&sdi.pdev->dev, "vdds_sdi");
 	if (IS_ERR(vdds_sdi)) {
-		vdds_sdi = devm_regulator_get(&sdi.pdev->dev, "vdds_sdi");
-		if (IS_ERR(vdds_sdi)) {
-			DSSERR("can't get VDDS_SDI regulator\n");
-			return PTR_ERR(vdds_sdi);
-		}
+		DSSERR("can't get VDDS_SDI regulator\n");
+		return PTR_ERR(vdds_sdi);
 	}
 
 	sdi.vdds_sdi_reg = vdds_sdi;
-- 
1.8.1.2

