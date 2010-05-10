From: Senthilvadivu Guruswamy <svadivu@ti.com>
Subject: [PATCH] DSS2 Include VRFB into omap2-3build only
Date: Mon, 10 May 2010 12:18:30 +0530
Message-ID: <1273474110-22451-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48604 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab0EJGsv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 May 2010 02:48:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, tony@atomide.com, tomi.valkeinen@nokia.com, v-hiremath@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

Exclude VRFB from OMAP4 onwards and include only for
OMAP2 and OMAP3 builds.  In OMAP4 VRFB HW IP is replaced
with a new HW IP "TILER"

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/plat-omap/include/plat/vrfb.h |   16 ++++++++++++++++
 drivers/video/omap2/Kconfig            |    4 ++++
 drivers/video/omap2/omapfb/Kconfig     |    1 -
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/vrfb.h b/arch/arm/plat-omap/include/plat/vrfb.h
index d8a03ce..3792bde 100644
--- a/arch/arm/plat-omap/include/plat/vrfb.h
+++ b/arch/arm/plat-omap/include/plat/vrfb.h
@@ -35,6 +35,7 @@ struct vrfb {
 	bool yuv_mode;
 };
 
+#ifdef CONFIG_OMAP2_VRFB
 extern int omap_vrfb_request_ctx(struct vrfb *vrfb);
 extern void omap_vrfb_release_ctx(struct vrfb *vrfb);
 extern void omap_vrfb_adjust_size(u16 *width, u16 *height,
@@ -47,4 +48,19 @@ extern void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
 extern int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot);
 extern void omap_vrfb_restore_context(void);
 
+#else
+static inline int omap_vrfb_request_ctx(struct vrfb *vrfb) { return 0; }
+static inline void omap_vrfb_release_ctx(struct vrfb *vrfb) {}
+static inline void omap_vrfb_adjust_size(u16 *width, u16 *height,
+		u8 bytespp) {}
+static inline u32 omap_vrfb_min_phys_size(u16 width, u16 height, u8 bytespp)
+		{ return 0; }
+static inline u16 omap_vrfb_max_height(u32 phys_size, u16 width, u8 bytespp)
+		{ return 0; }
+static inline void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
+		u16 width, u16 height, unsigned bytespp, bool yuv_mode) {}
+static inline int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot)
+		{ return 0; }
+static inline void omap_vrfb_restore_context(void) {}
+#endif
 #endif /* __VRFB_H */
diff --git a/drivers/video/omap2/Kconfig b/drivers/video/omap2/Kconfig
index d877c36..253376a 100644
--- a/drivers/video/omap2/Kconfig
+++ b/drivers/video/omap2/Kconfig
@@ -3,6 +3,10 @@ config OMAP2_VRAM
 
 config OMAP2_VRFB
 	bool
+	depends on FB_OMAP2 && (!ARCH_OMAP4)
+	default y if (ARCH_OMAP2 || ARCH_OMAP3)
+	help
+	  OMAP VRFB buffer support is efficient for rotation
 
 source "drivers/video/omap2/dss/Kconfig"
 source "drivers/video/omap2/omapfb/Kconfig"
diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index 43496d6..fee537e 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -3,7 +3,6 @@ menuconfig FB_OMAP2
         depends on FB && OMAP2_DSS
 
 	select OMAP2_VRAM
-	select OMAP2_VRFB
         select FB_CFB_FILLRECT
         select FB_CFB_COPYAREA
         select FB_CFB_IMAGEBLIT
-- 
1.5.4.7

