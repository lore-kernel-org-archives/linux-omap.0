From: imre.deak@solidboot.com
Subject: [PATCH 2/4] Input: ads7846: switch to hrtimer
Date: Mon, 3 Jul 2006 21:34:16 +0300
Message-ID: <20060703183416.GB29921@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: david-b@pacbell.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Use hrtimer instead of the normal timer, since it provides better
sampling resolution. This will:

- avoid a problem where we have a 1 jiffy poll period and dynamic tick on
- utilize high resolution HW clocks when they are added to the hrtimer
  framework

Signed-off-by: Imre Deak <imre.deak@solidboot.com>

---

 drivers/input/touchscreen/ads7846.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

827a36120885bcacb122ce3fb3a1947486afb3f8
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 94c36b1..008cf0a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -55,7 +55,8 @@
  * files.
  */
 
-#define	TS_POLL_PERIOD	msecs_to_jiffies(10)
+#define TS_POLL_DELAY	(1 * 1000000)	/* ns delay before the first sample */
+#define	TS_POLL_PERIOD	(5 * 1000000)	/* ns delay between samples */
 
 /* this driver doesn't aim at the peak continuous sample rate */
 #define	SAMPLE_BITS	(8 /*cmd*/ + 16 /*sample*/ + 2 /* before, after */)
@@ -100,7 +101,7 @@ struct ads7846 {
 	u16			debounce_rep;
 
 	spinlock_t		lock;
-	struct timer_list	timer;		/* P: lock */
+	struct hrtimer		timer;
 	unsigned		pendown:1;	/* P: lock */
 	unsigned		pending:1;	/* P: lock */
 // FIXME remove "irq_disabled"
@@ -448,7 +449,8 @@ static void ads7846_rx(void *ads)
 		pr_debug("%s: ignored %d pressure %d\n",
 			ts->spi->dev.bus_id, ts->tc.ignore, Rt);
 #endif
-		mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
+		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
+			      HRTIMER_REL);
 		return;
 	}
 
@@ -468,7 +470,7 @@ static void ads7846_rx(void *ads)
 	}
 
 
-	mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
+	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD), HRTIMER_REL);
 }
 
 static void ads7846_debounce(void *ads)
@@ -523,9 +525,9 @@ static void ads7846_debounce(void *ads)
 				status);
 }
 
-static void ads7846_timer(unsigned long handle)
+static int ads7846_timer(struct hrtimer *handle)
 {
-	struct ads7846	*ts = (void *)handle;
+	struct ads7846	*ts = container_of(handle, struct ads7846, timer);
 	int		status = 0;
 
 	spin_lock_irq(&ts->lock);
@@ -553,6 +555,7 @@ static void ads7846_timer(unsigned long 
 	}
 
 	spin_unlock_irq(&ts->lock);
+	return HRTIMER_NORESTART;
 }
 
 static irqreturn_t ads7846_irq(int irq, void *handle, struct pt_regs *regs)
@@ -572,7 +575,8 @@ static irqreturn_t ads7846_irq(int irq, 
 			ts->irq_disabled = 1;
 			disable_irq(ts->spi->irq);
 			ts->pending = 1;
-			mod_timer(&ts->timer, jiffies);
+			hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
+					HRTIMER_REL);
 		}
 	}
 	spin_unlock_irqrestore(&ts->lock, flags);
@@ -709,8 +713,7 @@ static int __devinit ads7846_probe(struc
 	ts->input = input_dev;
 	ts->hwmon = hwmon;
 
-	init_timer(&ts->timer);
-	ts->timer.data = (unsigned long) ts;
+	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_REL);
 	ts->timer.function = ads7846_timer;
 
 	spin_lock_init(&ts->lock);
-- 
1.2.3.g90cc1-dirty
