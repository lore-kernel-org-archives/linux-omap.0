From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: Fixed crash bug with serial + suspend
Date: Thu,  5 Mar 2009 16:32:23 +0200
Message-ID: <1236263543-7085-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49212 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbZCEOtn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 09:49:43 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n25EnZqx023962
	for <linux-omap@vger.kernel.org>; Thu, 5 Mar 2009 16:49:38 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n25EnVrW002594
	for <linux-omap@vger.kernel.org>; Thu, 5 Mar 2009 16:49:31 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

It was possible for an unhandled interrupt to occur if there was incoming
serial traffic during wakeup from suspend. This was caused by the code
in arch-arm/mach-omap2/serial.c keeping interrupt enabled all the time,
but not acking its interrupts. Applies on top of PM branch.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c             |   15 +++++++++++++++
 arch/arm/mach-omap2/serial.c             |   14 ++++++++++++++
 arch/arm/plat-omap/include/mach/serial.h |    1 +
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9102cee..5a627db 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -629,7 +629,22 @@ static void omap3_pm_finish(void)
 	pm_idle = saved_idle;
 }
 
+/* Hooks to enable / disable UART interrupts during suspend */
+static int omap3_pm_begin(suspend_state_t state)
+{
+	omap_uart_enable_irqs(0);
+	return 0;
+}
+
+static void omap3_pm_end(void)
+{
+	omap_uart_enable_irqs(1);
+	return;
+}
+
 static struct platform_suspend_ops omap_pm_ops = {
+	.begin		= omap3_pm_begin,
+	.end		= omap3_pm_end,
 	.prepare	= omap3_pm_prepare,
 	.enter		= omap3_pm_enter,
 	.finish		= omap3_pm_finish,
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 90f1c67..e77567a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -432,6 +432,20 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	WARN_ON(ret);
 }
 
+void omap_uart_enable_irqs(int enable)
+{
+	int ret;
+	struct omap_uart_state *uart;
+
+	list_for_each_entry(uart, &uart_list, node) {
+		if (enable)
+			ret = request_irq(uart->p->irq, omap_uart_interrupt,
+				IRQF_SHARED, "serial idle", (void *)uart);
+		else
+			free_irq(uart->p->irq, (void *)uart);
+	}
+}
+
 static ssize_t sleep_timeout_show(struct kobject *kobj,
 				  struct kobj_attribute *attr,
 				  char *buf)
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index 8e89585..7ca1f27 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -47,6 +47,7 @@ extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
 extern void omap_uart_prepare_idle(int num);
 extern void omap_uart_resume_idle(int num);
+extern void omap_uart_enable_irqs(int enable);
 #endif
 
 #endif
-- 
1.5.4.3

