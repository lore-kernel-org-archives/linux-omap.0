From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/11] OMAP3: Fixed crash bug with serial + suspend
Date: Thu, 25 Jun 2009 09:42:03 -0700
Message-ID: <1245948124-24111-11-git-send-email-khilman@deeprootsystems.com>
References: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-2-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-3-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-4-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-5-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-6-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-7-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-8-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-9-git-send-email-khilman@deeprootsystems.com>
 <1245948124-24111-10-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:35146 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757637AbZFYQno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:43:44 -0400
Received: by mail-pz0-f189.google.com with SMTP id 27so1461235pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:43:47 -0700 (PDT)
In-Reply-To: <1245948124-24111-10-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

It was possible for an unhandled interrupt to occur if there was incoming
serial traffic during wakeup from suspend. This was caused by the code
in arch-arm/mach-omap2/serial.c keeping interrupt enabled all the time,
but not acking its interrupts. Applies on top of PM branch.

Use the PM begin/end hooks to ensure that the "serial idle" interrupts
are disabled during the suspend path.  Also, since begin/end hooks are
now used, use the suspend_state that is passed in the begin hook instead
of the enter hook as per the platform_suspend_ops docs.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c             |   23 +++++++++++++++++++++--
 arch/arm/mach-omap2/serial.c             |   14 ++++++++++++++
 arch/arm/plat-omap/include/mach/serial.h |    1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 528f725..b07efb2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -296,6 +296,8 @@ out:
 }
 
 #ifdef CONFIG_SUSPEND
+static suspend_state_t suspend_state;
+
 static int omap3_pm_prepare(void)
 {
 	disable_hlt();
@@ -342,11 +344,11 @@ restore:
 	return ret;
 }
 
-static int omap3_pm_enter(suspend_state_t state)
+static int omap3_pm_enter(suspend_state_t unused)
 {
 	int ret = 0;
 
-	switch (state) {
+	switch (suspend_state) {
 	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
 		ret = omap3_pm_suspend();
@@ -363,7 +365,24 @@ static void omap3_pm_finish(void)
 	enable_hlt();
 }
 
+/* Hooks to enable / disable UART interrupts during suspend */
+static int omap3_pm_begin(suspend_state_t state)
+{
+	suspend_state = state;
+	omap_uart_enable_irqs(0);
+	return 0;
+}
+
+static void omap3_pm_end(void)
+{
+	suspend_state = PM_SUSPEND_ON;
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
index c82ec95..5352d05 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -435,6 +435,20 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
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
index 13abd02..def0529 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -59,6 +59,7 @@ extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
 extern void omap_uart_prepare_idle(int num);
 extern void omap_uart_resume_idle(int num);
+extern void omap_uart_enable_irqs(int enable);
 #endif
 
 #endif
-- 
1.6.3.2

