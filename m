From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/8] OMAPDSS: DISPC: fix usage of dispc_ovl_set_accu_uv
Date: Mon, 21 May 2012 12:28:00 +0300
Message-ID: <1337592486-13040-3-git-send-email-tomi.valkeinen@ti.com>
References: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42631 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932453Ab2EUJ2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:28:24 -0400
Received: by lahi5 with SMTP id i5so3432736lah.28
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:28:21 -0700 (PDT)
In-Reply-To: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Commit 05dd0f5308213e169b02458a7f3a61362e581e14 ("OMAPDSS: DISPC: Update
Accumulator configuration for chroma plane") adds
dispc_ovl_set_accu_uv() function that sets the accu, but the function
only handles YUV and NV12 modes, and BUGs otherwise.

The patch also adds a call to the function, but unfortunately the place
of call was such that the mode could be other than YUV or NV12, thus
crashing the driver.

This patchs moves the call to a slightly later spot, at which point only
YUV and NV12 modes are handled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ac71fec..0fa1c94 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1304,9 +1304,6 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
 
-	dispc_ovl_set_accu_uv(plane, orig_width, orig_height, out_width,
-			out_height, ilace, color_mode, rotation);
-
 	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
 		return;
 	if ((color_mode != OMAP_DSS_COLOR_YUV2 &&
@@ -1316,6 +1313,10 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 8, 8);
 		return;
 	}
+
+	dispc_ovl_set_accu_uv(plane, orig_width, orig_height, out_width,
+			out_height, ilace, color_mode, rotation);
+
 	switch (color_mode) {
 	case OMAP_DSS_COLOR_NV12:
 		/* UV is subsampled by 2 vertically*/
-- 
1.7.9.5

