From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3] OMAPDSS: Provide an interface for audio support
Date: Wed, 9 May 2012 22:42:32 -0500
Message-ID: <1336621352-27959-2-git-send-email-ricardo.neri@ti.com>
References: <1336621352-27959-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36137 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338Ab2EJDm6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 23:42:58 -0400
In-Reply-To: <1336621352-27959-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

There exist several display technologies and standards that support audio as
well. Hence, it is relevant to update the DSS device driver to provide an audio
interface that may be used by an audio driver or any other driver interested in
the functionality.

The audio_enable function is intended to prepare the relevant
IP for playback (e.g., enabling an audio FIFO, taking in/out of reset
some IP, enabling companion chips, etc). It is intended to be called before
audio_start. The audio_disable function performs the reverse operation and is
intended to be called after audio_stop.

While a given DSS device driver may support audio, it is possible that for
certain configurations audio is not supported (e.g., an HDMI display using a
VESA video timing). The audio_supported function is intended to query whether
the current configuration of the display supports audio.

The audio_config function is intended to configure all the relevant audio
parameters of the display. In order to make the function independent of any
specific DSS device driver, a struct omap_dss_audio is defined. Its purpose
is to contain all the required parameters for audio configuration. At the
moment, such structure contains pointers to IEC-60958 channel status word and
CEA-861 audio infoframe structures. This should be enough to support HDMI and
DisplayPort, as both are based on CEA-861 and IEC-60958. The omap_dss_audio
structure may be extended in the future if required.

The audio_enable/disable, audio_config and audio_supported functions could be
implemented as functions that may sleep. Hence, they should not be called
while holding a spinlock or a readlock.

The audio_start/audio_stop function is intended to effectively start/stop audio
playback after the configuration has taken place. These functions are designed
to be used in an atomic context. Hence, audio_start should return quickly and be
called only after all the needed resources for audio playback (audio FIFOs,
DMA channels, companion chips, etc) have been enabled to begin data transfers.
audio_stop is designed to only stop the audio transfers. The resources used
for playback are released using audio_disable.

A new enum omap_dss_audio_state is introduced to help the implementations of
the interface to keep track of the audio state. The initial state is _DISABLED;
then, the state transitions to _CONFIGURED, and then, when it is ready to
play audio, to _ENABLED. The state _PLAYING is used when the audio is being
rendered.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 Documentation/arm/OMAP/DSS |   45 ++++++++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h    |   34 +++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 888ae7b..c7c8ee4 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -47,6 +47,51 @@ flexible way to enable non-common multi-display configuration. In addition to
 modelling the hardware overlays, omapdss supports virtual overlays and overlay
 managers. These can be used when updating a display with CPU or system DMA.
 
+omapdss driver support for audio
+--------------------------------
+There exist several display technologies and standards that support audio as
+well. Hence, it is relevant to update the DSS device driver to provide an audio
+interface that may be used by an audio driver or any other driver interested in
+the functionality.
+
+The audio_enable function is intended to prepare the relevant
+IP for playback (e.g., enabling an audio FIFO, taking in/out of reset
+some IP, enabling companion chips, etc). It is intended to be called before
+audio_start. The audio_disable function performs the reverse operation and is
+intended to be called after audio_stop.
+
+While a given DSS device driver may support audio, it is possible that for
+certain configurations audio is not supported (e.g., an HDMI display using a
+VESA video timing). The audio_supported function is intended to query whether
+the current configuration of the display supports audio.
+
+The audio_config function is intended to configure all the relevant audio
+parameters of the display. In order to make the function independent of any
+specific DSS device driver, a struct omap_dss_audio is defined. Its purpose
+is to contain all the required parameters for audio configuration. At the
+moment, such structure contains pointers to IEC-60958 channel status word
+and CEA-861 audio infoframe structures. This should be enough to support
+HDMI and DisplayPort, as both are based on CEA-861 and IEC-60958.
+
+The audio_enable/disable, audio_config and audio_supported functions could be
+implemented as functions that may sleep. Hence, they should not be called
+while holding a spinlock or a readlock.
+
+The audio_start/audio_stop function is intended to effectively start/stop audio
+playback after the configuration has taken place. These functions are designed
+to be used in an atomic context. Hence, audio_start should return quickly and be
+called only after all the needed resources for audio playback (audio FIFOs,
+DMA channels, companion chips, etc) have been enabled to begin data transfers.
+audio_stop is designed to only stop the audio transfers. The resources used
+for playback are released using audio_disable.
+
+The enum omap_dss_audio_state may be used to help the implementations of
+the interface to keep track of the audio state. The initial state is _DISABLED;
+then, the state transitions to _CONFIGURED, and then, when it is ready to
+play audio, to _ENABLED. The state _PLAYING is used when the audio is being
+rendered.
+
+
 Panel and controller drivers
 ----------------------------
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 483f67c..718a437 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -51,6 +51,8 @@
 
 struct omap_dss_device;
 struct omap_overlay_manager;
+struct snd_aes_iec958;
+struct snd_cea_861_aud_if;
 
 enum omap_display_type {
 	OMAP_DISPLAY_TYPE_NONE		= 0,
@@ -158,6 +160,13 @@ enum omap_dss_display_state {
 	OMAP_DSS_DISPLAY_SUSPENDED,
 };
 
+enum omap_dss_audio_state {
+	OMAP_DSS_AUDIO_DISABLED = 0,
+	OMAP_DSS_AUDIO_ENABLED,
+	OMAP_DSS_AUDIO_CONFIGURED,
+	OMAP_DSS_AUDIO_PLAYING,
+};
+
 /* XXX perhaps this should be removed */
 enum omap_dss_overlay_managers {
 	OMAP_DSS_OVL_MGR_LCD,
@@ -583,6 +592,8 @@ struct omap_dss_device {
 
 	enum omap_dss_display_state state;
 
+	enum omap_dss_audio_state audio_state;
+
 	/* platform specific  */
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
@@ -595,6 +606,11 @@ struct omap_dss_hdmi_data
 	int hpd_gpio;
 };
 
+struct omap_dss_audio {
+	struct snd_aes_iec958 *iec;
+	struct snd_cea_861_aud_if *cea;
+};
+
 struct omap_dss_driver {
 	struct device_driver driver;
 
@@ -642,6 +658,24 @@ struct omap_dss_driver {
 
 	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
 	bool (*detect)(struct omap_dss_device *dssdev);
+
+	/*
+	 * For display drivers that support audio. This encompasses
+	 * HDMI and DisplayPort at the moment.
+	 */
+	/*
+	 * Note: These functions might sleep. Do not call while
+	 * holding a spinlock/readlock.
+	 */
+	int (*audio_enable)(struct omap_dss_device *dssdev);
+	void (*audio_disable)(struct omap_dss_device *dssdev);
+	bool (*audio_supported)(struct omap_dss_device *dssdev);
+	int (*audio_config)(struct omap_dss_device *dssdev,
+		struct omap_dss_audio *audio);
+	/* Note: These functions may not sleep */
+	int (*audio_start)(struct omap_dss_device *dssdev);
+	void (*audio_stop)(struct omap_dss_device *dssdev);
+
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
-- 
1.7.5.4

