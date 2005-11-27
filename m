From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Problem with ALSA in 2.6.14-omap2 on OSK
Date: Sun, 27 Nov 2005 18:46:19 +0100
Message-ID: <4389F0EB.6000404@de.bosch.com>
References: <520AB2AD990DC04082102F77CA17263801D40597@dlee03.ent.ti.com>
	<20051123164523.GC7547@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060307050207080907070601"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20051123164523.GC7547@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060307050207080907070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren wrote:
> * Menon, Nishanth <x0nishan@ti.com> [051123 08:37]:
> 
>>There is further the fix to L/R sync issue as reported by Ajaya Babu in
>>a previous mail in this list for the OSS - it might hit the ALSA too if
>>the condition is not met properly. 
> 
> 
> To me it sounds like Ajaya Babu's fix to stop mcbsp before dma is
> enabled probably fixes the remaining problems.
> 
> Does anybody have a tested patch for OSS and Alsa for that?

In the attachment a patch for Alsa as described by Ajaya Babu (hopefully
correct?). Unfortunately it seems to not fix the issues with repeated
audio parts while using Alsa.

Yves Godin wrote:
  > The files from the alsa driver have not changed between 2.6.14-rc1 and
  > 2.6.14-omap2. So I supposed the changes have been made to the OMAP dma
  > drivers.

Looks to me that it is something in DMA as well. I made some test with
rolling back DMA changes and seems to me that is something *before*

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=1ffea4734ff8b26784cb94ad77fe09151d6febb1 


Removing all changes in dma.c and dma.h including this patch shows the
broken audio output as well.

Dirk



--------------060307050207080907070601
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



--------------060307050207080907070601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060307050207080907070601--
