From: Dirk Behme <dirk.behme@googlemail.com>
Subject: OMAP1 realtime patch patch-2.6.23-rt1-omap1
Date: Fri, 12 Oct 2007 17:03:24 +0200
Message-ID: <470F8CBC.7030104@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080105060401020900000208"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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
--------------080105060401020900000208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Update of OMAP1 realtime patch to most recent -rt patch patch-2.6.23-rt1.

As ususal, use recent OMAP git (2.6.23-omap1) as starting point, then
apply patch-2.6.23-rt1 [1] ignoring conflicts, and on top of this
patch in attachment.

Cheers,

Dirk

[1] http://www.kernel.org/pub/linux/kernel/projects/rt/


--------------080105060401020900000208
Content-Type: text/plain;
 name="patch-2.6.23-rt1-omap1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.23-rt1-omap1"

Index: linux-osk/kernel/irq/manage.c
===================================================================
--- linux-osk.orig/kernel/irq/manage.c
+++ linux-osk/kernel/irq/manage.c
@@ -637,6 +637,7 @@ static void thread_simple_irq(irq_desc_t
 	unsigned int irq = desc - irq_desc;
 	irqreturn_t action_ret;
 
+	restart:
 	if (action && !desc->depth) {
 		spin_unlock(&desc->lock);
 		action_ret = handle_IRQ_event(irq, action);
@@ -645,6 +646,19 @@ static void thread_simple_irq(irq_desc_t
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret);
 	}
+
+	/*
+	 * Some boards will disable an interrupt when it
+	 * sets IRQ_PENDING . So we have to remove the flag
+	 * and re-enable to handle it.
+	 */
+	if (desc->status & IRQ_PENDING) {
+		desc->status &= ~IRQ_PENDING;
+		if (desc->chip)
+			desc->chip->enable(irq);
+		goto restart;
+	}
+
 	desc->status &= ~IRQ_INPROGRESS;
 }
 
Index: linux-osk/sound/arm/omap/omap-alsa.c
===================================================================
--- linux-osk.orig/sound/arm/omap/omap-alsa.c
+++ linux-osk/sound/arm/omap/omap-alsa.c
@@ -165,10 +165,8 @@ static u_int audio_get_dma_pos(struct au
  */
 static void audio_stop_dma(struct audio_stream *s)
 {
-	unsigned long flags;
 	ADEBUG();
 
-	spin_lock_irqsave(&s->dma_lock, flags);
 	s->active = 0;
 	s->period = 0;
 	s->periods = 0;
@@ -177,8 +175,6 @@ static void audio_stop_dma(struct audio_
 	omap_stop_alsa_sound_dma(s);
 
 	omap_clear_alsa_sound_dma(s);
-
-	spin_unlock_irqrestore(&s->dma_lock, flags);
 }
 
 /*
Index: linux-osk/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/gpio.c
+++ linux-osk/arch/arm/plat-omap/gpio.c
@@ -150,7 +150,7 @@ struct gpio_bank {
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
 #endif
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 #define METHOD_MPUIO		0


--------------080105060401020900000208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080105060401020900000208--
