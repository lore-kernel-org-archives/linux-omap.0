From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] Re: Pending patches mostly pushed, please check
Date: Fri, 06 Jan 2006 20:37:41 +0100
Message-ID: <43BEC705.50002@de.bosch.com>
References: <43B10E92.4060203@de.bosch.com> <20051230222808.GJ4415@atomide.com>
	<20060103191356.GR6034@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030605030102010009000105"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060103191356.GR6034@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------030605030102010009000105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tony,

Tony Lindgren wrote:

>>12) ALSA Audio L/R Channel Interchanges fix
>>http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005971.html
>  
> Applied.

Can you check if this is really applied? Using most recent git I can
still apply it ;-)

There were two similiar patches: One for OSS (is applied, number 7 of
the list) and this one for ALSA.

Best regards

Dirk




--------------030605030102010009000105
Content-Type: text/plain;
 name="audio_alsa_LR.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audio_alsa_LR.patch"

--- ./sound/arm/omap-aic23.c_orig	2005-12-02 16:57:32.000000000 +0100
+++ ./sound/arm/omap-aic23.c	2005-12-18 18:17:51.360077016 +0100
@@ -34,6 +34,8 @@
  *
  * 2005-07-29   INdT Kernel Team - Alsa driver for omap osk. Creation of new 
  *                                 file omap-aic23.c
+ *
+ * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
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
--- ./sound/arm/omap-aic23.h_orig	2005-11-20 17:38:56.000000000 +0100
+++ ./sound/arm/omap-aic23.h	2005-12-18 18:17:51.362076712 +0100
@@ -33,7 +33,8 @@
  *  2005/07/25 INdT-10LE Kernel Team - 	Alsa driver for omap osk,
  *  					original version based in sa1100 driver
  *  					and omap oss driver.
- *  
+ *
+ *  2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
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
--- ./sound/arm/omap-alsa-dma.c_orig	2005-11-20 17:38:56.000000000 +0100
+++ ./sound/arm/omap-alsa-dma.c	2005-12-18 18:17:51.365076256 +0100
@@ -34,7 +34,9 @@
  * 2005-07-19	INdT Kernel Team - Alsa port. Creation of new file omap-alsa-dma.c based in
  * 				   omap-audio-dma-intfc.c oss file. Support for aic23 codec.
  * 				   Removal of buffer handling (Alsa does that), modifications
- * 				   in dma handling and port to alsa structures. 
+ * 				   in dma handling and port to alsa structures.
+ *
+ * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
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




--------------030605030102010009000105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030605030102010009000105--
