From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 6/6] OMAPDSS: DPI: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 13:59:28 +0530
Message-ID: <a2f1395d6f92b4e3c6fd33ba4b658f9c22e56e97.1343912533.git.cmahapatra@ti.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37752 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab2HGIbj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Aug 2012 04:31:39 -0400
In-Reply-To: <cover.1343912532.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The OMAP3 checks have been removed and replaced by a dss feature
FEAT_DPI_USES_VDDS_DSI for cleaner implementation. The patches
"OMAP: DSS2: enable VDDS_DSI when using DPI" (8a2cfea8cc) by Tomi Valkeinen
<tomi.valkeinen@nokia.com> and "ARM: omap: fix oops in
drivers/video/omap2/dss/dpi.c" (4041071571) by Russell King
<rmk+kernel@arm.linux.org.uk> had introduced these checks. As it is evident
from these patches a dependency exists for some DSS pins on VDDS_DSI which is
better shown by dss feature FEAT_DPI_USES_VDDS_DSI.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dpi.c          |   12 +++++++-----
 drivers/video/omap2/dss/dss_features.c |    1 +
 drivers/video/omap2/dss/dss_features.h |    1 +
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 3266be2..b97f7b8 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -34,6 +34,7 @@
 #include <plat/cpu.h>
 
 #include "dss.h"
+#include "dss_features.h"
 
 static struct {
 	struct regulator *vdds_dsi_reg;
@@ -169,7 +170,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	if (cpu_is_omap34xx() && !dpi.vdds_dsi_reg) {
+	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) && !dpi.vdds_dsi_reg) {
 		DSSERR("no VDSS_DSI regulator\n");
 		return -ENODEV;
 	}
@@ -185,7 +186,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 		goto err_start_dev;
 	}
 
-	if (cpu_is_omap34xx()) {
+	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI)) {
 		r = regulator_enable(dpi.vdds_dsi_reg);
 		if (r)
 			goto err_reg_enable;
@@ -229,7 +230,7 @@ err_dsi_pll_init:
 err_get_dsi:
 	dispc_runtime_put();
 err_get_dispc:
-	if (cpu_is_omap34xx())
+	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
 		regulator_disable(dpi.vdds_dsi_reg);
 err_reg_enable:
 	omap_dss_stop_device(dssdev);
@@ -250,7 +251,7 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 
 	dispc_runtime_put();
 
-	if (cpu_is_omap34xx())
+	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
 		regulator_disable(dpi.vdds_dsi_reg);
 
 	omap_dss_stop_device(dssdev);
@@ -329,7 +330,8 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
-	if (cpu_is_omap34xx() && dpi.vdds_dsi_reg == NULL) {
+	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
+					dpi.vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
 
 		vdds_dsi = dss_get_vdds_dsi();
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 6b35200..ba70de5 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -373,6 +373,7 @@ static const enum dss_feat_id omap3430_dss_feat_list[] = {
 	FEAT_ALPHA_FIXED_ZORDER,
 	FEAT_FIFO_MERGE,
 	FEAT_OMAP3_DSI_FIFO_BUG,
+	FEAT_DPI_USES_VDDS_DSI,
 };
 
 static const enum dss_feat_id omap3630_dss_feat_list[] = {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index aa1e4b6..9c18fe3 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -50,6 +50,7 @@ enum dss_feat_id {
 	FEAT_DSI_VC_OCP_WIDTH,
 	FEAT_DSI_REVERSE_TXCLKESC,
 	FEAT_DSI_GNQ,
+	FEAT_DPI_USES_VDDS_DSI,
 	FEAT_HDMI_CTS_SWMODE,
 	FEAT_HDMI_AUDIO_USE_MCLK,
 	FEAT_HANDLE_UV_SEPARATE,
-- 
1.7.10

