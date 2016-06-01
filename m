From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 26/27] [media] omap_vout: Switch to use the video/omapfb_dss.h header file
Date: Wed, 1 Jun 2016 11:35:48 +0300
Message-ID: <20160601083549.10549-27-peter.ujfalusi@ti.com>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

The omap_vout is only supported with omapfb. Switch the driver to use the
correct header file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/media/platform/omap/omap_vout.c    | 2 +-
 drivers/media/platform/omap/omap_voutdef.h | 2 +-
 drivers/media/platform/omap/omap_voutlib.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
index 70c28d19ea04..22cf60991df6 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -45,7 +45,7 @@
 #include <media/v4l2-ioctl.h>
 
 #include <video/omapvrfb.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "omap_voutlib.h"
 #include "omap_voutdef.h"
diff --git a/drivers/media/platform/omap/omap_voutdef.h b/drivers/media/platform/omap/omap_voutdef.h
index 9ccfe1f475a4..94b5d65afb19 100644
--- a/drivers/media/platform/omap/omap_voutdef.h
+++ b/drivers/media/platform/omap/omap_voutdef.h
@@ -11,7 +11,7 @@
 #ifndef OMAP_VOUTDEF_H
 #define OMAP_VOUTDEF_H
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/omapvrfb.h>
 
 #define YUYV_BPP        2
diff --git a/drivers/media/platform/omap/omap_voutlib.c b/drivers/media/platform/omap/omap_voutlib.c
index 80b0d88f125c..58a25fdf0cce 100644
--- a/drivers/media/platform/omap/omap_voutlib.c
+++ b/drivers/media/platform/omap/omap_voutlib.c
@@ -26,7 +26,7 @@
 
 #include <linux/dma-mapping.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "omap_voutlib.h"
 
-- 
2.8.3
