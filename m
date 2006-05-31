From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH] omap-alsa, force the dma to receive irqs on all omap15xx
 based devices.
Date: Wed, 31 May 2006 03:23:36 +0300
Message-ID: <447CE208.3060400@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000409010909010001090306"
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000409010909010001090306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

According to tests made by James Selvam, this patch is also needed in
other omap1510 based devices that with iPAQ h6300.
I suggest adding this patch unless someone finds out a bug in upper
level explaining the need for stopping the dma in every round to be able
to get the irq.

Mika

--------------000409010909010001090306
Content-Type: text/plain;
	name="omap-alsa-force-the-dma-to-receive-irqs-on-all-omap15xx-based-devices.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="omap-alsa-force-the-dma-to-receive-irqs-on-all-omap15xx-based-devices.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Mika Laitio <lamikr@cc.jyu.fi>
Date: Wed May 31 02:08:16 2006 +0300
Subject: [PATCH] omap-alsa, force the dma to receive irqs on all omap15xx based devices.

Signed-off-by: lamikr <lamikr@cc.jyu.fi>


---

 sound/arm/omap/omap-alsa.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

8dcab62d5f3e6cb4ba4f8d1b677d94694036e4ae
diff --git a/sound/arm/omap/omap-alsa.c b/sound/arm/omap/omap-alsa.c
index 328003b..5a68471 100644
--- a/sound/arm/omap/omap-alsa.c
+++ b/sound/arm/omap/omap-alsa.c
@@ -190,7 +190,7 @@ static void audio_process_dma(struct aud
 	unsigned int dma_size;
 	unsigned int offset;
 	int ret;
-#ifdef CONFIG_MACH_OMAP_H6300
+#ifdef CONFIG_ARCH_OMAP15XX
 	unsigned long flags;
 #endif
 	
@@ -200,7 +200,13 @@ static void audio_process_dma(struct aud
 		dma_size = frames_to_bytes(runtime, runtime->period_size);
 		offset = dma_size * s->period;
 		snd_assert(dma_size <= DMA_BUF_SIZE,);
-#ifdef CONFIG_MACH_OMAP_H6300
+#ifdef CONFIG_ARCH_OMAP15XX
+		/*
+		 * On omap1510 based devices, we need to call the stop_dma
+		 * before calling the start_dma or we will not receive the
+		 * irq from DMA after the first transfered/played buffer.
+		 * (invocation of callback_omap_alsa_sound_dma() method).
+		 */
 		spin_lock_irqsave(&s->dma_lock, flags);
 		omap_stop_alsa_sound_dma(s);
 		spin_unlock_irqrestore(&s->dma_lock, flags);
-- 
1.2.2


--------------000409010909010001090306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000409010909010001090306--
