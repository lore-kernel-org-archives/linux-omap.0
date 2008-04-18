From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 06/19] Code clean-up for sound/arm/omap/omap-alsa-dma.c
Date: Fri, 18 Apr 2008 04:00:53 -0400
Message-ID: <1208505666-13744-7-git-send-email-edubezval@gmail.com>
References: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
 <1208505666-13744-2-git-send-email-edubezval@gmail.com>
 <1208505666-13744-3-git-send-email-edubezval@gmail.com>
 <1208505666-13744-4-git-send-email-edubezval@gmail.com>
 <1208505666-13744-5-git-send-email-edubezval@gmail.com>
 <1208505666-13744-6-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18794 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472AbYDRIBW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:22 -0400
In-Reply-To: <1208505666-13744-6-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-dma.c |  171 +++++++++++++++++++--------------------
 1 files changed, 83 insertions(+), 88 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-dma.c b/sound/arm/omap/omap-alsa-dma.c
index 00359cb..3f9ff68 100644
--- a/sound/arm/omap/omap-alsa-dma.c
+++ b/sound/arm/omap/omap-alsa-dma.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
  *
  * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * 
+ *
  * Copyright (C) 2004 Texas Instruments, Inc.
  *
  * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
@@ -21,24 +21,30 @@
  *
  * History:
  *
- * 2004-06-07	Sriram Kannan	- Created new file from omap_audio_dma_intfc.c. This file
- * 				  will contain only the DMA interface and buffer handling of OMAP
- * 				  audio driver.
+ * 2004-06-07	Sriram Kannan	- Created new file from omap_audio_dma_intfc.c.
+ * 				This file will contain only the DMA interface
+ * 				and buffer handling of OMAP audio driver.
+ *
+ * 2004-06-22	Sriram Kannan	- removed legacy code (auto-init). Self-linking
+ * 				of DMA logical channel.
  *
- * 2004-06-22	Sriram Kannan	- removed legacy code (auto-init). Self-linking of DMA logical channel.
+ * 2004-08-12   Nishanth Menon  - Modified to integrate Audio requirements on
+ * 				1610, 1710 platforms
  *
- * 2004-08-12   Nishanth Menon  - Modified to integrate Audio requirements on 1610,1710 platforms
+ * 2004-11-01   Nishanth Menon  - 16xx platform code base modified to support
+ * 				multi channel chaining.
  *
- * 2004-11-01   Nishanth Menon  - 16xx platform code base modified to support multi channel chaining.
+ * 2004-12-15   Nishanth Menon  - Improved 16xx platform channel logic
+ * 				introduced - tasklets, queue handling updated
  *
- * 2004-12-15   Nishanth Menon  - Improved 16xx platform channel logic introduced - tasklets, queue handling updated
- * 
- * 2005-07-19	INdT Kernel Team - Alsa port. Creation of new file omap-alsa-dma.c based in
- * 				   omap-audio-dma-intfc.c oss file. Support for aic23 codec.
- * 				   Removal of buffer handling (Alsa does that), modifications
- *	in dma handling and port to alsa structures.
+ * 2005-07-19	INdT Kernel Team - Alsa port. Creation of new file
+ * 				omap-alsa-dma.c based in omap-audio-dma-intfc.c
+ * 				oss file. Support for aic23 codec. Removal of
+ * 				buffer handling (Alsa does that), modifications
+ * 				in dma handling and port to alsa structures.
  *
- * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed by Ajaya Babu
+ * 2005-12-18   Dirk Behme      - Added L/R Channel Interchange fix as proposed
+ * 				by Ajaya Babu
  */
 
 #include <linux/module.h>
@@ -56,24 +62,21 @@
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
 
-#include <asm/uaccess.h>
-#include <asm/io.h>
 #include <asm/hardware.h>
 #include <asm/semaphore.h>
-
 #include <asm/arch/dma.h>
-#include "omap-alsa-dma.h"
-
 #include <asm/arch/mcbsp.h>
