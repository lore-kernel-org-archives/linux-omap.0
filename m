From: imre.deak@solidboot.com
Subject: [PATCH] ARM: OMAP: timer32k: fix tick count calculation when
	reprogramming
Date: Mon, 3 Jul 2006 18:51:55 +0300
Message-ID: <20060703155155.GA29815@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Reprogramming takes places before putting the CPU into idle mode if
the dynamic tick option is enabled. The timer is then set to expire
at the next pending timer event. Because some time has already passed
since the last reported jiffy we have to wait less than the time
specified in jiffies.

Also make sure we don't set a load value of 0 whose outcome is
unspecified according to the TRM.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>

--

diff --git a/arch/arm/plat-omap/timer32k.c b/arch/arm/plat-omap/timer32k.c
index 6ef5468..946b937 100644
--- a/arch/arm/plat-omap/timer32k.c
+++ b/arch/arm/plat-omap/timer32k.c
@@ -132,6 +132,8 @@ static inline unsigned long omap_32k_syn
 static inline void omap_32k_timer_start(unsigned long load_val)
 {
 	if (cpu_class_is_omap1()) {
+		if (!load_val)
+			load_val = 1;
 		omap_32k_timer_write(load_val, OMAP1_32K_TIMER_TVR);
 		omap_32k_timer_write(0x0f, OMAP1_32K_TIMER_CR);
 	}
@@ -236,7 +238,15 @@ static irqreturn_t omap_32k_timer_interr
  */
 void omap_32k_timer_reprogram(unsigned long next_tick)
 {
-	omap_32k_timer_start(JIFFIES_TO_HW_TICKS(next_tick, 32768) + 1);
+	unsigned long ticks = JIFFIES_TO_HW_TICKS(next_tick, 32768) + 1;
+	unsigned long now = omap_32k_sync_timer_read();
+	unsigned long idled = now - omap_32k_last_tick;
+
+	if (idled + 1 < ticks)
+		ticks -= idled;
+	else
+		ticks = 1;
+	omap_32k_timer_start(ticks);
 }
 
 static struct irqaction omap_32k_timer_irq;
