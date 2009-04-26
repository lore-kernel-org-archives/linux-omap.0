From: InKi Dae <daeinki@gmail.com>
Subject: Re: [PATCH] enabled alpha blender for OMAP2/3 DSS2 driver.
Date: Sun, 26 Apr 2009 19:22:35 +0900
Message-ID: <90b950fc0904260322y4bd09c15qc9a132c109c1757e@mail.gmail.com>
References: <90b950fc0904240213x70f66891j7dc587f09445e2f3@mail.gmail.com>
	 <87skjyxiyr.fsf@deeprootsystems.com>
	 <90b950fc0904250900k1cd29363l282e0eb81bd9cee6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f112.google.com ([209.85.221.112]:39589 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbZDZKWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 06:22:36 -0400
Received: by qyk10 with SMTP id 10so657550qyk.33
        for <linux-omap@vger.kernel.org>; Sun, 26 Apr 2009 03:22:35 -0700 (PDT)
In-Reply-To: <90b950fc0904250900k1cd29363l282e0eb81bd9cee6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

I am sending second alpha blending patch for DSS2 driver written by
Tomi Valkeinen.

In previous patch, I called functions for alpha channel from
omapfb_fb_init() of omapfb-main.c directly.
This patch is called by manager.
preliminary to call, those functions are registered in manager and
then omapfb_fb_init() just calls functions registered in manager.

Also, I think that omap_dss_mgr_enable_alpha_blending() of dispc.c
should be modified appropriately.
1. struct omap_overlay_manager must to have enum omap_channel as his member.
2. some way for confirming omap_channel should be added in
omap_dss_mgr_enable_alpha_blending().

signed-off-by: InKi Dae <inki.dae@samsung.com>

--
diff --git a/arch/arm/plat-omap/include/mach/display.h
b/arch/arm/plat-omap/include/mach/display.h
index d0b4c83..3c24b64 100644
--- a/arch/arm/plat-omap/include/mach/display.h
+++ b/arch/arm/plat-omap/include/mach/display.h
@@ -425,6 +425,8 @@ struct omap_overlay_manager {
 		u32 trans_key);
 	void (*enable_trans_key)(struct omap_overlay_manager *mgr,
 		bool enable);
+	void (*set_global_alpha)(struct omap_overlay_manager *mgr,
+			u8 value);
 	void (*enable_alpha_blending)(struct omap_overlay_manager *mgr,
 			bool enable);
 };
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 9bab6cf..e7bdd90 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1846,7 +1846,7 @@ void dispc_enable_trans_key(enum omap_channel
ch, bool enable)
 	enable_clocks(1);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
-	else /* OMAP_DSS_CHANNEL_DIGIT */
+	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
 	enable_clocks(0);
 }
@@ -1855,27 +1855,34 @@ void dispc_enable_alpha_blending(enum
omap_channel ch, bool enable)
 	enable_clocks(1);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 18, 18);
-	else /* OMAP_DSS_CHANNEL_DIGIT */
+	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 19, 19);
 	enable_clocks(0);
 }
 bool dispc_alpha_blending_enabled(enum omap_channel ch)
 {
-	bool enabled;
+	bool enabled = 0;

 	enable_clocks(1);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		enabled = REG_GET(DISPC_CONFIG, 18, 18);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		enabled = REG_GET(DISPC_CONFIG, 18, 18);
-	else
-		BUG();
+		enabled = REG_GET(DISPC_CONFIG, 19, 19);
 	enable_clocks(0);

 	return enabled;

 }

+void dispc_set_global_alpha(int layer, u8 value)
+{
+	enable_clocks(1);
+	if (layer == 0)
+		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, value, 7, 0);
+	else if (layer == 2)
+		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, value, 23, 16);
+	enable_clocks(0);
+}

 bool dispc_trans_key_enabled(enum omap_channel ch)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 1d01ff6..8c0f114 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -294,6 +294,7 @@ void dispc_get_trans_key(enum omap_channel ch,
 		enum omap_dss_color_key_type *type,
 		u32 *trans_key);
 void dispc_enable_trans_key(enum omap_channel ch, bool enable);
+void dispc_set_global_alpha(int layer, u8 value);
 void dispc_enable_alpha_blending(enum omap_channel ch, bool enable);
 bool dispc_trans_key_enabled(enum omap_channel ch);
 bool dispc_alpha_blending_enabled(enum omap_channel ch);
diff --git a/drivers/video/omap2/dss/manager.c
b/drivers/video/omap2/dss/manager.c
index bf059e0..810afea 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -545,10 +545,22 @@ static void omap_dss_mgr_enable_trans_key(struct
omap_overlay_manager *mgr,
 {
 	dispc_enable_trans_key(mgr->id, enable);
 }
+static void omap_dss_mgr_set_global_alpha(struct omap_overlay_manager
*mgr, u8 value)
+{
+	dispc_set_global_alpha(mgr->id, value);
+}
 static void omap_dss_mgr_enable_alpha_blending(struct
omap_overlay_manager *mgr,
 		bool enable)
 {
-	dispc_enable_alpha_blending(mgr->id, enable);
+	/*
+	 * This line should be modified.
+	 * I think that the way for confirming omap_channel must be added.
+	 * and struct omap_overlay_manager needs to have omap_channel as his member.
+	 */
+	int ch;
+	ch = OMAP_DSS_CHANNEL_LCD;
+
+	dispc_enable_alpha_blending(ch, enable);
 }
 static bool omap_dss_mgr_get_alpha_blending_status(
 		struct omap_overlay_manager *mgr)
@@ -609,6 +621,7 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 			&omap_dss_mgr_get_trans_key_type_and_value;
 		mgr->enable_trans_key = &omap_dss_mgr_enable_trans_key;
 		mgr->get_trans_key_status = &omap_dss_mgr_get_trans_key_status;
+		mgr->set_global_alpha = &omap_dss_mgr_set_global_alpha;
 		mgr->enable_alpha_blending =
 			&omap_dss_mgr_enable_alpha_blending;
 		mgr->get_alpha_blending_status =
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
b/drivers/video/omap2/omapfb/omapfb-main.c
index 76e7c6c..99888b0 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1583,6 +1583,22 @@ int omapfb_fb_init(struct omapfb2_device
*fbdev, struct fb_info *fbi)
 				r = mode;
 				goto err;
 			}
+
+			if (mode == OMAP_DSS_COLOR_ARGB16 ||
+					mode == OMAP_DSS_COLOR_RGBA32 ||
+					mode == OMAP_DSS_COLOR_ARGB32) {
+				struct omap_overlay *ovl;
+
+				ovl = omap_dss_get_overlay(id);
+
+				if (ovl->manager->enable_alpha_blending)
+					ovl->manager->enable_alpha_blending(ovl->manager, 1);
+
+				/* Set global alpha value to fully apaque */
+				if (ovl->manager->set_global_alpha)
+					ovl->manager->set_global_alpha(ovl->manager, 255);
+			}
+
 			r = dss_mode_to_fb_mode(mode, var);
 			if (r < 0)
 				goto err;
