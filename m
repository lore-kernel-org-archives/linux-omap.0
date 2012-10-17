From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 4/5] OMAPDSS: VRFB: add omap_vrfb_supported()
Date: Wed, 17 Oct 2012 13:18:21 +0300
Message-ID: <1350469102-24888-5-git-send-email-tomi.valkeinen@ti.com>
References: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44172 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756531Ab2JQKSk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 06:18:40 -0400
In-Reply-To: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add an exported function omap_vrfb_supported() which returns true if the
vrfb driver has been loaded succesfully. This can be used to decide if
VRFB can be used or not.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/vrfb.c |   16 ++++++++++++++++
 include/video/omapvrfb.h   |    2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/video/omap2/vrfb.c b/drivers/video/omap2/vrfb.c
index e4a0450..5d8fdac 100644
--- a/drivers/video/omap2/vrfb.c
+++ b/drivers/video/omap2/vrfb.c
@@ -77,6 +77,8 @@ static void __iomem *vrfb_base;
 static int num_ctxs;
 static struct vrfb_ctx *ctxs;
 
+static bool vrfb_loaded;
+
 static void omap2_sms_write_rot_control(u32 val, unsigned ctx)
 {
 	__raw_writel(val, vrfb_base + SMS_ROT_CONTROL(ctx));
@@ -336,6 +338,12 @@ out:
 }
 EXPORT_SYMBOL(omap_vrfb_request_ctx);
 
+bool omap_vrfb_supported(void)
+{
+	return vrfb_loaded;
+}
+EXPORT_SYMBOL(omap_vrfb_supported);
+
 static int __init vrfb_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
@@ -375,11 +383,19 @@ static int __init vrfb_probe(struct platform_device *pdev)
 		ctxs[i].base = mem->start;
 	}
 
+	vrfb_loaded = true;
+
 	return 0;
 }
 
+static void __exit vrfb_remove(struct platform_device *pdev)
+{
+	vrfb_loaded = false;
+}
+
 static struct platform_driver vrfb_driver = {
 	.driver.name	= "omapvrfb",
+	.remove		= __exit_p(vrfb_remove),
 };
 
 static int __init vrfb_init(void)
diff --git a/include/video/omapvrfb.h b/include/video/omapvrfb.h
index 3792bde..bb0bd89 100644
--- a/include/video/omapvrfb.h
+++ b/include/video/omapvrfb.h
@@ -36,6 +36,7 @@ struct vrfb {
 };
 
 #ifdef CONFIG_OMAP2_VRFB
+extern bool omap_vrfb_supported(void);
 extern int omap_vrfb_request_ctx(struct vrfb *vrfb);
 extern void omap_vrfb_release_ctx(struct vrfb *vrfb);
 extern void omap_vrfb_adjust_size(u16 *width, u16 *height,
@@ -49,6 +50,7 @@ extern int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot);
 extern void omap_vrfb_restore_context(void);
 
 #else
+static inline bool omap_vrfb_supported(void) { return false; }
 static inline int omap_vrfb_request_ctx(struct vrfb *vrfb) { return 0; }
 static inline void omap_vrfb_release_ctx(struct vrfb *vrfb) {}
 static inline void omap_vrfb_adjust_size(u16 *width, u16 *height,
-- 
1.7.9.5

