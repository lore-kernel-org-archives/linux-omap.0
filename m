From: Archit Taneja <archit@ti.com>
Subject: [RFC 16/17] OMAPDSS: VENC: Maintain our own timings field in driver data
Date: Wed, 1 Aug 2012 16:01:27 +0530
Message-ID: <1343817088-29645-17-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43841 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754915Ab2HAKeH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 06:34:07 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The VENC driver currently relies on the timings in omap_dss_device struct to
configure the DISPC and VENC blocks accordingly. This makes the VENC interface
driver dependent on the omap_dss_device struct.

Make the VENC driver data maintain it's own timings field. The panel driver is
expected to call omapdss_venc_set_timings() to set these timings before the
panel is enabled.

Make the VENC panel driver configure the new timings is the omap_dss_device
struct(dssdev->panel.timings). The VENC driver is responsible for maintaining
only it's own copy of timings.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/venc.c       |   12 +++++++-----
 drivers/video/omap2/dss/venc_panel.c |    1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index ffca542..d96025e 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -300,6 +300,8 @@ static struct {
 	struct regulator *vdda_dac_reg;
 
 	struct clk	*tv_dac_clk;
+
+	struct omap_video_timings timings;
 } venc;
 
 static inline void venc_write_reg(int idx, u32 val)
@@ -432,7 +434,7 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 		goto err0;
 
 	venc_reset();
-	venc_write_config(venc_timings_to_config(&dssdev->panel.timings));
+	venc_write_config(venc_timings_to_config(&venc.timings));
 
 	dss_set_venc_output(dssdev->phy.venc.type);
 	dss_set_dac_pwrdn_bgz(1);
@@ -449,7 +451,7 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 
 	venc_write_reg(VENC_OUTPUT_CONTROL, l);
 
-	dss_mgr_set_timings(dssdev->manager, &dssdev->panel.timings);
+	dss_mgr_set_timings(dssdev->manager, &venc.timings);
 
 	r = regulator_enable(venc.vdda_dac_reg);
 	if (r)
@@ -556,10 +558,10 @@ void omapdss_venc_set_timings(struct omap_dss_device *dssdev,
 	mutex_lock(&venc.venc_lock);
 
 	/* Reset WSS data when the TV standard changes. */
-	if (memcmp(&dssdev->panel.timings, timings, sizeof(*timings)))
+	if (memcmp(&venc.timings, timings, sizeof(*timings)))
 		venc.wss_data = 0;
 
-	dssdev->panel.timings = *timings;
+	venc.timings = *timings;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		int r;
@@ -606,7 +608,7 @@ int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss)
 
 	mutex_lock(&venc.venc_lock);
 
-	config = venc_timings_to_config(&dssdev->panel.timings);
+	config = venc_timings_to_config(&venc.timings);
 
 	/* Invert due to VENC_L21_WC_CTL:INV=1 */
 	venc.wss_data = (wss ^ 0xfffff) << 8;
diff --git a/drivers/video/omap2/dss/venc_panel.c b/drivers/video/omap2/dss/venc_panel.c
index 6b31298..350b0d9 100644
--- a/drivers/video/omap2/dss/venc_panel.c
+++ b/drivers/video/omap2/dss/venc_panel.c
@@ -170,6 +170,7 @@ static void venc_panel_set_timings(struct omap_dss_device *dssdev,
 	mutex_lock(&venc_panel.lock);
 
 	omapdss_venc_set_timings(dssdev, timings);
+	dssdev->panel.timings = *timings;
 
 	mutex_unlock(&venc_panel.lock);
 }
-- 
1.7.9.5

