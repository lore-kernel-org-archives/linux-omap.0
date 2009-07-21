From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/14] OMAP2/3/4: UART: Allow per-UART disabling wakeup for serial ports
Date: Tue, 21 Jul 2009 15:08:35 -0700
Message-ID: <1248214120-18886-10-git-send-email-khilman@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-2-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-4-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-5-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-6-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-7-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-8-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-9-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:7329 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbZGUWJF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:09:05 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1009646wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:09:05 -0700 (PDT)
In-Reply-To: <1248214120-18886-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Russ Dill <russ.dill@gmail.com>

This patch causes the OMAP uarts to honor the sysfs power/wakeup file
for IOPAD wakeups. Before the OMAP was always woken up from off mode
on a rs232 signal change.  This patch also creates a different
platform device for each serial port so that the wakeup properties can
be control per port.

By default, IOPAD wakeups are enabled for each UART.  To disable,

  # echo disabled > /sys/devices/platform/serial8250.0/power/wakeup

Where serial8250.0 can be replaced by .1, or .2 to control the other
ports.

Original idea and original patch from Russ Dill <russ.dill@gmail.com>

Cc: Russ Dill <russ.dill@gmail.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |  174 ++++++++++++++++++++++++++++--------------
 1 files changed, 116 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5352d05..6f35a7e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -54,6 +54,7 @@ struct omap_uart_state {
 
 	struct plat_serial8250_port *p;
 	struct list_head node;
+	struct platform_device pdev;
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 	int context_valid;
@@ -68,10 +69,9 @@ struct omap_uart_state {
 #endif
 };
 
-static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS];
 static LIST_HEAD(uart_list);
 
-static struct plat_serial8250_port serial_platform_data[] = {
+static struct plat_serial8250_port serial_platform_data0[] = {
 	{
 		.membase	= IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= OMAP_UART1_BASE,
@@ -81,6 +81,12 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
+		.flags		= 0
+	}
+};
+
+static struct plat_serial8250_port serial_platform_data1[] = {
+	{
 		.membase	= IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= OMAP_UART2_BASE,
 		.irq		= 73,
@@ -89,6 +95,12 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
+		.flags		= 0
+	}
+};
+
+static struct plat_serial8250_port serial_platform_data2[] = {
+	{
 		.membase	= IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= OMAP_UART3_BASE,
 		.irq		= 74,
@@ -217,6 +229,40 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 	clk_disable(uart->fck);
 }
 
+static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
+{
+	/* Set wake-enable bit */
+	if (uart->wk_en && uart->wk_mask) {
+		u32 v = __raw_readl(uart->wk_en);
+		v |= uart->wk_mask;
+		__raw_writel(v, uart->wk_en);
+	}
+
+	/* Ensure IOPAD wake-enables are set */
+	if (cpu_is_omap34xx() && uart->padconf) {
+		u16 v = omap_ctrl_readw(uart->padconf);
+		v |= OMAP3_PADCONF_WAKEUPENABLE0;
+		omap_ctrl_writew(v, uart->padconf);
+	}
+}
+
+static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
+{
+	/* Clear wake-enable bit */
+	if (uart->wk_en && uart->wk_mask) {
+		u32 v = __raw_readl(uart->wk_en);
+		v &= ~uart->wk_mask;
+		__raw_writel(v, uart->wk_en);
+	}
+
+	/* Ensure IOPAD wake-enables are cleared */
+	if (cpu_is_omap34xx() && uart->padconf) {
+		u16 v = omap_ctrl_readw(uart->padconf);
+		v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
+		omap_ctrl_writew(v, uart->padconf);
+	}
+}
+
 static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
 					  int enable)
 {
@@ -246,6 +292,11 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 
 static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 {
+	if (device_may_wakeup(&uart->pdev.dev))
+		omap_uart_enable_wakeup(uart);
+	else
+		omap_uart_disable_wakeup(uart);
+
 	if (!uart->clocked)
 		return;
 
@@ -292,7 +343,6 @@ void omap_uart_resume_idle(int num)
 			/* Check for normal UART wakeup */
 			if (__raw_readl(uart->wk_st) & uart->wk_mask)
 				omap_uart_block_sleep(uart);
-
 			return;
 		}
 	}
@@ -346,16 +396,13 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static u32 sleep_timeout = DEFAULT_TIMEOUT;
-
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
-	u32 v;
 	struct plat_serial8250_port *p = uart->p;
 	int ret;
 
 	uart->can_sleep = 0;
-	uart->timeout = sleep_timeout;
+	uart->timeout = DEFAULT_TIMEOUT;
 	setup_timer(&uart->timer, omap_uart_idle_timer,
 		    (unsigned long) uart);
 	mod_timer(&uart->timer, jiffies + uart->timeout);
@@ -413,22 +460,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->padconf = 0;
 	}
 
