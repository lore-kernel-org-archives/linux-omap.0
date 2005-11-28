From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Problem with ALSA in 2.6.14-omap2 on OSK
Date: Mon, 28 Nov 2005 10:55:40 +0100
Message-ID: <438AD41C.4090006@de.bosch.com>
References: <520AB2AD990DC04082102F77CA17263801D40597@dlee03.ent.ti.com>
	<20051123164523.GC7547@atomide.com> <4389F0EB.6000404@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000100010302020909020201"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4389F0EB.6000404@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000100010302020909020201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dirk Behme wrote:
> Yves Godin wrote:
>  > The files from the alsa driver have not changed between 2.6.14-rc1 and
>  > 2.6.14-omap2. So I supposed the changes have been made to the OMAP dma
>  > drivers.
> 
> Looks to me that it is something in DMA as well.

Next step ;) Looking into sound/oss/omap-audio-dma-intfc.c I found that
there is done much more stuff than in sound/arm/omap-alsa-dma.c. So, I
put the ping pong work item logic from OSS DMA to ALSA DMA as well. And
looks like this fixes the issue of repeated audio samples :)

Please test. I use 'madplay foo.mp3' for tests.

But unfortunately, now there seems to be some noise over the (now
unrepeated) audio output.

Any ideas about that?

Note: For tests, first apply alsa_dma.patch, which includes Ajaya Babu
L/R fix (reposted here, same as in the last mail), then apply
alsa_fix_repeat.patch.

Many thanks

Dirk



--------------000100010302020909020201
Content-Type: text/plain;
 name="alsa_dma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_dma.patch"

--- ./sound/arm/omap-aic23.c_orig	2005-11-25 20:24:14.782887816 +0100
+++ ./sound/arm/omap-aic23.c	2005-11-25 20:42:10.552346000 +0100
@@ -34,6 +34,8 @@
  *
  * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk. Creation of new 
  *                                 file omap-aic23.c
+ *
+ * 2005-11-25   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
  */
 
 #include <linux/config.h>
@@ -156,6 +158,20 @@ static snd_pcm_hw_constraint_list_t hw_c
 	.mask = 0,
 };
 
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
 
 /*
  * Codec/mcbsp init and configuration section
@@ -243,12 +259,20 @@ static void omap_aic23_audio_init(struct
 	    SNDRV_PCM_STREAM_PLAYBACK;
 	omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK].dma_dev =
 	    OMAP_DMA_MCBSP1_TX;
+	omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK].hw_start =
+	    audio_ifc_start;
+	omap_aic23->s[SNDRV_PCM_STREAM_PLAYBACK].hw_stop =
+	    audio_ifc_stop;
 
 	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].id = "Alsa AIC23 in";
 	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].stream_id =
 	    SNDRV_PCM_STREAM_CAPTURE;
 	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].dma_dev =
 	    OMAP_DMA_MCBSP1_RX;
+	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].hw_start =
+	    audio_ifc_start;
+	omap_aic23->s[SNDRV_PCM_STREAM_CAPTURE].hw_stop =
+	    audio_ifc_stop;
 
 	/* configuring the McBSP */
 	omap_mcbsp_request(AUDIO_MCBSP);
--- ./sound/arm/omap-aic23.h_orig	2005-11-25 20:28:02.368289576 +0100
+++ ./sound/arm/omap-aic23.h	2005-11-25 20:38:02.210099760 +0100
@@ -33,7 +33,8 @@
  *  2005/07/25 INdT-10LE Kernel Team - 	Alsa driver for omap osk,
  *  					original version based in sa1100 driver
  *  					and omap oss driver.
- *  
+ *
+ *  2005-11-25   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
  */
 
 #ifndef __OMAP_AIC23_H
@@ -85,6 +86,8 @@ struct audio_stream {
 	snd_pcm_substream_t *stream;	/* the pcm stream */
 	unsigned linked:1;	/* dma channels linked */
 	int offset;		/* store start position of the last period in the alsa buffer */
+        int (*hw_start)(void);  /* interface to start HW interface, e.g. McBSP */
+        int (*hw_stop)(void);   /* interface to stop HW interface, e.g. McBSP */
 };
 
 /*
--- ./sound/arm/omap-alsa-dma.c_orig	2005-11-24 17:13:48.000000000 +0100
+++ ./sound/arm/omap-alsa-dma.c	2005-11-25 20:46:58.328597360 +0100
@@ -34,7 +34,9 @@
  * 2005-07-19	INdT Kernel Team - Alsa port. Creation of new file omap-alsa-dma.c based in
  * 				   omap-audio-dma-intfc.c oss file. Support for aic23 codec.
  * 				   Removal of buffer handling (Alsa does that), modifications
- * 				   in dma handling and port to alsa structures. 
+ * 				   in dma handling and port to alsa structures.
+ *
+ * 2005-11-25   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
  */
 
 #include <linux/config.h>
