From: Archit Taneja <archit@ti.com>
Subject: [PATCH] V4L/DVB: OMAP_VOUT: Remove unneseccasry code in omap_vout_calculate_offset
Date: Wed,  1 Sep 2010 13:38:12 +0530
Message-ID: <1283328492-23715-1-git-send-email-archit@ti.com>
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
List-Id: linux-omap@vger.kernel.org

In omap_vout_calculate_offset(), cur_display is assigned ovl->manager->device, but
isn't used for anything. The corresponding code is removed.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/media/video/omap/omap_vout.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/omap/omap_vout.c
index 929073e..255cd99
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -506,11 +506,9 @@ static int v4l2_rot_to_dss_rot(int v4l2_rotation,
  */
 static int omap_vout_calculate_offset(struct omap_vout_device *vout)
 {
-	struct omap_overlay *ovl;
 	enum dss_rotation rotation;
 	struct omapvideo_info *ovid;
 	bool mirroring = vout->mirror;
-	struct omap_dss_device *cur_display;
 	struct v4l2_rect *crop = &vout->crop;
 	struct v4l2_pix_format *pix = &vout->pix;
 	int *cropped_offset = &vout->cropped_offset;
@@ -518,12 +516,6 @@ static int omap_vout_calculate_offset(struct omap_vout_device *vout)
 	int offset = 0, ctop = 0, cleft = 0, line_length = 0;
 
 	ovid = &vout->vid_info;
-	ovl = ovid->overlays[0];
-	/* get the display device attached to the overlay */
-	if (!ovl->manager || !ovl->manager->device)
-		return -1;
-
-	cur_display = ovl->manager->device;
 	rotation = calc_rotation(vout);
 
 	if (V4L2_PIX_FMT_YUYV == pix->pixelformat ||
-- 
1.7.0.4