-
 #include <asm/arch/omap-alsa.h>
 
-#undef DEBUG
+#include "omap-alsa-dma.h"
 
-#define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
+#undef DEBUG
 
-/* Channel Queue Handling macros
+/*
+ * Channel Queue Handling macros
  * tail always points to the current free entry
  * Head always points to the current entry being used
  * end is either head or tail
@@ -83,13 +86,21 @@
 #define AUDIO_QUEUE_FULL(s) (nr_linked_channels == s->dma_q_count)
 #define AUDIO_QUEUE_LAST(s) (1 == s->dma_q_count)
 #define AUDIO_QUEUE_EMPTY(s) (0 == s->dma_q_count)
-#define __AUDIO_INCREMENT_QUEUE(end) ((end)=((end)+1) % nr_linked_channels)
-#define AUDIO_INCREMENT_HEAD(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_head); s->dma_q_count--;
-#define AUDIO_INCREMENT_TAIL(s) __AUDIO_INCREMENT_QUEUE(s->dma_q_tail); s->dma_q_count++;
+#define __AUDIO_INCREMENT_QUEUE(end) ((end) = ((end)+1) % nr_linked_channels)
+#define AUDIO_INCREMENT_HEAD(s) 			\
+	do {						\
+		__AUDIO_INCREMENT_QUEUE(s->dma_q_head);	\
+		s->dma_q_count--;			\
+	} while (0)
+#define AUDIO_INCREMENT_TAIL(s)				\
+	do {						\
+		__AUDIO_INCREMENT_QUEUE(s->dma_q_tail);	\
+		s->dma_q_count++;			\
+	} while (0)
 
 /* DMA buffer fragmentation sizes */
 #define MAX_DMA_SIZE		 0x1000000 /* todo: sync with alsa */
-//#define CUT_DMA_SIZE		 0x1000
+/* #define CUT_DMA_SIZE		 0x1000 */
 /* TODO: To be moved to more appropriate location */
 #define DCSR_ERROR           0x3
 #define DCSR_END_BLOCK       (1 << 5)
@@ -100,7 +111,7 @@
 #define DCCR_EN              (1 << 7)
 #define DCCR_AI              (1 << 8)
 #define DCCR_REPEAT          (1 << 9)
-/* if 0 the channel works in 3.1 compatible mode*/
+/* if 0 the channel works in 3.1 compatible mode */
 #define DCCR_N31COMP         (1 << 10)
 #define DCCR_EP              (1 << 11)
 #define DCCR_SRC_AMODE_BIT   12
@@ -112,26 +123,22 @@
 #define AMODE_SINGLE_INDEX   0x2
 #define AMODE_DOUBLE_INDEX   0x3
 
-/**************************** DATA STRUCTURES *****************************************/
-
-static spinlock_t dma_list_lock = SPIN_LOCK_UNLOCKED;
-
+/* Data structures */
+DEFINE_SPINLOCK(dma_list_lock);
 static char nr_linked_channels = 1;
 
-/*********************************** MODULE SPECIFIC FUNCTIONS ***********************/
+/* Module specific functions */
 
 static void sound_dma_irq_handler(int lch, u16 ch_status, void *data);
 static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
 				     u_int dma_size);
 static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
 					u_int dma_size);
-static int audio_start_dma_chain(struct audio_stream * s);
+static int audio_start_dma_chain(struct audio_stream *s);
 
