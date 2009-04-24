From: InKi Dae <daeinki@gmail.com>
Subject: [PATCH] enabled alpha blender for OMAP2/3 DSS2 driver.
Date: Fri, 24 Apr 2009 18:13:22 +0900
Message-ID: <90b950fc0904240213x70f66891j7dc587f09445e2f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:41714 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZDXJNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 05:13:23 -0400
Received: by qw-out-2122.google.com with SMTP id 5so831525qwd.37
        for <linux-omap@vger.kernel.org>; Fri, 24 Apr 2009 02:13:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

- Added global alpha value for GFX and VIDEO2 layer.
- Modified dispc_alpha_blending_enabled function.
  -> for OMAP_DSS_CHANNEL_DIGIT, it has to get DISPC_CONFIG[19], not 18.

For alpha channel, dispc_enable_alpha_blending() is called by
omapfb_fb_init() in case of only XXX_ARGB16, RGBA32 or ARGB32

Signed-off-by: InKi Dae <inki.dae@samsung.com>
--
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 9bab6cf..c5335e5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1846,8 +1846,10 @@ void dispc_enable_trans_key(enum omap_channel
ch, bool enable)
          enable_clocks(1);
          if (ch == OMAP_DSS_CHANNEL_LCD)
                     REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
-          else /* OMAP_DSS_CHANNEL_DIGIT */
+         else if (ch == OMAP_DSS_CHANNEL_DIGIT)
                     REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
+         else
+                   BUG();
          enable_clocks(0);
 }
 void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
@@ -1855,8 +1857,10 @@ void dispc_enable_alpha_blending(enum
omap_channel ch, bool enable)
          enable_clocks(1);
          if (ch == OMAP_DSS_CHANNEL_LCD)
                     REG_FLD_MOD(DISPC_CONFIG, enable, 18, 18);
-          else /* OMAP_DSS_CHANNEL_DIGIT */
+         else if (ch == OMAP_DSS_CHANNEL_DIGIT)
                     REG_FLD_MOD(DISPC_CONFIG, enable, 19, 19);
+         else
+                   BUG();
          enable_clocks(0);
 }
 bool dispc_alpha_blending_enabled(enum omap_channel ch)
@@ -1867,7 +1871,7 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
          if (ch == OMAP_DSS_CHANNEL_LCD)
                     enabled = REG_GET(DISPC_CONFIG, 18, 18);
          else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-                    enabled = REG_GET(DISPC_CONFIG, 18, 18);
+                   enabled = REG_GET(DISPC_CONFIG, 19, 19);
          else
                     BUG();
          enable_clocks(0);
@@ -1876,6 +1880,18 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)

 }

+void dispc_set_global_alpha(int layer, int alpha)
+{
+         enable_clocks(1);
+         if (layer == 0)
+                   REG_FLD_MOD(DISPC_GLOBAL_ALPHA, alpha, 7, 0);
+         else if (layer == 2)
+                   REG_FLD_MOD(DISPC_GLOBAL_ALPHA, alpha, 23, 16);
+         else
+                   BUG();
+
+         enable_clocks(0);
+}

 bool dispc_trans_key_enabled(enum omap_channel ch)
 {
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
b/drivers/video/omap2/omapfb/omapfb-main.c
index 76e7c6c..98cad35 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1583,6 +1583,17 @@ int omapfb_fb_init(struct omapfb2_device
*fbdev, struct fb_info *fbi)
                                          r = mode;
                                          goto err;
                                }
+
+                              if (mode == OMAP_DSS_COLOR_ARGB16 ||
+                                                   mode ==
OMAP_DSS_COLOR_RGBA32 ||
+                                                   mode ==
OMAP_DSS_COLOR_ARGB32) {
+
+
dispc_enable_alpha_blending(OMAP_DSS_CHANNEL_LCD, 1);
+
+                                         /* Set global alpha value to
fully apaque */
+                                         dispc_set_global_alpha(id, 255);
+                              }
+
                                r = dss_mode_to_fb_mode(mode, var);
                                if (r < 0)
                                          goto err;
diff --git a/drivers/video/omap2/omapfb/omapfb.h
b/drivers/video/omap2/omapfb/omapfb.h
index 43f6922..56c303e 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -147,4 +147,8 @@ static inline int omapfb_overlay_enable(struct
omap_overlay *ovl,
          return ovl->set_overlay_info(ovl, &info);
 }

+extern void dispc_enable_alpha_blending(enum omap_channel ch,
+                   int enable);
+extern void dispc_set_global_alpha(int layer, int alpha);
+
 #endif

--
To unsubscribe from this list: send the line "unsubscribe linux-omap"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
