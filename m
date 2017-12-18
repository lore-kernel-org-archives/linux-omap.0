From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 1/2] clocksource: timer-dm: Make unexported functions static
Date: Mon, 18 Dec 2017 12:30:56 +0100
Message-ID: <20171218113056.GA18637@lenoch>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <20171218111610.GA16906@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171218111610.GA16906@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

As dmtimer no longer exports functions, there is no point
to have them non-static. Also delete those not used anywhere.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/clocksource/timer-dm.c | 125 ++++++++---------------------------------
 include/clocksource/dmtimer.h  |  26 ---------
 2 files changed, 23 insertions(+), 128 deletions(-)

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index 392978ccd8a6..ec3a28c90c70 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -204,16 +204,6 @@ static inline u32 omap_dm_timer_reserved_systimer(int id)
 	return (omap_reserved_systimers & (1 << (id - 1))) ? 1 : 0;
 }
 
-int omap_dm_timer_reserve_systimer(int id)
-{
-	if (omap_dm_timer_reserved_systimer(id))
-		return -ENODEV;
-
-	omap_reserved_systimers |= (1 << (id - 1));
-
-	return 0;
-}
-
 static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
 {
 	struct omap_dm_timer *timer = NULL, *t;
@@ -298,16 +288,16 @@ static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
 	return timer;
 }
 
-struct omap_dm_timer *omap_dm_timer_request(void)
+static struct omap_dm_timer *omap_dm_timer_request(void)
 {
 	return _omap_dm_timer_request(REQUEST_ANY, NULL);
 }
 
-struct omap_dm_timer *omap_dm_timer_request_specific(int id)
+static struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
 	/* Requesting timer by ID is not supported when device tree is used */
 	if (of_have_populated_dt()) {
-		pr_warn("%s: Please use omap_dm_timer_request_by_cap/node()\n",
+		pr_warn("%s: Please use omap_dm_timer_request_by_node()\n",
 			__func__);
 		return NULL;
 	}
@@ -315,20 +305,6 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 	return _omap_dm_timer_request(REQUEST_BY_ID, &id);
 }
 
-/**
- * omap_dm_timer_request_by_cap - Request a timer by capability
- * @cap:	Bit mask of capabilities to match
- *
- * Find a timer based upon capabilities bit mask. Callers of this function
- * should use the definitions found in the plat/dmtimer.h file under the
- * comment "timer capabilities used in hwmod database". Returns pointer to
- * timer handle on success and a NULL pointer on failure.
- */
-struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap)
-{
-	return _omap_dm_timer_request(REQUEST_BY_CAP, &cap);
-}
-
 /**
  * omap_dm_timer_request_by_node - Request a timer by device-tree node
  * @np:		Pointer to device-tree timer node
@@ -336,7 +312,7 @@ struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap)
  * Request a timer based upon a device node pointer. Returns pointer to
  * timer handle on success and a NULL pointer on failure.
  */
-struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np)
+static struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np)
 {
 	if (!np)
 		return NULL;
@@ -344,7 +320,7 @@ struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np)
 	return _omap_dm_timer_request(REQUEST_BY_NODE, np);
 }
 
-int omap_dm_timer_free(struct omap_dm_timer *timer)
+static int omap_dm_timer_free(struct omap_dm_timer *timer)
 {
 	if (unlikely(!timer))
 		return -EINVAL;
@@ -424,7 +400,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 #else
 
-struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
+static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
 	if (timer && !IS_ERR(timer->fclk))
 		return timer->fclk;
@@ -440,18 +416,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 #endif
 
-int omap_dm_timer_trigger(struct omap_dm_timer *timer)
-{
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
-		pr_err("%s: timer not available or enabled.\n", __func__);
-		return -EINVAL;
-	}
-
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
-	return 0;
-}
-
-int omap_dm_timer_start(struct omap_dm_timer *timer)
+static int omap_dm_timer_start(struct omap_dm_timer *timer)
 {
 	u32 l;
 
@@ -471,7 +436,7 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
 	return 0;
 }
 
-int omap_dm_timer_stop(struct omap_dm_timer *timer)
+static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
 	unsigned long rate = 0;
 
