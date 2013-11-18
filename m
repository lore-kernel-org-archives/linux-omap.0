From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/4] OMAPDSS: apply fixes
Date: Mon, 18 Nov 2013 14:44:08 +0200
Message-ID: <1384778649-9396-3-git-send-email-tomi.valkeinen@ti.com>
References: <1384778649-9396-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54022 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409Ab3KRMoV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:44:21 -0500
In-Reply-To: <1384778649-9396-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When omapfb does ovl->get_overlay_info, ovl->set_overlay_info, the set
function may fail even if the info has not been changed. This is because
omapdss doesn't initialize the info, but expect the caller to set valid
values.

Normally that is the case, but there is at least one corner case: if
omapfb has not allocated memory for the overlay yet, and the user uses
ioctl to disable the overlay to make sure it's disabled. In this case
get_overlay_info returns invalid data, but the user is only interested
in setting the overlay to disabled, not configuring it, and
set_overlay_info fails.

The issue is made possible by the omapfb's setup_plane ioctl, which
groups overlay configuration and overlay enable/disable bit into the
same struct. Thus, when you are disabling an overlay, you are also
configuring it.

This is a bit counter intuitive, so I think it's better to initialize
the info to some valid values.

The fields requiring initialization are color_mode and rotation_type,
and also we need to remove the check for (paddr == 0), as paddr is 0 for
unallocated overlay (but it's still fine to disable the overlay).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   | 3 +++
 drivers/video/omap2/dss/overlay.c | 5 -----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 24cd7c2..0a0b084 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -149,6 +149,9 @@ static void apply_init_priv(void)
 
 		op = &dss_data.ovl_priv_data_array[i];
 
+		op->info.color_mode = OMAP_DSS_COLOR_RGB16;
+		op->info.rotation_type = OMAP_DSS_ROT_DMA;
+
 		op->info.global_alpha = 255;
 
 		switch (i) {
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index eccde32..2f7cee9 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -113,11 +113,6 @@ void dss_uninit_overlays(struct platform_device *pdev)
 int dss_ovl_simple_check(struct omap_overlay *ovl,
 		const struct omap_overlay_info *info)
 {
-	if (info->paddr == 0) {
-		DSSERR("check_overlay: paddr cannot be 0\n");
-		return -EINVAL;
-	}
-
 	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0) {
 		if (info->out_width != 0 && info->width != info->out_width) {
 			DSSERR("check_overlay: overlay %d doesn't support "
-- 
1.8.3.2

