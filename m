From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v6 05/16] OMAP2+: UART: Cleanup part of clock gating mechanism for uart
Date: Fri, 30 Sep 2011 16:31:31 +0530
Message-ID: <1317380495-584-5-git-send-email-govindraj.raja@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Currently we use a shared irq handler to identify uart activity and then
trigger a timer. Based the timeout value set from sysfs the timer used to
expire. If no uart-activity was detected timer-expiry func sets can_sleep
flag. Based on this we will disable the uart clocks in idle path.

Since the clock gating mechanism is outside the uart driver, we currently
use this mechanism. In preparation to runtime implementation for omap-serial
driver we can cleanup this mechanism and use runtime API's to gate uart clocks.

Also remove timer related info from local uart_state struct and remove
the code used to set timeout value from sysfs. Remove un-used function
omap_uart_check_wakeup.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |  116 +------------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    1 -
 arch/arm/plat-omap/include/plat/serial.h      |    1 -
 3 files changed, 1 insertions(+), 117 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4ab90bf..c98b9b4 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -58,8 +58,6 @@
 struct omap_uart_state {
 	int num;
 	int can_sleep;
-	struct timer_list timer;
-	u32 timeout;
 
 	void __iomem *wk_st;
 	void __iomem *wk_en;
@@ -67,13 +65,9 @@ struct omap_uart_state {
 	u32 padconf;
 	u32 dma_enabled;
 
-	struct clk *ick;
-	struct clk *fck;
 	int clocked;
 
-	int irq;
 	int regshift;
-	int irqflags;
 	void __iomem *membase;
 	resource_size_t mapbase;
 
@@ -340,32 +334,6 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 
 	omap_uart_smart_idle_enable(uart, 0);
 	uart->can_sleep = 0;
-	if (uart->timeout)
-		mod_timer(&uart->timer, jiffies + uart->timeout);
-	else
-		del_timer(&uart->timer);
-}
-
-static void omap_uart_allow_sleep(struct omap_uart_state *uart)
-{
-	if (device_may_wakeup(&uart->pdev->dev))
-		omap_uart_enable_wakeup(uart);
-	else
-		omap_uart_disable_wakeup(uart);
-
-	if (!uart->clocked)
-		return;
-
-	omap_uart_smart_idle_enable(uart, 1);
-	uart->can_sleep = 1;
-	del_timer(&uart->timer);
-}
-
-static void omap_uart_idle_timer(unsigned long data)
-{
-	struct omap_uart_state *uart = (struct omap_uart_state *)data;
-
-	omap_uart_allow_sleep(uart);
 }
 
 int omap_uart_can_sleep(void)
@@ -389,35 +357,11 @@ int omap_uart_can_sleep(void)
 	return can_sleep;
 }
 
-/**
- * omap_uart_interrupt()
- *
- * This handler is used only to detect that *any* UART interrupt has
- * occurred.  It does _nothing_ to handle the interrupt.  Rather,
- * any UART interrupt will trigger the inactivity timer so the
- * UART will not idle or sleep for its timeout period.
- *
- **/
-/* static int first_interrupt; */
-static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
-{
-	struct omap_uart_state *uart = dev_id;
-
-	omap_uart_block_sleep(uart);
-
-	return IRQ_NONE;
-}
-
 static void omap_uart_idle_init(struct omap_uart_state *uart)
 {
 	int ret;
 
 	uart->can_sleep = 0;
-	uart->timeout = DEFAULT_TIMEOUT;
-	setup_timer(&uart->timer, omap_uart_idle_timer,
-		    (unsigned long) uart);
-	if (uart->timeout)
-		mod_timer(&uart->timer, jiffies + uart->timeout);
 	omap_uart_smart_idle_enable(uart, 0);
 
 	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
@@ -479,51 +423,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->wk_mask = 0;
 		uart->padconf = 0;
 	}
