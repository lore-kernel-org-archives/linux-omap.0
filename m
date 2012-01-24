From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/16] OMAPFB: remove omapfb_set_platform_data()
Date: Tue, 24 Jan 2012 12:00:27 +0200
Message-ID: <1327399231-20826-13-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:46131 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755824Ab2AXKBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:08 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb_set_platform_data() is no longer used, so remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/fb.c |   15 ---------------
 include/linux/omapfb.h  |    3 ---
 2 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index a742b60..45f35c9 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -52,10 +52,6 @@ static struct platform_device omap_fb_device = {
 	.num_resources = 0,
 };
 
-void omapfb_set_platform_data(struct omapfb_platform_data *data)
-{
-}
-
 static int __init omap_init_fb(void)
 {
 	const struct omap_lcd_config *conf;
@@ -87,11 +83,6 @@ static struct platform_device omap_fb_device = {
 	.num_resources = 0,
 };
 
-void omapfb_set_platform_data(struct omapfb_platform_data *data)
-{
-	omapfb_config = *data;
-}
-
 static int __init omap_init_fb(void)
 {
 	return platform_device_register(&omap_fb_device);
@@ -99,10 +90,4 @@ static int __init omap_init_fb(void)
 
 arch_initcall(omap_init_fb);
 
-#else
-
-void omapfb_set_platform_data(struct omapfb_platform_data *data)
-{
-}
-
 #endif
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index 7a8e0ea..a575706 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -226,9 +226,6 @@ struct omapfb_platform_data {
 	struct omap_lcd_config		lcd;
 };
 
-/* in arch/arm/plat-omap/fb.c */
-extern void omapfb_set_platform_data(struct omapfb_platform_data *data);
-
 #endif
 
 #endif /* __OMAPFB_H */
-- 
1.7.4.1