@@ -356,8 +358,10 @@ static int audio_start_dma_chain(struct 
 	int channel = s->lch[s->dma_q_head];
 	FN_IN;
 	if (!s->started) {
+	        s->hw_stop();            /* stops McBSP Interface */ 
 		omap_start_dma(channel);
 		s->started = 1;
+		s->hw_start();           /* start McBSP interface */ 
 	}
 	/* else the dma itself will progress forward with out our help */
 	FN_OUT(0);


--------------000100010302020909020201
Content-Type: text/plain;
 name="alsa_fix_repeat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_fix_repeat.patch"

--- ./sound/arm/omap-alsa-dma.c_orig	2005-11-28 09:58:01.601413144 +0100
+++ ./sound/arm/omap-alsa-dma.c	2005-11-28 10:41:38.272618656 +0100
@@ -37,6 +37,8 @@
  * 				   in dma handling and port to alsa structures.
  *
  * 2005-11-25   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
+ *
+ * 2005-11-28   Dirk Behme      - Fix DMA issues that all 5-10s a short audio part is repeated
  */
 
 #include <linux/config.h>
@@ -55,6 +57,7 @@
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/completion.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -126,7 +129,23 @@
 
 static spinlock_t dma_list_lock = SPIN_LOCK_UNLOCKED;
 
+struct audio_isr_work_item {
+	int current_lch;
+	u16 ch_status;
+	struct audio_stream *s;
+};
+
+static char work_item_running = 0;
 static char nr_linked_channels = 1;
+static struct audio_isr_work_item work1, work2;
+
+/*********************************** MODULE SPECIFIC FUNCTIONS PROTOTYPES *************/
+
+static void audio_dsr_handler(unsigned long);
+static DECLARE_TASKLET(audio_isr_work1, audio_dsr_handler,
+		(unsigned long)&work1);
+static DECLARE_TASKLET(audio_isr_work2, audio_dsr_handler,
+		(unsigned long)&work2);
 
 /*********************************** MODULE SPECIFIC FUNCTIONS ***********************/
 
@@ -414,6 +433,33 @@ int omap_start_sound_dma(struct audio_st
 
 }
 
+/***************************************************************************************
+ *
+ * ISR related functions
+ *
+ **************************************************************************************/
+/* The work item handler */
+static void audio_dsr_handler(unsigned long inData)
+{
+	void *data = (void *)inData;
+	struct audio_isr_work_item *work = data;
+	struct audio_stream *s = (work->s);
+
+	FN_IN;
+	DPRINTK("lch=%d,status=0x%x, data=%p as=%p\n", sound_curr_lch,
+		ch_status, data, s);
+	if (AUDIO_QUEUE_EMPTY(s)) {
+		FN_OUT(-1);
+		return;
+	}
+
+	AUDIO_INCREMENT_HEAD(s);	/* Empty the queue */
+
+	/* Try to fill again */
+	audio_dma_callback(s);
+	FN_OUT(0);
+}
+
 /* 
  * ISRs have to be short and smart.. 
  * Here we call alsa handling, after some error checking
@@ -438,8 +484,26 @@ static void sound_dma_irq_handler(int so
 		return;
 	}
 
-	if (ch_status & DCSR_END_BLOCK) 
-		audio_dma_callback(s);
+	if (AUDIO_QUEUE_LAST(s))
+		omap_audio_stop_dma(s);
+
+	/* Start the work item  - we ping pong the work items */
+	if (!work_item_running) {
+		work1.current_lch = sound_curr_lch;
+		work1.ch_status = ch_status;
+		work1.s = s;
+		/* schedule tasklet 1 */
+		tasklet_schedule(&audio_isr_work1);
+		work_item_running = 1;
+	} else {
+		work2.current_lch = sound_curr_lch;
+		work2.ch_status = ch_status;
+		work2.s = s;
+		/* schedule tasklet 2 */
+		tasklet_schedule(&audio_isr_work2);
+		work_item_running = 0;
+	}
+
 	FN_OUT(0);
 	return;
 }


--------------000100010302020909020201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000100010302020909020201--
