From: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Subject: [PATCH 1/1] Export dmtimer functions
Date: Fri, 30 Jan 2009 11:22:55 +0200
Message-ID: <1233307375-5943-2-git-send-email-timo.t.kokkonen@nokia.com>
References: <1233307375-5943-1-git-send-email-timo.t.kokkonen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31349 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbZA3JXF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 04:23:05 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0U9MfvM004642
	for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 11:23:02 +0200
In-Reply-To: <1233307375-5943-1-git-send-email-timo.t.kokkonen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Timo Kokkonen <timo.t.kokkonen@nokia.com>

Make the dmtimer function symbols available so modules can take use of
them.

Signed-off-by: Timo Kokkonen <timo.t.kokkonen@nokia.com>
---
 arch/arm/plat-omap/dmtimer.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index ed397f0..a05205c 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -33,6 +33,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <mach/hardware.h>
 #include <mach/dmtimer.h>
 #include <mach/irqs.h>
@@ -360,6 +361,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 
 	return timer;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
@@ -383,6 +385,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 
 	return timer;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 void omap_dm_timer_free(struct omap_dm_timer *timer)
 {
@@ -393,6 +396,7 @@ void omap_dm_timer_free(struct omap_dm_timer *timer)
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
@@ -404,6 +408,7 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 
 	timer->enabled = 1;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
@@ -415,11 +420,13 @@ void omap_dm_timer_disable(struct omap_dm_timer *timer)
 
 	timer->enabled = 0;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
 
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 {
 	return timer->irq;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
 
 #if defined(CONFIG_ARCH_OMAP1)
 
@@ -450,6 +457,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 	return inputmask;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 #elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
 
@@ -457,6 +465,7 @@ struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
 	return timer->fclk;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
 
 __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
@@ -464,6 +473,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 #endif
 
@@ -471,6 +481,7 @@ void omap_dm_timer_trigger(struct omap_dm_timer *timer)
 {
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
 
 void omap_dm_timer_start(struct omap_dm_timer *timer)
 {
@@ -482,6 +493,7 @@ void omap_dm_timer_start(struct omap_dm_timer *timer)
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	}
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 
 void omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
@@ -493,6 +505,7 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	}
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
 #ifdef CONFIG_ARCH_OMAP1
 
@@ -505,6 +518,7 @@ void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	l |= source << n;
 	omap_writel(l, MOD_CONF_CTRL_1);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
 #else
 
@@ -521,6 +535,7 @@ void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	 * cause an abort. */
 	__delay(150000);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
 #endif
 
@@ -539,6 +554,7 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
 
 /* Optimized set_load which removes costly spin wait in timer_start */
 void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
@@ -558,6 +574,7 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, load);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
 void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 			     unsigned int match)
@@ -572,6 +589,7 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
 
 void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger)
@@ -588,6 +606,7 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	l |= trigger << 10;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 
 void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
@@ -601,6 +620,7 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 
 void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
@@ -608,6 +628,7 @@ void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_INT_EN_REG, value);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
 unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
@@ -617,11 +638,13 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 
 	return l;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
 
 void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG, value);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
@@ -631,11 +654,13 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 
 	return l;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
 void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
 
 int omap_dm_timers_active(void)
 {
@@ -656,6 +681,7 @@ int omap_dm_timers_active(void)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
 int __init omap_dm_timer_init(void)
 {
-- 
1.6.0.6

