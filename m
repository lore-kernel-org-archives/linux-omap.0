From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Convert OMAP ALSA core and AIC23 to new ALSA
 struct usage
Date: Sun, 04 Mar 2007 18:59:29 +0100
Message-ID: <45EB0901.7010306@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060201070807020800010705"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201070807020800010705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Convert OMAP ALSA core and AIC23 to new ALSA
struct usage.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------060201070807020800010705
Content-Type: text/plain;
 name="omap_alsa_fixes.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_alsa_fixes.txt"

Index: linux-osk/sound/arm/omap/omap-alsa-aic23-mixer.c
===================================================================
--- linux-osk.orig/sound/arm/omap/omap-alsa-aic23-mixer.c
+++ linux-osk/sound/arm/omap/omap-alsa-aic23-mixer.c
@@ -139,7 +139,8 @@ u16 snd_sidetone[6] = {
 
 /* Begin Bool Functions */
 
-static int snd_omap_info_bool(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+static int snd_omap_info_bool(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
@@ -149,8 +150,8 @@ static int snd_omap_info_bool(snd_kcontr
 	return 0;
 }
 
-static int snd_omap_get_bool(snd_kcontrol_t * kcontrol,
-				 snd_ctl_elem_value_t * ucontrol)
+static int snd_omap_get_bool(struct snd_kcontrol * kcontrol,
+			     struct snd_ctl_elem_value * ucontrol)
 {
 	int mic_index = (kcontrol->private_value >> 8) & 0x03;
 	u16 mask = (kcontrol->private_value >> 12) & 0xff;
@@ -166,8 +167,8 @@ static int snd_omap_get_bool(snd_kcontro
 	return 0;
 }
 
-static int snd_omap_put_bool(snd_kcontrol_t * kcontrol,
-				 snd_ctl_elem_value_t * ucontrol)
+static int snd_omap_put_bool(struct snd_kcontrol * kcontrol,
+			     struct snd_ctl_elem_value * ucontrol)
 {
 	int mic_index = (kcontrol->private_value >> 8) & 0x03;
 	u16 mask = (kcontrol->private_value >> 12) & 0xff;
@@ -196,8 +197,8 @@ static int snd_omap_put_bool(snd_kcontro
 
 /* Begin Mux Functions */
 
-static int snd_omap_info_mux(snd_kcontrol_t *kcontrol,
-				 snd_ctl_elem_info_t * uinfo)
+static int snd_omap_info_mux(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info * uinfo)
 {
 	/* Mic = 0
 	 * Line = 1 */
@@ -216,8 +217,8 @@ static int snd_omap_info_mux(snd_kcontro
 	return 0;
 }
 
-static int snd_omap_get_mux(snd_kcontrol_t * kcontrol,
-				snd_ctl_elem_value_t * ucontrol)
+static int snd_omap_get_mux(struct snd_kcontrol * kcontrol,
+			    struct snd_ctl_elem_value * ucontrol)
 {
 	u16 mask = (kcontrol->private_value >> 10) & 0xff;
 	int mux_index = (kcontrol->private_value >> 8) & 0x03;
@@ -228,8 +229,8 @@ static int snd_omap_get_mux(snd_kcontrol
 	return 0;
 }
 
-static int snd_omap_put_mux(snd_kcontrol_t * kcontrol,
-				snd_ctl_elem_value_t * ucontrol)
+static int snd_omap_put_mux(struct snd_kcontrol * kcontrol,
+			    struct snd_ctl_elem_value * ucontrol)
 {
 	u16 reg = kcontrol->private_value & 0xff;
 	u16 mask = (kcontrol->private_value >> 10) & 0xff;
@@ -251,8 +252,8 @@ static int snd_omap_put_mux(snd_kcontrol
 
 /* Begin Single Functions */
 
-static int snd_omap_info_single(snd_kcontrol_t *kcontrol,
-				snd_ctl_elem_info_t * uinfo)
+static int snd_omap_info_single(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info * uinfo)
 {
 	int mask = (kcontrol->private_value >> 18) & 0xff;
 	int reg_val = (kcontrol->private_value >> 8) & 0xff;
@@ -266,8 +267,8 @@ static int snd_omap_info_single(snd_kcon
 	return 0;
 }
 
-static int snd_omap_get_single(snd_kcontrol_t * kcontrol,
-					snd_ctl_elem_value_t * ucontrol)
+static int snd_omap_get_single(struct snd_kcontrol * kcontrol,
+			       struct snd_ctl_elem_value * ucontrol)
 {
 	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
 
@@ -276,8 +277,8 @@ static int snd_omap_get_single(snd_kcont
 	return 0;
 }
 
-static int snd_omap_put_single(snd_kcontrol_t * kcontrol,
-					snd_ctl_elem_value_t * ucontrol)
+static int snd_omap_put_single(struct snd_kcontrol * kcontrol,
+			       struct snd_ctl_elem_value * ucontrol)
 {
 	u16 reg_index = (kcontrol->private_value >> 16) & 0x03;
 	u16 mask = (kcontrol->private_value >> 18) & 0x1ff;
@@ -308,8 +309,8 @@ static int snd_omap_put_single(snd_kcont
 
 /* Begin Double Functions */
 
-static int snd_omap_info_double(snd_kcontrol_t *kcontrol,
-				snd_ctl_elem_info_t * uinfo)
+static int snd_omap_info_double(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info * uinfo)
 {
 	/* mask == 0 : Switch
 	 * mask != 0 : Volume */
@@ -324,7 +325,8 @@ static int snd_omap_info_double(snd_kcon
 	return 0;
 }
 
-static int snd_omap_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_omap_get_double(struct snd_kcontrol * kcontrol,
+			       struct snd_ctl_elem_value * ucontrol)
 {
 	/* mask == 0 : Switch
 	 * mask != 0 : Volume */
@@ -343,7 +345,8 @@ static int snd_omap_get_double(snd_kcont
 	return 0;
 }
 
-static int snd_omap_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_omap_put_double(struct snd_kcontrol * kcontrol,
+			       struct snd_ctl_elem_value * ucontrol)
 {
 	/* mask == 0 : Switch
 	 * mask != 0 : Volume */
@@ -393,7 +396,7 @@ static int snd_omap_put_double(snd_kcont
 
 /* End Double Functions */
 
-static snd_kcontrol_new_t snd_omap_controls[] = {
+static struct snd_kcontrol_new snd_omap_controls[] = {
 	OMAP_DOUBLE("PCM Playback Switch", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
 		     PCM_INDEX, 0x00),
 	OMAP_DOUBLE("PCM Playback Volume", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
@@ -475,7 +478,7 @@ void snd_omap_init_mixer(void)
 
 int snd_omap_mixer(struct snd_card_omap_codec *chip)
 {
-	snd_card_t *card;
+	struct snd_card *card;
 	unsigned int idx;
 	int err;
 
Index: linux-osk/sound/arm/omap/omap-alsa-aic23.c
===================================================================
--- linux-osk.orig/sound/arm/omap/omap-alsa-aic23.c
+++ linux-osk/sound/arm/omap/omap-alsa-aic23.c
@@ -60,13 +60,13 @@ static unsigned int rates[] = {
 	48000, 88200, 96000,
 };
 
-static snd_pcm_hw_constraint_list_t aic23_hw_constraints_rates = {
+static struct snd_pcm_hw_constraint_list aic23_hw_constraints_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list = rates,
 	.mask = 0,
 };
 
-static snd_pcm_hardware_t aic23_snd_omap_alsa_playback = {
+static struct snd_pcm_hardware aic23_snd_omap_alsa_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
@@ -87,7 +87,7 @@ static snd_pcm_hardware_t aic23_snd_omap
 	.fifo_size = 0,
 };
 
-static snd_pcm_hardware_t aic23_snd_omap_alsa_capture = {
+static struct snd_pcm_hardware aic23_snd_omap_alsa_capture = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
Index: linux-osk/sound/arm/omap/omap-alsa.c
===================================================================
--- linux-osk.orig/sound/arm/omap/omap-alsa.c
+++ linux-osk/sound/arm/omap/omap-alsa.c
@@ -48,6 +48,7 @@
 #endif
 #include <sound/driver.h>
 #include <sound/core.h>
+#include <sound/pcm.h>
 
 #include <asm/arch/omap-alsa.h>
 #include "omap-alsa-dma.h"
@@ -135,8 +136,8 @@ static int audio_dma_free(struct audio_s
  */
 static u_int audio_get_dma_pos(struct audio_stream *s)
 {
-	snd_pcm_substream_t *substream = s->stream;
-	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct snd_pcm_substream *substream = s->stream;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int offset;
 	unsigned long flags;
 	dma_addr_t count;
@@ -185,8 +186,8 @@ static void audio_stop_dma(struct audio_
  */
 static void audio_process_dma(struct audio_stream *s)
 {
-	snd_pcm_substream_t *substream = s->stream;
-	snd_pcm_runtime_t *runtime;
+	struct snd_pcm_substream *substream = s->stream;
+	struct snd_pcm_runtime *runtime;
 	unsigned int dma_size;
 	unsigned int offset;
 	int ret;
@@ -250,7 +251,7 @@ void callback_omap_alsa_sound_dma(void *
  * Alsa section
  * PCM settings and callbacks
  */
-static int snd_omap_alsa_trigger(snd_pcm_substream_t * substream, int cmd)
+static int snd_omap_alsa_trigger(struct snd_pcm_substream * substream, int cmd)
 {
 	struct snd_card_omap_codec *chip =
 	    snd_pcm_substream_chip(substream);
@@ -280,10 +281,10 @@ static int snd_omap_alsa_trigger(snd_pcm
 	return err;
 }
 
-static int snd_omap_alsa_prepare(snd_pcm_substream_t * substream)
+static int snd_omap_alsa_prepare(struct snd_pcm_substream * substream)
 {
 	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_stream *s = &chip->s[substream->pstr->stream];
 	
 	ADEBUG();
@@ -297,7 +298,7 @@ static int snd_omap_alsa_prepare(snd_pcm
 	return 0;
 }
 
-static snd_pcm_uframes_t snd_omap_alsa_pointer(snd_pcm_substream_t *substream)
+static snd_pcm_uframes_t snd_omap_alsa_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
 
@@ -305,11 +306,11 @@ static snd_pcm_uframes_t snd_omap_alsa_p
 	return audio_get_dma_pos(&chip->s[substream->pstr->stream]);
 }
 
-static int snd_card_omap_alsa_open(snd_pcm_substream_t * substream)
+static int snd_card_omap_alsa_open(struct snd_pcm_substream * substream)
 {
 	struct snd_card_omap_codec *chip =
 	    snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	int stream_id = substream->pstr->stream;
 	int err;
 	
@@ -334,7 +335,7 @@ static int snd_card_omap_alsa_open(snd_p
 	return 0;
 }
 
-static int snd_card_omap_alsa_close(snd_pcm_substream_t * substream)
+static int snd_card_omap_alsa_close(struct snd_pcm_substream * substream)
 {
 	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
 	
@@ -346,20 +347,20 @@ static int snd_card_omap_alsa_close(snd_
 }
 
 /* HW params & free */
-static int snd_omap_alsa_hw_params(snd_pcm_substream_t * substream,
-				    snd_pcm_hw_params_t * hw_params)
+static int snd_omap_alsa_hw_params(struct snd_pcm_substream * substream,
+				   struct snd_pcm_hw_params * hw_params)
 {
 	return snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
 }
 
-static int snd_omap_alsa_hw_free(snd_pcm_substream_t * substream)
+static int snd_omap_alsa_hw_free(struct snd_pcm_substream * substream)
 {
 	return snd_pcm_lib_free_pages(substream);
 }
 
 /* pcm operations */
-static snd_pcm_ops_t snd_card_omap_alsa_playback_ops = {
+static struct snd_pcm_ops snd_card_omap_alsa_playback_ops = {
 	.open =		snd_card_omap_alsa_open,
 	.close =	snd_card_omap_alsa_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -370,7 +371,7 @@ static snd_pcm_ops_t snd_card_omap_alsa_
 	.pointer =	snd_omap_alsa_pointer,
 };
 
-static snd_pcm_ops_t snd_card_omap_alsa_capture_ops = {
+static struct snd_pcm_ops snd_card_omap_alsa_capture_ops = {
 	.open =		snd_card_omap_alsa_open,
 	.close =	snd_card_omap_alsa_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -389,7 +390,7 @@ static snd_pcm_ops_t snd_card_omap_alsa_
 static int __init snd_card_omap_alsa_pcm(struct snd_card_omap_codec *omap_alsa, 
 					int device)
 {
-	snd_pcm_t *pcm;
+	struct snd_pcm *pcm;
 	int err;
 	
 	ADEBUG();
@@ -432,7 +433,7 @@ static int __init snd_card_omap_alsa_pcm
 int snd_omap_alsa_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct snd_card_omap_codec *chip;
-	snd_card_t *card = platform_get_drvdata(pdev);
+	struct snd_card *card = platform_get_drvdata(pdev);
 	
 	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
 		chip = card->private_data;
@@ -450,7 +451,7 @@ int snd_omap_alsa_suspend(struct platfor
 int snd_omap_alsa_resume(struct platform_device *pdev)
 {
 	struct snd_card_omap_codec *chip;
-	snd_card_t *card = platform_get_drvdata(pdev);
+	struct snd_card *card = platform_get_drvdata(pdev);
 
 	if (card->power_state != SNDRV_CTL_POWER_D0) {				
 		chip = card->private_data;
@@ -465,7 +466,7 @@ int snd_omap_alsa_resume(struct platform
 
 #endif	/* CONFIG_PM */
 
-void snd_omap_alsa_free(snd_card_t * card)
+void snd_omap_alsa_free(struct snd_card * card)
 {
 	struct snd_card_omap_codec *chip = card->private_data;
 	ADEBUG();
@@ -494,7 +495,7 @@ int snd_omap_alsa_post_probe(struct plat
 {
 	int err = 0;
 	int def_rate;
-	snd_card_t *card;
+	struct snd_card *card;
 	
 	ADEBUG();
 	alsa_codec_config	= config;
@@ -565,7 +566,7 @@ nodev1:
 
 int snd_omap_alsa_remove(struct platform_device *pdev)
 {
-	snd_card_t *card = platform_get_drvdata(pdev);
+	struct snd_card *card = platform_get_drvdata(pdev);
 	struct snd_card_omap_codec *chip = card->private_data;
 	
 	snd_card_free(card);


--------------060201070807020800010705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060201070807020800010705--
