From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv3] OMAP3: Serial: Improved sleep logic
Date: Thu, 11 Feb 2010 15:39:01 +0200
Message-ID: <1265895541-12300-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58391 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0BKLu7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 06:50:59 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1BBos0o028929
	for <linux-omap@vger.kernel.org>; Thu, 11 Feb 2010 13:50:57 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1BBocTH009076
	for <linux-omap@vger.kernel.org>; Thu, 11 Feb 2010 13:50:39 +0200
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
- Smartidle is disabled while entering idle if we have data in the transmit
  buffer because having this enabled would prevent wakeups from the TX
  interrupt and this would cause pauses while sending large blocks of data
- Sleep prevent timer is changed to use ktime_get() instead of a jiffy timer
  as jiffy timers are not valid within idle loop (tick scheduler is stopped)
- Added RX ignore timer for ignoring the first character received during
  first millisecond of wakeup, this prevents garbage character to be received
  in low sleep states

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/serial.c |   81 ++++++++++++++++++++++++++++-------------
 1 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 837b347..75ce549 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -23,12 +23,15 @@
 #include <linux/serial_reg.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/clock.h>
 #include <plat/control.h>
 
+#include <asm/div64.h>
+
 #include "prm.h"
 #include "pm.h"
 #include "prm-regbits-34xx.h"
@@ -36,13 +39,14 @@
 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
-#define DEFAULT_TIMEOUT (5 * HZ)
+#define DEFAULT_TIMEOUT (5LL * NSEC_PER_SEC)
 
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
@@ -231,6 +235,9 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 	clk_enable(uart->fck);
 	uart->clocked = 1;
 	omap_uart_restore_context(uart);
+
+	/* Set up garbage timer to ignore RX during first 1ms */
+	uart->garbage_time = ktime_add_ns(ktime_get(), NSEC_PER_MSEC);
 }
 
 #ifdef CONFIG_PM
@@ -302,9 +309,7 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 	omap_uart_smart_idle_enable(uart, 0);
 	uart->can_sleep = 0;
 	if (uart->timeout)
-		mod_timer(&uart->timer, jiffies + uart->timeout);
-	else
-		del_timer(&uart->timer);
+		uart->expire_time = ktime_add_ns(ktime_get(), uart->timeout);
 }
 
 static void omap_uart_allow_sleep(struct omap_uart_state *uart)
@@ -317,25 +322,28 @@ static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 	if (!uart->clocked)
 		return;
 
-	omap_uart_smart_idle_enable(uart, 1);
+	if (serial_read_reg(uart->p, UART_LSR) & UART_LSR_TEMT)
+		omap_uart_smart_idle_enable(uart, 1);
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
 {
 	struct omap_uart_state *uart;
+	ktime_t t;
 
 	list_for_each_entry(uart, &uart_list, node) {
+		if (num == uart->num && !uart->can_sleep) {
+			t = ktime_get();
+			if (t.tv64 > uart->expire_time.tv64)
+				uart->can_sleep = 1;
+		}
 		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
+			if (serial_read_reg(uart->p, UART_LSR) &
+					UART_LSR_TEMT)
+				omap_uart_disable_clocks(uart);
+			else
+				omap_uart_smart_idle_enable(uart, 0);
 			return;
 		}
 	}
@@ -360,6 +368,7 @@ void omap_uart_resume_idle(int num)
 			/* Check for normal UART wakeup */
 			if (__raw_readl(uart->wk_st) & uart->wk_mask)
 				omap_uart_block_sleep(uart);
+
 			return;
 		}
 	}
@@ -407,10 +416,24 @@ int omap_uart_can_sleep(void)
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
+	if (lsr & UART_LSR_TEMT && uart->can_sleep)
+		omap_uart_smart_idle_enable(uart, 1);
 
-	return IRQ_NONE;
+	return ret;
 }
 
 static void omap_uart_idle_init(struct omap_uart_state *uart)
@@ -420,9 +443,9 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 
 	uart->can_sleep = 0;
 	uart->timeout = DEFAULT_TIMEOUT;
-	setup_timer(&uart->timer, omap_uart_idle_timer,
-		    (unsigned long) uart);
-	mod_timer(&uart->timer, jiffies + uart->timeout);
+
+	uart->expire_time = ktime_add_ns(ktime_get(), uart->timeout);
+
 	omap_uart_smart_idle_enable(uart, 0);
 
 	if (cpu_is_omap34xx()) {
@@ -505,8 +528,12 @@ static ssize_t sleep_timeout_show(struct device *dev,
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
@@ -524,10 +551,12 @@ static ssize_t sleep_timeout_store(struct device *dev,
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