-	/* Set wake-enable bit */
-	if (uart->wk_en && uart->wk_mask) {
-		v = __raw_readl(uart->wk_en);
-		v |= uart->wk_mask;
-		__raw_writel(v, uart->wk_en);
-	}
-
-	/* Ensure IOPAD wake-enables are set */
-	if (cpu_is_omap34xx() && uart->padconf) {
-		u16 v;
-
-		v = omap_ctrl_readw(uart->padconf);
-		v |= OMAP3_PADCONF_WAKEUPENABLE0;
-		omap_ctrl_writew(v, uart->padconf);
-	}
-
 	p->flags |= UPF_SHARE_IRQ;
 	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
 			  "serial idle", (void *)uart);
@@ -449,54 +480,81 @@ void omap_uart_enable_irqs(int enable)
 	}
 }
 
-static ssize_t sleep_timeout_show(struct kobject *kobj,
-				  struct kobj_attribute *attr,
+static ssize_t sleep_timeout_show(struct device *dev,
+				  struct device_attribute *attr,
 				  char *buf)
 {
-	return sprintf(buf, "%u\n", sleep_timeout / HZ);
+	struct platform_device *pdev = container_of(dev,
+					struct platform_device, dev);
+	struct omap_uart_state *uart = container_of(pdev,
+					struct omap_uart_state, pdev);
+
+	return sprintf(buf, "%u\n", uart->timeout / HZ);
 }
 
-static ssize_t sleep_timeout_store(struct kobject *kobj,
-				   struct kobj_attribute *attr,
+static ssize_t sleep_timeout_store(struct device *dev,
+				   struct device_attribute *attr,
 				   const char *buf, size_t n)
 {
-	struct omap_uart_state *uart;
+	struct platform_device *pdev = container_of(dev,
+					struct platform_device, dev);
+	struct omap_uart_state *uart = container_of(pdev,
+					struct omap_uart_state, pdev);
 	unsigned int value;
 
 	if (sscanf(buf, "%u", &value) != 1) {
 		printk(KERN_ERR "sleep_timeout_store: Invalid value\n");
 		return -EINVAL;
 	}
-	sleep_timeout = value * HZ;
-	list_for_each_entry(uart, &uart_list, node) {
-		uart->timeout = sleep_timeout;
-		if (uart->timeout)
-			mod_timer(&uart->timer, jiffies + uart->timeout);
-		else
-			/* A zero value means disable timeout feature */
-			omap_uart_block_sleep(uart);
-	}
+
+	uart->timeout = value * HZ;
+	if (uart->timeout)
+		mod_timer(&uart->timer, jiffies + uart->timeout);
+	else
+		/* A zero value means disable timeout feature */
+		omap_uart_block_sleep(uart);
+
 	return n;
 }
 
-static struct kobj_attribute sleep_timeout_attr =
-	__ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
-
+DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
+#define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
+#define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
 
-static struct platform_device serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= serial_platform_data,
+static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
+	{
+		.pdev = {
+			.name			= "serial8250",
+			.id			= PLAT8250_DEV_PLATFORM,
+			.dev			= {
+				.platform_data	= serial_platform_data0,
+			},
+		},
+	}, {
+		.pdev = {
+			.name			= "serial8250",
+			.id			= PLAT8250_DEV_PLATFORM1,
+			.dev			= {
+				.platform_data	= serial_platform_data1,
+			},
+		},
+	}, {
+		.pdev = {
+			.name			= "serial8250",
+			.id			= PLAT8250_DEV_PLATFORM2,
+			.dev			= {
+				.platform_data	= serial_platform_data2,
+			},
+		},
 	},
 };
 
 void __init omap_serial_init(void)
 {
-	int i, err;
+	int i;
 	const struct omap_uart_config *info;
 	char name[16];
 
@@ -512,8 +570,10 @@ void __init omap_serial_init(void)
 		return;
 
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
-		struct plat_serial8250_port *p = serial_platform_data + i;
 		struct omap_uart_state *uart = &omap_uart[i];
+		struct platform_device *pdev = &uart->pdev;
+		struct device *dev = &pdev->dev;
+		struct plat_serial8250_port *p = dev->platform_data;
 
 		if (!(info->enabled_uarts & (1 << i))) {
 			p->membase = NULL;
@@ -549,15 +609,13 @@ void __init omap_serial_init(void)
 		omap_uart_enable_clocks(uart);
 		omap_uart_reset(uart);
 		omap_uart_idle_init(uart);
-	}
-
-	err = platform_device_register(&serial_device);
-
-#ifdef CONFIG_PM
-	if (!err)
-		err = sysfs_create_file(&serial_device.dev.kobj,
-					&sleep_timeout_attr.attr);
-#endif
 
+		if (WARN_ON(platform_device_register(pdev)))
+			continue;
+		if ((cpu_is_omap34xx() && uart->padconf) ||
+		    (uart->wk_en && uart->wk_mask)) {
+			device_init_wakeup(dev, true);
+			DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
+		}
+	}
 }
-
-- 
1.6.3.3

