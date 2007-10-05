From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: [PATCH] OMAP: Asynchronous clock disable
Date: Fri, 5 Oct 2007 15:50:28 +0300
Message-ID: <20071005125028.GA32101@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

In N800 mmc driver we enable and disable mmc clock in a continous
cycle with small delays.

I wonder if asynchronou clock disable has been suggested before?

I would like to be able to disable clocks asynchronously with a
small delay so that when doing repetitive clk enable/disable
cycle, the clock would just stay up and only shut down when
the continuos stream of requests is over.

What I would like to do is:

     clk_enable(clk):
     ... process the request
     clk_disable_async(clk, 2);

This would leave clock running for 2 ticks after returning from
clk_disable_async() and only then disable it. In mmc driver the
delay could be close to 50 ms.

If clk_disable_async() would be reapplies, the latter call would
stay in effect since it is done using mod_timer().  For example here 
the clock would be disabled 1 tick after the second call to 
clk_disable_async():

     clk_enable(clk);
     clk_disable_async(clk, HZ);
     clk_enable(clk);
     clk_disable_async(clk, 1);


If clk_disable() and clk_disable_async() would be mixed, clk_disable()
would not cancel pending clk disable since the usecount would still
be bigger than 0 after calling clk_disable():

     clk_enable(clk);
     clk_disable_async(clk, HZ);
     clk_enable(clk);
     clk_disable(clk);

For clearing up pending clock disables I use clk_flush_disable(clk)
clears out any pending disable immediately.

     clk_enable(clk);
     clk_disable_async(clk, HZ);
     ... later
     clk_flush_disable(clk)


Jarkko Lavinen

--oyUTqETQ0mS9luUI
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-OMAP-Add-asynchronous-clock-disable.patch"

>From 557e94d0a43efbc7e312ab7c1d8a568d65a9310a Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Fri, 5 Oct 2007 15:39:46 +0300
Subject: [PATCH] OMAP: Add asynchronous clock disable

Asynchronouse clock disable is useful for repetitive request processing,
where clock is enabled and disabled continuosly.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 arch/arm/plat-omap/clock.c        |   56 +++++++++++++++++++++++++++++++++++--
 include/asm-arm/arch-omap/clock.h |    4 ++
 include/linux/clk.h               |   16 ++++++++++
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 70f2311..a94b122 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -127,7 +127,7 @@ int clk_enable(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_enable);
 
-void clk_disable(struct clk *clk)
+void clk_disable_async(struct clk *clk, int ticks)
 {
 	unsigned long flags;
 
@@ -142,14 +142,61 @@ void clk_disable(struct clk *clk)
 		goto out;
 	}
 
-	if (arch_clock->clk_disable)
-		arch_clock->clk_disable(clk);
+	if (ticks > 0) {
+		if ((clk->flags & CLOCK_ASYNC_DISABLE) == 0) {
+			printk(KERN_ERR "Trying to disable clock %s "
+			       "asynchronousely without proper "
+			       "initialization\n", clk->name);
+			WARN_ON(1);
+		} else {
+			if (timer_pending(&clk->disable_timer))
+				clk->usecount--;
+
+			mod_timer(&clk->disable_timer, jiffies + ticks);
+		}
+	} else
+		if (arch_clock->clk_disable)
+			arch_clock->clk_disable(clk);
+out:
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+}
+EXPORT_SYMBOL(clk_disable_async);
+
+void clk_flush_disable(struct clk *clk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+	if ((clk->flags & CLOCK_ASYNC_DISABLE) == 0) {
+		printk(KERN_ERR "Trying to disable clock %s asynchronousely "
+		       "without timer initialization\n", clk->name);
+		WARN_ON(1);
+		goto out;
+	}
 
+	if (timer_pending(&clk->disable_timer)) {
+		del_timer(&clk->disable_timer);
+		if (arch_clock->clk_disable)
+			arch_clock->clk_disable(clk);
+	}
 out:
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
+EXPORT_SYMBOL(clk_flush_disable);
+
+void clk_disable(struct clk *clk)
+{
+	clk_disable_async(clk, 0);
+}
 EXPORT_SYMBOL(clk_disable);
 
+static void clk_disable_timer(unsigned long data)
+{
+	struct clk *clk = (struct clk *) data;
+
+	clk_disable_async(clk, 0);
+}
+
 int clk_get_usecount(struct clk *clk)
 {
 	unsigned long flags;
@@ -336,6 +383,9 @@ int clk_register(struct clk *clk)
 
 	mutex_lock(&clocks_mutex);
 	list_add(&clk->node, &clocks);
+	if (clk->flags & CLOCK_ASYNC_DISABLE)
+		setup_timer(&clk->disable_timer, clk_disable_timer,
+			    (unsigned long) clk);
 	if (clk->init)
 		clk->init(clk);
 	mutex_unlock(&clocks_mutex);
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index cb7a301..aa95aac 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -13,6 +13,8 @@
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
+#include <linux/timer.h>
+
 struct module;
 struct clk;
 
@@ -57,6 +59,7 @@ struct clk {
 	void __iomem		*enable_reg;
 	__u8			enable_bit;
 	__s8			usecount;
+	struct timer_list	disable_timer;
 	void			(*recalc)(struct clk *);
 	int			(*set_rate)(struct clk *, unsigned long);
 	long			(*round_rate)(struct clk *, unsigned long);
@@ -123,6 +126,7 @@ extern void clk_enable_init_clocks(void);
 #define CLOCK_IN_OMAP243X	(1 << 26)
 #define CLOCK_IN_OMAP343X	(1 << 27)
 #define PARENT_CONTROLS_CLOCK	(1 << 28)
+#define CLOCK_ASYNC_DISABLE	(1 << 29)
 
 /* Clksel_rate flags */
 #define DEFAULT_RATE            (1 << 0)
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 5ca8c6f..c922f79 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -63,6 +63,22 @@ int clk_enable(struct clk *clk);
 void clk_disable(struct clk *clk);
 
 /**
+ * clk_disable_async - disable the clock after a delay
+ * @clk:   clock source
+ * @ticks: delay
+ *
+ * Asyncronous clock disable is implemented with a timer which runs
+ * clk_disable when the timer expires.
+ */
+void clk_disable_async(struct clk *clk, int ticks);
+
+/**
+ * clk_sync_disable - Finish pending clock disable immediately
+ * @clk: clock source
+ */
+void clk_flush_disable(struct clk *clk);
+
+/**
  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
  *		  This is only valid once the clock source has been enabled.
  * @clk: clock source
-- 
1.5.3.1


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--oyUTqETQ0mS9luUI--
