From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in timer32k.c
Date: Fri, 22 Dec 2006 11:07:53 +0100
Message-ID: <458BAE79.7020703@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040104010605090807040801"
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
--------------040104010605090807040801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix warning in timer32k.c if CONFIG_NO_IDLE_HZ
isn't set:

arch/arm/plat-omap/timer32k.c:221: warning:
'omap_32k_timer_handler' defined but not used

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------040104010605090807040801
Content-Type: text/plain;
 name="omap_32k_timer_handler_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="omap_32k_timer_handler_warning_patch.txt"

Index: linux-osk/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/timer32k.c
+++ linux-osk/arch/arm/plat-omap/timer32k.c
@@ -217,6 +217,18 @@ static inline irqreturn_t _omap_32k_time
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	_omap_32k_timer_interrupt(irq, dev_id);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_NO_IDLE_HZ
 static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
 {
 	unsigned long now;
@@ -233,18 +245,6 @@ static irqreturn_t omap_32k_timer_handle
 	return _omap_32k_timer_interrupt(irq, dev_id);
 }
 
-static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
-{
-	unsigned long flags;
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-	_omap_32k_timer_interrupt(irq, dev_id);
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-
-	return IRQ_HANDLED;
-}
-
-#ifdef CONFIG_NO_IDLE_HZ
 /*
  * Programs the next timer interrupt needed. Called when dynamic tick is
  * enabled, and to reprogram the ticks to skip from pm_idle. Note that



--------------040104010605090807040801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040104010605090807040801--
