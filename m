From: Matthias Brugger <matthias.bgg@googlemail.com>
Subject: [PATCH] omap2/ompafb/omapfb-main.c: Delete if evaluating constant.
Date: Fri, 16 Nov 2012 18:51:01 +0100
Message-ID: <1353088261-27085-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54555 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab2KPRvP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 12:51:15 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so1100243wey.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Nov 2012 09:51:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>

Variable r is never set to any value different to zero.
Delete the if statement as it will never executed.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 16db158..85f9de0 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2411,7 +2411,6 @@ static int __init omapfb_probe(struct platform_device *pdev)
 	fbdev->dev = &pdev->dev;
 	platform_set_drvdata(pdev, fbdev);
 
-	r = 0;
 	fbdev->num_displays = 0;
 	dssdev = NULL;
 	for_each_dss_dev(dssdev) {
@@ -2434,9 +2433,6 @@ static int __init omapfb_probe(struct platform_device *pdev)
 			d->update_mode = OMAPFB_AUTO_UPDATE;
 	}
 
-	if (r)
-		goto cleanup;
-
 	if (fbdev->num_displays == 0) {
 		dev_err(&pdev->dev, "no displays\n");
 		r = -EINVAL;
-- 
1.7.9.5

