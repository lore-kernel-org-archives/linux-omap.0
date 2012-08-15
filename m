From: Raphael Assenat <raph@8d.com>
Subject: [PATCH v2] OMAPDSS: Do not require a VDDS_DSI regulator on am35xx
Date: Wed, 15 Aug 2012 15:16:27 -0400
Message-ID: <20120815191627.GA22993@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:54611 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753873Ab2HOTQa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 15:16:30 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com

On our AM3505 based board, dpi.c complains that there is no VDSS_DSI re=
gulator
and the framebuffer cannot be enabled. However, this check does not see=
m to
apply to AM3505/17 chips.

Taking into account comments received after my first patch[1], I have a=
dded
entries to dss_features.c to support the am35xx soc. Then in dpi.c, ins=
tead
of using cpu_is_omap34xx() and soc_is_am35xx(), a call to dss_has_featu=
re()
is used.

[1] http://marc.info/?l=3Dlinux-fbdev&m=3D134272967203409&w=3D2

Signed-off-by: Rapha=EBl Ass=E9nat <raph@8d.com>

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dp=
i.c
index 3266be2..0e83054 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -31,9 +31,9 @@
 #include <linux/regulator/consumer.h>
=20
 #include <video/omapdss.h>
-#include <plat/cpu.h>
=20
 #include "dss.h"
