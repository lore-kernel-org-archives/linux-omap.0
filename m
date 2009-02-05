From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/21] OMAP: UART: Add sysfs interface for adjusting UART sleep timeout
Date: Wed,  4 Feb 2009 18:05:54 -0800
Message-ID: <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:13429 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148AbZBECG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:06:58 -0500
Received: by an-out-0708.google.com with SMTP id c2so43anc.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:06:57 -0800 (PST)
In-Reply-To: <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

This patch makes it possible to change uart sleep timeout. New sysfs
entry is added (/sys/devices/platform/serial8250.0/sleep_timeout)

Also default timeout is increased to 5 second to make serial console
more usable.

Original patch was written by Tero Kristo some time ago.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |   44 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index cb191d0..29328e1 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -30,7 +30,7 @@
 #include "pm.h"
 #include "prm-regbits-34xx.h"
 
-#define DEFAULT_TIMEOUT (2 * HZ)
+#define DEFAULT_TIMEOUT (5 * HZ)
 
 struct omap_uart_state {
 	int num;
@@ -341,6 +341,8 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static u32 sleep_timeout = DEFAULT_TIMEOUT;
+
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
 	u32 v;
@@ -348,7 +350,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	int ret;
 
 	uart->can_sleep = 0;
-	uart->timeout = DEFAULT_TIMEOUT;
+	uart->timeout = sleep_timeout;
 	setup_timer(&uart->timer, omap_uart_idle_timer,
 		    (unsigned long) uart);
 	mod_timer(&uart->timer, jiffies + uart->timeout);
@@ -428,6 +430,33 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
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
+	list_for_each_entry(uart, &uart_list, node)
+		uart->timeout = sleep_timeout;
+	return n;
+}
+
+static struct kobj_attribute sleep_timeout_attr =
+	__ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
+
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 #endif /* CONFIG_PM */
@@ -497,6 +526,15 @@ static struct platform_device serial_device = {
 
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
1.6.1