-
-	uart->irqflags |= IRQF_SHARED;
-	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
-				   IRQF_SHARED, "serial idle", (void *)uart);
-	WARN_ON(ret);
-}
-
-static ssize_t sleep_timeout_show(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_device *odev = to_omap_device(pdev);
-	struct omap_uart_state *uart = odev->hwmods[0]->dev_attr;
-
-	return sprintf(buf, "%u\n", uart->timeout / HZ);
 }
 
-static ssize_t sleep_timeout_store(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t n)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_device *odev = to_omap_device(pdev);
-	struct omap_uart_state *uart = odev->hwmods[0]->dev_attr;
-	unsigned int value;
-
-	if (sscanf(buf, "%u", &value) != 1) {
-		dev_err(dev, "sleep_timeout_store: Invalid value\n");
-		return -EINVAL;
-	}
-
-	uart->timeout = value * HZ;
-	if (uart->timeout)
-		mod_timer(&uart->timer, jiffies + uart->timeout);
-	else
-		/* A zero value means disable timeout feature */
-		omap_uart_block_sleep(uart);
-
-	return n;
-}
-
-static DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show,
-		sleep_timeout_store);
-#define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
@@ -531,7 +432,6 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
 	/* Needed to enable UART clocks when built without CONFIG_PM */
 	omap_uart_enable_clocks(uart);
 }
-#define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
 
 static int __init omap_serial_early_init(void)
@@ -615,7 +515,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
 	omap_up.mapbase = oh->slaves[0]->addr->pa_start;
 	omap_up.membase = omap_hwmod_get_mpu_rt_va(oh);
-	omap_up.irqflags = IRQF_SHARED;
 	omap_up.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
 
 	pdata = &omap_up;
@@ -633,7 +532,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_device_disable_idle_on_suspend(pdev);
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
-	uart->irq = oh->mpu_irqs[0].irq;
 	uart->regshift = 2;
 	uart->mapbase = oh->slaves[0]->addr->pa_start;
 	uart->membase = omap_hwmod_get_mpu_rt_va(oh);
@@ -655,24 +553,12 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_hwmod_enable_wakeup(uart->oh);
 	omap_device_idle(uart->pdev);
 
-	/*
-	 * Need to block sleep long enough for interrupt driven
-	 * driver to start.  Console driver is in polling mode
-	 * so device needs to be kept enabled while polling driver
-	 * is in use.
-	 */
-	if (uart->timeout)
-		uart->timeout = (30 * HZ);
 	omap_uart_block_sleep(uart);
-	uart->timeout = DEFAULT_TIMEOUT;
-
 	console_unlock();
 
 	if ((cpu_is_omap34xx() && uart->padconf) ||
-	    (uart->wk_en && uart->wk_mask)) {
+	    (uart->wk_en && uart->wk_mask))
 		device_init_wakeup(&pdev->dev, true);
-		DEV_CREATE_FILE(&pdev->dev, &dev_attr_sleep_timeout);
-	}
 
 	/* Enable the MDR1 errata for OMAP3 */
 	if (cpu_is_omap34xx() && !cpu_is_ti816x())
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 2682043..307cd6f 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -61,7 +61,6 @@ struct omap_uart_port_info {
 	unsigned int		uartclk;	/* UART clock rate */
 	void __iomem		*membase;	/* ioremap cookie or NULL */
 	resource_size_t		mapbase;	/* resource base */
-	unsigned long		irqflags;	/* request_irq flags */
 	upf_t			flags;		/* UPF_* flags */
 };
 
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index fc8b60c..a8bc1f1 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -110,7 +110,6 @@ struct omap_board_data;
 extern void omap_serial_init(void);
 extern void omap_serial_init_port(struct omap_board_data *bdata);
 extern int omap_uart_can_sleep(void);
-extern void omap_uart_check_wakeup(void);
 #endif
 
 #endif
-- 
1.7.4.1

