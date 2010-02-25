From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv6] OMAP3: Serial: Improved sleep logic
Date: Thu, 25 Feb 2010 19:25:49 +0200
Message-ID: <1267118749-1836-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43796 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442Ab0BYPjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 10:39:21 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1PFd8oi004580
	for <linux-omap@vger.kernel.org>; Thu, 25 Feb 2010 17:39:17 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1PFdC1C020210
	for <linux-omap@vger.kernel.org>; Thu, 25 Feb 2010 17:39:12 +0200
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
  smartidle enabled while RX/TX prevents any wakeups from being received
  from UART module
- Added workqueue for wakeup checks, as jiffy timer access within the
  idle loop results into skewed timers as jiffy timers are stopped
- Added garbage_timer for ignoring the first character received during
  the first tick after clock enable, this prevents garbage characters to be
  received in low sleep states
- omap_uart_enable_irqs() changed to use enable_irq / disable_irq instead
  of request / free. Using request/free changes the behavior after first
  suspend due to reversed interrupt handler ordering

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/serial.c |   67 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5f3035e..06d18f5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -23,6 +23,7 @@
 #include <linux/serial_reg.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/workqueue.h>
 
 #include <plat/common.h>
 #include <plat/board.h>
@@ -48,7 +49,10 @@ struct omap_uart_state {
 	int num;
 	int can_sleep;
 	struct timer_list timer;
+	struct timer_list garbage_timer;
+	struct work_struct wakeup_work;
 	u32 timeout;
+	u8 garbage_ignore;
 
 	void __iomem *wk_st;
 	void __iomem *wk_en;
@@ -243,6 +247,11 @@ static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
 static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
 #endif /* CONFIG_PM && CONFIG_ARCH_OMAP3 */
 
+#ifdef CONFIG_PM
+static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
+		int enable);
+#endif
+
 static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 {
 	if (uart->clocked)
@@ -252,6 +261,15 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 	clk_enable(uart->fck);
 	uart->clocked = 1;
 	omap_uart_restore_context(uart);
+#ifdef CONFIG_PM
+	omap_uart_smart_idle_enable(uart, 0);
+#endif
+
+	/* Set up garbage timer to ignore RX during first jiffy */
+	if (uart->timeout) {
+		mod_timer(&uart->garbage_timer, jiffies + 1);
+		uart->garbage_ignore = 1;
+	}
 }
 
 #ifdef CONFIG_PM
@@ -263,6 +281,7 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 
 	omap_uart_save_context(uart);
 	uart->clocked = 0;
+	omap_uart_smart_idle_enable(uart, 1);
 	clk_disable(uart->ick);
 	clk_disable(uart->fck);
 }
@@ -320,7 +339,6 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	omap_uart_enable_clocks(uart);
 
-	omap_uart_smart_idle_enable(uart, 0);
 	uart->can_sleep = 0;
 	if (uart->timeout)
 		mod_timer(&uart->timer, jiffies + uart->timeout);
@@ -338,7 +356,6 @@ static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 	if (!uart->clocked)
 		return;
 
-	omap_uart_smart_idle_enable(uart, 1);
 	uart->can_sleep = 1;
 	del_timer(&uart->timer);
 }
@@ -350,13 +367,30 @@ static void omap_uart_idle_timer(unsigned long data)
 	omap_uart_allow_sleep(uart);
 }
 
+static void omap_uart_garbage_timer(unsigned long data)
+{
+	struct omap_uart_state *uart = (struct omap_uart_state *)data;
+
+	uart->garbage_ignore = 0;
+}
+
+static void omap_uart_wakeup_work(struct work_struct *work)
+{
+	struct omap_uart_state *uart =
+		container_of(work, struct omap_uart_state, wakeup_work);
+
+	omap_uart_block_sleep(uart);
+}
+
 void omap_uart_prepare_idle(int num)
 {
 	struct omap_uart_state *uart;
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
+			if (serial_read_reg(uart->p, UART_LSR) &
+					UART_LSR_TEMT)
+				omap_uart_disable_clocks(uart);
 			return;
 		}
 	}
@@ -375,12 +409,12 @@ void omap_uart_resume_idle(int num)
 				u16 p = omap_ctrl_readw(uart->padconf);
 
 				if (p & OMAP3_PADCONF_WAKEUPEVENT0)
-					omap_uart_block_sleep(uart);
+					schedule_work(&uart->wakeup_work);
 			}
 
 			/* Check for normal UART wakeup */
 			if (__raw_readl(uart->wk_st) & uart->wk_mask)
-				omap_uart_block_sleep(uart);
+				schedule_work(&uart->wakeup_work);
 			return;
 		}
 	}
@@ -428,8 +462,18 @@ int omap_uart_can_sleep(void)
 static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 {
 	struct omap_uart_state *uart = dev_id;
+	u8 lsr;
 
-	omap_uart_block_sleep(uart);
+	lsr = serial_read_reg(uart->p, UART_LSR);
+	/* Check for receive interrupt */
+	if (lsr & UART_LSR_DR) {
+		omap_uart_block_sleep(uart);
+		if (uart->garbage_ignore) {
+			del_timer(&uart->garbage_timer);
+			uart->garbage_ignore = 0;
+			serial_read_reg(uart->p, UART_RX);
+		}
+	}
 
 	return IRQ_NONE;
 }
@@ -443,6 +487,9 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	uart->timeout = DEFAULT_TIMEOUT;
 	setup_timer(&uart->timer, omap_uart_idle_timer,
 		    (unsigned long) uart);
+	setup_timer(&uart->garbage_timer, omap_uart_garbage_timer,
+		    (unsigned long) uart);
+	INIT_WORK(&uart->wakeup_work, omap_uart_wakeup_work);
 	if (uart->timeout)
 		mod_timer(&uart->timer, jiffies + uart->timeout);
 	omap_uart_smart_idle_enable(uart, 0);
@@ -507,15 +554,13 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 
 void omap_uart_enable_irqs(int enable)
 {
-	int ret;
 	struct omap_uart_state *uart;
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (enable)
-			ret = request_irq(uart->p->irq, omap_uart_interrupt,
-				IRQF_SHARED, "serial idle", (void *)uart);
+			enable_irq(uart->p->irq);
 		else
-			free_irq(uart->p->irq, (void *)uart);
+			disable_irq(uart->p->irq);
 	}
 }
 
-- 
1.5.4.3