-/***************************************************************************************
- *
+/*
  * DMA channel requests
- *
- **************************************************************************************/
+ */
 static void omap_sound_dma_link_lch(void *data)
 {
 
@@ -166,8 +173,7 @@ int omap_request_alsa_sound_dma(int device_id, const char *device_name,
 		return -EPERM;
 	}
 	/* Try allocate memory for the num channels */
-	*channels =
-	    (int *) kmalloc(sizeof(int) * nr_linked_channels, GFP_KERNEL);
+	*channels = kmalloc(sizeof(int) * nr_linked_channels, GFP_KERNEL);
 	chan = *channels;
 	if (NULL == chan) {
 		ERR("No Memory for channel allocs!\n");
@@ -176,18 +182,19 @@ int omap_request_alsa_sound_dma(int device_id, const char *device_name,
 	}
 	spin_lock(&dma_list_lock);
 	for (i = 0; i < nr_linked_channels; i++) {
-		err = omap_request_dma(device_id, 
+		err = omap_request_dma(device_id,
 				device_name,
-				sound_dma_irq_handler, 
+				sound_dma_irq_handler,
 				data,
 				&chan[i]);
 
 		/* Handle Failure condition here */
 		if (err < 0) {
 			int j;
-			for (j = 0; j < i; j++) {
+
+			for (j = 0; j < i; j++)
 				omap_free_dma(chan[j]);
-			}
+
 			spin_unlock(&dma_list_lock);
 			kfree(chan);
 			*channels = NULL;
@@ -206,12 +213,11 @@ int omap_request_alsa_sound_dma(int device_id, const char *device_name,
 	FN_OUT(0);
 	return 0;
 }
+EXPORT_SYMBOL(omap_request_alsa_sound_dma);
 
-/***************************************************************************************
- *
+/*
  * DMA channel requests Freeing
- *
- **************************************************************************************/
+ */
 static void omap_sound_dma_unlink_lch(void *data)
 {
 	struct audio_stream *s = (struct audio_stream *)data;
@@ -238,7 +244,7 @@ int omap_free_alsa_sound_dma(void *data, int **channels)
 {
 	int i;
 	int *chan = NULL;
-	
+
 	FN_IN;
 	if (unlikely(NULL == channels)) {
 		BUG();
@@ -262,17 +268,16 @@ int omap_free_alsa_sound_dma(void *data, int **channels)
 	FN_OUT(0);
 	return 0;
 }
+EXPORT_SYMBOL(omap_free_alsa_sound_dma);
 
-/***************************************************************************************
- *
+/*
  * Stop all the DMA channels of the stream
- *
- **************************************************************************************/
+ */
 void omap_stop_alsa_sound_dma(struct audio_stream *s)
 {
 	int *chan = s->lch;
 	int i;
-	
+
 	FN_IN;
 	if (unlikely(NULL == chan)) {
 		BUG();
@@ -286,31 +291,30 @@ void omap_stop_alsa_sound_dma(struct audio_stream *s)
 	FN_OUT(0);
 	return;
 }
-/***************************************************************************************
- *
+EXPORT_SYMBOL(omap_stop_alsa_sound_dma);
+
+/*
  * Clear any pending transfers
- *
- **************************************************************************************/
-void omap_clear_alsa_sound_dma(struct audio_stream * s)
+ */
+void omap_clear_alsa_sound_dma(struct audio_stream *s)
 {
 	FN_IN;
 	omap_clear_dma(s->lch[s->dma_q_head]);
 	FN_OUT(0);
 	return;
 }
+EXPORT_SYMBOL(omap_clear_alsa_sound_dma);
 
-/***************************************************************************************
- *
+/*
  * DMA related functions
- *
- **************************************************************************************/
+ */
 static int audio_set_dma_params_play(int channel, dma_addr_t dma_ptr,
 				     u_int dma_size)
 {
 	int dt = 0x1;		/* data type 16 */
 	int cen = 32;		/* Stereo */
 	int cfn = dma_size / (2 * cen);
-	
+
 	FN_IN;
 	omap_set_dma_dest_params(channel, 0x05, 0x00,
 				 (OMAP1510_MCBSP1_BASE + 0x06),
@@ -328,7 +332,7 @@ static int audio_set_dma_params_capture(int channel, dma_addr_t dma_ptr,
 	int dt = 0x1;		/* data type 16 */
 	int cen = 32;		/* stereo */
 	int cfn = dma_size / (2 * cen);
-	
+
 	FN_IN;
 	omap_set_dma_src_params(channel, 0x05, 0x00,
 				(OMAP1510_MCBSP1_BASE + 0x02),
@@ -344,7 +348,7 @@ static int audio_start_dma_chain(struct audio_stream *s)
 	int channel = s->lch[s->dma_q_head];
 	FN_IN;
 	if (!s->started) {
-	 	s->hw_stop();	   /* stops McBSP Interface */
+		s->hw_stop();	   /* stops McBSP Interface */
 		omap_start_dma(channel);
 		s->started = 1;
 		s->hw_start();	   /* start McBSP interface */
@@ -355,12 +359,13 @@ static int audio_start_dma_chain(struct audio_stream *s)
 	return 0;
 }
 
-/* Start DMA -
+/*
+ * Start DMA -
  * Do the initial set of work to initialize all the channels as required.
  * We shall then initate a transfer
  */
-int omap_start_alsa_sound_dma(struct audio_stream *s, 
-			dma_addr_t dma_ptr, 
+int omap_start_alsa_sound_dma(struct audio_stream *s,
+			dma_addr_t dma_ptr,
 			u_int dma_size)
 {
 	int ret = -EPERM;
@@ -372,13 +377,9 @@ int omap_start_alsa_sound_dma(struct audio_stream *s,
 		    MAX_DMA_SIZE);
 		return -EOVERFLOW;
 	}
-	//if (AUDIO_QUEUE_FULL(s)) {
-	//      ret = -2;
-	//      goto sound_out;
-	//}
 
 	if (s->stream_id == SNDRV_PCM_STREAM_PLAYBACK) {
-		/*playback */
+		/* playback */
 		ret =
 		    audio_set_dma_params_play(s->lch[s->dma_q_tail],
 					      dma_ptr, dma_size);
@@ -393,17 +394,18 @@ int omap_start_alsa_sound_dma(struct audio_stream *s,
 	}
 	AUDIO_INCREMENT_TAIL(s);
 	ret = audio_start_dma_chain(s);
-	if (ret) {
+	if (ret)
 		ERR("dma start failed");
-	}
-      sound_out:
+
+sound_out:
 	FN_OUT(ret);
 	return ret;
 
 }
+EXPORT_SYMBOL(omap_start_alsa_sound_dma);
 
-/* 
- * ISRs have to be short and smart.. 
+/*
+ * ISRs have to be short and smart..
  * Here we call alsa handling, after some error checking
  */
 static void sound_dma_irq_handler(int sound_curr_lch, u16 ch_status,
@@ -413,9 +415,7 @@ static void sound_dma_irq_handler(int sound_curr_lch, u16 ch_status,
 	struct audio_stream *s = (struct audio_stream *) data;
 	FN_IN;
 
-	/*
-	 * some register checkings
-	 */ 
+	/* some register checking */
 	DPRINTK("lch=%d,status=0x%x, dma_status=%d, data=%p\n",
 		sound_curr_lch, ch_status, dma_status, data);
 
@@ -426,7 +426,7 @@ static void sound_dma_irq_handler(int sound_curr_lch, u16 ch_status,
 		return;
 	}
 
-	if (ch_status & DCSR_END_BLOCK) 
+	if (ch_status & DCSR_END_BLOCK)
 		callback_omap_alsa_sound_dma(s);
 	FN_OUT(0);
 	return;
@@ -436,8 +436,3 @@ MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("Common DMA handling for Audio driver on OMAP processors");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(omap_start_alsa_sound_dma);
-EXPORT_SYMBOL(omap_clear_alsa_sound_dma);
-EXPORT_SYMBOL(omap_request_alsa_sound_dma);
-EXPORT_SYMBOL(omap_free_alsa_sound_dma);
-EXPORT_SYMBOL(omap_stop_alsa_sound_dma);
-- 
1.5.5-rc3.GIT

