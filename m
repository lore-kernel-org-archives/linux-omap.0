From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC v5 3/8] ASoC: hdmi-codec: Add audio abort() callback for video side to use
Date: Wed, 17 Feb 2016 16:49:04 +0200
Message-ID: <9aed642926bee8c108b82e243ed0ef3e810db50f.1455720381.git.jsarha@ti.com>
References: <cover.1455720381.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1455720381.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add audio abort() callback, that is provided at audio stream start,
for video side. This is for video side to use in case there is a
pressing need to tear down the audio playback for some reason.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 include/sound/hdmi-codec.h    |  8 ++++++--
 sound/soc/codecs/hdmi-codec.c | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index fc3a481..15fe70f 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -55,10 +55,14 @@ struct hdmi_codec_params {
 
 struct hdmi_codec_ops {
 	/*
-	 * Called when ASoC starts an audio stream setup.
+	 * Called when ASoC starts an audio stream setup. The call
+	 * provides an audio abort callback for stoping an ongoing
+	 * stream from video side driver if the HDMI audio becomes
+	 * unavailable.
 	 * Optional
 	 */
-	int (*audio_startup)(struct device *dev);
+	int (*audio_startup)(struct device *dev,
+			     void (*abort_cb)(struct device *dev));
 
 	/*
 	 * Configures HDMI-encoder for audio stream.
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index bc47b9a..cc08097 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -47,6 +47,23 @@ enum {
 	DAI_ID_SPDIF,
 };
 
+static void hdmi_codec_abort(struct device *dev)
+{
+	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	mutex_lock(&hcp->current_stream_lock);
+	if (hcp->current_stream && hcp->current_stream->runtime &&
+	    snd_pcm_running(hcp->current_stream)) {
+		dev_info(dev, "HDMI audio playback aborted\n");
+		snd_pcm_stream_lock_irq(hcp->current_stream);
+		snd_pcm_stop(hcp->current_stream, SNDRV_PCM_STATE_DISCONNECTED);
+		snd_pcm_stream_unlock_irq(hcp->current_stream);
+	}
+	mutex_unlock(&hcp->current_stream_lock);
+}
+
 static int hdmi_codec_new_stream(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
@@ -78,7 +95,8 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 		return ret;
 
 	if (hcp->hcd.ops->audio_startup) {
-		ret = hcp->hcd.ops->audio_startup(dai->dev->parent);
+		ret = hcp->hcd.ops->audio_startup(dai->dev->parent,
+						  hdmi_codec_abort);
 		if (ret) {
 			mutex_lock(&hcp->current_stream_lock);
 			hcp->current_stream = NULL;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
