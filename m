From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH] This patch removes a dead line from omapfb_main.c
Date: Mon, 31 Mar 2008 12:22:48 +0530
Message-ID: <c656a4d20803302352q672816b7pdba535cf6b2d4143@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:14408 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbYCaGwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 02:52:49 -0400
Received: by yw-out-2324.google.com with SMTP id 5so159769ywb.1
        for <linux-omap@vger.kernel.org>; Sun, 30 Mar 2008 23:52:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch removes a dead line from omapfb_main.c


Signed-off-by: arun c <arunedarath@mistralsolutions.com>
---
 drivers/video/omap/omapfb_main.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 139c84c..418ed9f 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -559,7 +559,6 @@ static int set_fb_var(struct fb_info *fbi,
 		var->xoffset = var->xres_virtual - var->xres;
 	if (var->yres + var->yoffset > var->yres_virtual)
 		var->yoffset = var->yres_virtual - var->yres;
-	line_size = var->xres * bpp / 8;

 	if (plane->color_mode == OMAPFB_COLOR_RGB444) {
 		var->red.offset	  = 8; var->red.length	 = 4;
-- 
1.5.0.6
