From: Raphael Assenat <raph@8d.com>
Subject: [PATCH] OMAPDSS: Do not require a VDDS_DSI regulator on am35xx
Date: Thu, 19 Jul 2012 16:04:29 -0400
Message-ID: <20120719200429.GD3850@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:36955 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab2GSUEd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 16:04:33 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org

On our AM3505 based board, dpi.c complains that there is no VDSS_DSI regulator
and the framebuffer cannot be enabled. However, this check does not seem to
apply to AM3505/17 chips.

I am not the first facing this issue, see this thread from Nov. 2011:
http://marc.info/?l=linux-omap&m=132147745930213&w=2

The string 'vdds_dsi' does appear once in the technical reference manual[1]
but there is no corresponding power pin on the package[2]. I failed to 
locate any signal that could be an equivalent. I am trying to obtain some
clarifications on TI's forum[3]...

In any case, I am currently running with the patch below. In order to keep
cpu_is_xx uses to a minimum, I check for am35xx once at init time and allow
dpi.vdds_dsi_reg to be NULL from then on, getting rid of all the other
cpu_is_omap34xx uses in the process.

Your comments would be appreciated. Please also consider for merging.

[1] http://www.ti.com/litv/pdf/sprugr0b
[2] http://www.ti.com/lit/gpn/am3505
[3] http://e2e.ti.com/support/dsp/sitara_arm174_microprocessors/f/416/t/202586.aspx

Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 8c2056c..d3b428d 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -180,11 +180,6 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	if (cpu_is_omap34xx() && !dpi.vdds_dsi_reg) {
-		DSSERR("no VDSS_DSI regulator\n");
-		return -ENODEV;
-	}
-
 	if (dssdev->manager == NULL) {
 		DSSERR("failed to enable display: no manager\n");
 		return -ENODEV;
@@ -196,7 +191,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 		goto err_start_dev;
 	}
 
-	if (cpu_is_omap34xx()) {
+	if (dpi.vdds_dsi_reg) {
 		r = regulator_enable(dpi.vdds_dsi_reg);
 		if (r)
 			goto err_reg_enable;
@@ -240,7 +235,7 @@ err_dsi_pll_init:
 err_get_dsi:
 	dispc_runtime_put();
 err_get_dispc:
-	if (cpu_is_omap34xx())
+	if (dpi.vdds_dsi_reg)
 		regulator_disable(dpi.vdds_dsi_reg);
 err_reg_enable:
 	omap_dss_stop_device(dssdev);
@@ -261,7 +256,7 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 
 	dispc_runtime_put();
 
-	if (cpu_is_omap34xx())
+	if (dpi.vdds_dsi_reg)
 		regulator_disable(dpi.vdds_dsi_reg);
 
 	omap_dss_stop_device(dssdev);
@@ -343,7 +338,7 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
-	if (cpu_is_omap34xx() && dpi.vdds_dsi_reg == NULL) {
+	if (cpu_is_omap34xx() && dpi.vdds_dsi_reg == NULL && !soc_is_am35xx()) {
 		struct regulator *vdds_dsi;
 
 		vdds_dsi = dss_get_vdds_dsi();
