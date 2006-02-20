From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH] Alsa modularisations and support for tsc2101 5/7
Date: Mon, 20 Feb 2006 20:27:21 +0200
Message-ID: <43FA0A09.8080107@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020408040500070805090004"
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

This is a multi-part message in MIME format.
--------------020408040500070805090004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ALSA Omap Patch

This patch only moves all alsa files from sound/arm to sound/arm/omap
as recomended in "writing an alsa driver" documentation at
http://www.alsa-project.org/~iwai/writing-an-alsa-driver/index.html
if the driver contains several source files.

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>

----------------
Mika Laitio

--------------020408040500070805090004
Content-Type: text/x-patch;
 name="alsa5-20060214.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa5-20060214.patch"

ALSA Omap Patch

This patch only moves all the alsa files from sound/arm to sound/arm/omap
as recomended in alsa documentation, as pointed by Mika Laitio.

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>

Index: linux-omap-2.6.git-q/sound/arm/omap/omap-alsa.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6.git-q/sound/arm/omap/omap-alsa.c	2006-02-16 08:40:57.000000000 -0400
@@ -0,0 +1,714 @@
+/*
+ * sound/arm/omap/omap-alsa.c
+ * 
+ * Alsa Driver for AIC23 codec on OSK5912 platform board
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by Daniel Petrini, David Cohen, Anderson Briglia
+ *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
+ *
+ * Based on sa11xx-uda1341.c, 
+ * Copyright (C) 2002 Tomas Kasparek <tomas.kasparek@seznam.cz>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * History:
+ *
+ * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk. Creation of new 
+ *                                 file omap-aic23.c
+ * 
+ * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
+ *
+ * 2006-02-07   Daniel Petrini  - Codec specific function separated. File renamed to
+ *                                omap-alsa.c
+ * 2006-02-10	Mika Laitio	- Codec specific function pointers are set in the codec.
+ * 				  Default samplerate queried from the codec.
+ */
+
+#include <linux/platform_device.h>
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
+#include <sound/driver.h>
+#include <sound/core.h>
+
+#include <asm/arch/omap-alsa.h>
+#include "omap-alsa-dma.h"
+
+MODULE_AUTHOR("Mika Laitio, Daniel Petrini, David Cohen, Anderson Briglia - INdT");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OMAP driver for ALSA");
+MODULE_ALIAS("omap_alsa_mcbsp.1");
+
+static char *id	= NULL;	
+static struct snd_card_omap_codec 	*alsa_codec		= NULL;
+static struct omap_alsa_codec_config	*alsa_codec_config	= NULL;
+
+/*
+ * DAC USB-mode sampling rates (MCLK = 12 MHz)
+ * The rates and rate_reg_into MUST be in the same order
+ */
+static unsigned int rates[] = {
+	4000, 8000, 16000, 22050,
+	24000, 32000, 44100,
+	48000, 88200, 96000,
+};
+
+static snd_pcm_hw_constraint_list_t hw_constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+/*
+ * HW interface start and stop helper functions
+ */
+static int audio_ifc_start(void)
+{
+	omap_mcbsp_start(AUDIO_MCBSP);
+	return 0;
+}
+
+static int audio_ifc_stop(void)
+{
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	return 0;
+}
+
+static void omap_alsa_audio_init(struct snd_card_omap_codec *omap_alsa)
+{
+	/* Setup DMA stuff */
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].id = "Alsa omap out";
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].stream_id =
+	    SNDRV_PCM_STREAM_PLAYBACK;
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].dma_dev =
+	    OMAP_DMA_MCBSP1_TX;
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].hw_start =
+	    audio_ifc_start;
+	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].hw_stop =
+	    audio_ifc_stop;
+
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].id = "Alsa omap in";
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].stream_id =
+	    SNDRV_PCM_STREAM_CAPTURE;
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].dma_dev =
+	    OMAP_DMA_MCBSP1_RX;
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].hw_start =
+	    audio_ifc_start;
+	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].hw_stop =
+	    audio_ifc_stop;
+}
+
+/* 
+ * DMA functions 
+ * Depends on omap-alsa-dma.c functions and (omap) dma.c
+ * 
+ */
+#define DMA_BUF_SIZE	1024 * 8
+
+static int audio_dma_request(struct audio_stream *s,
+			     void (*callback) (void *))
+{
+	int err;
+	ADEBUG();
+
+	err = omap_request_sound_dma(s->dma_dev, s->id, s, &s->lch);
+	if (err < 0)
+		printk(KERN_ERR "unable to grab audio dma 0x%x\n",
+		       s->dma_dev);
+	return err;
+}
+
+static int audio_dma_free(struct audio_stream *s)
+{
+	int err = 0;
+	ADEBUG();
+
+	err = omap_free_sound_dma(s, &s->lch);
+	if (err < 0)
+		printk(KERN_ERR "Unable to free audio dma channels!\n");
+	return err;
+}
+
+/*
+ *  This function should calculate the current position of the dma in the
+ *  buffer. It will help alsa middle layer to continue update the buffer.
+ *  Its correctness is crucial for good functioning.
+ */
+static u_int audio_get_dma_pos(struct audio_stream *s)
+{
+	snd_pcm_substream_t *substream = s->stream;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	unsigned int offset;
+	unsigned long flags;
+	dma_addr_t count;
+	ADEBUG();
+
+	/* this must be called w/ interrupts locked as requested in dma.c */
+	spin_lock_irqsave(&s->dma_lock, flags);
+
+	/* For the current period let's see where we are */
+	count = omap_get_dma_src_addr_counter(s->lch[s->dma_q_head]);
+
+	spin_unlock_irqrestore(&s->dma_lock, flags);
+
+	/* Now, the position related to the end of that period */
+	offset = bytes_to_frames(runtime, s->offset) - bytes_to_frames(runtime, count);
+
+	if (offset >= runtime->buffer_size || offset < 0)
+		offset = 0;
+
+	return offset;
+}
+
+/*
+ * this stops the dma and clears the dma ptrs
+ */
+static void audio_stop_dma(struct audio_stream *s)
+{
+	unsigned long flags;
+	ADEBUG();
+
+	spin_lock_irqsave(&s->dma_lock, flags);
+	s->active = 0;
+	s->period = 0;
+	s->periods = 0;
+
+	/* this stops the dma channel and clears the buffer ptrs */
+	omap_audio_stop_dma(s);
+
+	omap_clear_sound_dma(s);
+
+	spin_unlock_irqrestore(&s->dma_lock, flags);
+}
+
+/*
+ *  Main dma routine, requests dma according where you are in main alsa buffer
+ */
+static void audio_process_dma(struct audio_stream *s)
+{
+	snd_pcm_substream_t *substream = s->stream;
+	snd_pcm_runtime_t *runtime;
+	unsigned int dma_size;
+	unsigned int offset;
+	int ret;
+#ifdef CONFIG_MACH_OMAP_H6300
+	unsigned long flags;
+#endif
+	
+	ADEBUG();
+	runtime = substream->runtime;
+	if (s->active) {
+		dma_size = frames_to_bytes(runtime, runtime->period_size);
+		offset = dma_size * s->period;
+		snd_assert(dma_size <= DMA_BUF_SIZE,);
+#ifdef CONFIG_MACH_OMAP_H6300
+		spin_lock_irqsave(&s->dma_lock, flags);
+		omap_audio_stop_dma(s);
+		spin_unlock_irqrestore(&s->dma_lock, flags);
+#endif
+		ret = omap_start_sound_dma(s,
+					 (dma_addr_t) runtime->dma_area +
+					 offset, dma_size);
+		if (ret) {
+			printk(KERN_ERR
+			       "audio_process_dma: cannot queue DMA buffer (%i)\n",
+			       ret);
+			return;
+		}
+
+		s->period++;
+		s->period %= runtime->periods;
+		s->periods++;
+		s->offset = offset;
+	}
+}
+
+/* 
+ *  This is called when dma IRQ occurs at the end of each transmited block
+ */
+void audio_dma_callback(void *data)
+{
+	struct audio_stream *s = data;
+	ADEBUG();
+
+	/* 
+	 * If we are getting a callback for an active stream then we inform
+	 * the PCM middle layer we've finished a period
+	 */
+	if (s->active)
+		snd_pcm_period_elapsed(s->stream);
+
+	spin_lock(&s->dma_lock);
+	if (s->periods > 0) {
+		s->periods--;
+	}
+	audio_process_dma(s);
+	spin_unlock(&s->dma_lock);
+}
+
+/* 
+ * Alsa section
+ * PCM settings and callbacks
+ */
+
+static int snd_omap_alsa_trigger(snd_pcm_substream_t * substream, int cmd)
+{
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	int stream_id = substream->pstr->stream;
+	struct audio_stream *s = &chip->s[stream_id];
+	int err = 0;
+	ADEBUG();
+
+	/* note local interrupts are already disabled in the midlevel code */
+	spin_lock(&s->dma_lock);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* requested stream startup */
+		s->active = 1;
+		audio_process_dma(s);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		/* requested stream shutdown */
+		audio_stop_dma(s);
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+	spin_unlock(&s->dma_lock);
+	
+	return err;
+}
+
+static int snd_omap_alsa_prepare(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	struct audio_stream *s = &chip->s[substream->pstr->stream];
+	ADEBUG();
+
+	/* set requested samplerate */
+	alsa_codec_config->codec_set_samplerate(runtime->rate);
+	chip->samplerate = runtime->rate;
+
+	s->period = 0;
+	s->periods = 0;
+
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_omap_alsa_pointer(snd_pcm_substream_t *substream)
+{
+	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
+
+	ADEBUG();	
+	return audio_get_dma_pos(&chip->s[substream->pstr->stream]);
+}
+
+/* Hardware capabilities */
+
+static snd_pcm_hardware_t snd_omap_alsa_capture = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 8000,
+	.rate_max = 96000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 128 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 8 * 1024,
+	.periods_min = 16,
+	.periods_max = 255,
+	.fifo_size = 0,
+};
+
+static snd_pcm_hardware_t snd_omap_alsa_playback = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 8000,
+	.rate_max = 96000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 128 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 8 * 1024,
+	.periods_min = 16,
+	.periods_max = 255,
+	.fifo_size = 0,
+};
+
+static int snd_card_omap_alsa_open(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	int stream_id = substream->pstr->stream;
+	int err;
+	
+	ADEBUG();
+	chip->s[stream_id].stream = substream;
+	alsa_codec_config->codec_clock_on();
+	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
+		runtime->hw = snd_omap_alsa_playback;
+	}
+	else {
+		runtime->hw = snd_omap_alsa_capture;
+	}
+	if ((err = snd_pcm_hw_constraint_integer(runtime,
+					   SNDRV_PCM_HW_PARAM_PERIODS)) < 0) {
+		return err;
+	}
+	if ((err = snd_pcm_hw_constraint_list(runtime, 0,
+					SNDRV_PCM_HW_PARAM_RATE,
+					&hw_constraints_rates)) < 0) {
+		return err;
+	}
+	return 0;
+}
+
+static int snd_card_omap_alsa_close(snd_pcm_substream_t * substream)
+{
+	struct snd_card_omap_codec *chip =
+	    snd_pcm_substream_chip(substream);
+	ADEBUG();
+	
+	alsa_codec_config->codec_clock_off();
+	chip->s[substream->pstr->stream].stream = NULL;
+	
+	return 0;
+}
+
+/* HW params & free */
+
+static int snd_omap_alsa_hw_params(snd_pcm_substream_t * substream,
+				    snd_pcm_hw_params_t * hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+}
+
+static int snd_omap_alsa_hw_free(snd_pcm_substream_t * substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/* pcm operations */
+
+static snd_pcm_ops_t snd_card_omap_alsa_playback_ops = {
+	.open =		snd_card_omap_alsa_open,
+	.close =	snd_card_omap_alsa_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_omap_alsa_hw_params,
+	.hw_free =	snd_omap_alsa_hw_free,
+	.prepare =	snd_omap_alsa_prepare,
+	.trigger =	snd_omap_alsa_trigger,
+	.pointer =	snd_omap_alsa_pointer,
+};
+
+static snd_pcm_ops_t snd_card_omap_alsa_capture_ops = {
+	.open =		snd_card_omap_alsa_open,
+	.close =	snd_card_omap_alsa_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_omap_alsa_hw_params,
+	.hw_free =	snd_omap_alsa_hw_free,
+	.prepare =	snd_omap_alsa_prepare,
+	.trigger =	snd_omap_alsa_trigger,
+	.pointer =	snd_omap_alsa_pointer,
+};
+
+/*
+ *  Alsa init and exit section
+ *  
+ *  Inits pcm alsa structures, allocate the alsa buffer, suspend, resume
+ */
+static int __init snd_card_omap_alsa_pcm(struct snd_card_omap_codec
+					  *omap_alsa, int device)
+{
+	snd_pcm_t *pcm;
+	int err;
+	ADEBUG();
+
+	if ((err =
+	     snd_pcm_new(omap_alsa->card, "AIC23 PCM", device, 1, 1, &pcm)) < 0)
+		return err;
+
+	/* sets up initial buffer with continuous allocation */
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
+					      SNDRV_DMA_TYPE_CONTINUOUS,
+					      snd_dma_continuous_data
+					      (GFP_KERNEL),
+					      128 * 1024, 128 * 1024);
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_card_omap_alsa_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_card_omap_alsa_capture_ops);
+	pcm->private_data = omap_alsa;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "omap aic23 pcm");
+
+	omap_alsa_audio_init(omap_alsa);
+
+	/* setup DMA controller */
+	audio_dma_request(&omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK],
+			  audio_dma_callback);
+	audio_dma_request(&omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE],
+			  audio_dma_callback);
+
+	omap_alsa->pcm = pcm;
+
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+
+static int snd_omap_alsa_suspend(snd_card_t * card, pm_message_t state)
+{
+	struct snd_card_omap_codec *chip = card->private_data;
+	ADEBUG();
+
+	if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
+		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
+		snd_pcm_suspend_all(chip->pcm);
+		/* Mutes and turn clock off */
+		alsa_codec_config->codec_clock_off();
+		snd_omap_suspend_mixer();
+	}
+	return 0;
+}
+
+/*
+ *  Prepare hardware for resume
+ */
+static int snd_omap_alsa_resume(snd_card_t * card)
+{
+	struct snd_card_omap_codec *chip = card->private_data;
+	ADEBUG();
+	
+	if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
+		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
+		alsa_codec_config->codec_clock_on();
+		snd_omap_resume_mixer();
+	}
+	return 0;
+}
+
+/*
+ * Driver suspend/resume - calls alsa functions. Some hints from aaci.c
+ */
+static int omap_alsa_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	snd_card_t *card = platform_get_drvdata(pdev);
+	
+	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
+		snd_omap_alsa_suspend(card, PMSG_SUSPEND);
+	}
+	return 0;
+}
+
+static int omap_alsa_resume(struct platform_device *pdev)
+{
+	snd_card_t *card = platform_get_drvdata(pdev);
+
+	if (card->power_state != SNDRV_CTL_POWER_D0) {
+		snd_omap_alsa_resume(card);
+	}
+	return 0;
+}
+
+#else
+#define snd_omap_alsa_suspend	NULL
+#define snd_omap_alsa_resume	NULL
+#define omap_alsa_suspend	NULL
+#define omap_alsa_resume	NULL
+
+#endif	/* CONFIG_PM */
+
+/* 
+ */
+void snd_omap_alsa_free(snd_card_t * card)
+{
+	struct snd_card_omap_codec *chip = card->private_data;
+	ADEBUG();
+	
+	/*
+	 * Turn off codec after it is done.
+	 * Can't do it immediately, since it may still have
+	 * buffered data.
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(2);
+
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_free(AUDIO_MCBSP);
+
+	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_PLAYBACK]);
+	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_CAPTURE]);
+}
+
+/* module init & exit */
+
+/* 
+ *  Inits alsa soudcard structure
+ */
+static int __init snd_omap_alsa_probe(struct platform_device *pdev)
+{
+	int err = 0;
+	int def_rate;
+	snd_card_t *card;
+	
+	ADEBUG();
+	alsa_codec_config = pdev->dev.platform_data;
+	if (alsa_codec_config == NULL) {
+		err = -ENODEV;
+		goto nodev1;
+	}
+	
+	alsa_codec_config->codec_clock_setup();
+	alsa_codec_config->codec_clock_on(); 
+
+	omap_mcbsp_request(AUDIO_MCBSP);
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_config(AUDIO_MCBSP, alsa_codec_config->mcbsp_regs_alsa);
+	omap_mcbsp_start(AUDIO_MCBSP);
+	
+	if (alsa_codec_config && alsa_codec_config->codec_configure_dev) {
+		alsa_codec_config->codec_configure_dev();
+	}
+
+	alsa_codec_config->codec_clock_off();
+
+	/* register the soundcard */
+	card = snd_card_new(-1, id, THIS_MODULE, sizeof(alsa_codec));
+	if (card == NULL) {
+		goto nodev2;
+	}
+
+	alsa_codec = kcalloc(1, sizeof(*alsa_codec), GFP_KERNEL);
+	if (alsa_codec == NULL) {
+		goto nodev3;
+	}
+
+	card->private_data = (void *)alsa_codec;
+	card->private_free = snd_omap_alsa_free;
+
+	alsa_codec->card	= card;
+	def_rate		= alsa_codec_config->get_default_samplerate(); 
+	alsa_codec->samplerate	= def_rate;
+
+	spin_lock_init(&alsa_codec->s[0].dma_lock);
+	spin_lock_init(&alsa_codec->s[1].dma_lock);
+
+	/* mixer */
+	if ((err = snd_omap_mixer(alsa_codec)) < 0) {
+		goto nodev4;
+	}
+
+	/* PCM */
+	if ((err = snd_card_omap_alsa_pcm(alsa_codec, 0)) < 0) {
+		goto nodev4;
+	}
+
+	strcpy(card->driver, "OMAP_ALSA");
+	strcpy(card->shortname, alsa_codec_config->name);
+	sprintf(card->longname, alsa_codec_config->name);
+
+	snd_omap_init_mixer();
+	snd_card_set_dev(card, &pdev->dev);
+	
+	if ((err = snd_card_register(card)) == 0) {
+		printk(KERN_INFO "audio support initialized\n");
+		platform_set_drvdata(pdev, card);
+		return 0;
+	}
+	
+nodev4:
+	kfree(alsa_codec);	
+nodev3:	
+	snd_card_free(card);
+nodev2:
+	omap_mcbsp_stop(AUDIO_MCBSP);
+	omap_mcbsp_free(AUDIO_MCBSP);
+nodev1:	
+	return err;
+}
+
+static int snd_omap_alsa_remove(struct platform_device *pdev)
+{
+	snd_card_t *card = platform_get_drvdata(pdev);
+	struct snd_card_omap_codec *chip = card->private_data;
+	
+	snd_card_free(card);
+
+	alsa_codec = NULL;
+	card->private_data = NULL;
+	kfree(chip);
+	
+	platform_set_drvdata(pdev, NULL);
+	
+	return 0;
+	
+}
+
+static struct platform_driver omap_alsa_driver = {
+	.probe =	snd_omap_alsa_probe,
+	.remove =	snd_omap_alsa_remove,
+	.suspend =	omap_alsa_suspend, 
+	.resume =	omap_alsa_resume, 
+	.driver = {
+		.name =	"omap_alsa_mcbsp",
+	},
+};
+
+static int __init omap_alsa_init(void)
+{
+	int err;
+	ADEBUG();
+
+	err = platform_driver_register(&omap_alsa_driver);
+
+	return err;
+}
+
+static void __exit omap_alsa_exit(void)
+{
+	ADEBUG();
+	
+	platform_driver_unregister(&omap_alsa_driver);
+}
+
+module_init(omap_alsa_init);
+module_exit(omap_alsa_exit);
Index: linux-omap-2.6.git-q/sound/arm/omap-alsa.c
===================================================================
--- linux-omap-2.6.git-q.orig/sound/arm/omap-alsa.c	2006-02-16 08:34:58.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,714 +0,0 @@
-/*
- * sound/arm/omap-alsa.c
- * 
- * Alsa Driver for AIC23 codec on OSK5912 platform board
- *
- * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * Written by Daniel Petrini, David Cohen, Anderson Briglia
- *            {daniel.petrini, david.cohen, anderson.briglia}@indt.org.br
- *
- * Based on sa11xx-uda1341.c, 
- * Copyright (C) 2002 Tomas Kasparek <tomas.kasparek@seznam.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * History:
- *
- * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk. Creation of new 
- *                                 file omap-aic23.c
- * 
- * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
- *
- * 2006-02-07   Daniel Petrini  - Codec specific function separated. File renamed to
- *                                omap-alsa.c
- * 2006-02-10	Mika Laitio	- Codec specific function pointers are set in the codec.
- * 				  Default samplerate queried from the codec.
- */
-
-#include <linux/platform_device.h>
-#ifdef CONFIG_PM
-#include <linux/pm.h>
-#endif
-#include <sound/driver.h>
-#include <sound/core.h>
-
-#include <asm/arch/omap-alsa.h>
-#include "omap-alsa-dma.h"
-
-MODULE_AUTHOR("Mika Laitio, Daniel Petrini, David Cohen, Anderson Briglia - INdT");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("OMAP driver for ALSA");
-MODULE_ALIAS("omap_alsa_mcbsp.1");
-
-static char *id	= NULL;	
-static struct snd_card_omap_codec 	*alsa_codec		= NULL;
-static struct omap_alsa_codec_config	*alsa_codec_config	= NULL;
-
-/*
- * DAC USB-mode sampling rates (MCLK = 12 MHz)
- * The rates and rate_reg_into MUST be in the same order
- */
-static unsigned int rates[] = {
-	4000, 8000, 16000, 22050,
-	24000, 32000, 44100,
-	48000, 88200, 96000,
-};
-
-static snd_pcm_hw_constraint_list_t hw_constraints_rates = {
-	.count = ARRAY_SIZE(rates),
-	.list = rates,
-	.mask = 0,
-};
-
-/*
- * HW interface start and stop helper functions
- */
-static int audio_ifc_start(void)
-{
-	omap_mcbsp_start(AUDIO_MCBSP);
-	return 0;
-}
-
-static int audio_ifc_stop(void)
-{
-	omap_mcbsp_stop(AUDIO_MCBSP);
-	return 0;
-}
-
-static void omap_alsa_audio_init(struct snd_card_omap_codec *omap_alsa)
-{
-	/* Setup DMA stuff */
-	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].id = "Alsa omap out";
-	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].stream_id =
-	    SNDRV_PCM_STREAM_PLAYBACK;
-	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].dma_dev =
-	    OMAP_DMA_MCBSP1_TX;
-	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].hw_start =
-	    audio_ifc_start;
-	omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK].hw_stop =
-	    audio_ifc_stop;
-
-	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].id = "Alsa omap in";
-	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].stream_id =
-	    SNDRV_PCM_STREAM_CAPTURE;
-	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].dma_dev =
-	    OMAP_DMA_MCBSP1_RX;
-	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].hw_start =
-	    audio_ifc_start;
-	omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE].hw_stop =
-	    audio_ifc_stop;
-}
-
-/* 
- * DMA functions 
- * Depends on omap-alsa-dma.c functions and (omap) dma.c
- * 
- */
-#define DMA_BUF_SIZE	1024 * 8
-
-static int audio_dma_request(struct audio_stream *s,
-			     void (*callback) (void *))
-{
-	int err;
-	ADEBUG();
-
-	err = omap_request_sound_dma(s->dma_dev, s->id, s, &s->lch);
-	if (err < 0)
-		printk(KERN_ERR "unable to grab audio dma 0x%x\n",
-		       s->dma_dev);
-	return err;
-}
-
-static int audio_dma_free(struct audio_stream *s)
-{
-	int err = 0;
-	ADEBUG();
-
-	err = omap_free_sound_dma(s, &s->lch);
-	if (err < 0)
-		printk(KERN_ERR "Unable to free audio dma channels!\n");
-	return err;
-}
-
-/*
- *  This function should calculate the current position of the dma in the
- *  buffer. It will help alsa middle layer to continue update the buffer.
- *  Its correctness is crucial for good functioning.
- */
-static u_int audio_get_dma_pos(struct audio_stream *s)
-{
-	snd_pcm_substream_t *substream = s->stream;
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	unsigned int offset;
-	unsigned long flags;
-	dma_addr_t count;
-	ADEBUG();
-
-	/* this must be called w/ interrupts locked as requested in dma.c */
-	spin_lock_irqsave(&s->dma_lock, flags);
-
-	/* For the current period let's see where we are */
-	count = omap_get_dma_src_addr_counter(s->lch[s->dma_q_head]);
-
-	spin_unlock_irqrestore(&s->dma_lock, flags);
-
-	/* Now, the position related to the end of that period */
-	offset = bytes_to_frames(runtime, s->offset) - bytes_to_frames(runtime, count);
-
-	if (offset >= runtime->buffer_size || offset < 0)
-		offset = 0;
-
-	return offset;
-}
-
-/*
- * this stops the dma and clears the dma ptrs
- */
-static void audio_stop_dma(struct audio_stream *s)
-{
-	unsigned long flags;
-	ADEBUG();
-
-	spin_lock_irqsave(&s->dma_lock, flags);
-	s->active = 0;
-	s->period = 0;
-	s->periods = 0;
-
-	/* this stops the dma channel and clears the buffer ptrs */
-	omap_audio_stop_dma(s);
-
-	omap_clear_sound_dma(s);
-
-	spin_unlock_irqrestore(&s->dma_lock, flags);
-}
-
-/*
- *  Main dma routine, requests dma according where you are in main alsa buffer
- */
-static void audio_process_dma(struct audio_stream *s)
-{
-	snd_pcm_substream_t *substream = s->stream;
-	snd_pcm_runtime_t *runtime;
-	unsigned int dma_size;
-	unsigned int offset;
-	int ret;
-#ifdef CONFIG_MACH_OMAP_H6300
-	unsigned long flags;
-#endif
-	
-	ADEBUG();
-	runtime = substream->runtime;
-	if (s->active) {
-		dma_size = frames_to_bytes(runtime, runtime->period_size);
-		offset = dma_size * s->period;
-		snd_assert(dma_size <= DMA_BUF_SIZE,);
-#ifdef CONFIG_MACH_OMAP_H6300
-		spin_lock_irqsave(&s->dma_lock, flags);
-		omap_audio_stop_dma(s);
-		spin_unlock_irqrestore(&s->dma_lock, flags);
-#endif
-		ret = omap_start_sound_dma(s,
-					 (dma_addr_t) runtime->dma_area +
-					 offset, dma_size);
-		if (ret) {
-			printk(KERN_ERR
-			       "audio_process_dma: cannot queue DMA buffer (%i)\n",
-			       ret);
-			return;
-		}
-
-		s->period++;
-		s->period %= runtime->periods;
-		s->periods++;
-		s->offset = offset;
-	}
-}
-
-/* 
- *  This is called when dma IRQ occurs at the end of each transmited block
- */
-void audio_dma_callback(void *data)
-{
-	struct audio_stream *s = data;
-	ADEBUG();
-
-	/* 
-	 * If we are getting a callback for an active stream then we inform
-	 * the PCM middle layer we've finished a period
-	 */
-	if (s->active)
-		snd_pcm_period_elapsed(s->stream);
-
-	spin_lock(&s->dma_lock);
-	if (s->periods > 0) {
-		s->periods--;
-	}
-	audio_process_dma(s);
-	spin_unlock(&s->dma_lock);
-}
-
-/* 
- * Alsa section
- * PCM settings and callbacks
- */
-
-static int snd_omap_alsa_trigger(snd_pcm_substream_t * substream, int cmd)
-{
-	struct snd_card_omap_codec *chip =
-	    snd_pcm_substream_chip(substream);
-	int stream_id = substream->pstr->stream;
-	struct audio_stream *s = &chip->s[stream_id];
-	int err = 0;
-	ADEBUG();
-
-	/* note local interrupts are already disabled in the midlevel code */
-	spin_lock(&s->dma_lock);
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		/* requested stream startup */
-		s->active = 1;
-		audio_process_dma(s);
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-		/* requested stream shutdown */
-		audio_stop_dma(s);
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-	spin_unlock(&s->dma_lock);
-	
-	return err;
-}
-
-static int snd_omap_alsa_prepare(snd_pcm_substream_t * substream)
-{
-	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	struct audio_stream *s = &chip->s[substream->pstr->stream];
-	ADEBUG();
-
-	/* set requested samplerate */
-	alsa_codec_config->codec_set_samplerate(runtime->rate);
-	chip->samplerate = runtime->rate;
-
-	s->period = 0;
-	s->periods = 0;
-
-	return 0;
-}
-
-static snd_pcm_uframes_t snd_omap_alsa_pointer(snd_pcm_substream_t *substream)
-{
-	struct snd_card_omap_codec *chip = snd_pcm_substream_chip(substream);
-
-	ADEBUG();	
-	return audio_get_dma_pos(&chip->s[substream->pstr->stream]);
-}
-
-/* Hardware capabilities */
-
-static snd_pcm_hardware_t snd_omap_alsa_capture = {
-	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
-	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
-	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
-		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-		  SNDRV_PCM_RATE_KNOT),
-	.rate_min = 8000,
-	.rate_max = 96000,
-	.channels_min = 2,
-	.channels_max = 2,
-	.buffer_bytes_max = 128 * 1024,
-	.period_bytes_min = 32,
-	.period_bytes_max = 8 * 1024,
-	.periods_min = 16,
-	.periods_max = 255,
-	.fifo_size = 0,
-};
-
-static snd_pcm_hardware_t snd_omap_alsa_playback = {
-	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),	
-	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
-	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
-		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-		  SNDRV_PCM_RATE_KNOT),
-	.rate_min = 8000,
-	.rate_max = 96000,
-	.channels_min = 2,
-	.channels_max = 2,
-	.buffer_bytes_max = 128 * 1024,
-	.period_bytes_min = 32,
-	.period_bytes_max = 8 * 1024,
-	.periods_min = 16,
-	.periods_max = 255,
-	.fifo_size = 0,
-};
-
-static int snd_card_omap_alsa_open(snd_pcm_substream_t * substream)
-{
-	struct snd_card_omap_codec *chip =
-	    snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	int stream_id = substream->pstr->stream;
-	int err;
-	
-	ADEBUG();
-	chip->s[stream_id].stream = substream;
-	alsa_codec_config->codec_clock_on();
-	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
-		runtime->hw = snd_omap_alsa_playback;
-	}
-	else {
-		runtime->hw = snd_omap_alsa_capture;
-	}
-	if ((err = snd_pcm_hw_constraint_integer(runtime,
-					   SNDRV_PCM_HW_PARAM_PERIODS)) < 0) {
-		return err;
-	}
-	if ((err = snd_pcm_hw_constraint_list(runtime, 0,
-					SNDRV_PCM_HW_PARAM_RATE,
-					&hw_constraints_rates)) < 0) {
-		return err;
-	}
-	return 0;
-}
-
-static int snd_card_omap_alsa_close(snd_pcm_substream_t * substream)
-{
-	struct snd_card_omap_codec *chip =
-	    snd_pcm_substream_chip(substream);
-	ADEBUG();
-	
-	alsa_codec_config->codec_clock_off();
-	chip->s[substream->pstr->stream].stream = NULL;
-	
-	return 0;
-}
-
-/* HW params & free */
-
-static int snd_omap_alsa_hw_params(snd_pcm_substream_t * substream,
-				    snd_pcm_hw_params_t * hw_params)
-{
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-}
-
-static int snd_omap_alsa_hw_free(snd_pcm_substream_t * substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
-/* pcm operations */
-
-static snd_pcm_ops_t snd_card_omap_alsa_playback_ops = {
-	.open =		snd_card_omap_alsa_open,
-	.close =	snd_card_omap_alsa_close,
-	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_omap_alsa_hw_params,
-	.hw_free =	snd_omap_alsa_hw_free,
-	.prepare =	snd_omap_alsa_prepare,
-	.trigger =	snd_omap_alsa_trigger,
-	.pointer =	snd_omap_alsa_pointer,
-};
-
-static snd_pcm_ops_t snd_card_omap_alsa_capture_ops = {
-	.open =		snd_card_omap_alsa_open,
-	.close =	snd_card_omap_alsa_close,
-	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_omap_alsa_hw_params,
-	.hw_free =	snd_omap_alsa_hw_free,
-	.prepare =	snd_omap_alsa_prepare,
-	.trigger =	snd_omap_alsa_trigger,
-	.pointer =	snd_omap_alsa_pointer,
-};
-
-/*
- *  Alsa init and exit section
- *  
- *  Inits pcm alsa structures, allocate the alsa buffer, suspend, resume
- */
-static int __init snd_card_omap_alsa_pcm(struct snd_card_omap_codec
-					  *omap_alsa, int device)
-{
-	snd_pcm_t *pcm;
-	int err;
-	ADEBUG();
-
-	if ((err =
-	     snd_pcm_new(omap_alsa->card, "AIC23 PCM", device, 1, 1, &pcm)) < 0)
-		return err;
-
-	/* sets up initial buffer with continuous allocation */
-	snd_pcm_lib_preallocate_pages_for_all(pcm,
-					      SNDRV_DMA_TYPE_CONTINUOUS,
-					      snd_dma_continuous_data
-					      (GFP_KERNEL),
-					      128 * 1024, 128 * 1024);
-
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-			&snd_card_omap_alsa_playback_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
-			&snd_card_omap_alsa_capture_ops);
-	pcm->private_data = omap_alsa;
-	pcm->info_flags = 0;
-	strcpy(pcm->name, "omap aic23 pcm");
-
-	omap_alsa_audio_init(omap_alsa);
-
-	/* setup DMA controller */
-	audio_dma_request(&omap_alsa->s[SNDRV_PCM_STREAM_PLAYBACK],
-			  audio_dma_callback);
-	audio_dma_request(&omap_alsa->s[SNDRV_PCM_STREAM_CAPTURE],
-			  audio_dma_callback);
-
-	omap_alsa->pcm = pcm;
-
-	return 0;
-}
-
-
-#ifdef CONFIG_PM
-
-static int snd_omap_alsa_suspend(snd_card_t * card, pm_message_t state)
-{
-	struct snd_card_omap_codec *chip = card->private_data;
-	ADEBUG();
-
-	if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
-		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
-		snd_pcm_suspend_all(chip->pcm);
-		/* Mutes and turn clock off */
-		alsa_codec_config->codec_clock_off();
-		snd_omap_suspend_mixer();
-	}
-	return 0;
-}
-
-/*
- *  Prepare hardware for resume
- */
-static int snd_omap_alsa_resume(snd_card_t * card)
-{
-	struct snd_card_omap_codec *chip = card->private_data;
-	ADEBUG();
-	
-	if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
-		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
-		alsa_codec_config->codec_clock_on();
-		snd_omap_resume_mixer();
-	}
-	return 0;
-}
-
-/*
- * Driver suspend/resume - calls alsa functions. Some hints from aaci.c
- */
-static int omap_alsa_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	snd_card_t *card = platform_get_drvdata(pdev);
-	
-	if (card->power_state != SNDRV_CTL_POWER_D3hot) {
-		snd_omap_alsa_suspend(card, PMSG_SUSPEND);
-	}
-	return 0;
-}
-
-static int omap_alsa_resume(struct platform_device *pdev)
-{
-	snd_card_t *card = platform_get_drvdata(pdev);
-
-	if (card->power_state != SNDRV_CTL_POWER_D0) {
-		snd_omap_alsa_resume(card);
-	}
-	return 0;
-}
-
-#else
-#define snd_omap_alsa_suspend	NULL
-#define snd_omap_alsa_resume	NULL
-#define omap_alsa_suspend	NULL
-#define omap_alsa_resume	NULL
-
-#endif	/* CONFIG_PM */
-
-/* 
- */
-void snd_omap_alsa_free(snd_card_t * card)
-{
-	struct snd_card_omap_codec *chip = card->private_data;
-	ADEBUG();
-	
-	/*
-	 * Turn off codec after it is done.
-	 * Can't do it immediately, since it may still have
-	 * buffered data.
-	 */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(2);
-
-	omap_mcbsp_stop(AUDIO_MCBSP);
-	omap_mcbsp_free(AUDIO_MCBSP);
-
-	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_PLAYBACK]);
-	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_CAPTURE]);
-}
-
-/* module init & exit */
-
-/* 
- *  Inits alsa soudcard structure
- */
-static int __init snd_omap_alsa_probe(struct platform_device *pdev)
-{
-	int err = 0;
-	int def_rate;
-	snd_card_t *card;
-	
-	ADEBUG();
-	alsa_codec_config = pdev->dev.platform_data;
-	if (alsa_codec_config == NULL) {
-		err = -ENODEV;
-		goto nodev1;
-	}
-	
-	alsa_codec_config->codec_clock_setup();
-	alsa_codec_config->codec_clock_on(); 
-
-	omap_mcbsp_request(AUDIO_MCBSP);
-	omap_mcbsp_stop(AUDIO_MCBSP);
-	omap_mcbsp_config(AUDIO_MCBSP, alsa_codec_config->mcbsp_regs_alsa);
-	omap_mcbsp_start(AUDIO_MCBSP);
-	
-	if (alsa_codec_config && alsa_codec_config->codec_configure_dev) {
-		alsa_codec_config->codec_configure_dev();
-	}
-
-	alsa_codec_config->codec_clock_off();
-
-	/* register the soundcard */
-	card = snd_card_new(-1, id, THIS_MODULE, sizeof(alsa_codec));
-	if (card == NULL) {
-		goto nodev2;
-	}
-
-	alsa_codec = kcalloc(1, sizeof(*alsa_codec), GFP_KERNEL);
-	if (alsa_codec == NULL) {
-		goto nodev3;
-	}
-
-	card->private_data = (void *)alsa_codec;
-	card->private_free = snd_omap_alsa_free;
-
-	alsa_codec->card	= card;
-	def_rate		= alsa_codec_config->get_default_samplerate(); 
-	alsa_codec->samplerate	= def_rate;
-
-	spin_lock_init(&alsa_codec->s[0].dma_lock);
-	spin_lock_init(&alsa_codec->s[1].dma_lock);
-
-	/* mixer */
-	if ((err = snd_omap_mixer(alsa_codec)) < 0) {
-		goto nodev4;
-	}
-
-	/* PCM */
-	if ((err = snd_card_omap_alsa_pcm(alsa_codec, 0)) < 0) {
-		goto nodev4;
-	}
-
-	strcpy(card->driver, "OMAP_ALSA");
-	strcpy(card->shortname, alsa_codec_config->name);
-	sprintf(card->longname, alsa_codec_config->name);
-
-	snd_omap_init_mixer();
-	snd_card_set_dev(card, &pdev->dev);
-	
-	if ((err = snd_card_register(card)) == 0) {
-		printk(KERN_INFO "audio support initialized\n");
-		platform_set_drvdata(pdev, card);
-		return 0;
-	}
-	
-nodev4:
-	kfree(alsa_codec);	
-nodev3:	
-	snd_card_free(card);
-nodev2:
-	omap_mcbsp_stop(AUDIO_MCBSP);
-	omap_mcbsp_free(AUDIO_MCBSP);
-nodev1:	
-	return err;
-}
-
-static int snd_omap_alsa_remove(struct platform_device *pdev)
-{
-	snd_card_t *card = platform_get_drvdata(pdev);
-	struct snd_card_omap_codec *chip = card->private_data;
-	
-	snd_card_free(card);
-
-	alsa_codec = NULL;
-	card->private_data = NULL;
-	kfree(chip);
-	
-	platform_set_drvdata(pdev, NULL);
-	
-	return 0;
-	
-}
-
-static struct platform_driver omap_alsa_driver = {
-	.probe =	snd_omap_alsa_probe,
-	.remove =	snd_omap_alsa_remove,
-	.suspend =	omap_alsa_suspend, 
-	.resume =	omap_alsa_resume, 
-	.driver = {
-		.name =	"omap_alsa_mcbsp",
-	},
-};
-
-static int __init omap_alsa_init(void)
-{
-	int err;
-	ADEBUG();
-
-	err = platform_driver_register(&omap_alsa_driver);
-
-	return err;
-}
-
-static void __exit omap_alsa_exit(void)
-{
-	ADEBUG();
-	
-	platform_driver_unregister(&omap_alsa_driver);
-}
-
-module_init(omap_alsa_init);
-module_exit(omap_alsa_exit);
Index: linux-omap-2.6.git-q/sound/arm/omap/omap-alsa-mixer.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6.git-q/sound/arm/omap/omap-alsa-mixer.c	2006-02-16 08:40:57.000000000 -0400
@@ -0,0 +1,485 @@
+/*
+ * sound/arm/omap/omap-alsa-aic23-mixer.c
+ * 
+ * Alsa Driver Mixer for generic codecs for omap boards
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * Written by David Cohen, Daniel Petrini
+ *            {david.cohen, daniel.petrini}@indt.org.br
+ *
+ * Based on es1688_lib.c, 
+ * Copyright (c) by Jaroslav Kysela <perex@suse.cz>
+ *  
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * History:
+ *
+ * 2005-08-02   INdT Kernel Team - Alsa mixer driver for omap osk. Creation of new 
+ *                                 file omap-alsa-mixer.c. Initial version
+ *                                 with aic23 codec for osk5912
+ */
+
+#include <linux/config.h>
+#include <sound/driver.h>
+#include <asm/arch/aic23.h>
+
+#include <asm/arch/omap-alsa.h>
+#include <../arch/arm/mach-omap1/omap-alsa-aic23.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+
+MODULE_AUTHOR("David Cohen, Daniel Petrini - INdT");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OMAP Alsa mixer driver for ALSA");
+
+/*
+ * Codec dependent region
+ */
+
+/* Codec AIC23 */
+#if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
+
+extern void audio_aic23_write(u8, u16);
+
+#define MIXER_NAME		     "Mixer AIC23"
+#define SND_OMAP_WRITE(reg, val)     audio_aic23_write(reg, val)
+
+#endif
+
+/* Callback Functions */
+#define OMAP_BOOL(xname, xindex, reg, reg_index, mask, invert) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_omap_info_bool, \
+	.get = snd_omap_get_bool, \
+	.put = snd_omap_put_bool, \
+	.private_value = reg | (reg_index << 8) | (invert << 10) | (mask << 12) \
+}
+
+#define OMAP_MUX(xname, reg, reg_index, mask) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.info = snd_omap_info_mux, \
+	.get = snd_omap_get_mux, \
+	.put = snd_omap_put_mux, \
+	.private_value = reg | (reg_index << 8) | (mask << 10) \
+}
+
+#define OMAP_SINGLE(xname, xindex, reg, reg_index, reg_val, mask) \
+{\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_omap_info_single, \
+	.get = snd_omap_get_single, \
+	.put = snd_omap_put_single, \
+	.private_value = reg | (reg_val << 8) | (reg_index << 16) | (mask << 18) \
+}
+
+#define OMAP_DOUBLE(xname, xindex, left_reg, right_reg, reg_index, mask) \
+{\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_omap_info_double, \
+	.get = snd_omap_get_double, \
+	.put = snd_omap_put_double, \
+	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) | (mask << 18) \
+}
+
+/* Local Registers */
+enum snd_device_index {
+	PCM_INDEX = 0,
+	LINE_INDEX,
+	AAC_INDEX, /* Analog Audio Control: reg = l_reg */
+};
+
+struct {
+	u16 l_reg;
+	u16 r_reg;
+	u8 sw;
+} omap_regs[3];
+
+#ifdef CONFIG_PM
+struct {
+	u16 l_reg;
+	u16 r_reg;
+	u8 sw;
+} omap_pm_regs[3];
+#endif
+
+u16 snd_sidetone[6] = {
+	SIDETONE_18,
+	SIDETONE_12,
+	SIDETONE_9,
+	SIDETONE_6,
+	SIDETONE_0,
+	0
+};
+
+/* Begin Bool Functions */
+
+static int snd_omap_info_bool(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	
+	return 0;
+}
+
+static int snd_omap_get_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	int mic_index = (kcontrol->private_value >> 8) & 0x03;
+	u16 mask = (kcontrol->private_value >> 12) & 0xff;
+	int invert = (kcontrol->private_value >> 10) & 0x03;
+	
+	if (invert)
+		ucontrol->value.integer.value[0] = (omap_regs[mic_index].l_reg & mask) ? 0 : 1;
+	else
+		ucontrol->value.integer.value[0] = (omap_regs[mic_index].l_reg & mask) ? 1 : 0;
+	
+	return 0;
+}
+
+static int snd_omap_put_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	int mic_index = (kcontrol->private_value >> 8) & 0x03;
+	u16 mask = (kcontrol->private_value >> 12) & 0xff;
+	u16 reg = kcontrol->private_value & 0xff;
+	int invert = (kcontrol->private_value >> 10) & 0x03;
+	
+	int changed = 1;
+
+	if (ucontrol->value.integer.value[0]) /* XOR */
+		if (invert)
+			omap_regs[mic_index].l_reg &= ~mask;
+		else
+			omap_regs[mic_index].l_reg |= mask;
+	else
+		if (invert)
+			omap_regs[mic_index].l_reg |= mask;
+		else
+			omap_regs[mic_index].l_reg &= ~mask;
+		
+	SND_OMAP_WRITE(reg, omap_regs[mic_index].l_reg);
+	
+	return changed;
+}
+
+/* End Bool Functions */
+
+/* Begin Mux Functions */
+
+static int snd_omap_info_mux(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	/* Mic = 0
+	 * Line = 1 */
+	static char *texts[2] =	{ "Mic", "Line"	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	
+	if (uinfo->value.enumerated.item > 1)
+		uinfo->value.enumerated.item = 1;
+	
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	
+	return 0;
+}
+
+static int snd_omap_get_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	u16 mask = (kcontrol->private_value >> 10) & 0xff;
+	int mux_index = (kcontrol->private_value >> 8) & 0x03;
+
+	ucontrol->value.enumerated.item[0] = (omap_regs[mux_index].l_reg & mask) ? 0 /* Mic */ : 1 /* Line */;
+	
+	return 0;
+}
+
+static int snd_omap_put_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	u16 reg = kcontrol->private_value & 0xff;
+	u16 mask = (kcontrol->private_value >> 10) & 0xff;
+	int mux_index = (kcontrol->private_value >> 8) & 0x03;
+	
+	int changed = 1;
+
+	if (!ucontrol->value.integer.value[0])
+		omap_regs[mux_index].l_reg |= mask; /* AIC23: Mic */
+	else
+		omap_regs[mux_index].l_reg &= ~mask; /* AIC23: Line */
+	
+	SND_OMAP_WRITE(reg, omap_regs[mux_index].l_reg);
+	
+	return changed;
+}
+
+/* End Mux Functions */
+
+/* Begin Single Functions */
+
+static int snd_omap_info_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	int mask = (kcontrol->private_value >> 18) & 0xff;
+	int reg_val = (kcontrol->private_value >> 8) & 0xff;
+	
+	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER : SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = reg_val-1;
+	
+	return 0;
+}
+
+static int snd_omap_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
+
+	ucontrol->value.integer.value[0] = snd_sidetone[reg_val];
+	
+	return 0;
+}
+
+static int snd_omap_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	u16 reg_index = (kcontrol->private_value >> 16) & 0x03;
+	u16 mask = (kcontrol->private_value >> 18) & 0x1ff;
+	u16 reg = kcontrol->private_value & 0xff;
+	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
+
+	int changed = 0;
+
+	/* Volume */
+	if ((omap_regs[reg_index].l_reg != (ucontrol->value.integer.value[0] & mask)))
+	{
+		changed = 1;
+	
+		omap_regs[reg_index].l_reg &= ~mask;
+		omap_regs[reg_index].l_reg |= snd_sidetone[ucontrol->value.integer.value[0]];
+
+		snd_sidetone[reg_val] = ucontrol->value.integer.value[0];
+		SND_OMAP_WRITE(reg, omap_regs[reg_index].l_reg);
+	}
+	else
+		changed = 0;
+	
+	return changed;
+}
+
+/* End Single Functions */
+
+/* Begin Double Functions */
+
+static int snd_omap_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	/* mask == 0 : Switch
+	 * mask != 0 : Volume */
+	int mask = (kcontrol->private_value >> 18) & 0xff;
+
+	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER : SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = mask ? 2 : 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = mask ? mask : 1;
+	
+	return 0;
+}
+
+static int snd_omap_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	/* mask == 0 : Switch
+	 * mask != 0 : Volume */
+	int mask = (kcontrol->private_value >> 18) & 0xff;
+	int vol_index = (kcontrol->private_value >> 16) & 0x03;
+	
+	if (!mask)
+		/* Switch */
+		ucontrol->value.integer.value[0] = omap_regs[vol_index].sw;
+	else
+	{
+		/* Volume */
+		ucontrol->value.integer.value[0] = omap_regs[vol_index].l_reg;
+		ucontrol->value.integer.value[1] = omap_regs[vol_index].r_reg;
+	}
+
+	return 0;
+}
+
+static int snd_omap_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	/* mask == 0 : Switch
+	 * mask != 0 : Volume */
+	int vol_index = (kcontrol->private_value >> 16) & 0x03;
+	int mask = (kcontrol->private_value >> 18) & 0xff;
+	int left_reg = kcontrol->private_value & 0xff;
+	int right_reg = (kcontrol->private_value >> 8) & 0xff;
+
+	int changed = 0;
+
+	if (!mask)
+	{
+		/* Switch */
+		if (!ucontrol->value.integer.value[0])
+		{
+			SND_OMAP_WRITE(left_reg, 0x00);
+			SND_OMAP_WRITE(right_reg, 0x00);
+		}
+		else
+		{
+			SND_OMAP_WRITE(left_reg, omap_regs[vol_index].l_reg);
+			SND_OMAP_WRITE(right_reg, omap_regs[vol_index].r_reg);
+		}
+		changed = 1;
+		omap_regs[vol_index].sw = ucontrol->value.integer.value[0]; 
+	}
+	else
+	{
+		/* Volume */
+		if ((omap_regs[vol_index].l_reg != (ucontrol->value.integer.value[0] & mask)) ||
+		    (omap_regs[vol_index].r_reg != (ucontrol->value.integer.value[1] & mask)))
+		{
+			changed = 1;
+		
+			omap_regs[vol_index].l_reg &= ~mask;
+			omap_regs[vol_index].r_reg &= ~mask;
+			omap_regs[vol_index].l_reg |= (ucontrol->value.integer.value[0] & mask);
+			omap_regs[vol_index].r_reg |= (ucontrol->value.integer.value[1] & mask);
+			if (omap_regs[vol_index].sw)
+			{
+				/* write to registers only if sw is actived */
+				SND_OMAP_WRITE(left_reg, omap_regs[vol_index].l_reg);
+				SND_OMAP_WRITE(right_reg, omap_regs[vol_index].r_reg);
+			}
+		}
+		else
+			changed = 0;
+	}
+	
+	return changed;
+}
+
+/* End Double Functions */
+
+static snd_kcontrol_new_t snd_omap_controls[] = {
+	OMAP_DOUBLE("PCM Playback Switch", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
+		     PCM_INDEX, 0x00),
+	OMAP_DOUBLE("PCM Playback Volume", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
+		     PCM_INDEX, OUTPUT_VOLUME_MASK),
+	OMAP_BOOL("Line Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, BYPASS_ON, 0),
+	OMAP_DOUBLE("Line Capture Switch", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
+		     LINE_INDEX, 0x00),
+	OMAP_DOUBLE("Line Capture Volume", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
+		     LINE_INDEX, INPUT_VOLUME_MASK),	
+	OMAP_BOOL("Mic Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, STE_ENABLED, 0),	
+	OMAP_SINGLE("Mic Playback Volume", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, 5, SIDETONE_MASK),
+	OMAP_BOOL("Mic Capture Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICM_MUTED, 1),
+	OMAP_BOOL("Mic Booster Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICB_20DB, 0),
+	OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, INSEL_MIC),
+};
+
+#ifdef CONFIG_PM
+
+void snd_omap_suspend_mixer(void)
+{
+	/* Saves current values to wake-up correctly */
+	omap_pm_regs[LINE_INDEX].l_reg = omap_regs[LINE_INDEX].l_reg;
+	omap_pm_regs[LINE_INDEX].r_reg = omap_regs[LINE_INDEX].l_reg;
+	omap_pm_regs[LINE_INDEX].sw = omap_regs[LINE_INDEX].sw;
+	
+	omap_pm_regs[AAC_INDEX].l_reg = omap_regs[AAC_INDEX].l_reg;
+	
+	omap_pm_regs[PCM_INDEX].l_reg = omap_regs[PCM_INDEX].l_reg;
+	omap_pm_regs[PCM_INDEX].r_reg = omap_regs[PCM_INDEX].r_reg;
+	omap_pm_regs[PCM_INDEX].sw = omap_regs[PCM_INDEX].sw;
+}
+
+void snd_omap_resume_mixer(void)
+{
+	/* Line's saved values */
+	omap_regs[LINE_INDEX].l_reg = omap_pm_regs[LINE_INDEX].l_reg;
+	omap_regs[LINE_INDEX].r_reg = omap_pm_regs[LINE_INDEX].l_reg;
+	omap_regs[LINE_INDEX].sw = omap_pm_regs[LINE_INDEX].sw;
+	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, omap_pm_regs[LINE_INDEX].l_reg);
+	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, omap_pm_regs[LINE_INDEX].l_reg);
+	
+	/* Analog Audio Control's saved values */
+	omap_regs[AAC_INDEX].l_reg = omap_pm_regs[AAC_INDEX].l_reg;
+	SND_OMAP_WRITE(ANALOG_AUDIO_CONTROL_ADDR, omap_regs[AAC_INDEX].l_reg);
+	
+	/* Headphone's saved values */
+	omap_regs[PCM_INDEX].l_reg = omap_pm_regs[PCM_INDEX].l_reg;
+	omap_regs[PCM_INDEX].r_reg = omap_pm_regs[PCM_INDEX].r_reg;
+	omap_regs[PCM_INDEX].sw = omap_pm_regs[PCM_INDEX].sw;
+	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].l_reg);
+	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].r_reg);
+}
+#endif
+
+void snd_omap_init_mixer(void)
+{
+	u16 vol_reg;
+
+	/* Line's default values */
+	omap_regs[LINE_INDEX].l_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
+	omap_regs[LINE_INDEX].r_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
+	omap_regs[LINE_INDEX].sw = 0;
+	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
+	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
+	
+	/* Analog Audio Control's default values */
+	omap_regs[AAC_INDEX].l_reg = DEFAULT_ANALOG_AUDIO_CONTROL;
+	
+	/* Headphone's default values */
+	vol_reg = LZC_ON;
+	vol_reg &= ~OUTPUT_VOLUME_MASK;
+	vol_reg |= DEFAULT_OUTPUT_VOLUME;
+	omap_regs[PCM_INDEX].l_reg = DEFAULT_OUTPUT_VOLUME;
+	omap_regs[PCM_INDEX].r_reg = DEFAULT_OUTPUT_VOLUME;
+	omap_regs[PCM_INDEX].sw = 1;
+	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, vol_reg);
+	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, vol_reg);
+}
+
+int snd_omap_mixer(struct snd_card_omap_codec *chip)
+{
+	snd_card_t *card;
+	unsigned int idx;
+	int err;
+
+	snd_assert(chip != NULL && chip->card != NULL, return -EINVAL);
+
+	card = chip->card;
+
+	strcpy(card->mixername, MIXER_NAME);
+
+	/* Registering alsa mixer controls */
+	for (idx = 0; idx < ARRAY_SIZE(snd_omap_controls); idx++) 
+		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_omap_controls[idx], chip))) < 0)
+			return err;
+
+	return 0;
+}
Index: linux-omap-2.6.git-q/sound/arm/omap/omap-alsa-dma.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6.git-q/sound/arm/omap/omap-alsa-dma.c	2006-02-16 08:40:57.000000000 -0400
@@ -0,0 +1,456 @@
+/*
+ * sound/arm/omap/omap-alsa-dma.c
+ *
+ * Common audio DMA handling for the OMAP processors
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * 
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * History:
+ *
+ * 2004-06-07	Sriram Kannan	- Created new file from omap_audio_dma_intfc.c. This file
+ * 				  will contain only the DMA interface and buffer handling of OMAP
+ * 				  audio driver.
+ *
+ * 2004-06-22	Sriram Kannan	- removed legacy code (auto-init). Self-linking of DMA logical channel.
+ *
+ * 2004-08-12   Nishanth Menon  - Modified to integrate Audio requirements on 1610,1710 platforms
+ *
+ * 2004-11-01   Nishanth Menon  - 16xx platform code base modified to support multi channel chaining.
+ *
+ * 2004-12-15   Nishanth Menon  - Improved 16xx platform channel logic introduced - tasklets, queue handling updated
+ * 
+ * 2005-07-19	INdT Kernel Team - Alsa port. Creation of new file omap-alsa-dma.c based in
+ * 				   omap-audio-dma-intfc.c oss file. Support for aic23 codec.
+ * 				   Removal of buffer handling (Alsa does that), modifications
+ *	in dma handling and port to alsa structures.
+ *
+ * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/poll.h>
+#include <linux/pm.h>
+#include <linux/errno.h>
+#include <linux/sound.h>
+#include <linux/soundcard.h>
+#include <linux/sysrq.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/hardware.h>
+#include <asm/semaphore.h>
+
+#include <asm/arch/dma.h>
+#include "omap-alsa-dma.h"
+
+#include <asm/arch/mcbsp.h>
+
+#include <asm/arch/omap-alsa.h>
+
+#undef DEBUG
+//#define DEBUG
+//#ifdef DEBUG
+//#define DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
+//#define FN_IN printk(KERN_INFO "[%s]: start\n", __FUNCTION__)
+//#define FN_OUT(n) printk(KERN_INFO "[%s]: end(%u)\n",__FUNCTION__, n)
+//#else
+
+//#define DPRINTK( x... )
+//#define FN_IN
+//#define FN_OUT(x)
+//#endif
+
+#define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
+
+/* Channel Queue Handling macros
+ * tail always points to the current free entry
+ * Head always points to the current entry being used
+ * end is either head or tail
+ */
+
+#define AUDIO_QUEUE_INIT(s) s->dma_q_head = s->dma_q_tail = s->dma_q_count = 0;
+#define AUDIO_QUEUE_FULL(s) (nr_linked_channels == s->dma_q_count)
+#define AUDIO_QUEUE_LAST(s) (1 == s->dma_q_count)
+#define AUDIO_QUEUE_EMPTY(s) (0 == s->dma_q_count)
+#define __AUDIO_INCREMENT_QUEUE(end) ((end)=((end)+1) % nr_linked_channels)
+#define AUDIO_INCREMENT_HEAD(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_head); s->dma_q_count--;
+#define AUDIO_INCREMENT_TAIL(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_tail); s->dma_q_count++;
+
+/* DMA buffer fragmentation sizes */
+#define MAX_DMA_SIZE		 0x1000000 /* todo: sync with alsa */
+//#define CUT_DMA_SIZE		 0x1000
+/* TODO: To be moved to more appropriate location */
+#define DCSR_ERROR           0x3
+#define DCSR_END_BLOCK       (1 << 5)
+#define DCSR_SYNC_SET        (1 << 6)
+
+#define DCCR_FS              (1 << 5)
+#define DCCR_PRIO            (1 << 6)
+#define DCCR_EN              (1 << 7)
+#define DCCR_AI              (1 << 8)
+#define DCCR_REPEAT          (1 << 9)
+/* if 0 the channel works in 3.1 compatible mode*/
+#define DCCR_N31COMP         (1 << 10)
+#define DCCR_EP              (1 << 11)
+#define DCCR_SRC_AMODE_BIT   12
+#define DCCR_SRC_AMODE_MASK  (0x3<<12)
+#define DCCR_DST_AMODE_BIT   14
+#define DCCR_DST_AMODE_MASK  (0x3<<14)
+#define AMODE_CONST          0x0
+#define AMODE_POST_INC       0x1
+#define AMODE_SINGLE_INDEX   0x2
+#define AMODE_DOUBLE_INDEX   0x3
+
+/**************************** DATA STRUCTURES *****************************************/
+
+static spinlock_t dma_list_lock = SPIN_LOCK_UNLOCKED;
+
+static char nr_linked_channels = 1;
+
+/*********************************** MODULE SPECIFIC FUNCTIONS ***********************/
+
+static void sound_dma_irq_handler(int lch, u16 ch_status, void *data);
+static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
+				     u_int dma_size);
+static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
+					u_int dma_size);
+static int audio_start_dma_chain(struct audio_stream * s);
+
+/***************************************************************************************
+ *
+ * DMA channel requests
+ *
+ **************************************************************************************/
+static void omap_sound_dma_link_lch(void *data)
+{
+
+	struct audio_stream *s = (struct audio_stream *) data;
+	int *chan = s->lch;
+	int i;
+
+	FN_IN;
+	if (s->linked) {
+		FN_OUT(1);
+		return;
+	}
+	for (i = 0; i < nr_linked_channels; i++) {
+		int cur_chan = chan[i];
+		int nex_chan =
+		    ((nr_linked_channels - 1 ==
+		      i) ? chan[0] : chan[i + 1]);
+		omap_dma_link_lch(cur_chan, nex_chan);
+	}
+	s->linked = 1;
+	FN_OUT(0);
+}
+
+int omap_request_sound_dma(int device_id, const char *device_name,
+			   void *data, int **channels)
+{
+	int i, err = 0;
+	int *chan = NULL;
+	FN_IN;
+	if (unlikely((NULL == channels) || (NULL == device_name))) {
+		BUG();
+		return -EPERM;
+	}
+	/* Try allocate memory for the num channels */
+	*channels =
+	    (int *) kmalloc(sizeof(int) * nr_linked_channels, GFP_KERNEL);
+	chan = *channels;
+	if (NULL == chan) {
+		ERR("No Memory for channel allocs!\n");
+		FN_OUT(-ENOMEM);
+		return -ENOMEM;
+	}
+	spin_lock(&dma_list_lock);
+	for (i = 0; i < nr_linked_channels; i++) {
+		err =
+		    omap_request_dma(device_id, device_name,
+				     sound_dma_irq_handler, data,
+				     &chan[i]);
+
+		/* Handle Failure condition here */
+		if (err < 0) {
+			int j;
+			for (j = 0; j < i; j++) {
+				omap_free_dma(chan[j]);
+			}
+			spin_unlock(&dma_list_lock);
+			kfree(chan);
+			*channels = NULL;
+			ERR("Error in requesting channel %d=0x%x\n", i,
+			    err);
+			FN_OUT(err);
+			return err;
+		}
+	}
+
+	/* Chain the channels together */
+	if (!cpu_is_omap1510())
+		omap_sound_dma_link_lch(data);
+
+	spin_unlock(&dma_list_lock);
+	FN_OUT(0);
+	return 0;
+}
+
+/***************************************************************************************
+ *
+ * DMA channel requests Freeing
+ *
+ **************************************************************************************/
+static void omap_sound_dma_unlink_lch(void *data)
+{
+	struct audio_stream *s = (struct audio_stream *) data;
+	int *chan = s->lch;
+	int i;
+
+	FN_IN;
+	if (!s->linked) {
+		FN_OUT(1);
+		return;
+	}
+	for (i = 0; i < nr_linked_channels; i++) {
+		int cur_chan = chan[i];
+		int nex_chan =
+		    ((nr_linked_channels - 1 ==
+		      i) ? chan[0] : chan[i + 1]);
+		omap_dma_unlink_lch(cur_chan, nex_chan);
+	}
+	s->linked = 0;
+	FN_OUT(0);
+}
+
+int omap_free_sound_dma(void *data, int **channels)
+{
+
+	int i;
+	int *chan = NULL;
+	FN_IN;
+	if (unlikely(NULL == channels)) {
+		BUG();
+		return -EPERM;
+	}
+	if (unlikely(NULL == *channels)) {
+		BUG();
+		return -EPERM;
+	}
+	chan = (*channels);
+
+	if (!cpu_is_omap1510())
+		omap_sound_dma_unlink_lch(data);
+	for (i = 0; i < nr_linked_channels; i++) {
+		int cur_chan = chan[i];
+		omap_stop_dma(cur_chan);
+		omap_free_dma(cur_chan);
+	}
+	kfree(*channels);
+	*channels = NULL;
+	FN_OUT(0);
+	return 0;
+}
+
+/***************************************************************************************
+ *
+ * Stop all the DMA channels of the stream
+ *
+ **************************************************************************************/
+void omap_audio_stop_dma(struct audio_stream *s)
+{
+	int *chan = s->lch;
+	int i;
+	FN_IN;
+	if (unlikely(NULL == chan)) {
+		BUG();
+		return;
+	}
+	for (i = 0; i < nr_linked_channels; i++) {
+		int cur_chan = chan[i];
+		omap_stop_dma(cur_chan);
+	}
+	s->started = 0;
+	FN_OUT(0);
+	return;
+}
+/***************************************************************************************
+ *
+ * Clear any pending transfers
+ *
+ **************************************************************************************/
+void omap_clear_sound_dma(struct audio_stream * s)
+{
+	FN_IN;
+	omap_clear_dma(s->lch[s->dma_q_head]);
+	FN_OUT(0);
+	return;
+}
+
+/*********************************** MODULE FUNCTIONS DEFINTIONS ***********************/
+
+#ifdef OMAP1610_MCBSP1_BASE
+#undef OMAP1610_MCBSP1_BASE
+#endif
+#define OMAP1610_MCBSP1_BASE    0xE1011000
+
+/***************************************************************************************
+ *
+ * DMA related functions
+ *
+ **************************************************************************************/
+static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
+				     u_int dma_size)
+{
+	int dt = 0x1;		/* data type 16 */
+	int cen = 32;		/* Stereo */
+	int cfn = dma_size / (2 * cen);
+	FN_IN;
+	omap_set_dma_dest_params(channel, 0x05, 0x00,
+				 (OMAP1610_MCBSP1_BASE + 0x806),
+				 0, 0);
+	omap_set_dma_src_params(channel, 0x00, 0x01, dma_ptr,
+				0, 0);
+	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
+	FN_OUT(0);
+	return 0;
+}
+
+static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
+					u_int dma_size)
+{
+	int dt = 0x1;		/* data type 16 */
+	int cen = 32;		/* stereo */
+	
+	int cfn = dma_size / (2 * cen);
+	FN_IN;
+	omap_set_dma_src_params(channel, 0x05, 0x00,
+				(OMAP1610_MCBSP1_BASE + 0x802),
+				0, 0);
+	omap_set_dma_dest_params(channel, 0x00, 0x01, dma_ptr, 0, 0);
+	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
+	FN_OUT(0);
+	return 0;
+}
+
+static int audio_start_dma_chain(struct audio_stream *s)
+{
+	int channel = s->lch[s->dma_q_head];
+	FN_IN;
+	if (!s->started) {
+	 s->hw_stop();	    /* stops McBSP Interface */
+		omap_start_dma(channel);
+		s->started = 1;
+		s->hw_start();	   /* start McBSP interface */
+	}
+	/* else the dma itself will progress forward with out our help */
+	FN_OUT(0);
+	return 0;
+}
+
+/* Start DMA -
+ * Do the initial set of work to initialize all the channels as required.
+ * We shall then initate a transfer
+ */
+int omap_start_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,
+			 u_int dma_size)
+{
+	int ret = -EPERM;
+
+	FN_IN;
+
+	if (unlikely(dma_size > MAX_DMA_SIZE)) {
+		ERR("DmaSoundDma: Start: overflowed %d-%d\n", dma_size,
+		    MAX_DMA_SIZE);
+		return -EOVERFLOW;
+	}
+	//if (AUDIO_QUEUE_FULL(s)) {
+	//      ret = -2;
+	//      goto sound_out;
+	//}
+
+	if (s->stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
+		/*playback */
+		ret =
+		    audio_set_dma_params_play(s->lch[s->dma_q_tail],
+					      dma_ptr, dma_size);
+	} else {
+		ret =
+		    audio_set_dma_params_capture(s->lch[s->dma_q_tail],
+						 dma_ptr, dma_size);
+	}
+	if (ret != 0) {
+		ret = -3;	/* indicate queue full */
+		goto sound_out;
+	}
+	AUDIO_INCREMENT_TAIL(s);
+	ret = audio_start_dma_chain(s);
+	if (ret) {
+		ERR("dma start failed");
+	}
+      sound_out:
+	FN_OUT(ret);
+	return ret;
+
+}
+
+/* 
+ * ISRs have to be short and smart.. 
+ * Here we call alsa handling, after some error checking
+ */
+static void sound_dma_irq_handler(int sound_curr_lch, u16 ch_status,
+				  void *data)
+{
+	int dma_status = ch_status;
+	struct audio_stream *s = (struct audio_stream *) data;
+	FN_IN;
+
+	/*
+	 * some register checkings
+	 */ 
+	DPRINTK("lch=%d,status=0x%x, dma_status=%d, data=%p\n",
+		sound_curr_lch, ch_status, dma_status, data);
+
+	if (dma_status & (DCSR_ERROR)) {
+		OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
+		ERR("DCSR_ERROR!\n");
+		FN_OUT(-1);
+		return;
+	}
+
+	if (ch_status & DCSR_END_BLOCK) 
+		audio_dma_callback(s);
+	FN_OUT(0);
+	return;
+}
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION
+    ("Common DMA handling for Audio driver on OMAP processors");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(omap_start_sound_dma);
+EXPORT_SYMBOL(omap_clear_sound_dma);
+EXPORT_SYMBOL(omap_request_sound_dma);
+EXPORT_SYMBOL(omap_free_sound_dma);
+EXPORT_SYMBOL(omap_audio_stop_dma);
Index: linux-omap-2.6.git-q/sound/arm/omap-alsa-dma.c
===================================================================
--- linux-omap-2.6.git-q.orig/sound/arm/omap-alsa-dma.c	2006-02-16 08:38:29.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,456 +0,0 @@
-/*
- * sound/arm/omap-alsa-dma.c
- *
- * Common audio DMA handling for the OMAP processors
- *
- * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * 
- * Copyright (C) 2004 Texas Instruments, Inc.
- *
- * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- *
- * History:
- *
- * 2004-06-07	Sriram Kannan	- Created new file from omap_audio_dma_intfc.c. This file
- * 				  will contain only the DMA interface and buffer handling of OMAP
- * 				  audio driver.
- *
- * 2004-06-22	Sriram Kannan	- removed legacy code (auto-init). Self-linking of DMA logical channel.
- *
- * 2004-08-12   Nishanth Menon  - Modified to integrate Audio requirements on 1610,1710 platforms
- *
- * 2004-11-01   Nishanth Menon  - 16xx platform code base modified to support multi channel chaining.
- *
- * 2004-12-15   Nishanth Menon  - Improved 16xx platform channel logic introduced - tasklets, queue handling updated
- * 
- * 2005-07-19	INdT Kernel Team - Alsa port. Creation of new file omap-alsa-dma.c based in
- * 				   omap-audio-dma-intfc.c oss file. Support for aic23 codec.
- * 				   Removal of buffer handling (Alsa does that), modifications
- *	in dma handling and port to alsa structures.
- *
- * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/poll.h>
-#include <linux/pm.h>
-#include <linux/errno.h>
-#include <linux/sound.h>
-#include <linux/soundcard.h>
-#include <linux/sysrq.h>
-#include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/hardware.h>
-#include <asm/semaphore.h>
-
-#include <asm/arch/dma.h>
-#include "omap-alsa-dma.h"
-
-#include <asm/arch/mcbsp.h>
-
-#include <asm/arch/omap-alsa.h>
-
-#undef DEBUG
-//#define DEBUG
-//#ifdef DEBUG
-//#define DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
-//#define FN_IN printk(KERN_INFO "[%s]: start\n", __FUNCTION__)
-//#define FN_OUT(n) printk(KERN_INFO "[%s]: end(%u)\n",__FUNCTION__, n)
-//#else
-
-//#define DPRINTK( x... )
-//#define FN_IN
-//#define FN_OUT(x)
-//#endif
-
-#define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
-
-/* Channel Queue Handling macros
- * tail always points to the current free entry
- * Head always points to the current entry being used
- * end is either head or tail
- */
-
-#define AUDIO_QUEUE_INIT(s) s->dma_q_head = s->dma_q_tail = s->dma_q_count = 0;
-#define AUDIO_QUEUE_FULL(s) (nr_linked_channels == s->dma_q_count)
-#define AUDIO_QUEUE_LAST(s) (1 == s->dma_q_count)
-#define AUDIO_QUEUE_EMPTY(s) (0 == s->dma_q_count)
-#define __AUDIO_INCREMENT_QUEUE(end) ((end)=((end)+1) % nr_linked_channels)
-#define AUDIO_INCREMENT_HEAD(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_head); s->dma_q_count--;
-#define AUDIO_INCREMENT_TAIL(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_tail); s->dma_q_count++;
-
-/* DMA buffer fragmentation sizes */
-#define MAX_DMA_SIZE		 0x1000000 /* todo: sync with alsa */
-//#define CUT_DMA_SIZE		 0x1000
-/* TODO: To be moved to more appropriate location */
-#define DCSR_ERROR           0x3
-#define DCSR_END_BLOCK       (1 << 5)
-#define DCSR_SYNC_SET        (1 << 6)
-
-#define DCCR_FS              (1 << 5)
-#define DCCR_PRIO            (1 << 6)
-#define DCCR_EN              (1 << 7)
-#define DCCR_AI              (1 << 8)
-#define DCCR_REPEAT          (1 << 9)
-/* if 0 the channel works in 3.1 compatible mode*/
-#define DCCR_N31COMP         (1 << 10)
-#define DCCR_EP              (1 << 11)
-#define DCCR_SRC_AMODE_BIT   12
-#define DCCR_SRC_AMODE_MASK  (0x3<<12)
-#define DCCR_DST_AMODE_BIT   14
-#define DCCR_DST_AMODE_MASK  (0x3<<14)
-#define AMODE_CONST          0x0
-#define AMODE_POST_INC       0x1
-#define AMODE_SINGLE_INDEX   0x2
-#define AMODE_DOUBLE_INDEX   0x3
-
-/**************************** DATA STRUCTURES *****************************************/
-
-static spinlock_t dma_list_lock = SPIN_LOCK_UNLOCKED;
-
-static char nr_linked_channels = 1;
-
-/*********************************** MODULE SPECIFIC FUNCTIONS ***********************/
-
-static void sound_dma_irq_handler(int lch, u16 ch_status, void *data);
-static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
-				     u_int dma_size);
-static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
-					u_int dma_size);
-static int audio_start_dma_chain(struct audio_stream * s);
-
-/***************************************************************************************
- *
- * DMA channel requests
- *
- **************************************************************************************/
-static void omap_sound_dma_link_lch(void *data)
-{
-
-	struct audio_stream *s = (struct audio_stream *) data;
-	int *chan = s->lch;
-	int i;
-
-	FN_IN;
-	if (s->linked) {
-		FN_OUT(1);
-		return;
-	}
-	for (i = 0; i < nr_linked_channels; i++) {
-		int cur_chan = chan[i];
-		int nex_chan =
-		    ((nr_linked_channels - 1 ==
-		      i) ? chan[0] : chan[i + 1]);
-		omap_dma_link_lch(cur_chan, nex_chan);
-	}
-	s->linked = 1;
-	FN_OUT(0);
-}
-
-int omap_request_sound_dma(int device_id, const char *device_name,
-			   void *data, int **channels)
-{
-	int i, err = 0;
-	int *chan = NULL;
-	FN_IN;
-	if (unlikely((NULL == channels) || (NULL == device_name))) {
-		BUG();
-		return -EPERM;
-	}
-	/* Try allocate memory for the num channels */
-	*channels =
-	    (int *) kmalloc(sizeof(int) * nr_linked_channels, GFP_KERNEL);
-	chan = *channels;
-	if (NULL == chan) {
-		ERR("No Memory for channel allocs!\n");
-		FN_OUT(-ENOMEM);
-		return -ENOMEM;
-	}
-	spin_lock(&dma_list_lock);
-	for (i = 0; i < nr_linked_channels; i++) {
-		err =
-		    omap_request_dma(device_id, device_name,
-				     sound_dma_irq_handler, data,
-				     &chan[i]);
-
-		/* Handle Failure condition here */
-		if (err < 0) {
-			int j;
-			for (j = 0; j < i; j++) {
-				omap_free_dma(chan[j]);
-			}
-			spin_unlock(&dma_list_lock);
-			kfree(chan);
-			*channels = NULL;
-			ERR("Error in requesting channel %d=0x%x\n", i,
-			    err);
-			FN_OUT(err);
-			return err;
-		}
-	}
-
-	/* Chain the channels together */
-	if (!cpu_is_omap1510())
-		omap_sound_dma_link_lch(data);
-
-	spin_unlock(&dma_list_lock);
-	FN_OUT(0);
-	return 0;
-}
-
-/***************************************************************************************
- *
- * DMA channel requests Freeing
- *
- **************************************************************************************/
-static void omap_sound_dma_unlink_lch(void *data)
-{
-	struct audio_stream *s = (struct audio_stream *) data;
-	int *chan = s->lch;
-	int i;
-
-	FN_IN;
-	if (!s->linked) {
-		FN_OUT(1);
-		return;
-	}
-	for (i = 0; i < nr_linked_channels; i++) {
-		int cur_chan = chan[i];
-		int nex_chan =
-		    ((nr_linked_channels - 1 ==
-		      i) ? chan[0] : chan[i + 1]);
-		omap_dma_unlink_lch(cur_chan, nex_chan);
-	}
-	s->linked = 0;
-	FN_OUT(0);
-}
-
-int omap_free_sound_dma(void *data, int **channels)
-{
-
-	int i;
-	int *chan = NULL;
-	FN_IN;
-	if (unlikely(NULL == channels)) {
-		BUG();
-		return -EPERM;
-	}
-	if (unlikely(NULL == *channels)) {
-		BUG();
-		return -EPERM;
-	}
-	chan = (*channels);
-
-	if (!cpu_is_omap1510())
-		omap_sound_dma_unlink_lch(data);
-	for (i = 0; i < nr_linked_channels; i++) {
-		int cur_chan = chan[i];
-		omap_stop_dma(cur_chan);
-		omap_free_dma(cur_chan);
-	}
-	kfree(*channels);
-	*channels = NULL;
-	FN_OUT(0);
-	return 0;
-}
-
-/***************************************************************************************
- *
- * Stop all the DMA channels of the stream
- *
- **************************************************************************************/
-void omap_audio_stop_dma(struct audio_stream *s)
-{
-	int *chan = s->lch;
-	int i;
-	FN_IN;
-	if (unlikely(NULL == chan)) {
-		BUG();
-		return;
-	}
-	for (i = 0; i < nr_linked_channels; i++) {
-		int cur_chan = chan[i];
-		omap_stop_dma(cur_chan);
-	}
-	s->started = 0;
-	FN_OUT(0);
-	return;
-}
-/***************************************************************************************
- *
- * Clear any pending transfers
- *
- **************************************************************************************/
-void omap_clear_sound_dma(struct audio_stream * s)
-{
-	FN_IN;
-	omap_clear_dma(s->lch[s->dma_q_head]);
-	FN_OUT(0);
-	return;
-}
-
-/*********************************** MODULE FUNCTIONS DEFINTIONS ***********************/
-
-#ifdef OMAP1610_MCBSP1_BASE
-#undef OMAP1610_MCBSP1_BASE
-#endif
-#define OMAP1610_MCBSP1_BASE    0xE1011000
-
-/***************************************************************************************
- *
- * DMA related functions
- *
- **************************************************************************************/
-static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
-				     u_int dma_size)
-{
-	int dt = 0x1;		/* data type 16 */
-	int cen = 32;		/* Stereo */
-	int cfn = dma_size / (2 * cen);
-	FN_IN;
-	omap_set_dma_dest_params(channel, 0x05, 0x00,
-				 (OMAP1610_MCBSP1_BASE + 0x806),
-				 0, 0);
-	omap_set_dma_src_params(channel, 0x00, 0x01, dma_ptr,
-				0, 0);
-	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
-	FN_OUT(0);
-	return 0;
-}
-
-static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
-					u_int dma_size)
-{
-	int dt = 0x1;		/* data type 16 */
-	int cen = 32;		/* stereo */
-	
-	int cfn = dma_size / (2 * cen);
-	FN_IN;
-	omap_set_dma_src_params(channel, 0x05, 0x00,
-				(OMAP1610_MCBSP1_BASE + 0x802),
-				0, 0);
-	omap_set_dma_dest_params(channel, 0x00, 0x01, dma_ptr, 0, 0);
-	omap_set_dma_transfer_params(channel, dt, cen, cfn, 0x00, 0, 0);
-	FN_OUT(0);
-	return 0;
-}
-
-static int audio_start_dma_chain(struct audio_stream *s)
-{
-	int channel = s->lch[s->dma_q_head];
-	FN_IN;
-	if (!s->started) {
-	 s->hw_stop();	    /* stops McBSP Interface */
-		omap_start_dma(channel);
-		s->started = 1;
-		s->hw_start();	   /* start McBSP interface */
-	}
-	/* else the dma itself will progress forward with out our help */
-	FN_OUT(0);
-	return 0;
-}
-
-/* Start DMA -
- * Do the initial set of work to initialize all the channels as required.
- * We shall then initate a transfer
- */
-int omap_start_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,
-			 u_int dma_size)
-{
-	int ret = -EPERM;
-
-	FN_IN;
-
-	if (unlikely(dma_size > MAX_DMA_SIZE)) {
-		ERR("DmaSoundDma: Start: overflowed %d-%d\n", dma_size,
-		    MAX_DMA_SIZE);
-		return -EOVERFLOW;
-	}
-	//if (AUDIO_QUEUE_FULL(s)) {
-	//      ret = -2;
-	//      goto sound_out;
-	//}
-
-	if (s->stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
-		/*playback */
-		ret =
-		    audio_set_dma_params_play(s->lch[s->dma_q_tail],
-					      dma_ptr, dma_size);
-	} else {
-		ret =
-		    audio_set_dma_params_capture(s->lch[s->dma_q_tail],
-						 dma_ptr, dma_size);
-	}
-	if (ret != 0) {
-		ret = -3;	/* indicate queue full */
-		goto sound_out;
-	}
-	AUDIO_INCREMENT_TAIL(s);
-	ret = audio_start_dma_chain(s);
-	if (ret) {
-		ERR("dma start failed");
-	}
-      sound_out:
-	FN_OUT(ret);
-	return ret;
-
-}
-
-/* 
- * ISRs have to be short and smart.. 
- * Here we call alsa handling, after some error checking
- */
-static void sound_dma_irq_handler(int sound_curr_lch, u16 ch_status,
-				  void *data)
-{
-	int dma_status = ch_status;
-	struct audio_stream *s = (struct audio_stream *) data;
-	FN_IN;
-
-	/*
-	 * some register checkings
-	 */ 
-	DPRINTK("lch=%d,status=0x%x, dma_status=%d, data=%p\n",
-		sound_curr_lch, ch_status, dma_status, data);
-
-	if (dma_status & (DCSR_ERROR)) {
-		OMAP_DMA_CCR_REG(sound_curr_lch) &= ~DCCR_EN;
-		ERR("DCSR_ERROR!\n");
-		FN_OUT(-1);
-		return;
-	}
-
-	if (ch_status & DCSR_END_BLOCK) 
-		audio_dma_callback(s);
-	FN_OUT(0);
-	return;
-}
-
-MODULE_AUTHOR("Texas Instruments");
-MODULE_DESCRIPTION
-    ("Common DMA handling for Audio driver on OMAP processors");
-MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL(omap_start_sound_dma);
-EXPORT_SYMBOL(omap_clear_sound_dma);
-EXPORT_SYMBOL(omap_request_sound_dma);
-EXPORT_SYMBOL(omap_free_sound_dma);
-EXPORT_SYMBOL(omap_audio_stop_dma);
Index: linux-omap-2.6.git-q/sound/arm/omap/omap-alsa-dma.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6.git-q/sound/arm/omap/omap-alsa-dma.h	2006-02-16 08:40:57.000000000 -0400
@@ -0,0 +1,59 @@
+/*  
+ * linux/sound/arm/omap/omap-alsa-dma.h
+ *
+ * Common audio DMA handling for the OMAP processors
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
+ * 
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * History:
+ *
+ * 
+ * 2004/08/12  Nishanth Menon - Modified to integrate Audio requirements on 1610,1710 platforms
+ *
+ * 2005/07/25  INdT Kernel Team - Renamed to omap-alsa-dma.h. Ported to Alsa.
+ */
+
+#ifndef __OMAP_AUDIO_ALSA_DMA_H
+#define __OMAP_AUDIO_ALSA_DMA_H
+
+/************************** INCLUDES *************************************/
+
+#include <asm/arch/omap-alsa.h>
+
+/************************** GLOBAL MACROS *************************************/
+
+/* Provide the Macro interfaces common across platforms */
+#define DMA_REQUEST(e,s, cb)	{e=omap_request_sound_dma(s->dma_dev, s->id, s, &s->lch);}
+#define DMA_FREE(s)		omap_free_sound_dma(s, &s->lch)
+#define DMA_CLEAR(s)		omap_clear_sound_dma(s)
+
+/************************** GLOBAL DATA STRUCTURES *********************************/
+
+typedef void (*dma_callback_t) (int lch, u16 ch_status, void *data);
+
+/**************** ARCH SPECIFIC FUNCIONS *******************************************/
+
+void omap_clear_sound_dma(struct audio_stream * s);
+
+int omap_request_sound_dma(int device_id, const char *device_name,
+			   void *data, int **channels);
+int omap_free_sound_dma(void *data, int **channels);
+
+int omap_start_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,
+			 u_int dma_size);
+
+void omap_audio_stop_dma(struct audio_stream *s);
+
+#endif
Index: linux-omap-2.6.git-q/sound/arm/omap-alsa-dma.h
===================================================================
--- linux-omap-2.6.git-q.orig/sound/arm/omap-alsa-dma.h	2006-02-16 08:38:29.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,59 +0,0 @@
-/*  
- * linux/sound/arm/omap-alsa-dma.h
- *
- * Common audio DMA handling for the OMAP processors
- *
- * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * 
- * Copyright (C) 2004 Texas Instruments, Inc.
- *
- * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- *
- * History:
- *
- * 
- * 2004/08/12  Nishanth Menon - Modified to integrate Audio requirements on 1610,1710 platforms
- *
- * 2005/07/25  INdT Kernel Team - Renamed to omap-alsa-dma.h. Ported to Alsa.
- */
-
-#ifndef __OMAP_AUDIO_ALSA_DMA_H
-#define __OMAP_AUDIO_ALSA_DMA_H
-
-/************************** INCLUDES *************************************/
-
-#include <asm/arch/omap-alsa.h>
-
-/************************** GLOBAL MACROS *************************************/
-
-/* Provide the Macro interfaces common across platforms */
-#define DMA_REQUEST(e,s, cb)	{e=omap_request_sound_dma(s->dma_dev, s->id, s, &s->lch);}
-#define DMA_FREE(s)		omap_free_sound_dma(s, &s->lch)
-#define DMA_CLEAR(s)		omap_clear_sound_dma(s)
-
-/************************** GLOBAL DATA STRUCTURES *********************************/
-
-typedef void (*dma_callback_t) (int lch, u16 ch_status, void *data);
-
-/**************** ARCH SPECIFIC FUNCIONS *******************************************/
-
-void omap_clear_sound_dma(struct audio_stream * s);
-
-int omap_request_sound_dma(int device_id, const char *device_name,
-			   void *data, int **channels);
-int omap_free_sound_dma(void *data, int **channels);
-
-int omap_start_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,
-			 u_int dma_size);
-
-void omap_audio_stop_dma(struct audio_stream *s);
-
-#endif
Index: linux-omap-2.6.git-q/sound/arm/Makefile
===================================================================
--- linux-omap-2.6.git-q.orig/sound/arm/Makefile	2006-02-16 08:34:58.000000000 -0400
+++ linux-omap-2.6.git-q/sound/arm/Makefile	2006-02-16 08:40:57.000000000 -0400
@@ -14,9 +14,4 @@ snd-pxa2xx-pcm-objs		:= pxa2xx-pcm.o
 obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
 snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o
 
