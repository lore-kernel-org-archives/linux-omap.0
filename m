From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v3 1/3] DSS2: Allow FB_OMAP2 to build without VRFB
Date: Thu, 10 Jun 2010 16:53:55 +0530
Message-ID: <1276169037-2598-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41637 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755799Ab0FJLYH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jun 2010 07:24:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

FB_OMAP2 can work without VRFB, but currently does not build. Fix this.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/plat-omap/include/plat/vrfb.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+), 0 deletions(-)

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
-- 
1.5.4.7

