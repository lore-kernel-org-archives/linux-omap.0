From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v5 1/8] clocksource: dmtimer: Remove all the exports
Date: Tue, 12 Dec 2017 11:42:10 +0530
Message-ID: <1513059137-21593-2-git-send-email-j-keerthy@ti.com>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

Remove all the unwanted exports from the driver

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Changes in v3:

  * Added Sebastian's Reviewed-by.

Changes in v2:

  * No code changes in this v2 version. Only enhanced patch
    statistics for renames.

 arch/arm/plat-omap/dmtimer.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index d443e48..72565fc 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -302,7 +302,6 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 {
 	return _omap_dm_timer_request(REQUEST_ANY, NULL);
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
@@ -315,7 +314,6 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 
 	return _omap_dm_timer_request(REQUEST_BY_ID, &id);
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 /**
  * omap_dm_timer_request_by_cap - Request a timer by capability
@@ -330,7 +328,6 @@ struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap)
 {
 	return _omap_dm_timer_request(REQUEST_BY_CAP, &cap);
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_request_by_cap);
 
 /**
  * omap_dm_timer_request_by_node - Request a timer by device-tree node
@@ -346,7 +343,6 @@ struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np)
 
 	return _omap_dm_timer_request(REQUEST_BY_NODE, np);
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_request_by_node);
 
 int omap_dm_timer_free(struct omap_dm_timer *timer)
 {
@@ -359,7 +355,6 @@ int omap_dm_timer_free(struct omap_dm_timer *timer)
 	timer->reserved = 0;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
@@ -379,13 +374,11 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
 	pm_runtime_put_sync(&timer->pdev->dev);
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
 
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 {
@@ -393,7 +386,6 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 		return timer->irq;
 	return -EINVAL;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
 
 #if defined(CONFIG_ARCH_OMAP1)
 #include <mach/hardware.h>
@@ -429,7 +421,6 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 	return inputmask;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 #else
 
@@ -439,7 +430,6 @@ struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 		return timer->fclk;
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
 
 __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
@@ -447,7 +437,6 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 #endif
 
@@ -461,7 +450,6 @@ int omap_dm_timer_trigger(struct omap_dm_timer *timer)
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
 
 int omap_dm_timer_start(struct omap_dm_timer *timer)
 {
@@ -482,7 +470,6 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
 	timer->context.tclr = l;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 
 int omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
@@ -506,7 +493,6 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
@@ -569,7 +555,6 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
 int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 			    unsigned int load)
@@ -595,7 +580,6 @@ int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
 
 /* Optimized set_load which removes costly spin wait in timer_start */
 int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
@@ -625,7 +609,6 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	timer->context.tcrr = load;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
 int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 			     unsigned int match)
@@ -650,7 +633,6 @@ int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
 
 int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger)
@@ -676,7 +658,6 @@ int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 
 int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
@@ -699,7 +680,6 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 
 int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
@@ -716,7 +696,6 @@ int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
 /**
  * omap_dm_timer_set_int_disable - disable timer interrupts
@@ -747,7 +726,6 @@ int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_disable);
 
 unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
@@ -762,7 +740,6 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 
 	return l;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
 
 int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
@@ -773,7 +750,6 @@ int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
@@ -784,7 +760,6 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 
 	return __omap_dm_timer_read_counter(timer, timer->posted);
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
 int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
@@ -799,7 +774,6 @@ int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 	timer->context.tcrr = value;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
 int omap_dm_timers_active(void)
 {
@@ -816,7 +790,6 @@ int omap_dm_timers_active(void)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
 static const struct of_device_id omap_timer_match[];
 
-- 
1.9.1
