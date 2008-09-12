From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] omapfb: use proper bits per pixel for beagleboard.
Date: Sat, 13 Sep 2008 01:28:20 +0300
Message-ID: <1221258481-18531-1-git-send-email-felipe.contreras@gmail.com>
References: <c656a4d20809120913i2cf6b2d0i33289ac8b45f76e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:35818 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731AbYILW21 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 18:28:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so610034fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 15:28:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <c656a4d20809120913i2cf6b2d0i33289ac8b45f76e9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>

This was suggested by Mans Rullgard, otherwise it doesn't work.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/video/omap/lcd_omap3beagle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
index 9637735..dc59f39 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -66,7 +66,7 @@ struct lcd_panel omap3beagle_panel = {
 	.name		= "omap3beagle",
 	.config		= OMAP_LCDC_PANEL_TFT,
 
-	.bpp		= 24,
+	.bpp		= 16,
 	.data_lines	= 24,
 	.x_res		= LCD_XRES,
 	.y_res		= LCD_YRES,
-- 
1.6.0.1

