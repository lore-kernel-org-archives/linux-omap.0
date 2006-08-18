From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 1/5] Change all omap15xx devices to use similar DMA handling
 than h6300 uses.
Date: Fri, 18 Aug 2006 04:14:35 +0300
Message-ID: <44E5147B.3020006@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010200010107020905080407"
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
--------------010200010107020905080407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Change all omap15xx devices to use similar DMA handling than h6300 uses.
Thanks for the James Selvam for verifying this with omap 1510 innovator.
http://linux.omap.com/pipermail/linux-omap-open-source/2006-May/007256.html

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>



--------------010200010107020905080407
Content-Type: text/x-patch;
	name*0="0001-change-all-omap15xx-devices-to-use-similar-DMA-handling-tha";
	name*1="t-h6300-uses.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-change-all-omap15xx-devices-to-use-similar-DMA-handling";
	filename*1="-that-h6300-uses.patch"

From: Mika Laitio <lamikr@cc.jyu.fi>
Date: Fri, 18 Aug 2006 01:47:42 +0300
Subject: [PATCH 1/5] change all omap15xx devices to use similar DMA handling than h6300 uses.

Change all omap15xx devices to use similar DMA handling than h6300 uses. Thanks for the James Selvam for verifying this with omap 1510 innovator. http://linux.omap.com/pipermail/linux-omap-open-source/2006-May/007256.html

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>

---
 sound/arm/omap/omap-alsa.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/arm/omap/omap-alsa.c b/sound/arm/omap/omap-alsa.c
index 328003b..583460c 100644
--- a/sound/arm/omap/omap-alsa.c
+++ b/sound/arm/omap/omap-alsa.c
@@ -190,9 +190,7 @@ static void audio_process_dma(struct aud
 	unsigned int dma_size;
 	unsigned int offset;
 	int ret;
-#ifdef CONFIG_MACH_OMAP_H6300
 	unsigned long flags;
-#endif
 	
 	ADEBUG();
 	runtime = substream->runtime;
@@ -200,14 +198,20 @@ #endif
 		dma_size = frames_to_bytes(runtime, runtime->period_size);
 		offset = dma_size * s->period;
 		snd_assert(dma_size <= DMA_BUF_SIZE,);
-#ifdef CONFIG_MACH_OMAP_H6300
-		spin_lock_irqsave(&s->dma_lock, flags);
-		omap_stop_alsa_sound_dma(s);
-		spin_unlock_irqrestore(&s->dma_lock, flags);
-#endif
+		/*
+		 * On omap1510 based devices, we need to call the stop_dma
+		 * before calling the start_dma or we will not receive the
+		 * irq from DMA after the first transfered/played buffer.
+		 * (invocation of callback_omap_alsa_sound_dma() method).
+		 */
+		if (cpu_is_omap15xx()) {
+			spin_lock_irqsave(&s->dma_lock, flags);
+			omap_stop_alsa_sound_dma(s);
+			spin_unlock_irqrestore(&s->dma_lock, flags);
+		}
 		ret = omap_start_alsa_sound_dma(s,
-					 (dma_addr_t) runtime->dma_area +
-					 offset, dma_size);
+				(dma_addr_t)runtime->dma_area + offset,
+				dma_size);
 		if (ret) {
 			printk(KERN_ERR
 			       "audio_process_dma: cannot queue DMA buffer (%i)\n",
-- 
1.4.2


--------------010200010107020905080407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010200010107020905080407--
