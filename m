From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 02/27] ARM/video: omap2: Move omap_display_init declaration to mach-omap2/display.h
Date: Fri, 3 Jun 2016 14:03:04 +0300
Message-ID: <20160603110329.9953-3-peter.ujfalusi@ti.com>
References: <20160603110329.9953-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603110329.9953-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

The omap_display_init() is implemented in the mach-omap2/display.c so the
declaration should have been there as well.
Change the board files to include display.h to avoid build breakage at the
same time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c        | 1 +
 arch/arm/mach-omap2/board-rx51-video.c | 1 +
 arch/arm/mach-omap2/display.h          | 5 +++++
 include/video/omapdss.h                | 3 ---
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d9c3ffc39329..f364a1b779f0 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -47,6 +47,7 @@
 #include "hsmmc.h"
 #include "control.h"
 #include "common-board-devices.h"
+#include "display.h"
 
 #define LDP_SMSC911X_CS		1
 #define LDP_SMSC911X_GPIO	152
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index b76f84245ad9..9866ec06a395 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -22,6 +22,7 @@
 
 #include "soc.h"
 #include "board-rx51.h"
+#include "display.h"
 
 #include "mux.h"
 
diff --git a/arch/arm/mach-omap2/display.h b/arch/arm/mach-omap2/display.h
index 7375854b16c7..78f253005279 100644
--- a/arch/arm/mach-omap2/display.h
+++ b/arch/arm/mach-omap2/display.h
@@ -33,4 +33,9 @@ int omap_init_vout(void);
 
 struct device_node * __init omapdss_find_dss_of_node(void);
 
+struct omap_dss_board_info;
+
+/* Init with the board info */
+int omap_display_init(struct omap_dss_board_info *board_data);
+
 #endif
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 8e14ad7327c9..0c7ae93ebd76 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -330,9 +330,6 @@ struct omap_dss_board_info {
 	enum omapdss_version version;
 };
 
-/* Init with the board info */
-extern int omap_display_init(struct omap_dss_board_info *board_data);
-
 struct omap_video_timings {
 	/* Unit: pixels */
 	u16 x_res;
-- 
2.8.3
