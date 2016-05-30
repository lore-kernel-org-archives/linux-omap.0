From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 21/26] omapdss: hdmi audio: Make header file independent of video/omapdss.h
Date: Mon, 30 May 2016 14:42:53 +0300
Message-ID: <20160530114258.30879-22-peter.ujfalusi@ti.com>
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Clean up the header files regarding to hdmi audio so the omap-hdmi-audio.h
file will only need to include the platform_data/omapdss.h file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Mark Brown <broonie@kernel.org>
CC: Jyri Sarha <jsarha@ti.com>
CC: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 drivers/gpu/drm/omapdrm/dss/hdmi.h          | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi.h | 1 +
 include/sound/omap-hdmi-audio.h             | 9 +++++++--
 include/video/omapdss.h                     | 5 -----
 sound/soc/omap/omap-hdmi-audio.c            | 1 -
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi.h b/drivers/gpu/drm/omapdrm/dss/hdmi.h
index 53616b02b613..c32a21a26054 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi.h
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi.h
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/hdmi.h>
 #include <video/omapdss.h>
+#include <sound/omap-hdmi-audio.h>
 
 #include "dss.h"
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi.h b/drivers/video/fbdev/omap2/omapfb/dss/hdmi.h
index 53616b02b613..c32a21a26054 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi.h
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/hdmi.h>
 #include <video/omapdss.h>
+#include <sound/omap-hdmi-audio.h>
 
 #include "dss.h"
 
diff --git a/include/sound/omap-hdmi-audio.h b/include/sound/omap-hdmi-audio.h
index afdb416898e0..1df2ff61a4dd 100644
--- a/include/sound/omap-hdmi-audio.h
+++ b/include/sound/omap-hdmi-audio.h
@@ -16,11 +16,16 @@
  *
  */
 
-#include <video/omapdss.h>
-
 #ifndef __OMAP_HDMI_AUDIO_H__
 #define __OMAP_HDMI_AUDIO_H__
 
+#include <linux/platform_data/omapdss.h>
+
+struct omap_dss_audio {
+	struct snd_aes_iec958 *iec;
+	struct snd_cea_861_aud_if *cea;
+};
+
 struct omap_hdmi_audio_ops {
 	int (*audio_startup)(struct device *dev,
 			     void (*abort_cb)(struct device *dev));
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 53ada70cf23c..b25e2eab4b48 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -168,11 +168,6 @@ enum omap_dss_display_state {
 	OMAP_DSS_DISPLAY_ACTIVE,
 };
 
-struct omap_dss_audio {
-	struct snd_aes_iec958 *iec;
-	struct snd_cea_861_aud_if *cea;
-};
-
 enum omap_dss_rotation_type {
 	OMAP_DSS_ROT_DMA	= 1 << 0,
 	OMAP_DSS_ROT_VRFB	= 1 << 1,
diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/omap/omap-hdmi-audio.c
index 64425d352962..888133f9e65d 100644
--- a/sound/soc/omap/omap-hdmi-audio.c
+++ b/sound/soc/omap/omap-hdmi-audio.c
@@ -28,7 +28,6 @@
 #include <sound/asoundef.h>
 #include <sound/omap-pcm.h>
 #include <sound/omap-hdmi-audio.h>
-#include <video/omapdss.h>
 
 #define DRV_NAME "omap-hdmi-audio"
 
-- 
2.8.3
