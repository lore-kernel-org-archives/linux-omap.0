From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/16] OMAPFB: Move old omapfb private structs to a private include file
Date: Tue, 24 Jan 2012 12:00:26 +0200
Message-ID: <1327399231-20826-12-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:49905 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755883Ab2AXKBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:07 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

include/linux/omapfb.h contains structs that are used only by the
omapfb driver. Move the structs into drivers/video/omap/omapfb.h.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/omapfb.h |   25 +++++++++++++++++++++++++
 include/linux/omapfb.h      |   25 -------------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap/omapfb.h b/drivers/video/omap/omapfb.h
index 3a5ab13..07fe498 100644
--- a/drivers/video/omap/omapfb.h
+++ b/drivers/video/omap/omapfb.h
@@ -47,6 +47,31 @@
 
 struct omapfb_device;
 
+#ifdef CONFIG_ARCH_OMAP1
+#define OMAPFB_PLANE_NUM		1
+#else
+#define OMAPFB_PLANE_NUM		3
+#endif
+
+struct omapfb_mem_region {
+	u32		paddr;
+	void __iomem	*vaddr;
+	unsigned long	size;
+	u8		type;		/* OMAPFB_PLANE_MEM_* */
+	enum omapfb_color_format format;/* OMAPFB_COLOR_* */
+	unsigned	format_used:1;	/* Must be set when format is set.
+					 * Needed b/c of the badly chosen 0
+					 * base for OMAPFB_COLOR_* values
+					 */
+	unsigned	alloc:1;	/* allocated by the driver */
+	unsigned	map:1;		/* kernel mapped by the driver */
+};
+
+struct omapfb_mem_desc {
+	int				region_cnt;
+	struct omapfb_mem_region	region[OMAPFB_PLANE_NUM];
+};
+
 struct lcd_panel {
 	const char	*name;
 	int		config;		/* TFT/STN, signal inversion */
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index 03f5255..7a8e0ea 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -222,31 +222,6 @@ struct omapfb_display_info {
 
 #include <plat/board.h>
 
-#ifdef CONFIG_ARCH_OMAP1
-#define OMAPFB_PLANE_NUM		1
-#else
-#define OMAPFB_PLANE_NUM		3
-#endif
-
-struct omapfb_mem_region {
-	u32		paddr;
-	void __iomem	*vaddr;
-	unsigned long	size;
-	u8		type;		/* OMAPFB_PLANE_MEM_* */
-	enum omapfb_color_format format;/* OMAPFB_COLOR_* */
-	unsigned	format_used:1;	/* Must be set when format is set.
-					 * Needed b/c of the badly chosen 0
-					 * base for OMAPFB_COLOR_* values
-					 */
-	unsigned	alloc:1;	/* allocated by the driver */
-	unsigned	map:1;		/* kernel mapped by the driver */
-};
-
-struct omapfb_mem_desc {
-	int				region_cnt;
-	struct omapfb_mem_region	region[OMAPFB_PLANE_NUM];
-};
-
 struct omapfb_platform_data {
 	struct omap_lcd_config		lcd;
 };
-- 
1.7.4.1

