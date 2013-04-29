From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/10] OMAPFB: use module_platform_driver()
Date: Mon, 29 Apr 2013 13:22:29 +0300
Message-ID: <1367230957-32337-3-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37174 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab3D2KXE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:23:04 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of using platform_driver_probe(), use module_platform_driver()
so that we can support deferred probing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index f38348e..808f6af 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2422,7 +2422,7 @@ static int omapfb_init_connections(struct omapfb2_device *fbdev,
 	return 0;
 }
 
-static int __init omapfb_probe(struct platform_device *pdev)
+static int omapfb_probe(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = NULL;
 	int r = 0;
@@ -2595,6 +2595,7 @@ static int __exit omapfb_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omapfb_driver = {
+	.probe		= omapfb_probe,
 	.remove         = __exit_p(omapfb_remove),
 	.driver         = {
 		.name   = "omapfb",
@@ -2602,36 +2603,13 @@ static struct platform_driver omapfb_driver = {
 	},
 };
 
-static int __init omapfb_init(void)
-{
-	DBG("omapfb_init\n");
-
-	if (platform_driver_probe(&omapfb_driver, omapfb_probe)) {
-		printk(KERN_ERR "failed to register omapfb driver\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static void __exit omapfb_exit(void)
-{
-	DBG("omapfb_exit\n");
-	platform_driver_unregister(&omapfb_driver);
-}
-
 module_param_named(mode, def_mode, charp, 0);
 module_param_named(vram, def_vram, charp, 0);
 module_param_named(rotate, def_rotate, int, 0);
 module_param_named(vrfb, def_vrfb, bool, 0);
 module_param_named(mirror, def_mirror, bool, 0);
 
-/* late_initcall to let panel/ctrl drivers loaded first.
- * I guess better option would be a more dynamic approach,
- * so that omapfb reacts to new panels when they are loaded */
-late_initcall(omapfb_init);
-/*module_init(omapfb_init);*/
-module_exit(omapfb_exit);
+module_platform_driver(omapfb_driver);
 
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
 MODULE_DESCRIPTION("OMAP2/3 Framebuffer");
-- 
1.7.10.4

