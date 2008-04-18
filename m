From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 02/19] Code clean-up for include/asm-arm/arch-omap/omap-alsa.h
Date: Fri, 18 Apr 2008 04:00:49 -0400
Message-ID: <1208505666-13744-3-git-send-email-edubezval@gmail.com>
References: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
 <1208505666-13744-2-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18783 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250AbYDRIBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:20 -0400
In-Reply-To: <1208505666-13744-2-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 include/asm-arm/arch-omap/omap-alsa.h |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/asm-arm/arch-omap/omap-alsa.h b/include/asm-arm/arch-omap/omap-alsa.h
index 0f8a7d3..9eaa7f2 100644
--- a/include/asm-arm/arch-omap/omap-alsa.h
+++ b/include/asm-arm/arch-omap/omap-alsa.h
@@ -49,15 +49,23 @@
  * Debug functions
  */
 #undef DEBUG
-//#define DEBUG
+/* #define DEBUG */
 
-#define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
+#define ERR(ARGS...)						\
+	do {							\
+		printk(KERN_ERR "{%s}-ERROR: ", __func__);	\
+		printk(ARGS);					\
+	} while (0)
 
 #ifdef DEBUG
-#define DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
-#define ADEBUG() printk("XXX Alsa debug f:%s, l:%d\n", __FUNCTION__, __LINE__)
-#define FN_IN printk(KERN_INFO "[%s]: start\n", __FUNCTION__)
-#define FN_OUT(n) printk(KERN_INFO "[%s]: end(%u)\n",__FUNCTION__, n)
+#define DPRINTK(ARGS...)					\
+	do {							\
+		printk(KERN_INFO "<%s>: ", __func__);		\
+		printk(ARGS);					\
+	} while (0)
+#define ADEBUG() printk("XXX Alsa debug f:%s, l:%d\n", __func__, __LINE__)
+#define FN_IN printk(KERN_INFO "[%s]: start\n", __func__)
+#define FN_OUT(n) printk(KERN_INFO "[%s]: end(%u)\n", __func__, n)
 #else
 #define DPRINTK(ARGS...)	/* nop */
 #define ADEBUG()		/* nop */
@@ -81,12 +89,12 @@ struct audio_stream {
 	char dma_q_count;	/* DMA Channel Q Count */
 	int active:1;		/* we are using this stream for transfer now */
 	int period;		/* current transfer period */
-	int periods;		/* current count of periods registerd in the DMA engine */
+	int periods;		/* current registered periods in DMA engine */
 	spinlock_t dma_lock;	/* for locking in DMA operations */
 	struct snd_pcm_substream *stream;	/* the pcm stream */
 	unsigned linked:1;	/* dma channels linked */
-	int offset;		/* store start position of the last period in the alsa buffer */
-	int (*hw_start)(void);  /* interface to start HW interface, e.g. McBSP */
+	int offset;		/* start position of last period in alsa buf */
+	int (*hw_start)(void);  /* interface to start HW interface, (McBSP) */
 	int (*hw_stop)(void);   /* interface to stop HW interface, e.g. McBSP */
 };
 
@@ -127,7 +135,8 @@ void snd_omap_suspend_mixer(void);
 void snd_omap_resume_mixer(void);
 #endif
 
-int snd_omap_alsa_post_probe(struct platform_device *pdev, struct omap_alsa_codec_config *config);
+int snd_omap_alsa_post_probe(struct platform_device *pdev,
+				struct omap_alsa_codec_config *config);
 int snd_omap_alsa_remove(struct platform_device *pdev);
 #ifdef CONFIG_PM
 int snd_omap_alsa_suspend(struct platform_device *pdev, pm_message_t state);
-- 
1.5.5-rc3.GIT

