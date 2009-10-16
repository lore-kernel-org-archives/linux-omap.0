From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] omapfb: Wrong test on unsigned?
Date: Fri, 16 Oct 2009 20:23:43 +0200
Message-ID: <4AD8BA2F.9090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:42987 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbZJPSOA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 14:14:00 -0400
Received: by ewy4 with SMTP id 4so1866733ewy.37
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 11:14:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Only if the test is signed negative values can be spotted.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Is this correct? please review.

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 0d0c8c8..cc7dd93 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -286,7 +286,7 @@ static int _setcolreg(struct fb_info *info, u_int regno, u_int red, u_int green,
 		if (r != 0)
 			break;
 
-		if (regno < 0) {
+		if ((int)regno < 0) {
 			r = -EINVAL;
 			break;
 		}
