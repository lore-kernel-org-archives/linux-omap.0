From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: Fixed crash bug with serial + suspend
Date: Tue,  3 Mar 2009 11:45:39 +0200
Message-ID: <1236073539-21607-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45594 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZCCKCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 05:02:43 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n23A20dn021823
	for <linux-omap@vger.kernel.org>; Tue, 3 Mar 2009 04:02:39 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n23A2Twx024749
	for <linux-omap@vger.kernel.org>; Tue, 3 Mar 2009 12:02:29 +0200
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
 arch/arm/mach-omap2/serial.c             |   18 ++++++++++++++++++
 arch/arm/plat-omap/include/mach/serial.h |    1 +
 3 files changed, 34 insertions(+), 0 deletions(-)

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
index 90f1c67..952da79 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -432,6 +432,24 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	WARN_ON(ret);
 }
 
+void omap_uart_enable_irqs(int enable)
+{
+	int i, ret;
+
+	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+		struct plat_serial8250_port *p = serial_platform_data + i;
+		struct omap_uart_state *uart = &omap_uart[i];
+
+		if (!p->membase)
+			continue;
+		if (enable)
+			ret = request_irq(p->irq, omap_uart_interrupt,
+				IRQF_SHARED, "serial idle", (void *)uart);
+		else
+			free_irq(p->irq, (void *)uart);
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

