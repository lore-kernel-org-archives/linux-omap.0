From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 2/5] Removed double spinlocking with omap15xx devices.
Date: Fri, 18 Aug 2006 04:15:03 +0300
Message-ID: <44E51497.3020600@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070705050603050702040208"
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
--------------070705050603050702040208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Removed double spinlocking with omap15xx devices. Thanks for the Jian
Zhang for reporting this one.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>



--------------070705050603050702040208
Content-Type: text/x-patch;
	name*0="0002-removed-double-spinlocking-with-omap15xx-devices.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0002-removed-double-spinlocking-with-omap15xx-devices.patch"

>From cc97975a2fad87878c9a1a2885b9c831df0c239a Mon Sep 17 00:00:00 2001
From: Mika Laitio <lamikr@cc.jyu.fi>
Date: Fri, 18 Aug 2006 01:56:59 +0300
Subject: [PATCH 2/5] removed double spinlocking with omap15xx devices.

Removed double spinlocking with omap15xx devices. Thanks for the Jian Zhang for reporting this one.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
---
 sound/arm/omap/omap-alsa.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/arm/omap/omap-alsa.c b/sound/arm/omap/omap-alsa.c
index 583460c..b74202f 100644
--- a/sound/arm/omap/omap-alsa.c
+++ b/sound/arm/omap/omap-alsa.c
@@ -190,7 +190,6 @@ static void audio_process_dma(struct aud
 	unsigned int dma_size;
 	unsigned int offset;
 	int ret;
-	unsigned long flags;
 	
 	ADEBUG();
 	runtime = substream->runtime;
@@ -205,9 +204,7 @@ static void audio_process_dma(struct aud
 		 * (invocation of callback_omap_alsa_sound_dma() method).
 		 */
 		if (cpu_is_omap15xx()) {
-			spin_lock_irqsave(&s->dma_lock, flags);
 			omap_stop_alsa_sound_dma(s);
-			spin_unlock_irqrestore(&s->dma_lock, flags);
 		}
 		ret = omap_start_alsa_sound_dma(s,
 				(dma_addr_t)runtime->dma_area + offset,
-- 
1.4.2


--------------070705050603050702040208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070705050603050702040208--