-obj-$(CONFIG_SND_OMAP_AIC23) += snd-omap-alsa-aic23.o
-snd-omap-alsa-aic23-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-mixer.o 
-
-obj-$(CONFIG_SND_OMAP_TSC2101) += snd-omap-alsa-tsc2101.o
-snd-omap-alsa-tsc2101-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-tsc2101-mixer.o 
-
+obj-$(CONFIG_SND) += omap/
Index: linux-omap-2.6.git-q/sound/arm/omap/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6.git-q/sound/arm/omap/Makefile	2006-02-16 08:40:57.000000000 -0400
@@ -0,0 +1,10 @@
+#
+## Makefile for ALSA OMAP
+#
+#
+obj-$(CONFIG_SND_OMAP_AIC23) += snd-omap-alsa-aic23.o
+snd-omap-alsa-aic23-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-mixer.o
+
+obj-$(CONFIG_SND_OMAP_TSC2101) += snd-omap-alsa-tsc2101.o
+snd-omap-alsa-tsc2101-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-tsc2101-mixer.o
+
Index: linux-omap-2.6.git-q/sound/arm/omap-alsa-mixer.c
===================================================================
--- linux-omap-2.6.git-q.orig/sound/arm/omap-alsa-mixer.c	2006-02-16 08:38:29.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,485 +0,0 @@
-/*
- * sound/arm/omap/omap-alsa-mixer.c
- * 
- * Alsa Driver Mixer for generic codecs for omap boards
- *
- * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * Written by David Cohen, Daniel Petrini
- *            {david.cohen, daniel.petrini}@indt.org.br
- *
- * Based on es1688_lib.c, 
- * Copyright (c) by Jaroslav Kysela <perex@suse.cz>
- *  
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * History:
- *
- * 2005-08-02   INdT Kernel Team - Alsa mixer driver for omap osk. Creation of new 
- *                                 file omap-alsa-mixer.c. Initial version
- *                                 with aic23 codec for osk5912
- */
-
-#include <linux/config.h>
-#include <sound/driver.h>
-#include <asm/arch/aic23.h>
-
-#include <asm/arch/omap-alsa.h>
-#include <../arch/arm/mach-omap1/omap-alsa-aic23.h>
-#include <sound/initval.h>
-#include <sound/control.h>
-
-MODULE_AUTHOR("David Cohen, Daniel Petrini - INdT");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("OMAP Alsa mixer driver for ALSA");
-
-/*
- * Codec dependent region
- */
-
-/* Codec AIC23 */
-#if defined(CONFIG_SENSORS_TLV320AIC23) || defined (CONFIG_SENSORS_TLV320AIC23_MODULE)
-
-extern __inline__ void audio_aic23_write(u8, u16);
-
-#define MIXER_NAME		     "Mixer AIC23"
-#define SND_OMAP_WRITE(reg, val)     audio_aic23_write(reg, val)
-
-#endif
-
-/* Callback Functions */
-#define OMAP_BOOL(xname, xindex, reg, reg_index, mask, invert) \
-{ \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.index = xindex, \
-	.info = snd_omap_info_bool, \
-	.get = snd_omap_get_bool, \
-	.put = snd_omap_put_bool, \
-	.private_value = reg | (reg_index << 8) | (invert << 10) | (mask << 12) \
-}
-
-#define OMAP_MUX(xname, reg, reg_index, mask) \
-{ \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.info = snd_omap_info_mux, \
-	.get = snd_omap_get_mux, \
-	.put = snd_omap_put_mux, \
-	.private_value = reg | (reg_index << 8) | (mask << 10) \
-}
-
-#define OMAP_SINGLE(xname, xindex, reg, reg_index, reg_val, mask) \
-{\
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.index = xindex, \
-	.info = snd_omap_info_single, \
-	.get = snd_omap_get_single, \
-	.put = snd_omap_put_single, \
-	.private_value = reg | (reg_val << 8) | (reg_index << 16) | (mask << 18) \
-}
-
-#define OMAP_DOUBLE(xname, xindex, left_reg, right_reg, reg_index, mask) \
-{\
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.index = xindex, \
-	.info = snd_omap_info_double, \
-	.get = snd_omap_get_double, \
-	.put = snd_omap_put_double, \
-	.private_value = left_reg | (right_reg << 8) | (reg_index << 16) | (mask << 18) \
-}
-
-/* Local Registers */
-enum snd_device_index {
-	PCM_INDEX = 0,
-	LINE_INDEX,
-	AAC_INDEX, /* Analog Audio Control: reg = l_reg */
-};
-
-struct {
-	u16 l_reg;
-	u16 r_reg;
-	u8 sw;
-} omap_regs[3];
-
-#ifdef CONFIG_PM
-struct {
-	u16 l_reg;
-	u16 r_reg;
-	u8 sw;
-} omap_pm_regs[3];
-#endif
-
-u16 snd_sidetone[6] = {
-	SIDETONE_18,
-	SIDETONE_12,
-	SIDETONE_9,
-	SIDETONE_6,
-	SIDETONE_0,
-	0
-};
-
-/* Begin Bool Functions */
-
-static int snd_omap_info_bool(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 1;
-	
-	return 0;
-}
-
-static int snd_omap_get_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	int mic_index = (kcontrol->private_value >> 8) & 0x03;
-	u16 mask = (kcontrol->private_value >> 12) & 0xff;
-	int invert = (kcontrol->private_value >> 10) & 0x03;
-	
-	if (invert)
-		ucontrol->value.integer.value[0] = (omap_regs[mic_index].l_reg & mask) ? 0 : 1;
-	else
-		ucontrol->value.integer.value[0] = (omap_regs[mic_index].l_reg & mask) ? 1 : 0;
-	
-	return 0;
-}
-
-static int snd_omap_put_bool(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	int mic_index = (kcontrol->private_value >> 8) & 0x03;
-	u16 mask = (kcontrol->private_value >> 12) & 0xff;
-	u16 reg = kcontrol->private_value & 0xff;
-	int invert = (kcontrol->private_value >> 10) & 0x03;
-	
-	int changed = 1;
-
-	if (ucontrol->value.integer.value[0]) /* XOR */
-		if (invert)
-			omap_regs[mic_index].l_reg &= ~mask;
-		else
-			omap_regs[mic_index].l_reg |= mask;
-	else
-		if (invert)
-			omap_regs[mic_index].l_reg |= mask;
-		else
-			omap_regs[mic_index].l_reg &= ~mask;
-		
-	SND_OMAP_WRITE(reg, omap_regs[mic_index].l_reg);
-	
-	return changed;
-}
-
-/* End Bool Functions */
-
-/* Begin Mux Functions */
-
-static int snd_omap_info_mux(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	/* Mic = 0
-	 * Line = 1 */
-	static char *texts[2] =	{ "Mic", "Line"	};
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	
-	return 0;
-}
-
-static int snd_omap_get_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	u16 mask = (kcontrol->private_value >> 10) & 0xff;
-	int mux_index = (kcontrol->private_value >> 8) & 0x03;
-
-	ucontrol->value.enumerated.item[0] = (omap_regs[mux_index].l_reg & mask) ? 0 /* Mic */ : 1 /* Line */;
-	
-	return 0;
-}
-
-static int snd_omap_put_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	u16 reg = kcontrol->private_value & 0xff;
-	u16 mask = (kcontrol->private_value >> 10) & 0xff;
-	int mux_index = (kcontrol->private_value >> 8) & 0x03;
-	
-	int changed = 1;
-
-	if (!ucontrol->value.integer.value[0])
-		omap_regs[mux_index].l_reg |= mask; /* AIC23: Mic */
-	else
-		omap_regs[mux_index].l_reg &= ~mask; /* AIC23: Line */
-	
-	SND_OMAP_WRITE(reg, omap_regs[mux_index].l_reg);
-	
-	return changed;
-}
-
-/* End Mux Functions */
-
-/* Begin Single Functions */
-
-static int snd_omap_info_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int mask = (kcontrol->private_value >> 18) & 0xff;
-	int reg_val = (kcontrol->private_value >> 8) & 0xff;
-	
-	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER : SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = reg_val-1;
-	
-	return 0;
-}
-
-static int snd_omap_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
-
-	ucontrol->value.integer.value[0] = snd_sidetone[reg_val];
-	
-	return 0;
-}
-
-static int snd_omap_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	u16 reg_index = (kcontrol->private_value >> 16) & 0x03;
-	u16 mask = (kcontrol->private_value >> 18) & 0x1ff;
-	u16 reg = kcontrol->private_value & 0xff;
-	u16 reg_val = (kcontrol->private_value >> 8) & 0xff;
-
-	int changed = 0;
-
-	/* Volume */
-	if ((omap_regs[reg_index].l_reg != (ucontrol->value.integer.value[0] & mask)))
-	{
-		changed = 1;
-	
-		omap_regs[reg_index].l_reg &= ~mask;
-		omap_regs[reg_index].l_reg |= snd_sidetone[ucontrol->value.integer.value[0]];
-
-		snd_sidetone[reg_val] = ucontrol->value.integer.value[0];
-		SND_OMAP_WRITE(reg, omap_regs[reg_index].l_reg);
-	}
-	else
-		changed = 0;
-	
-	return changed;
-}
-
-/* End Single Functions */
-
-/* Begin Double Functions */
-
-static int snd_omap_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
-	int mask = (kcontrol->private_value >> 18) & 0xff;
-
-	uinfo->type = mask ? SNDRV_CTL_ELEM_TYPE_INTEGER : SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count = mask ? 2 : 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = mask ? mask : 1;
-	
-	return 0;
-}
-
-static int snd_omap_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
-	int mask = (kcontrol->private_value >> 18) & 0xff;
-	int vol_index = (kcontrol->private_value >> 16) & 0x03;
-	
-	if (!mask)
-		/* Switch */
-		ucontrol->value.integer.value[0] = omap_regs[vol_index].sw;
-	else
-	{
-		/* Volume */
-		ucontrol->value.integer.value[0] = omap_regs[vol_index].l_reg;
-		ucontrol->value.integer.value[1] = omap_regs[vol_index].r_reg;
-	}
-
-	return 0;
-}
-
-static int snd_omap_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
-{
-	/* mask == 0 : Switch
-	 * mask != 0 : Volume */
-	int vol_index = (kcontrol->private_value >> 16) & 0x03;
-	int mask = (kcontrol->private_value >> 18) & 0xff;
-	int left_reg = kcontrol->private_value & 0xff;
-	int right_reg = (kcontrol->private_value >> 8) & 0xff;
-
-	int changed = 0;
-
-	if (!mask)
-	{
-		/* Switch */
-		if (!ucontrol->value.integer.value[0])
-		{
-			SND_OMAP_WRITE(left_reg, 0x00);
-			SND_OMAP_WRITE(right_reg, 0x00);
-		}
-		else
-		{
-			SND_OMAP_WRITE(left_reg, omap_regs[vol_index].l_reg);
-			SND_OMAP_WRITE(right_reg, omap_regs[vol_index].r_reg);
-		}
-		changed = 1;
-		omap_regs[vol_index].sw = ucontrol->value.integer.value[0]; 
-	}
-	else
-	{
-		/* Volume */
-		if ((omap_regs[vol_index].l_reg != (ucontrol->value.integer.value[0] & mask)) ||
-		    (omap_regs[vol_index].r_reg != (ucontrol->value.integer.value[1] & mask)))
-		{
-			changed = 1;
-		
-			omap_regs[vol_index].l_reg &= ~mask;
-			omap_regs[vol_index].r_reg &= ~mask;
-			omap_regs[vol_index].l_reg |= (ucontrol->value.integer.value[0] & mask);
-			omap_regs[vol_index].r_reg |= (ucontrol->value.integer.value[1] & mask);
-			if (omap_regs[vol_index].sw)
-			{
-				/* write to registers only if sw is actived */
-				SND_OMAP_WRITE(left_reg, omap_regs[vol_index].l_reg);
-				SND_OMAP_WRITE(right_reg, omap_regs[vol_index].r_reg);
-			}
-		}
-		else
-			changed = 0;
-	}
-	
-	return changed;
-}
-
-/* End Double Functions */
-
-static snd_kcontrol_new_t snd_omap_controls[] = {
-	OMAP_DOUBLE("PCM Playback Switch", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
-		     PCM_INDEX, 0x00),
-	OMAP_DOUBLE("PCM Playback Volume", 0, LEFT_CHANNEL_VOLUME_ADDR, RIGHT_CHANNEL_VOLUME_ADDR,
-		     PCM_INDEX, OUTPUT_VOLUME_MASK),
-	OMAP_BOOL("Line Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, BYPASS_ON, 0),
-	OMAP_DOUBLE("Line Capture Switch", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
-		     LINE_INDEX, 0x00),
-	OMAP_DOUBLE("Line Capture Volume", 0, LEFT_LINE_VOLUME_ADDR, RIGHT_LINE_VOLUME_ADDR,
-		     LINE_INDEX, INPUT_VOLUME_MASK),	
-	OMAP_BOOL("Mic Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, STE_ENABLED, 0),	
-	OMAP_SINGLE("Mic Playback Volume", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, 5, SIDETONE_MASK),
-	OMAP_BOOL("Mic Capture Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICM_MUTED, 1),
-	OMAP_BOOL("Mic Booster Playback Switch", 0, ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, MICB_20DB, 0),
-	OMAP_MUX("Capture Source", ANALOG_AUDIO_CONTROL_ADDR, AAC_INDEX, INSEL_MIC),
-};
-
-#ifdef CONFIG_PM
-
-void snd_omap_suspend_mixer(void)
-{
-	/* Saves current values to wake-up correctly */
-	omap_pm_regs[LINE_INDEX].l_reg = omap_regs[LINE_INDEX].l_reg;
-	omap_pm_regs[LINE_INDEX].r_reg = omap_regs[LINE_INDEX].l_reg;
-	omap_pm_regs[LINE_INDEX].sw = omap_regs[LINE_INDEX].sw;
-	
-	omap_pm_regs[AAC_INDEX].l_reg = omap_regs[AAC_INDEX].l_reg;
-	
-	omap_pm_regs[PCM_INDEX].l_reg = omap_regs[PCM_INDEX].l_reg;
-	omap_pm_regs[PCM_INDEX].r_reg = omap_regs[PCM_INDEX].r_reg;
-	omap_pm_regs[PCM_INDEX].sw = omap_regs[PCM_INDEX].sw;
-}
-
-void snd_omap_resume_mixer(void)
-{
-	/* Line's saved values */
-	omap_regs[LINE_INDEX].l_reg = omap_pm_regs[LINE_INDEX].l_reg;
-	omap_regs[LINE_INDEX].r_reg = omap_pm_regs[LINE_INDEX].l_reg;
-	omap_regs[LINE_INDEX].sw = omap_pm_regs[LINE_INDEX].sw;
-	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, omap_pm_regs[LINE_INDEX].l_reg);
-	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, omap_pm_regs[LINE_INDEX].l_reg);
-	
-	/* Analog Audio Control's saved values */
-	omap_regs[AAC_INDEX].l_reg = omap_pm_regs[AAC_INDEX].l_reg;
-	SND_OMAP_WRITE(ANALOG_AUDIO_CONTROL_ADDR, omap_regs[AAC_INDEX].l_reg);
-	
-	/* Headphone's saved values */
-	omap_regs[PCM_INDEX].l_reg = omap_pm_regs[PCM_INDEX].l_reg;
-	omap_regs[PCM_INDEX].r_reg = omap_pm_regs[PCM_INDEX].r_reg;
-	omap_regs[PCM_INDEX].sw = omap_pm_regs[PCM_INDEX].sw;
-	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].l_reg);
-	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, omap_pm_regs[PCM_INDEX].r_reg);
-}
-#endif
-
-void snd_omap_init_mixer(void)
-{
-	u16 vol_reg;
-
-	/* Line's default values */
-	omap_regs[LINE_INDEX].l_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
-	omap_regs[LINE_INDEX].r_reg = DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK;
-	omap_regs[LINE_INDEX].sw = 0;
-	SND_OMAP_WRITE(LEFT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
-	SND_OMAP_WRITE(RIGHT_LINE_VOLUME_ADDR, DEFAULT_INPUT_VOLUME & INPUT_VOLUME_MASK);
-	
-	/* Analog Audio Control's default values */
-	omap_regs[AAC_INDEX].l_reg = DEFAULT_ANALOG_AUDIO_CONTROL;
-	
-	/* Headphone's default values */
-	vol_reg = LZC_ON;
-	vol_reg &= ~OUTPUT_VOLUME_MASK;
-	vol_reg |= DEFAULT_OUTPUT_VOLUME;
-	omap_regs[PCM_INDEX].l_reg = DEFAULT_OUTPUT_VOLUME;
-	omap_regs[PCM_INDEX].r_reg = DEFAULT_OUTPUT_VOLUME;
-	omap_regs[PCM_INDEX].sw = 1;
-	SND_OMAP_WRITE(LEFT_CHANNEL_VOLUME_ADDR, vol_reg);
-	SND_OMAP_WRITE(RIGHT_CHANNEL_VOLUME_ADDR, vol_reg);
-}
-
-int snd_omap_mixer(struct snd_card_omap_codec *chip)
-{
-	snd_card_t *card;
-	unsigned int idx;
-	int err;
-
-	snd_assert(chip != NULL && chip->card != NULL, return -EINVAL);
-
-	card = chip->card;
-
-	strcpy(card->mixername, MIXER_NAME);
-
-	/* Registering alsa mixer controls */
-	for (idx = 0; idx < ARRAY_SIZE(snd_omap_controls); idx++) 
-		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_omap_controls[idx], chip))) < 0)
-			return err;
-
-	return 0;
-}


--------------020408040500070805090004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020408040500070805090004--
