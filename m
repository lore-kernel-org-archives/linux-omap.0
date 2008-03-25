From: "arun c" <arunedarath@mistralsolutions.com>
Subject: Unnecessary line in omapfb_main.c
Date: Tue, 25 Mar 2008 14:40:51 +0530
Message-ID: <c656a4d20803250210l7a950409lbc6897b68c27019f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:46129 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbYCYJKz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2008 05:10:55 -0400
Received: by ti-out-0910.google.com with SMTP id 28so778286tif.23
        for <linux-omap@vger.kernel.org>; Tue, 25 Mar 2008 02:10:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

While grepping through the sources i found one unnecessary line in
omapfb_main.c

The patch is pasted below.

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index f66b81a..07eb3f0 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -559,7 +559,6 @@ static int set_fb_var(struct fb_info *fbi,
 		var->xoffset = var->xres_virtual - var->xres;
 	if (var->yres + var->yoffset > var->yres_virtual)
 		var->yoffset = var->yres_virtual - var->yres;
-	line_size = var->xres * bpp / 8;

 	if (plane->color_mode == OMAPFB_COLOR_RGB444) {
 		var->red.offset	  = 8; var->red.length	 = 4;

Regards,
Arun c
