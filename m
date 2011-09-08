From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v15 11/12] OMAP: dmtimer: extend spinlock to exported APIs
Date: Fri, 9 Sep 2011 02:38:17 +0530
Message-ID: <1315516098-29761-12-git-send-email-tarun.kanti@ti.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Since the exported APIs can be called from interrupt context
extend spinlock protection to some more relevant APIs to avoid
race condition.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 15fe01a..8891f80 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -174,7 +174,6 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 		timer->reserved = 1;
 		break;
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -183,6 +182,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 			timer = NULL;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer request failed!\n", __func__);
@@ -205,7 +205,6 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -214,6 +213,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			timer = NULL;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer%d request failed!\n", __func__, id);
@@ -317,9 +317,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
 void omap_dm_timer_start(struct omap_dm_timer *timer)
 {
 	u32 l;
+	unsigned long flags;
 
 	omap_dm_timer_enable(timer);
 
+	spin_lock_irqsave(&dm_timer_lock, flags);
 	if (timer->loses_context) {
 		u32 ctx_loss_cnt_after =
 			timer->get_context_loss_count(&timer->pdev->dev);
@@ -335,15 +337,17 @@ void omap_dm_timer_start(struct omap_dm_timer *timer)
 
 	/* Save the context */
 	timer->context.tclr = l;
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 
 void omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
-	unsigned long rate = 0;
+	unsigned long rate = 0, flags;
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
 	bool is_omap2 = true;
 
+	spin_lock_irqsave(&dm_timer_lock, flags);
 	if (pdata->needs_manual_reset)
 		is_omap2 = false;
 	else
@@ -367,6 +371,7 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	timer->context.tisr =
 			omap_dm_timer_read_reg(timer, OMAP_TIMER_STAT_REG);
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
@@ -389,8 +394,10 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 			    unsigned int load)
 {
 	u32 l;
+	unsigned long flags;
 
 	omap_dm_timer_enable(timer);
+	spin_lock_irqsave(&dm_timer_lock, flags);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload)
 		l |= OMAP_TIMER_CTRL_AR;
@@ -403,6 +410,7 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	/* Save the context */
 	timer->context.tclr = l;
 	timer->context.tldr = load;
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
@@ -412,9 +420,11 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
                             unsigned int load)
 {
 	u32 l;
+	unsigned long flags;
 
 	omap_dm_timer_enable(timer);
 
+	spin_lock_irqsave(&dm_timer_lock, flags);
 	if (timer->loses_context) {
 		u32 ctx_loss_cnt_after =
 			timer->get_context_loss_count(&timer->pdev->dev);
@@ -438,6 +448,7 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	timer->context.tclr = l;
 	timer->context.tldr = load;
 	timer->context.tcrr = load;
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
@@ -445,8 +456,10 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 			     unsigned int match)
 {
 	u32 l;
+	unsigned long flags;
 
 	omap_dm_timer_enable(timer);
+	spin_lock_irqsave(&dm_timer_lock, flags);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |= OMAP_TIMER_CTRL_CE;
@@ -458,6 +471,7 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	/* Save the context */
 	timer->context.tclr = l;
 	timer->context.tmar = match;
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
@@ -466,8 +480,10 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger)
 {
 	u32 l;
+	unsigned long flags;
 
 	omap_dm_timer_enable(timer);
+	spin_lock_irqsave(&dm_timer_lock, flags);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10));
@@ -480,6 +496,7 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 
 	/* Save the context */
 	timer->context.tclr = l;
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
@@ -487,8 +504,10 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
 	u32 l;
+	unsigned long flags;
 
 	omap_dm_timer_enable(timer);
+	spin_lock_irqsave(&dm_timer_lock, flags);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0x00 && prescaler <= 0x07) {
@@ -499,6 +518,7 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 
 	/* Save the context */
 	timer->context.tclr = l;
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
@@ -506,13 +526,17 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
+	unsigned long flags;
+
 	omap_dm_timer_enable(timer);
+	spin_lock_irqsave(&dm_timer_lock, flags);
 	__omap_dm_timer_int_enable(timer->io_base, value,
 					timer->intr_offset, timer->func_offset);
 
 	/* Save the context */
 	timer->context.tier = value;
 	timer->context.twer = value;
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	omap_dm_timer_disable(timer);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
@@ -570,16 +594,20 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 int omap_dm_timers_active(void)
 {
 	struct omap_dm_timer *timer;
+	unsigned long flags;
 
+	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_for_each_entry(timer, &omap_timer_list, node) {
 		if (!timer->reserved)
 			continue;
 
 		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
 		    OMAP_TIMER_CTRL_ST) {
+			spin_unlock_irqrestore(&dm_timer_lock, flags);
 			return 1;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timers_active);
-- 
1.7.0.4
