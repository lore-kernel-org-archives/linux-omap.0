From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/21] ARM: OMAP: DMTimer: Optimize by adding load and start
Date: Fri,  6 Jun 2008 18:30:34 -0700
Message-ID: <1212802253-17797-3-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53191 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933765AbYFGBa6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:30:58 -0400
In-Reply-To: <1212802253-17797-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>

From: Richard Woodruff <r-woodruff2@ti.com>

This patch optimizes the timer load and start sequence.  By combining the
load and start a needless posted wait can be removed from the system timer
execution path.

* Before patch register writes are taking up .078% @ 500MHz during idle.

 Address                 |total  |min  |max      |avr     |count|ratio%
 old\process\default_idle|7.369s |0.0us|999.902ms|14.477ms|509. |62.661%
 ld\Global\cpu_v7_do_idle|4.265s |0.0us|375.786ms|24.374ms|175. |36.270%
                (UNKNOWN)|17.503ms|0.us|531.080us|5.119us|3419. |0.148%
 r\omap_dm_timer_set_load|8.135ms|0.0us|79.887us|15.065us|540.  |0.069% <--
 \vmlinux-old\Global\_end|2.023ms|0.0us|4.000us|0.560us|3613.   |0.017%
 -old\Global\__raw_readsw|1.962ms|0.0us|108.610us|9.167us|214.  |0.016%
 old\smc91x\smc_interrupt|1.353ms|0.0us|10.212us|2.348us|576.   |0.011%
 s/namei\__link_path_walk|1.161ms|0.0us|4.310us|0.762us|  1524. |0.009%
 \omap_dm_timer_write_reg|1.085ms|0.0us|126.150us|2.153us|504.  |0.009% <--

* After patch timer functions do not show up in top listings for long captures.

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 78d05f2..557603f 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -59,8 +59,7 @@ static struct irqaction omap2_gp_timer_irq = {
 static int omap2_gp_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
 {
-	omap_dm_timer_set_load(gptimer, 0, 0xffffffff - cycles);
-	omap_dm_timer_start(gptimer);
+	omap_dm_timer_set_load_start(gptimer, 0, 0xffffffff - cycles);
 
 	return 0;
 }
@@ -77,8 +76,7 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 		period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
 		period -= 1;
 
-		omap_dm_timer_set_load(gptimer, 1, 0xffffffff - period);
-		omap_dm_timer_start(gptimer);
+		omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - period);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		break;
@@ -172,8 +170,7 @@ static void __init omap2_gp_clocksource_init(void)
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
 	tick_period = (tick_rate / HZ) - 1;
 
-	omap_dm_timer_set_load(gpt, 1, 0);
-	omap_dm_timer_start(gpt);
+	omap_dm_timer_set_load_start(gpt, 1, 0);
 
 	clocksource_gpt.mult =
 		clocksource_khz2mult(tick_rate/1000, clocksource_gpt.shift);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 822b6bb..f22506a 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -546,6 +546,24 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
 
+/* Optimized set_load which removes costly spin wait in timer_start */
+void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
+                            unsigned int load)
+{
+	u32 l;
+
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	if (autoreload)
+		l |= OMAP_TIMER_CTRL_AR;
+	else
+		l &= ~OMAP_TIMER_CTRL_AR;
+	l |= OMAP_TIMER_CTRL_ST;
+
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, load);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+}
+
 void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 			     unsigned int match)
 {
@@ -560,7 +578,6 @@ void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
 }
 
-
 void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger)
 {
diff --git a/include/asm-arm/arch-omap/dmtimer.h b/include/asm-arm/arch-omap/dmtimer.h
index fefb276..02b29e8 100644
--- a/include/asm-arm/arch-omap/dmtimer.h
+++ b/include/asm-arm/arch-omap/dmtimer.h
@@ -66,6 +66,7 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer);
 
 void omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
 void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload, unsigned int value);
+void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload, unsigned int value);
 void omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, unsigned int match);
 void omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int toggle, int trigger);
 void omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler);
