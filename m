From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2] OMAPDSS: Provide an interface for audio
	support in DSS
Date: Thu, 3 May 2012 19:53:53 -0500
Message-ID: <1336092833-1908-2-git-send-email-ricardo.neri@ti.com>
References: <1336092833-1908-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1336092833-1908-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tomi.valkeinen@ti.com
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, lrg@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, s-chereau@ti.com
List-Id: linux-omap@vger.kernel.org

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

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 Documentation/arm/OMAP/DSS |   38 ++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h    |   25 +++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 888ae7b..32ca5d9 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -47,6 +47,44 @@ flexible way to enable non-common multi-display configuration. In addition to
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
 Panel and controller drivers
 ----------------------------
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 483f67c..5f43295 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -51,6 +51,8 @@
 
 struct omap_dss_device;
 struct omap_overlay_manager;
+struct snd_aes_iec958;
+struct snd_cea_861_aud_if;
 
 enum omap_display_type {
 	OMAP_DISPLAY_TYPE_NONE		= 0,
@@ -595,6 +597,11 @@ struct omap_dss_hdmi_data
 	int hpd_gpio;
 };
 
+struct omap_dss_audio {
+	struct snd_aes_iec958 *iec;
+	struct snd_cea_861_aud_if *cea;
+};
+
 struct omap_dss_driver {
 	struct device_driver driver;
 
@@ -642,6 +649,24 @@ struct omap_dss_driver {
 
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
