From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] omapfb: invalid test on unsigned
Date: Mon, 22 Jun 2009 22:35:59 +0200
Message-ID: <4A3FEB2F.8040307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:45091 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZFVSfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 14:35:24 -0400
Received: by ewy6 with SMTP id 6so4932636ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 11:35:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: imre.deak@nokia.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Unsigned regno cannot be less than 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Is this correct? please review.

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 060d72f..787271f 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -276,7 +276,7 @@ static int _setcolreg(struct fb_info *info, u_int regno, u_int red, u_int green,
 		if (r != 0)
 			break;
 
-		if (regno < 0) {
+		if (regno >= info->cmap.len) {
 			r = -EINVAL;
 			break;
 		}
