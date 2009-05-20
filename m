From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/13] OMAP: UART: Add sysfs interface for adjusting UART sleep timeout
Date: Wed, 20 May 2009 16:19:30 -0700
Message-ID: <1242861576-13008-8-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-5-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-6-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:37575 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757169AbZETXT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:19:56 -0400
Received: by wf-out-1314.google.com with SMTP id 26so241368wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:19:58 -0700 (PDT)
In-Reply-To: <1242861576-13008-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

From: Jouni Hogander <jouni.hogander@nokia.com>

This patch makes it possible to change uart sleep timeout. New sysfs
entry is added (/sys/devices/platform/serial8250.<uart>/sleep_timeout)
Writing zero will disable the timeout feature and prevent UART clocks
from being disabled.

Also default timeout is increased to 5 second to make serial console
more usable.

Original patch was written by Tero Kristo.

Cc: Tero Kristo <Tero.Kristo@nokia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |   55 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 50bff3d..854ac94 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -30,7 +30,7 @@
 #include "pm.h"
 #include "prm-regbits-34xx.h"
 
-#define DEFAULT_TIMEOUT (2 * HZ)
+#define DEFAULT_TIMEOUT (5 * HZ)
 
 struct omap_uart_state {
 	int num;
@@ -233,7 +233,10 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 
 	omap_uart_smart_idle_enable(uart, 0);
 	uart->can_sleep = 0;
-	mod_timer(&uart->timer, jiffies + uart->timeout);
+	if (uart->timeout)
+		mod_timer(&uart->timer, jiffies + uart->timeout);
+	else
+		del_timer(&uart->timer);
 }
 
 static void omap_uart_allow_sleep(struct omap_uart_state *uart)
@@ -338,6 +341,8 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static u32 sleep_timeout = DEFAULT_TIMEOUT;
+
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
 	u32 v;
@@ -345,7 +350,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	int ret;
 
 	uart->can_sleep = 0;
-	uart->timeout = DEFAULT_TIMEOUT;
+	uart->timeout = sleep_timeout;
 	setup_timer(&uart->timer, omap_uart_idle_timer,
 		    (unsigned long) uart);
 	mod_timer(&uart->timer, jiffies + uart->timeout);
@@ -425,6 +430,39 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	WARN_ON(ret);
 }
 
+static ssize_t sleep_timeout_show(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  char *buf)
+{
+	return sprintf(buf, "%u\n", sleep_timeout / HZ);
+}
+
+static ssize_t sleep_timeout_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t n)
+{
+	struct omap_uart_state *uart;
+	unsigned int value;
+
+	if (sscanf(buf, "%u", &value) != 1) {
+		printk(KERN_ERR "sleep_timeout_store: Invalid value\n");
+		return -EINVAL;
+	}
+	sleep_timeout = value * HZ;
+	list_for_each_entry(uart, &uart_list, node) {
+		uart->timeout = sleep_timeout;
+		if (uart->timeout)
+			mod_timer(&uart->timer, jiffies + uart->timeout);
+		else
+			/* A zero value means disable timeout feature */
+			omap_uart_block_sleep(uart);
+	}
+	return n;
+}
+
+static struct kobj_attribute sleep_timeout_attr =
+	__ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
+
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 #endif /* CONFIG_PM */
@@ -494,6 +532,15 @@ static struct platform_device serial_device = {
 
 static int __init omap_init(void)
 {
-	return platform_device_register(&serial_device);
+	int ret;
+
+	ret = platform_device_register(&serial_device);
+
+#ifdef CONFIG_PM
+	if (!ret)
+		ret = sysfs_create_file(&serial_device.dev.kobj,
+					&sleep_timeout_attr.attr);
+#endif
+	return ret;
 }
 arch_initcall(omap_init);
-- 
1.6.2.2

