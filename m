From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] OSS Audio L/R Channel Interchanges fix
Date: Sat, 10 Dec 2005 18:28:27 +0100
Message-ID: <439B103B.1060509@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090902060406040905040308"
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
--------------090902060406040905040308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: OSS L/R Channel Interchange fix as proposed by
             Ajaya Babu Anne <anneajaya_at_gmail.com>

Signed-off-by: Dirk Behme <dirk.behme_at_de.bosch.com>




--------------090902060406040905040308
Content-Type: text/plain;
 name="audio_oss_LR.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audio_oss_LR.patch"

--- ./sound/oss/omap-audio-dma-intfc.c_orig	2005-12-10 18:03:21.686775384 +0100
+++ ./sound/oss/omap-audio-dma-intfc.c	2005-12-10 18:04:35.904492576 +0100
@@ -28,6 +28,8 @@
  * 2004-11-01   Nishanth Menon  - 16xx platform code base modified to support multi channel chaining.
  *
  * 2004-12-15   Nishanth Menon  - Improved 16xx platform channel logic introduced - tasklets, queue handling updated
+ *
+ * 2005-12-10   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
  */
 
 #include <linux/config.h>
@@ -730,8 +732,10 @@ static int audio_start_dma_chain(audio_s
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
--- ./sound/oss/omap-audio-aic23.c_orig	2005-12-10 17:55:27.471867008 +0100
+++ ./sound/oss/omap-audio-aic23.c	2005-12-10 18:02:33.822051928 +0100
@@ -111,16 +111,35 @@
 
 #define NUMBER_SAMPLE_RATES_SUPPORTED 9
 
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
 static audio_stream_t output_stream = {
         .id              = "AIC23 out",
         .dma_dev         = OMAP_DMA_MCBSP1_TX,
-        .input_or_output = FMODE_WRITE
+        .input_or_output = FMODE_WRITE,
+        .hw_start        = audio_ifc_start,
+        .hw_stop         = audio_ifc_stop
 };
 
 static audio_stream_t input_stream = {
         .id              = "AIC23 in",
         .dma_dev         = OMAP_DMA_MCBSP1_RX,
-        .input_or_output = FMODE_READ
+        .input_or_output = FMODE_READ,
+        .hw_start        = audio_ifc_start,
+        .hw_stop         = audio_ifc_stop
 };
 
 static struct clk *aic23_mclk = 0;
--- ./sound/oss/omap-audio.h_orig	2005-12-10 17:55:49.571507352 +0100
+++ ./sound/oss/omap-audio.h	2005-12-10 17:57:47.124636560 +0100
@@ -20,6 +20,8 @@
  *  2004/08/12 Nishanth Menon - Modified to integrate Audio requirements on 1610,1710 platforms
  *
  *  2004/04/04 Nishanth menon - Added hooks for power management
+ *
+ *  2005/12/10 Dirk Behme     - Added L/R Channel Interchange fix as proposed by Ajaya Babu
  */
 
 #ifndef __OMAP_AUDIO_H
@@ -75,6 +77,8 @@ typedef struct {
 	unsigned stopped:1;	/* might be active but stopped */
 	unsigned spin_idle:1;	/* have DMA spin on zeros when idle */
 	unsigned linked:1;	/* dma channels linked */
+        int (*hw_start)(void);  /* interface to start HW interface, e.g. McBSP */
+        int (*hw_stop)(void);   /* interface to stop HW interface, e.g. McBSP */
 } audio_stream_t;
 
 /*


--------------090902060406040905040308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090902060406040905040308--
