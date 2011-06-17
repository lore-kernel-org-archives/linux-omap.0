From: Vladimir Pantelic <vladoman@gmail.com>
Subject: [PATCH v2] omap v4l2: fix wrong resizer calculation
Date: Fri, 17 Jun 2011 10:34:44 +0200
Message-ID: <4DFB11A4.1040202@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050606080005010505030509"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kernel development list <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050606080005010505030509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

changes since v1:
	reworded the commit message as requested

--------------050606080005010505030509
Content-Type: text/x-diff;
 name="0001-omap-v4l2-fix-wrong-resizer-calculation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-omap-v4l2-fix-wrong-resizer-calculation.patch"

>From f7f1c11fef76e53cdfe4ad98c6c9605dbe94aa86 Mon Sep 17 00:00:00 2001
From: Vladimir Pantelic <vladoman@gmail.com>
Date: Tue, 26 Apr 2011 09:28:11 +0200
Subject: [PATCH] omap v4l2: fix wrong resizer calculation

The omap_vout_new_crop() function has a possible bug, it uses
uninitialized variables "crop.width/height" which are actually output of the
function. Instead we should be using "try_crop.width/height" to calculate
the resizer values.

Signed-off-by: Vladimir Pantelic <vladoman@gmail.com>
Acked-by: Hiremath, Vaibhav <hvaibhav@ti.com>
---
 drivers/media/video/omap/omap_voutlib.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/video/omap/omap_voutlib.c b/drivers/media/video/omap/omap_voutlib.c
index 2aa6a76..8ae7481 100644
--- a/drivers/media/video/omap/omap_voutlib.c
+++ b/drivers/media/video/omap/omap_voutlib.c
@@ -193,7 +193,7 @@ int omap_vout_new_crop(struct v4l2_pix_format *pix,
 		return -EINVAL;
 
 	if (cpu_is_omap24xx()) {
-		if (crop->height != win->w.height) {
+		if (try_crop.height != win->w.height) {
 			/* If we're resizing vertically, we can't support a
 			 * crop width wider than 768 pixels.
 			 */
@@ -202,7 +202,7 @@ int omap_vout_new_crop(struct v4l2_pix_format *pix,
 		}
 	}
 	/* vertical resizing */
-	vresize = (1024 * crop->height) / win->w.height;
+	vresize = (1024 * try_crop.height) / win->w.height;
 	if (cpu_is_omap24xx() && (vresize > 2048))
 		vresize = 2048;
 	else if (cpu_is_omap34xx() && (vresize > 4096))
@@ -221,7 +221,7 @@ int omap_vout_new_crop(struct v4l2_pix_format *pix,
 			try_crop.height = 2;
 	}
 	/* horizontal resizing */
-	hresize = (1024 * crop->width) / win->w.width;
+	hresize = (1024 * try_crop.width) / win->w.width;
 	if (cpu_is_omap24xx() && (hresize > 2048))
 		hresize = 2048;
 	else if (cpu_is_omap34xx() && (hresize > 4096))
-- 
1.7.6.rc1.1.g2c162b


--------------050606080005010505030509--
