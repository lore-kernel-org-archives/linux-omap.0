From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/16] OAMPFB: remove unused omapfb_set_ctrl_platform_data()
Date: Tue, 24 Jan 2012 12:00:22 +0200
Message-ID: <1327399231-20826-8-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44390 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755921Ab2AXKA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:00:57 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb_set_ctrl_platform_data() is no longer used, so it can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/fb.c |    5 -----
 include/linux/omapfb.h  |    2 --
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 15d4d16..a05ab56 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -175,11 +175,6 @@ void __init omapfb_reserve_sdram_memblock(void)
 			 reserved);
 }
 
-void omapfb_set_ctrl_platform_data(void *data)
-{
-	omapfb_config.ctrl_platform_data = data;
-}
-
 static int __init omap_init_fb(void)
 {
 	const struct omap_lcd_config *conf;
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index c0b0187..85cad31 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -250,12 +250,10 @@ struct omapfb_mem_desc {
 struct omapfb_platform_data {
 	struct omap_lcd_config		lcd;
 	struct omapfb_mem_desc		mem_desc;
-	void				*ctrl_platform_data;
 };
 
 /* in arch/arm/plat-omap/fb.c */
 extern void omapfb_set_platform_data(struct omapfb_platform_data *data);
-extern void omapfb_set_ctrl_platform_data(void *pdata);
 extern void omapfb_reserve_sdram_memblock(void);
 
 #endif
-- 
1.7.4.1

