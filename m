From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv4] OMAP3: Serial: Improved sleep logic
Date: Fri, 12 Feb 2010 20:22:35 +0200
Message-ID: <1265998955-4334-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63748 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903Ab0BLQe0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:34:26 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGYNDG017218
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 10:34:25 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGYLS4013979
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:34:22 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This patch contains following improvements:
- Only RX interrupt will now kick the sleep prevent timer
- TX fifo status is checked before disabling clocks, this will prevent
  on-going transmission to be cut
- Smartidle is now enabled/disabled only while switching clocks, as having
  smartidle enabled while RX/TX prevents any wakeups from being
  received from UART module
- Sleep prevent timer is changed to use ktime_get() instead of a jiffy timer
  as jiffy timers are not valid within idle loop (tick scheduler is stopped)
- Added RX ignore timer for ignoring the first character received during
  first millisecond of wakeup, this prevents garbage character to be receive
  in low sleep states

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/serial.c |   79 +++++++++++++++++++++++++++--------------
 1 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5f3035e..4be9ace 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -29,6 +29,8 @@
 #include <plat/clock.h>
 #include <plat/control.h>
 
+#include <asm/div64.h>
+
 #include "prm.h"
 #include "pm.h"
 #include "prm-regbits-34xx.h"
@@ -42,13 +44,14 @@
  * disabled via sysfs. This also causes that any deeper omap sleep states are
  * blocked. 
  */
-#define DEFAULT_TIMEOUT 0
+#define DEFAULT_TIMEOUT (0LL * NSEC_PER_SEC)
 
 struct omap_uart_state {
 	int num;
 	int can_sleep;
-	struct timer_list timer;
-	u32 timeout;
+	ktime_t expire_time;
+	ktime_t garbage_time;
+	u64 timeout;
 
 	void __iomem *wk_st;
 	void __iomem *wk_en;
@@ -243,6 +246,9 @@ static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
 static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
 #endif /* CONFIG_PM && CONFIG_ARCH_OMAP3 */
 
+static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
+		int enable);
+
 static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 {
 	if (uart->clocked)
@@ -250,8 +256,12 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 
 	clk_enable(uart->ick);
 	clk_enable(uart->fck);
+	omap_uart_smart_idle_enable(uart, 0);
 	uart->clocked = 1;
 	omap_uart_restore_context(uart);
+
+	/* Set up garbage timer to ignore RX during first 1ms */
+	uart->garbage_time = ktime_add_ns(ktime_get(), NSEC_PER_MSEC);
 }
 
 #ifdef CONFIG_PM
@@ -263,6 +273,7 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 
 	omap_uart_save_context(uart);
 	uart->clocked = 0;
+	omap_uart_smart_idle_enable(uart, 1);
 	clk_disable(uart->ick);
 	clk_disable(uart->fck);
 }
@@ -320,12 +331,9 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	omap_uart_enable_clocks(uart);
 
-	omap_uart_smart_idle_enable(uart, 0);
 	uart->can_sleep = 0;
 	if (uart->timeout)
-		mod_timer(&uart->timer, jiffies + uart->timeout);
-	else
-		del_timer(&uart->timer);
+		uart->expire_time = ktime_add_ns(ktime_get(), uart->timeout);
 }
 
 static void omap_uart_allow_sleep(struct omap_uart_state *uart)
@@ -338,16 +346,7 @@ static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 	if (!uart->clocked)
 		return;
 
-	omap_uart_smart_idle_enable(uart, 1);
 	uart->can_sleep = 1;
-	del_timer(&uart->timer);
-}
-
-static void omap_uart_idle_timer(unsigned long data)
-{
-	struct omap_uart_state *uart = (struct omap_uart_state *)data;
-
-	omap_uart_allow_sleep(uart);
 }
 
 void omap_uart_prepare_idle(int num)
@@ -355,8 +354,14 @@ void omap_uart_prepare_idle(int num)
 	struct omap_uart_state *uart;
 
 	list_for_each_entry(uart, &uart_list, node) {
+		if (num == uart->num && !uart->can_sleep && uart->timeout)
+			if (ktime_get().tv64 > uart->expire_time.tv64)
+				uart->can_sleep = 1;
+
 		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
+			if (serial_read_reg(uart->p, UART_LSR) &
+					UART_LSR_TEMT)
+				omap_uart_disable_clocks(uart);
 			return;
 		}
 	}
@@ -404,6 +409,10 @@ int omap_uart_can_sleep(void)
 		if (!uart->clocked)
 			continue;
 
+		if (!uart->can_sleep && uart->timeout &&
+		    ktime_get().tv64 > uart->expire_time.tv64)
+			uart->can_sleep = 1;
+
 		if (!uart->can_sleep) {
 			can_sleep = 0;
 			continue;
@@ -428,10 +437,22 @@ int omap_uart_can_sleep(void)
 static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 {
 	struct omap_uart_state *uart = dev_id;
+	u8 lsr;
+	int ret = IRQ_NONE;
 
-	omap_uart_block_sleep(uart);
+	lsr = serial_read_reg(uart->p, UART_LSR);
+	/* Check for receive interrupt */
+	if (lsr & UART_LSR_DR) {
+		omap_uart_block_sleep(uart);
+		if (uart->garbage_time.tv64 &&
+		    ktime_get().tv64 < uart->garbage_time.tv64) {
+			serial_read_reg(uart->p, UART_RX);
+			uart->garbage_time.tv64 = 0;
+			ret = IRQ_HANDLED;
+		}
+	}
 
-	return IRQ_NONE;
+	return ret;
 }
 
 static void omap_uart_idle_init(struct omap_uart_state *uart)
@@ -441,10 +462,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 
 	uart->can_sleep = 0;
 	uart->timeout = DEFAULT_TIMEOUT;
-	setup_timer(&uart->timer, omap_uart_idle_timer,
-		    (unsigned long) uart);
 	if (uart->timeout)
-		mod_timer(&uart->timer, jiffies + uart->timeout);
+		uart->expire_time = ktime_add_ns(ktime_get(), uart->timeout);
 	omap_uart_smart_idle_enable(uart, 0);
 
 	if (cpu_is_omap34xx()) {
@@ -527,8 +546,12 @@ static ssize_t sleep_timeout_show(struct device *dev,
 					struct platform_device, dev);
 	struct omap_uart_state *uart = container_of(pdev,
 					struct omap_uart_state, pdev);
+	u64 val;
+
+	val = uart->timeout;
 
-	return sprintf(buf, "%u\n", uart->timeout / HZ);
+	do_div(val, NSEC_PER_SEC);
+	return sprintf(buf, "%llu\n", val);
 }
 
 static ssize_t sleep_timeout_store(struct device *dev,
@@ -546,10 +569,12 @@ static ssize_t sleep_timeout_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	uart->timeout = value * HZ;
-	if (uart->timeout)
-		mod_timer(&uart->timer, jiffies + uart->timeout);
-	else
+	uart->timeout = (u64)value * NSEC_PER_SEC;
+	if (uart->timeout) {
+		uart->expire_time = ktime_get();
+		uart->expire_time =
+			ktime_add_ns(uart->expire_time, uart->timeout);
+	} else
 		/* A zero value means disable timeout feature */
 		omap_uart_block_sleep(uart);
 
-- 
1.5.4.3

