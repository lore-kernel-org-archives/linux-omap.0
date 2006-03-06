From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: [PATCH] Alsa modularisations and support for tsc2101 1/3 (round 2)
Date: Mon, 6 Mar 2006 16:25:33 -0400
Message-ID: <9268368b0603061225n549badc3l770c6ca1036e1235@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5650_14689927.1141676733652"
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_5650_14689927.1141676733652
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ALSA Omap Modularisation

This series of patches adds modularisation in alsa files for omap so that
makes possible to use the same alsa omap core files for different boards.
Regarding the original omap alsa support, the codec specific functions
were removed from file omap-aic23.c (which now is called omap-alsa.c)
and inserted in a specific file for this codec. Similar action was made
for tsc2101 codec, based in oss former drivers.
With this series of patches omap now have support for osk and H2 boards.
Besides codec files, the mixer file has its support added for H2.

Summary:

-New architecture: extraction of codec dependent code from main alsa file
-Support for board H2
-Creation of codec alsa file for codec aic23 (from existing alsa work)
-Creation of codec alsa file for codec tsc2101 from oss
-Migration of specific codec configuration to platform_data
-Improvement of function probe in omap-alsa driver
-Creation of the mixer for tsc2101

Changes based on to feedback in the previous patch
- All files except omap-alsa.h are now located under the sound/arm/omap
directory
 (no files to arch/arm/mach-omap or arch/arm/plat-omap)
- Function pointers required are now specified in the codec file
- Codec specific function names are not defined anymore in the omap-alsa.h
- Codec specific samplerates and other constraint are now defined in the
codec file.
- Usage of schedule_timeout_interruptible instead of using
set_current_state and schedule_timeout functions
- Same naming style in suspend/resume/remove functions. Note that the
probe is now a special case
 that is splitted to codec specific functionality and common
functionality between all codecs.
- Linux code format suggestions added
- AIC23 specific naming removed from the omap-alsa.c

Following suggestions were not done or were left to be implemented in
the later set of patches
- Driver is set in the board code is "omap_alsa_mcbsp"
- Default clock frequency is not yet dynamic / patches
- GPG_KERNEL requires brackets around it to be able to compile.


OMAP Alsa Patch 1/3

This 1/3 patch prepares the addon of tsc2101 driver by renaming structures
that can be shared by aic23 and tsc2101 drivers to more specific names.
In addition this patch renames DMA function names so that they do not
conflict with the dma function names in the oss driver.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
Signed-off-by: Daniel Petrini <d.pensator@gmail.com>


Daniel
--
INdT - Manaus - Brazil

------=_Part_5650_14689927.1141676733652
Content-Type: text/x-patch; name=0001_omap_alsa_tsc2101.patch;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ekh7w295
Content-Disposition: attachment; filename="0001_omap_alsa_tsc2101.patch"

ALSA Omap Modularisation

This series of patches adds modularisation in alsa files for omap so that
makes possible to use the same alsa omap core files for different boards.
Regarding the original omap alsa support, the codec specific functions
were removed from file omap-aic23.c (which now is called omap-alsa.c)
and inserted in a specific file for this codec. Similar action was made
for tsc2101 codec, based in oss former drivers.
With this series of patches omap now have support for osk and H2 boards.
Besides codec files, the mixer file has its support added for H2.

Summary:

-New architecture: extraction of codec dependent code from main alsa file
-Support for board H2
-Creation of codec alsa file for codec aic23 (from existing alsa work)
-Creation of codec alsa file for codec tsc2101 from oss
-Migration of specific codec configuration to platform_data
-Improvement of function probe in omap-alsa driver
-Creation of the mixer for tsc2101

Changes based on to feedback in the previous patch
- All files except omap-alsa.h are now located under the sound/arm/omap directory
  (no files to arch/arm/mach-omap or arch/arm/plat-omap)
- Function pointers required are now specified in the codec file
- Codec specific function names are not defined anymore in the omap-alsa.h
- Codec specific samplerates and other constraint are now defined in the codec file.
- Usage of schedule_timeout_interruptible instead of using set_current_state and schedule_timeout functions
- Same naming style in suspend/resume/remove functions. Note that the probe is now a special case
  that is splitted to codec specific functionality and common functionality between all codecs.