+#include "dss_features.h"
=20
 static struct {
 	struct regulator *vdds_dsi_reg;
@@ -169,11 +169,6 @@ int omapdss_dpi_display_enable(struct omap_dss_dev=
ice *dssdev)
 {
 	int r;
=20
-	if (cpu_is_omap34xx() && !dpi.vdds_dsi_reg) {
-		DSSERR("no VDSS_DSI regulator\n");
-		return -ENODEV;
-	}
-
 	if (dssdev->manager =3D=3D NULL) {
 		DSSERR("failed to enable display: no manager\n");
 		return -ENODEV;
@@ -185,7 +180,7 @@ int omapdss_dpi_display_enable(struct omap_dss_devi=
ce *dssdev)
 		goto err_start_dev;
 	}
=20
-	if (cpu_is_omap34xx()) {
+	if (dpi.vdds_dsi_reg) {
 		r =3D regulator_enable(dpi.vdds_dsi_reg);
 		if (r)
 			goto err_reg_enable;
@@ -229,7 +224,7 @@ err_dsi_pll_init:
 err_get_dsi:
 	dispc_runtime_put();
 err_get_dispc:
-	if (cpu_is_omap34xx())
+	if (dpi.vdds_dsi_reg)
 		regulator_disable(dpi.vdds_dsi_reg);
 err_reg_enable:
 	omap_dss_stop_device(dssdev);
@@ -250,7 +245,7 @@ void omapdss_dpi_display_disable(struct omap_dss_de=
vice *dssdev)
=20
 	dispc_runtime_put();
=20
-	if (cpu_is_omap34xx())
+	if (dpi.vdds_dsi_reg)
 		regulator_disable(dpi.vdds_dsi_reg);
=20
 	omap_dss_stop_device(dssdev);
@@ -329,7 +324,7 @@ static int __init dpi_init_display(struct omap_dss_=
device *dssdev)
 {
 	DSSDBG("init_display\n");
=20
-	if (cpu_is_omap34xx() && dpi.vdds_dsi_reg =3D=3D NULL) {
+	if (dss_has_feature(FEAT_VDDS_DSI) && dpi.vdds_dsi_reg =3D=3D NULL) {
 		struct regulator *vdds_dsi;
=20
 		vdds_dsi =3D dss_get_vdds_dsi();
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/oma=
p2/dss/dss_features.c
index 9387097..6d4b6c5 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -373,6 +373,26 @@ static const enum dss_feat_id omap3430_dss_feat_li=
st[] =3D {
 	FEAT_ALPHA_FIXED_ZORDER,
 	FEAT_FIFO_MERGE,
 	FEAT_OMAP3_DSI_FIFO_BUG,
+	FEAT_VDDS_DSI,
+};
+
+static const enum dss_feat_id am35xx_dss_feat_list[] =3D {
+	FEAT_LCDENABLEPOL,
+	FEAT_LCDENABLESIGNAL,
+	FEAT_PCKFREEENABLE,
+	FEAT_FUNCGATED,
+	FEAT_LINEBUFFERSPLIT,
+	FEAT_ROWREPEATENABLE,
+	FEAT_RESIZECONF,
+	FEAT_DSI_PLL_FREQSEL,
+	FEAT_DSI_REVERSE_TXCLKESC,
+	FEAT_VENC_REQUIRES_TV_DAC_CLK,
+	FEAT_CPR,
+	FEAT_PRELOAD,
+	FEAT_FIR_COEF_V,
+	FEAT_ALPHA_FIXED_ZORDER,
+	FEAT_FIFO_MERGE,
+	FEAT_OMAP3_DSI_FIFO_BUG,
 };
=20
 static const enum dss_feat_id omap3630_dss_feat_list[] =3D {
@@ -487,6 +507,27 @@ static const struct omap_dss_features omap3430_dss=
_features =3D {
 	.burst_size_unit =3D 8,
 };
=20
+/* AM35xx DSS Features. This is basically OMAP3 DSS Features without
+   the vdds_dsi regulator. */
+static const struct omap_dss_features am35xx_dss_features =3D {
+	.reg_fields =3D omap3_dss_reg_fields,
+	.num_reg_fields =3D ARRAY_SIZE(omap3_dss_reg_fields),
+
+	.features =3D am35xx_dss_feat_list,
+	.num_features =3D ARRAY_SIZE(am35xx_dss_feat_list),
+
+	.num_mgrs =3D 2,
+	.num_ovls =3D 3,
+	.supported_displays =3D omap3430_dss_supported_displays,
+	.supported_color_modes =3D omap3_dss_supported_color_modes,
+	.overlay_caps =3D omap3430_dss_overlay_caps,
+	.clksrc_names =3D omap3_dss_clk_source_names,
+	.dss_params =3D omap3_dss_param_range,
+	.supported_rotation_types =3D OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
+	.buffer_size_unit =3D 1,
+	.burst_size_unit =3D 8,
+};
+
 static const struct omap_dss_features omap3630_dss_features =3D {
 	.reg_fields =3D omap3_dss_reg_fields,
 	.num_reg_fields =3D ARRAY_SIZE(omap3_dss_reg_fields),
@@ -694,8 +735,12 @@ void dss_features_init(void)
 		omap_current_dss_features =3D &omap2_dss_features;
 	else if (cpu_is_omap3630())
 		omap_current_dss_features =3D &omap3630_dss_features;
-	else if (cpu_is_omap34xx())
-		omap_current_dss_features =3D &omap3430_dss_features;
+	else if (cpu_is_omap34xx()) {
+		if (soc_is_am35xx())
+			omap_current_dss_features =3D &am35xx_dss_features;
+		else
+			omap_current_dss_features =3D &omap3430_dss_features;
+	}
 	else if (omap_rev() =3D=3D OMAP4430_REV_ES1_0)
 		omap_current_dss_features =3D &omap4430_es1_0_dss_features;
 	else if (omap_rev() =3D=3D OMAP4430_REV_ES2_0 ||
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/oma=
p2/dss/dss_features.h
index 996ffcb..8a68ebf 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -64,6 +64,7 @@ enum dss_feat_id {
 	/* An unknown HW bug causing the normal FIFO thresholds not to work *=
/
 	FEAT_OMAP3_DSI_FIFO_BUG,
 	FEAT_BURST_2D,
+	FEAT_VDDS_DSI,
 };
=20
 /* DSS register field id */
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
