From: Colin King <colin.king@canonical.com>
Subject: [PATCH] OMAP: DSS2: remove non-zero check on variable r
Date: Wed,  4 Dec 2019 15:28:47 +0000
Message-ID: <20191204152847.1435188-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable r is being initialized to zero, so the check of a non-zero
rv is redundant and can be removed.

It appears that the previous case statements set r to be -EINVAL
and the "Fallthrough" comment afterwards suggested it was going
to fall through to this non-zero check but won't because of the
break statement. Remove the confusion by removing the Fallthrough
comment too.

Addresses-Coverity: ("Logically dead code")
Fixes: b39a982ddecf ("OMAP: DSS2: omapfb driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index 858c2c011d19..a2a2c1b205d9 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1154,16 +1154,12 @@ static int _setcolreg(struct fb_info *fbi, u_int regno, u_int red, u_int green,
 		   r = fbdev->ctrl->setcolreg(regno, red, green, blue,
 		   transp, update_hw_pal);
 		   */
-		/* Fallthrough */
 		r = -EINVAL;
 		break;
 	case OMAPFB_COLOR_RGB565:
 	case OMAPFB_COLOR_RGB444:
 	case OMAPFB_COLOR_RGB24P:
 	case OMAPFB_COLOR_RGB24U:
-		if (r != 0)
-			break;
-
 		if (regno < 16) {
 			u32 pal;
 			pal = ((red >> (16 - var->red.length)) <<
-- 
2.24.0
