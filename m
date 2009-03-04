From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/7] ARM: OMAP: Export dmtimer functions
Date: Wed, 04 Mar 2009 13:48:30 -0800
Message-ID: <20090304214830.21101.1523.stgit@localhost>
References: <20090304214540.21101.72079.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54150 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbZCDVse (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 16:48:34 -0500
In-Reply-To: <20090304214540.21101.72079.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Timo Kokkonen <timo.t.kokkonen@nokia.com>, linux-omap@vger.kernel.org

From: Timo Kokkonen <timo.t.kokkonen@nokia.com>

Make the dmtimer function symbols available so modules can take use of
them.

Signed-off-by: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index e4f0ce0..bfd4757 100644
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
@@ -362,6 +363,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 
 	return timer;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_request);
 
 struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
@@ -385,6 +387,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 
 	return timer;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 void omap_dm_timer_free(struct omap_dm_timer *timer)
 {
@@ -395,6 +398,7 @@ void omap_dm_timer_free(struct omap_dm_timer *timer)
 	WARN_ON(!timer->reserved);
 	timer->reserved = 0;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_free);
 
 void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
@@ -406,6 +410,7 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 
 	timer->enabled = 1;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
 
 void omap_dm_timer_disable(struct omap_dm_timer *timer)
 {
@@ -417,11 +422,13 @@ void omap_dm_timer_disable(struct omap_dm_timer *timer)
 
 	timer->enabled = 0;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
 
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 {
 	return timer->irq;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
 
 #if defined(CONFIG_ARCH_OMAP1)
 
@@ -452,6 +459,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 	return inputmask;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 #elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
 
@@ -459,6 +467,7 @@ struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
 	return timer->fclk;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
 
 __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
@@ -466,6 +475,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
 #endif
 
@@ -473,6 +483,7 @@ void omap_dm_timer_trigger(struct omap_dm_timer *timer)
 {
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
 
 void omap_dm_timer_start(struct omap_dm_timer *timer)
 {
@@ -484,6 +495,7 @@ void omap_dm_timer_start(struct omap_dm_timer *timer)
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	}
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_start);
 
 void omap_dm_timer_stop(struct omap_dm_timer *timer)
 {
@@ -495,6 +507,7 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	}
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
 #ifdef CONFIG_ARCH_OMAP1
 
@@ -507,6 +520,7 @@ void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	l |= source << n;
 	omap_writel(l, MOD_CONF_CTRL_1);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
 #else
 
@@ -523,6 +537,7 @@ void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	 * cause an abort. */
 	__delay(150000);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
 #endif
 
@@ -541,6 +556,7 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
 
 /* Optimized set_load which removes costly spin wait in timer_start */
 void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
@@ -560,6 +576,7 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, load);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
 void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 			     unsigned int match)
@@ -574,6 +591,7 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
 
 void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger)
@@ -590,6 +608,7 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	l |= trigger << 10;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 
 void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
@@ -603,6 +622,7 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 
 void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
@@ -610,6 +630,7 @@ void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_INT_EN_REG, value);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
 }
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
 unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
@@ -619,11 +640,13 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 
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
@@ -633,11 +656,13 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 
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
@@ -658,6 +683,7 @@ int omap_dm_timers_active(void)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
 int __init omap_dm_timer_init(void)
 {

