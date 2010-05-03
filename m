From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/3] OMAP3: Serial: Improved sleep logic
Date: Mon,  3 May 2010 14:41:09 -0700
Message-ID: <1272922871-18847-2-git-send-email-khilman@deeprootsystems.com>
References: <1272922871-18847-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:45892 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680Ab0ECVlS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 17:41:18 -0400
Received: by pxi5 with SMTP id 5so454018pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 14:41:17 -0700 (PDT)
In-Reply-To: <1272922871-18847-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

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
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |   71 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3771254..b709cf8 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/workqueue.h>
 
 #include <plat/common.h>
 #include <plat/board.h>
@@ -49,7 +50,10 @@ struct omap_uart_state {
 	int num;
 	int can_sleep;
 	struct timer_list timer;
+	struct timer_list garbage_timer;
+	struct work_struct wakeup_work;
 	u32 timeout;
+	u8 garbage_ignore;
 
 	void __iomem *wk_st;
 	void __iomem *wk_en;
@@ -239,6 +243,11 @@ static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
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
@@ -248,6 +257,9 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 	clk_enable(uart->fck);
 	uart->clocked = 1;
 	omap_uart_restore_context(uart);
+#ifdef CONFIG_PM
+	omap_uart_smart_idle_enable(uart, 0);
+#endif
 }
 
 #ifdef CONFIG_PM
@@ -259,8 +271,13 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 
 	omap_uart_save_context(uart);
 	uart->clocked = 0;
+	omap_uart_smart_idle_enable(uart, 1);
 	clk_disable(uart->ick);
 	clk_disable(uart->fck);
+	if (uart->garbage_ignore) {
+		del_timer(&uart->garbage_timer);
+		uart->garbage_ignore = 0;
+	}
 }
 
 static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
@@ -316,7 +333,6 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	omap_uart_enable_clocks(uart);
 
-	omap_uart_smart_idle_enable(uart, 0);
 	uart->can_sleep = 0;
 	if (uart->timeout)
 		mod_timer(&uart->timer, jiffies + uart->timeout);
@@ -334,7 +350,6 @@ static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 	if (!uart->clocked)
 		return;
 
-	omap_uart_smart_idle_enable(uart, 1);
 	uart->can_sleep = 1;
 	del_timer(&uart->timer);
 }
@@ -346,18 +361,46 @@ static void omap_uart_idle_timer(unsigned long data)
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
+
+	/* Set up garbage timer to ignore RX during first jiffy */
+	if (uart->timeout)
+		mod_timer(&uart->garbage_timer, jiffies + 1);
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
 }
 
+static void serial_wakeup(struct omap_uart_state *uart)
+{
+	if (uart->timeout)
+		uart->garbage_ignore = 1;
+	schedule_work(&uart->wakeup_work);
+}
+
 void omap_uart_resume_idle(int num)
 {
 	struct omap_uart_state *uart;
@@ -371,12 +414,12 @@ void omap_uart_resume_idle(int num)
 				u16 p = omap_ctrl_readw(uart->padconf);
 
 				if (p & OMAP3_PADCONF_WAKEUPEVENT0)
-					omap_uart_block_sleep(uart);
+					serial_wakeup(uart);
 			}
 
 			/* Check for normal UART wakeup */
 			if (__raw_readl(uart->wk_st) & uart->wk_mask)
-				omap_uart_block_sleep(uart);
+				serial_wakeup(uart);
 			return;
 		}
 	}
@@ -425,7 +468,14 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 {
 	struct omap_uart_state *uart = dev_id;
 
-	omap_uart_block_sleep(uart);
+	/* Check for receive interrupt */
+	while (serial_read_reg(uart->p, UART_LSR) & UART_LSR_DR) {
+		omap_uart_block_sleep(uart);
+		if (uart->garbage_ignore)
+			serial_read_reg(uart->p, UART_RX);
+		else
+			break;
+	}
 
 	return IRQ_NONE;
 }
@@ -439,6 +489,9 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	uart->timeout = DEFAULT_TIMEOUT;
 	setup_timer(&uart->timer, omap_uart_idle_timer,
 		    (unsigned long) uart);
+	setup_timer(&uart->garbage_timer, omap_uart_garbage_timer,
+		    (unsigned long) uart);
+	INIT_WORK(&uart->wakeup_work, omap_uart_wakeup_work);
 	if (uart->timeout)
 		mod_timer(&uart->timer, jiffies + uart->timeout);
 	omap_uart_smart_idle_enable(uart, 0);
@@ -503,15 +556,13 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 
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
1.7.0.2

