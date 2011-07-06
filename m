From: Andy Doan <andy.doan@linaro.org>
Subject: [PATCH] OMAPFB: make debug message more useful
Date: Wed,  6 Jul 2011 12:08:29 -0500
Message-ID: <1309972109-23778-1-git-send-email-andy.doan@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50507 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab1GFRK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 13:10:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Doan <andy.doan@linaro.org>

Make the debug message useful by printing the name of the device
that no associated driver could be found for.

Signed-off-by: Andy Doan <andy.doan@linaro.org>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 602b71a..e5a64b3 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2373,7 +2373,8 @@ static int omapfb_probe(struct platform_device *pdev)
 		omap_dss_get_device(dssdev);
 
 		if (!dssdev->driver) {
-			dev_err(&pdev->dev, "no driver for display\n");
+			dev_err(&pdev->dev, "no driver for display: %s\n",
+				dssdev->name);
 			r = -ENODEV;
 		}
 
-- 
1.7.4.1

