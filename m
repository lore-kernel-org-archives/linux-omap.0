From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC v4 2/8] ALSA: pcm: add IEC958 channel status helper for hw_params
Date: Fri, 18 Sep 2015 14:06:39 +0300
Message-ID: <a7b69fb075b0ae993846cfb65abb20ecab5c9805.1442572860.git.jsarha@ti.com>
References: <cover.1442572860.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1442572860.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add IEC958 channel status helper that gets the audio properties from
snd_pcm_hw_params instead of snd_pcm_runtime. This is needed to
produce the channel status bits already in audio stream configuration
phase.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 include/sound/pcm_iec958.h |  2 ++
 sound/core/pcm_iec958.c    | 52 +++++++++++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/include/sound/pcm_iec958.h b/include/sound/pcm_iec958.h
index 0eed397..36f023a 100644
--- a/include/sound/pcm_iec958.h
+++ b/include/sound/pcm_iec958.h
@@ -6,4 +6,6 @@
 int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
 	size_t len);
 
+int snd_pcm_create_iec958_consumer_hw_params(struct snd_pcm_hw_params *params,
+					     u8 *cs, size_t len);
 #endif
diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
index 36b2d7a..c9f8b66 100644
--- a/sound/core/pcm_iec958.c
+++ b/sound/core/pcm_iec958.c
@@ -9,30 +9,18 @@
 #include <linux/types.h>
 #include <sound/asoundef.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/pcm_iec958.h>
 
-/**
- * snd_pcm_create_iec958_consumer - create consumer format IEC958 channel status
- * @runtime: pcm runtime structure with ->rate filled in
- * @cs: channel status buffer, at least four bytes
- * @len: length of channel status buffer
- *
- * Create the consumer format channel status data in @cs of maximum size
- * @len corresponding to the parameters of the PCM runtime @runtime.
- *
- * Drivers may wish to tweak the contents of the buffer after creation.
- *
- * Returns: length of buffer, or negative error code if something failed.
- */
-int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
-	size_t len)
+static int create_iec958_consumer(uint rate, uint sample_width,
+				  u8 *cs, size_t len)
 {
 	unsigned int fs, ws;
 
 	if (len < 4)
 		return -EINVAL;
 
-	switch (runtime->rate) {
+	switch (rate) {
 	case 32000:
 		fs = IEC958_AES3_CON_FS_32000;
 		break;
@@ -59,7 +47,7 @@ int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
 	}
 
 	if (len > 4) {
-		switch (snd_pcm_format_width(runtime->format)) {
+		switch (sample_width) {
 		case 16:
 			ws = IEC958_AES4_CON_WORDLEN_20_16;
 			break;
@@ -92,4 +80,34 @@ int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
 
 	return len;
 }
+
+/**
+ * snd_pcm_create_iec958_consumer - create consumer format IEC958 channel status
+ * @runtime: pcm runtime structure with ->rate filled in
+ * @cs: channel status buffer, at least four bytes
+ * @len: length of channel status buffer
+ *
+ * Create the consumer format channel status data in @cs of maximum size
+ * @len corresponding to the parameters of the PCM runtime @runtime.
+ *
+ * Drivers may wish to tweak the contents of the buffer after creation.
+ *
+ * Returns: length of buffer, or negative error code if something failed.
+ */
+int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
+	size_t len)
+{
+	return create_iec958_consumer(runtime->rate,
+				      snd_pcm_format_width(runtime->format),
+				      cs, len);
+}
 EXPORT_SYMBOL(snd_pcm_create_iec958_consumer);
+
+
+int snd_pcm_create_iec958_consumer_hw_params(struct snd_pcm_hw_params *params,
+					     u8 *cs, size_t len)
+{
+	return create_iec958_consumer(params_rate(params), params_width(params),
+				      cs, len);
+}
+EXPORT_SYMBOL(snd_pcm_create_iec958_consumer_hw_params);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