@@ -556,8 +521,8 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	return ret;
 }
 
-int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
-			    unsigned int load)
+static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
+				  unsigned int load)
 {
 	u32 l;
 
@@ -581,37 +546,8 @@ int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	return 0;
 }
 
-/* Optimized set_load which removes costly spin wait in timer_start */
-int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
-                            unsigned int load)
-{
-	u32 l;
-
-	if (unlikely(!timer))
-		return -EINVAL;
-
-	omap_dm_timer_enable(timer);
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (autoreload) {
-		l |= OMAP_TIMER_CTRL_AR;
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
-	} else {
-		l &= ~OMAP_TIMER_CTRL_AR;
-	}
-	l |= OMAP_TIMER_CTRL_ST;
-
-	__omap_dm_timer_load_start(timer, l, load, timer->posted);
-
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tldr = load;
-	timer->context.tcrr = load;
-	return 0;
-}
-
-int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
-			     unsigned int match)
+static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
+				   unsigned int match)
 {
 	u32 l;
 
@@ -634,8 +570,8 @@ int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	return 0;
 }
 
-int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
-			   int toggle, int trigger)
+static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
+				 int toggle, int trigger)
 {
 	u32 l;
 
@@ -659,7 +595,8 @@ int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	return 0;
 }
 
-int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
+static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
+					int prescaler)
 {
 	u32 l;
 
@@ -681,8 +618,8 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 	return 0;
 }
 
-int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
-				  unsigned int value)
+static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
+					unsigned int value)
 {
 	if (unlikely(!timer))
 		return -EINVAL;
@@ -704,7 +641,7 @@ int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
  *
  * Disables the specified timer interrupts for a timer.
  */
-int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
+static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 {
 	u32 l = mask;
 
@@ -727,7 +664,7 @@ int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	return 0;
 }
 
-unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
+static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
@@ -741,7 +678,7 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 	return l;
 }
 
-int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
+static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
 	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev)))
 		return -EINVAL;
@@ -751,7 +688,7 @@ int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 	return 0;
 }
 
-unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
+static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
 	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
 		pr_err("%s: timer not iavailable or enabled.\n", __func__);
@@ -761,7 +698,7 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 	return __omap_dm_timer_read_counter(timer, timer->posted);
 }
 
-int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
+static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
 	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
@@ -775,22 +712,6 @@ int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 	return 0;
 }
 
-int omap_dm_timers_active(void)
-{
-	struct omap_dm_timer *timer;
-
-	list_for_each_entry(timer, &omap_timer_list, node) {
-		if (!timer->reserved)
-			continue;
-
-		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
-		    OMAP_TIMER_CTRL_ST) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
 static const struct of_device_id omap_timer_match[];
 
 /**
diff --git a/include/clocksource/dmtimer.h b/include/clocksource/dmtimer.h
index 862ad62dab9d..63d6ec0747d9 100644
--- a/include/clocksource/dmtimer.h
+++ b/include/clocksource/dmtimer.h
@@ -124,40 +124,14 @@ struct omap_dm_timer {
 	struct list_head node;
 };
 
-int omap_dm_timer_reserve_systimer(int id);
-struct omap_dm_timer *omap_dm_timer_request(void);
-struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
-struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
-struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np);
-int omap_dm_timer_free(struct omap_dm_timer *timer);
 void omap_dm_timer_enable(struct omap_dm_timer *timer);
 void omap_dm_timer_disable(struct omap_dm_timer *timer);
 
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
 
 u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
-struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer);
-
-int omap_dm_timer_trigger(struct omap_dm_timer *timer);
-int omap_dm_timer_start(struct omap_dm_timer *timer);
-int omap_dm_timer_stop(struct omap_dm_timer *timer);
 
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
-int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload, unsigned int value);
-int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload, unsigned int value);
-int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, unsigned int match);
-int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int toggle, int trigger);
-int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler);
-
-int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned int value);
-int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask);
-
-unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer);
-int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value);
-unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer);
-int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value);
-
-int omap_dm_timers_active(void);
 
 /*
  * Do not use the defines below, they are not needed. They should be only
-- 
2.15.1