- Linux code format suggestions added
- AIC23 specific naming removed from the omap-alsa.c

Following suggestions were not done or were left to be implemented in the later set of patches
- Driver is set in the board code is "omap_alsa_mcbsp"
- Default clock frequency is not yet dynamic / patches 
- GPG_KERNEL requires brackets around it to be able to compile.


OMAP Alsa Patch 1/3

This 1/3 patch prepares the addon of tsc2101 driver by renaming structures 
that can be shared by aic23 and tsc2101 drivers to more specific names.
In addition this patch renames DMA function names so that they do not
conflict with the dma function names in the oss driver.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
Signed-off-by: Daniel Petrini <d.pensator@gmail.com>

---

 sound/arm/omap-aic23.c      |  195 +++++++++++++++++++------------------------
 sound/arm/omap-aic23.h      |   11 +-
 sound/arm/omap-alsa-dma.c   |   64 +++++++-------
 sound/arm/omap-alsa-dma.h   |   22 ++---
 sound/arm/omap-alsa-mixer.c |    2 
 5 files changed, 130 insertions(+), 164 deletions(-)

866b5f7fb074e448f371c91c1262da46e8fcd715
diff --git a/sound/arm/omap-aic23.c b/sound/arm/omap-aic23.c
index c92e245..bd2df14 100644
--- a/sound/arm/omap-aic23.c
+++ b/sound/arm/omap-aic23.c
@@ -98,7 +98,7 @@ MODULE_ALIAS("omap_mcbsp.1");
 static char *id = NULL;	
 MODULE_PARM_DESC(id, "OMAP OSK ALSA Driver for AIC23 chip.");
 
-static struct snd_card_omap_aic23 *omap_aic23 = NULL;
+static struct snd_card_omap_codec *omap_aic23 = NULL;
 
 static struct clk *aic23_mclk = 0;
 
@@ -182,7 +182,7 @@ static int audio_ifc_stop(void)
 /*
  * Sample rate changing
  */
