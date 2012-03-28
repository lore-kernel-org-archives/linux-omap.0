From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] OMAPDSS: Provide interface for audio support in DSS
Date: Wed, 28 Mar 2012 15:51:56 -0600
Message-ID: <1332971516-4325-2-git-send-email-ricardo.neri@ti.com>
References: <1332971516-4325-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40111 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259Ab2C1Vxs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 17:53:48 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q2SLrlFr030009
	for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 16:53:47 -0500
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q2SLrlcD018249
	for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 16:53:47 -0500 (CDT)
In-Reply-To: <1332971516-4325-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

There exist several display technologies and standards that support audio as
well. Hence, it is relevant to update the DSS device driver to provide an audio
interface that may be used by an audio or any other driver interested in the
functionality.

The DSS audio functions are intended to be used as follows:

The audio_enable function is intended to prepare the relevant IP for playback
(e.g., enabling an audio FIFO, taking out of reset some IP, etc).

While the display may support audio, it is possible that for certain
configurations audio is not supported (e.g., an HDMI display using a VESA video
timing). The audio_detect function is intended to query whether the current
configuration of the display supports audio.

The audio_config function is intended to configure all the relevant audio
parameters of the display. In order to make the function independent of any DSS
device driver or IP, it takes an IEC-60958 channel status word struct as well
as a CEA-861 audio infoframe struct. At the moment, this should be enough to
support HDMI and DisplayPort, as both are based on CEA-861 and IEC-60958.

The audio_start function is intended to effectively start/stop audio playback
after the configuration has taken place.

Please note that asound.h is #included only to pass the relevant data
structures to the DSS device driver. The DSS device driver should
not link to any ALSA function as DSS and ALSA are built in separate modules.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 Documentation/arm/OMAP/DSS |   28 ++++++++++++++++++++++++++++
 include/video/omapdss.h    |   12 ++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 888ae7b..b303a5c 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -47,6 +47,34 @@ flexible way to enable non-common multi-display configuration. In addition to
 modelling the hardware overlays, omapdss supports virtual overlays and overlay
 managers. These can be used when updating a display with CPU or system DMA.
 
+omapdss driver support for audio
+--------------------------------
+There exist several display technologies and standards that support audio as
+well. Hence, it is relevant to update the DSS device driver to provide an audio
+interface that may be used by an audio or any other driver interested in the
+functionality.
+
+The audio_enable function is intended to prepare the relevant IP for playback
+(e.g., enabling an audio FIFO, taking out of reset some IP, etc).
+
+While the display may support audio, it is possible that for certain
+configurations audio is not supported (e.g., an HDMI display using a VESA video
+timing). The audio_detect function is intended to query whether the current
+configuration of the display supports audio.
+
+The audio_config function is intended to configure all the relevant audio
+parameters of the display. In order to make the function independent of DSS
+any device driver, it takes a IEC-60958 channel status word as well
+as a CEA-861 audio infoframe. At the moment, this should be enough to support
+HDMI and DisplayPort, as both are based on CEA-861 and IEC-60958.
+
+The audio_start function is intended to effectively start/stop audio playback
+after the configuration has taken place.
+
+Please note that asound.h is #included only to pass the relevant data
+structures to the DSS device driver. The DSS device driver should
+not link to any ALSA function as DSS and ALSA are built in separate modules.
+
 Panel and controller drivers
 ----------------------------
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 483f67c..e35ae96 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -21,6 +21,7 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/device.h>
+#include <sound/asound.h>
 
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
 #define DISPC_IRQ_VSYNC			(1 << 1)
@@ -642,6 +643,17 @@ struct omap_dss_driver {
 
 	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
 	bool (*detect)(struct omap_dss_device *dssdev);
+
+	/*
+	 * For display drivers that support audio. This encompasses
+	 * HDMI and DisplayPort at the moment.
+	 */
+	int (*audio_enable)(struct omap_dss_device *dssdev, bool enable);
+	int (*audio_start)(struct omap_dss_device *dssdev, bool start);
+	bool (*audio_detect)(struct omap_dss_device *dssdev);
+	int (*audio_config)(struct omap_dss_device *dssdev,
+		struct snd_aes_iec958 *iec, struct snd_cea_861_aud_if *aud_if);
+
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
-- 
1.7.0.4