-static void omap_aic23_set_samplerate(struct snd_card_omap_aic23
+static void omap_aic23_set_samplerate(struct snd_card_omap_codec
 				      *omap_aic23, long rate)
 {
 	u8 count = 0;
@@ -252,7 +252,7 @@ static inline void aic23_configure(void)
 
 }
 
-static void omap_aic23_audio_init(struct snd_card_omap_aic23 *omap_aic23)
+static void omap_aic23_audio_init(struct snd_card_omap_codec *omap_aic23)
 {
 	/* Setup DMA stuff */
 	omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK].id = "Alsa AIC23 out";
@@ -298,7 +298,7 @@ static int audio_dma_request(struct audi
 {
 	int err;
 
-	err = omap_request_sound_dma(s->dma_dev, s->id, s, &s->lch);
+	err = omap_request_alsa_sound_dma(s->dma_dev, s->id, s, &s->lch);
 	if (err < 0)
 		printk(KERN_ERR "unable to grab audio dma 0x%x\n",
 		       s->dma_dev);
@@ -309,7 +309,7 @@ static int audio_dma_free(struct audio_s
 {
 	int err = 0;
 
-	err = omap_free_sound_dma(s, &s->lch);
+	err = omap_free_alsa_sound_dma(s, &s->lch);
 	if (err < 0)
 		printk(KERN_ERR "Unable to free audio dma channels!\n");
 	return err;
@@ -360,9 +360,10 @@ static void audio_stop_dma(struct audio_
 	s->periods = 0;
 
 	/* this stops the dma channel and clears the buffer ptrs */
-	omap_audio_stop_dma(s);
+	/* this stops the dma channel and clears the buffer ptrs */
+	omap_stop_alsa_sound_dma(s);
 
-	omap_clear_sound_dma(s);
+	omap_clear_alsa_sound_dma(s);
 
 	spin_unlock_irqrestore(&s->dma_lock, flags);
 }
@@ -383,8 +384,7 @@ static void audio_process_dma(struct aud
 		dma_size = frames_to_bytes(runtime, runtime->period_size);
 		offset = dma_size * s->period;
 		snd_assert(dma_size <= DMA_BUF_SIZE,);
-		ret =
-		    omap_start_sound_dma(s,
+		ret = omap_start_alsa_sound_dma(s,
 					 (dma_addr_t) runtime->dma_area +
 					 offset, dma_size);
 		if (ret) {
@@ -404,7 +404,7 @@ static void audio_process_dma(struct aud
 /* 
  *  This is called when dma IRQ occurs at the end of each transmited block
  */
-void audio_dma_callback(void *data)
+void callback_omap_alsa_sound_dma(void *data)
 {
 	struct audio_stream *s = data;
 
@@ -429,9 +429,9 @@ void audio_dma_callback(void *data)
  * PCM settings and callbacks
  */
 
-static int snd_omap_aic23_trigger(snd_pcm_substream_t * substream, int cmd)
+static int snd_omap_alsa_trigger(snd_pcm_substream_t * substream, int cmd)
 {
-	struct snd_card_omap_aic23 *chip =
+	struct snd_card_omap_codec *chip =
 	    snd_pcm_substream_chip(substream);
 	int stream_id = substream->pstr->stream;
 	struct audio_stream *s = &chip->s[stream_id];
@@ -459,9 +459,9 @@ static int snd_omap_aic23_trigger(snd_pc
 	return err;
 }
 
-static int snd_omap_aic23_prepare(snd_pcm_substream_t * substream)
+static int snd_omap_alsa_prepare(snd_pcm_substream_t * substream)
 {
-	struct snd_card_omap_aic23 *chip =
+	struct snd_card_omap_codec *chip =
 	    snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	struct audio_stream *s = &chip->s[substream->pstr->stream];
@@ -475,10 +475,10 @@ static int snd_omap_aic23_prepare(snd_pc
 	return 0;
 }
 
-static snd_pcm_uframes_t snd_omap_aic23_pointer(snd_pcm_substream_t *
+static snd_pcm_uframes_t snd_omap_alsa_pointer(snd_pcm_substream_t *
 						substream)
 {
-	struct snd_card_omap_aic23 *chip =
+	struct snd_card_omap_codec *chip =
 	    snd_pcm_substream_chip(substream);
 	
 	return audio_get_dma_pos(&chip->s[substream->pstr->stream]);
@@ -486,7 +486,7 @@ static snd_pcm_uframes_t snd_omap_aic23_
 
 /* Hardware capabilities */
 
-static snd_pcm_hardware_t snd_omap_aic23_capture = {
+static snd_pcm_hardware_t snd_omap_alsa_capture = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
@@ -507,7 +507,7 @@ static snd_pcm_hardware_t snd_omap_aic23
 	.fifo_size = 0,
 };
 
-static snd_pcm_hardware_t snd_omap_aic23_playback = {
+static snd_pcm_hardware_t snd_omap_alsa_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
@@ -528,9 +528,9 @@ static snd_pcm_hardware_t snd_omap_aic23
 	.fifo_size = 0,
 };
 
-static int snd_card_omap_aic23_open(snd_pcm_substream_t * substream)
+static int snd_card_omap_alsa_open(snd_pcm_substream_t * substream)
 {
-	struct snd_card_omap_aic23 *chip =
+	struct snd_card_omap_codec *chip =
 	    snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int stream_id = substream->pstr->stream;
@@ -542,9 +542,9 @@ static int snd_card_omap_aic23_open(snd_
 	omap_aic23_clock_on();
 	
 	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK)
-		runtime->hw = snd_omap_aic23_playback;
+		runtime->hw = snd_omap_alsa_playback;
 	else
-		runtime->hw = snd_omap_aic23_capture;
+		runtime->hw = snd_omap_alsa_capture;
 	if ((err =
 	     snd_pcm_hw_constraint_integer(runtime,
 					   SNDRV_PCM_HW_PARAM_PERIODS)) <
@@ -559,9 +559,9 @@ static int snd_card_omap_aic23_open(snd_
 	return 0;
 }
 
-static int snd_card_omap_aic23_close(snd_pcm_substream_t * substream)
+static int snd_card_omap_alsa_close(snd_pcm_substream_t * substream)
 {
-	struct snd_card_omap_aic23 *chip =
+	struct snd_card_omap_codec *chip =
 	    snd_pcm_substream_chip(substream);
 	ADEBUG();
 	
@@ -573,40 +573,39 @@ static int snd_card_omap_aic23_close(snd
 
 /* HW params & free */
 
-static int snd_omap_aic23_hw_params(snd_pcm_substream_t * substream,
+static int snd_omap_alsa_hw_params(snd_pcm_substream_t * substream,
 				    snd_pcm_hw_params_t * hw_params)
 {
 	return snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
 }
 
-static int snd_omap_aic23_hw_free(snd_pcm_substream_t * substream)
+static int snd_omap_alsa_hw_free(snd_pcm_substream_t * substream)
 {
 	return snd_pcm_lib_free_pages(substream);
 }
 
 /* pcm operations */
-
-static snd_pcm_ops_t snd_card_omap_aic23_playback_ops = {
-	.open =		snd_card_omap_aic23_open,
-	.close =	snd_card_omap_aic23_close,
+static snd_pcm_ops_t snd_card_omap_alsa_playback_ops = {
+	.open =		snd_card_omap_alsa_open,
+	.close =	snd_card_omap_alsa_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_omap_aic23_hw_params,
-	.hw_free =	snd_omap_aic23_hw_free,
-	.prepare =	snd_omap_aic23_prepare,
-	.trigger =	snd_omap_aic23_trigger,
-	.pointer =	snd_omap_aic23_pointer,
+	.hw_params =	snd_omap_alsa_hw_params,
+	.hw_free =	snd_omap_alsa_hw_free,
+	.prepare =	snd_omap_alsa_prepare,
+	.trigger =	snd_omap_alsa_trigger,
+	.pointer =	snd_omap_alsa_pointer,
 };
 
-static snd_pcm_ops_t snd_card_omap_aic23_capture_ops = {
-	.open =		snd_card_omap_aic23_open,
-	.close =	snd_card_omap_aic23_close,
+static snd_pcm_ops_t snd_card_omap_alsa_capture_ops = {
+	.open =		snd_card_omap_alsa_open,
+	.close =	snd_card_omap_alsa_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_omap_aic23_hw_params,
-	.hw_free =	snd_omap_aic23_hw_free,
-	.prepare =	snd_omap_aic23_prepare,
-	.trigger =	snd_omap_aic23_trigger,
-	.pointer =	snd_omap_aic23_pointer,
+	.hw_params =	snd_omap_alsa_hw_params,
+	.hw_free =	snd_omap_alsa_hw_free,
+	.prepare =	snd_omap_alsa_prepare,
+	.trigger =	snd_omap_alsa_trigger,
+	.pointer =	snd_omap_alsa_pointer,
 };
 
 /*
@@ -614,8 +613,8 @@ static snd_pcm_ops_t snd_card_omap_aic23
  *  
  *  Inits pcm alsa structures, allocate the alsa buffer, suspend, resume
  */
-static int __init snd_card_omap_aic23_pcm(struct snd_card_omap_aic23
-					  *omap_aic23, int device)
+static int __init snd_card_omap_alsa_pcm(struct snd_card_omap_codec *omap_alsa, 
+					int device)
 {
 	snd_pcm_t *pcm;
 	int err;
@@ -634,9 +633,9 @@ static int __init snd_card_omap_aic23_pc
 					      128 * 1024, 128 * 1024);
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-			&snd_card_omap_aic23_playback_ops);
+			&snd_card_omap_alsa_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
-			&snd_card_omap_aic23_capture_ops);
+			&snd_card_omap_alsa_capture_ops);
 	pcm->private_data = omap_aic23;
 	pcm->info_flags = 0;
 	strcpy(pcm->name, "omap aic23 pcm");
@@ -645,87 +644,63 @@ static int __init snd_card_omap_aic23_pc
 
 	/* setup DMA controller */
 	audio_dma_request(&omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK],
-			  audio_dma_callback);
+			  callback_omap_alsa_sound_dma);
 	audio_dma_request(&omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE],
-			  audio_dma_callback);
+			  callback_omap_alsa_sound_dma);
 
 	omap_aic23->pcm = pcm;
 
 	return 0;
 }
 
-
 #ifdef CONFIG_PM
-
-static int snd_omap_aic23_suspend(snd_card_t * card, pm_message_t state)
-{
-	struct snd_card_omap_aic23 *chip = card->private_data;
-	ADEBUG();
-
-	if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
-		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
-		snd_pcm_suspend_all(chip->pcm);
-		/* Mutes and turn clock off */
-		omap_aic23_clock_off();
-		snd_omap_suspend_mixer();
-	}
-
-	return 0;
-}
-
-/*
- *  Prepare hardware for resume
- */
-static int snd_omap_aic23_resume(snd_card_t * card)
-{
-	struct snd_card_omap_aic23 *chip = card->private_data;
-	ADEBUG();
-	
-	if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
-		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
-		omap_aic23_clock_on();
-		snd_omap_resume_mixer();
-	}
-
-	return 0;
-}
-
 /*
  * Driver suspend/resume - calls alsa functions. Some hints from aaci.c
  */
-static int omap_aic23_suspend(struct platform_device *pdev, pm_message_t state)
+int snd_omap_alsa_suspend(struct platform_device *pdev, pm_message_t state)
 {
+	struct snd_card_omap_codec *chip;
 	snd_card_t *card = platform_get_drvdata(pdev);
 	
 	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
-		snd_omap_aic23_suspend(card, PMSG_SUSPEND);
+		chip = card->private_data;
+		if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
+			snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
+			snd_pcm_suspend_all(chip->pcm);
+			/* Mutes and turn clock off */
+			omap_aic23_clock_off();
+			snd_omap_suspend_mixer();
+		}
 	}
 	return 0;
 }
 
-static int omap_aic23_resume(struct platform_device *pdev)
+int snd_omap_alsa_resume(struct platform_device *pdev)
 {
+	struct snd_card_omap_codec *chip;
 	snd_card_t *card = platform_get_drvdata(pdev);
 
-	if (card->power_state != SNDRV_CTL_POWER_D0) {
-		snd_omap_aic23_resume(card);
+	if (card->power_state != SNDRV_CTL_POWER_D0) {				
+		chip = card->private_data;
+		if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
+			snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
+			omap_aic23_clock_on();
+			snd_omap_resume_mixer();
+		}
 	}
 	return 0;
 }
 
 #else
-#define snd_omap_aic23_suspend	NULL
-#define snd_omap_aic23_resume	NULL
-#define omap_aic23_suspend	NULL
-#define omap_aic23_resume	NULL
-
+#define snd_omap_alsa_suspend	NULL
+#define snd_omap_alsa_resume	NULL
 #endif	/* CONFIG_PM */
 
 /* 
  */
-void snd_omap_aic23_free(snd_card_t * card)
+void snd_omap_alsa_free(snd_card_t * card)
 {
-	struct snd_card_omap_aic23 *chip = card->private_data;
+	struct snd_card_omap_codec *chip = card->private_data;
 	ADEBUG();
 	
 	/*
@@ -826,7 +801,7 @@ int omap_aic23_clock_off(void)
 /* 
  *  Inits alsa soudcard structure
  */
-static int __init snd_omap_aic23_probe(struct platform_device *pdev)
+static int __init snd_omap_alsa_aic23_probe(struct platform_device *pdev)
 {
 	int err = 0;
 	snd_card_t *card;
@@ -845,7 +820,7 @@ static int __init snd_omap_aic23_probe(s
 		return -ENOMEM;
 
 	card->private_data = (void *) omap_aic23;
-	card->private_free = snd_omap_aic23_free;
+	card->private_free = snd_omap_alsa_free;
 
 	omap_aic23->card = card;
 	omap_aic23->samplerate = AUDIO_RATE_DEFAULT;
@@ -858,7 +833,7 @@ static int __init snd_omap_aic23_probe(s
 		goto nodev;
 
 	/* PCM */
-	if ((err = snd_card_omap_aic23_pcm(omap_aic23, 0)) < 0)
+	if ((err = snd_card_omap_alsa_pcm(omap_aic23, 0)) < 0)
 		goto nodev;
 
 	strcpy(card->driver, "AIC23");
@@ -876,15 +851,15 @@ static int __init snd_omap_aic23_probe(s
 	}
 	
 nodev:
-	snd_omap_aic23_free(card);
+	snd_card_free(card);
 	
 	return err;
 }
 
-static int snd_omap_aic23_remove(struct platform_device *pdev)
+static int snd_omap_alsa_remove(struct platform_device *pdev)
 {
 	snd_card_t *card = platform_get_drvdata(pdev);
-	struct snd_card_omap_aic23 *chip = card->private_data;
+	struct snd_card_omap_codec *chip = card->private_data;
 	
 	snd_card_free(card);
 
@@ -899,16 +874,16 @@ static int snd_omap_aic23_remove(struct 
 }
 
 static struct platform_driver omap_alsa_driver = {
-	.probe =	snd_omap_aic23_probe,
-	.remove =	snd_omap_aic23_remove,
-	.suspend =	omap_aic23_suspend, 
-	.resume =	omap_aic23_resume, 
+	.probe		= snd_omap_alsa_aic23_probe,
+	.remove 	= snd_omap_alsa_remove,
+	.suspend	= snd_omap_alsa_suspend,
+	.resume		= snd_omap_alsa_resume,
 	.driver = {
 		.name =	"omap_mcbsp",
 	},
 };
 
-static int __init omap_aic23_init(void)
+static int __init omap_alsa_aic23_init(void)
 {
 	int err;
 	ADEBUG();
@@ -918,12 +893,12 @@ static int __init omap_aic23_init(void)
 	return err;
 }
 
-static void __exit omap_aic23_exit(void)
+static void __exit omap_alsa_aic23_exit(void)
 {
 	ADEBUG();
 	
 	platform_driver_unregister(&omap_alsa_driver);
 }
 
-module_init(omap_aic23_init);
-module_exit(omap_aic23_exit);
+module_init(omap_alsa_aic23_init);
+module_exit(omap_alsa_aic23_exit);
diff --git a/sound/arm/omap-aic23.h b/sound/arm/omap-aic23.h
index c8ab42c..c471d6c 100644
--- a/sound/arm/omap-aic23.h
+++ b/sound/arm/omap-aic23.h
@@ -93,17 +93,15 @@ struct audio_stream {
 /*
  * Alsa card structure for aic23
  */
-struct snd_card_omap_aic23 {
+struct snd_card_omap_codec {
 	snd_card_t *card;
 	snd_pcm_t *pcm;
 	long samplerate;
 	struct audio_stream s[2];	/* playback & capture */
 };
 
-/*********** Function Prototypes *************************/
-
-void audio_dma_callback(void *);
-int snd_omap_mixer(struct snd_card_omap_aic23 *);
+/*********** Mixer function prototypes *************************/
+int snd_omap_mixer(struct snd_card_omap_codec *);
 void snd_omap_init_mixer(void);
 /* Clock functions */
 int omap_aic23_clock_on(void);
@@ -114,6 +112,9 @@ void snd_omap_suspend_mixer(void);
 void snd_omap_resume_mixer(void);
 #endif
 
+/*********** function prototype to function called from the dma interrupt handler ******/
+void callback_omap_alsa_sound_dma(void *);
+
 /* Codec AIC23 */
 #if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
 
diff --git a/sound/arm/omap-alsa-dma.c b/sound/arm/omap-alsa-dma.c
index 8530acf..beb7944 100644
--- a/sound/arm/omap-alsa-dma.c
+++ b/sound/arm/omap-alsa-dma.c
@@ -3,6 +3,8 @@
  *
  * Common audio DMA handling for the OMAP processors
  *
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
+ *
  * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
  * 
  * Copyright (C) 2004 Texas Instruments, Inc.
@@ -66,10 +68,8 @@
 
 #include <asm/arch/mcbsp.h>
 
-#include "omap-aic23.h"
-
 #undef DEBUG
-//#define DEBUG
+#define DEBUG
 #ifdef DEBUG
 #define DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
 #define FN_IN printk(KERN_INFO "[%s]: start\n", __FUNCTION__)
@@ -165,7 +165,7 @@ static void omap_sound_dma_link_lch(void
 	FN_OUT(0);
 }
 
-int omap_request_sound_dma(int device_id, const char *device_name,
+int omap_request_alsa_sound_dma(int device_id, const char *device_name,
 			   void *data, int **channels)
 {
 	int i, err = 0;
@@ -186,10 +186,11 @@ int omap_request_sound_dma(int device_id
 	}
 	spin_lock(&dma_list_lock);
 	for (i = 0; i < nr_linked_channels; i++) {
-		err =
-		    omap_request_dma(device_id, device_name,
-				     sound_dma_irq_handler, data,
-				     &chan[i]);
+		err = omap_request_dma(device_id, 
+				device_name,
+				sound_dma_irq_handler, 
+				data,
+				&chan[i]);
 
 		/* Handle Failure condition here */
 		if (err < 0) {
@@ -223,7 +224,7 @@ int omap_request_sound_dma(int device_id
  **************************************************************************************/
 static void omap_sound_dma_unlink_lch(void *data)
 {
-	struct audio_stream *s = (struct audio_stream *) data;
+	struct audio_stream *s = (struct audio_stream *)data;
 	int *chan = s->lch;
 	int i;
 
@@ -243,11 +244,11 @@ static void omap_sound_dma_unlink_lch(vo
 	FN_OUT(0);
 }
 
-int omap_free_sound_dma(void *data, int **channels)
+int omap_free_alsa_sound_dma(void *data, int **channels)
 {
-
 	int i;
 	int *chan = NULL;
+	
 	FN_IN;
 	if (unlikely(NULL == channels)) {
 		BUG();
@@ -277,10 +278,11 @@ int omap_free_sound_dma(void *data, int 
  * Stop all the DMA channels of the stream
  *
  **************************************************************************************/
-void omap_audio_stop_dma(struct audio_stream *s)
+void omap_stop_alsa_sound_dma(struct audio_stream *s)
 {
 	int *chan = s->lch;
 	int i;
+	
 	FN_IN;
 	if (unlikely(NULL == chan)) {
 		BUG();
@@ -299,7 +301,7 @@ void omap_audio_stop_dma(struct audio_st
  * Clear any pending transfers
  *
  **************************************************************************************/
-void omap_clear_sound_dma(struct audio_stream * s)
+void omap_clear_alsa_sound_dma(struct audio_stream * s)
 {
 	FN_IN;
 	omap_clear_dma(s->lch[s->dma_q_head]);
@@ -307,13 +309,6 @@ void omap_clear_sound_dma(struct audio_s
 	return;
 }
 
-/*********************************** MODULE FUNCTIONS DEFINTIONS ***********************/
-
-#ifdef OMAP1610_MCBSP1_BASE
-#undef OMAP1610_MCBSP1_BASE
-#endif
-#define OMAP1610_MCBSP1_BASE    0xE1011000
-
 /***************************************************************************************
  *
  * DMA related functions
@@ -325,9 +320,10 @@ static int audio_set_dma_params_play(int
 	int dt = 0x1;		/* data type 16 */
 	int cen = 32;		/* Stereo */
 	int cfn = dma_size / (2 * cen);
+	
 	FN_IN;
 	omap_set_dma_dest_params(channel, 0x05, 0x00,
-				 (OMAP1610_MCBSP1_BASE + 0x806),
+				 (OMAP1510_MCBSP1_BASE + 0x06),
 				 0, 0);
 	omap_set_dma_src_params(channel, 0x00, 0x01, dma_ptr,
 				0, 0);
@@ -341,11 +337,11 @@ static int audio_set_dma_params_capture(
 {
 	int dt = 0x1;		/* data type 16 */
 	int cen = 32;		/* stereo */
-	
 	int cfn = dma_size / (2 * cen);
+	
 	FN_IN;
 	omap_set_dma_src_params(channel, 0x05, 0x00,
-				(OMAP1610_MCBSP1_BASE + 0x802),
+				(OMAP1510_MCBSP1_BASE + 0x02),
 				0, 0);
 	omap_set_dma_dest_params(channel, 0x00, 0x01, dma_ptr, 0, 0);
 	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
@@ -358,7 +354,7 @@ static int audio_start_dma_chain(struct 
 	int channel = s->lch[s->dma_q_head];
 	FN_IN;
 	if (!s->started) {
-	 s->hw_stop();	    /* stops McBSP Interface */
+	 	s->hw_stop();	   /* stops McBSP Interface */
 		omap_start_dma(channel);
 		s->started = 1;
 		s->hw_start();	   /* start McBSP interface */
@@ -372,8 +368,9 @@ static int audio_start_dma_chain(struct 
  * Do the initial set of work to initialize all the channels as required.
  * We shall then initate a transfer
  */
-int omap_start_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,
-			 u_int dma_size)
+int omap_start_alsa_sound_dma(struct audio_stream *s, 
+			dma_addr_t dma_ptr, 
+			u_int dma_size)
 {
 	int ret = -EPERM;
 
@@ -439,18 +436,17 @@ static void sound_dma_irq_handler(int so
 	}
 
 	if (ch_status & DCSR_END_BLOCK) 
-		audio_dma_callback(s);
+		callback_omap_alsa_sound_dma(s);
 	FN_OUT(0);
 	return;
 }
 
 MODULE_AUTHOR("Texas Instruments");
-MODULE_DESCRIPTION
-    ("Common DMA handling for Audio driver on OMAP processors");
+MODULE_DESCRIPTION("Common DMA handling for Audio driver on OMAP processors");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(omap_start_sound_dma);
-EXPORT_SYMBOL(omap_clear_sound_dma);
-EXPORT_SYMBOL(omap_request_sound_dma);
-EXPORT_SYMBOL(omap_free_sound_dma);
-EXPORT_SYMBOL(omap_audio_stop_dma);
+EXPORT_SYMBOL(omap_start_alsa_sound_dma);
+EXPORT_SYMBOL(omap_clear_alsa_sound_dma);
+EXPORT_SYMBOL(omap_request_alsa_sound_dma);
+EXPORT_SYMBOL(omap_free_alsa_sound_dma);
+EXPORT_SYMBOL(omap_stop_alsa_sound_dma);
diff --git a/sound/arm/omap-alsa-dma.h b/sound/arm/omap-alsa-dma.h
index 2ac7650..187e09c 100644
--- a/sound/arm/omap-alsa-dma.h
+++ b/sound/arm/omap-alsa-dma.h
@@ -1,8 +1,10 @@
 /*  
- * linux/sound/arm/omap-alsa-dma.h
+ * sound/arm/omap-alsa-dma.h
  *
  * Common audio DMA handling for the OMAP processors
  *
+ * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
+ *
  * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
  * 
  * Copyright (C) 2004 Texas Instruments, Inc.
@@ -32,28 +34,20 @@
 
 #include "omap-aic23.h"
 
-/************************** GLOBAL MACROS *************************************/
-
-/* Provide the Macro interfaces common across platforms */
-#define DMA_REQUEST(e,s, cb)	{e=omap_request_sound_dma(s->dma_dev, s->id, s, &s->lch);}
-#define DMA_FREE(s)		omap_free_sound_dma(s, &s->lch)
-#define DMA_CLEAR(s)		omap_clear_sound_dma(s)
-
 /************************** GLOBAL DATA STRUCTURES *********************************/
 
 typedef void (*dma_callback_t) (int lch, u16 ch_status, void *data);
 
 /**************** ARCH SPECIFIC FUNCIONS *******************************************/
 
-void omap_clear_sound_dma(struct audio_stream * s);
+void omap_clear_alsa_sound_dma(struct audio_stream * s);
 
-int omap_request_sound_dma(int device_id, const char *device_name,
+int omap_request_alsa_sound_dma(int device_id, const char *device_name,
 			   void *data, int **channels);
-int omap_free_sound_dma(void *data, int **channels);
+int omap_free_alsa_sound_dma(void *data, int **channels);
 
-int omap_start_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,
-			 u_int dma_size);
+int omap_start_alsa_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,  u_int dma_size);
 
-void omap_audio_stop_dma(struct audio_stream *s);
+void omap_stop_alsa_sound_dma(struct audio_stream *s);
 
 #endif
diff --git a/sound/arm/omap-alsa-mixer.c b/sound/arm/omap-alsa-mixer.c
index 742e5b6..476f106 100644
--- a/sound/arm/omap-alsa-mixer.c
+++ b/sound/arm/omap-alsa-mixer.c
@@ -474,7 +474,7 @@ void snd_omap_resume_mixer(void)
 }
 #endif
 
-int snd_omap_mixer(struct snd_card_omap_aic23 *chip)
+int snd_omap_mixer(struct snd_card_omap_codec *chip)
 {
 	snd_card_t *card;
 	unsigned int idx;
-- 
1.2.2





------=_Part_5650_14689927.1141676733652
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_5650_14689927.1141676733652--
