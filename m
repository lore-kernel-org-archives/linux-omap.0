From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 20/20] OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
Date: Fri, 11 Nov 2011 15:32:17 +0530
Message-ID: <1321005737-21909-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Omap_uart_can_sleep function blocks system wide low power state until
uart is active remove this func and add qos requests to prevent
MPU from transitioning.

Keep qos request to default value which will allow MPU to transition
and while uart baud rate is available calculate the latency value
from the baudrate and use the same to hold constraint while uart clocks
are enabled, and if uart is auto-idled the constraint is updated with
default constraint value allowing MPU to transition.

Qos requests are blocking notifier calls so put these requests to
work queue, also the driver uses irq_safe version of runtime API's
and callbacks can be called in interrupt disabled context.
So to avoid warn on slow path warning while using qos update
API's from runtime callbacks use the qos_work_queue.

During bootup the runtime_resume call backs might not be called and runtime
callback gets called only after uart is idled by setting the autosuspend
timeout. So qos_request from runtime resume callback might not activated during
boot if uart baudrate is calculated during bootup for console uart, so schedule
the qos_work queue once we calc_latency while configuring the uart port.

Flush and complete any pending qos jobs in work queue while suspending.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c             |    5 ---
 arch/arm/mach-omap2/pm24xx.c                  |    2 -
 arch/arm/mach-omap2/pm34xx.c                  |   10 -------
 arch/arm/mach-omap2/serial.c                  |   22 ---------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    6 ++++
 drivers/tty/serial/omap-serial.c              |   36 ++++++++++++++++++++++++-
 6 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1fe35c2..6b4ed89 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -243,11 +243,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx;
 	int ret;
 
-	if (!omap3_can_sleep()) {
-		new_state_idx = drv->safe_state_index;
-		goto select_state;
-	}
-
 	/*
 	 * Prevent idle completely if CAM is active.
 	 * CAM does not have wakeup capability in OMAP3.
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 5ec2b43..3a9e80b 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -221,8 +221,6 @@ static int omap2_can_sleep(void)
 {
 	if (omap2_fclks_active())
 		return 0;
-	if (!omap_uart_can_sleep())
-		return 0;
 	if (osc_ck->usecount > 1)
 		return 0;
 	if (omap_dma_running())
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2eb3215..6edcca8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -417,21 +417,11 @@ void omap_sram_idle(void)
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
-int omap3_can_sleep(void)
-{
-	if (!omap_uart_can_sleep())
-		return 0;
-	return 1;
-}
-
 static void omap3_pm_idle(void)
 {
 	local_irq_disable();
 	local_fiq_disable();
 
-	if (!omap3_can_sleep())
-		goto out;
-
 	if (omap_irq_pending() || need_resched())
 		goto out;
 
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index a5d9c9c..cf7484a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -111,28 +111,6 @@ static struct omap_device_pm_latency console_uart_latency[] = {
 };
 
 #ifdef CONFIG_PM
-
-int omap_uart_can_sleep(void)
-{
-	struct omap_uart_state *uart;
-	int can_sleep = 1;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (!uart->clocked)
-			continue;
-
-		if (!uart->can_sleep) {
-			can_sleep = 0;
-			continue;
-		}
-
-		/* This UART can now safely sleep. */
-		omap_uart_allow_sleep(uart);
-	}
-
-	return can_sleep;
-}
-
 static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
 {
 	struct omap_device *od = to_omap_device(pdev);
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index e05c8da..f685150 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -19,6 +19,7 @@
 
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 
 #include <plat/mux.h>
 
@@ -129,6 +130,11 @@ struct uart_omap_port {
 	u32			context_loss_cnt;
 	u32			errata;
 	u8			wakeups_enabled;
+
+	struct pm_qos_request	pm_qos_request;
+	u32			latency;
+	u32			calc_latency;
+	struct work_struct	qos_work;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index be55a5d..e1c8527 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -51,6 +51,8 @@ static void serial_omap_rxdma_poll(unsigned long uart_no);
 static int serial_omap_start_rxdma(struct uart_omap_port *up);
 static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1);
 
+static struct workqueue_struct *serial_omap_uart_wq;
+
 static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
 {
 	offset <<= up->port.regshift;
@@ -671,6 +673,14 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_LCR, up->lcr);
 }
 
+static void serial_omap_uart_qos_work(struct work_struct *work)
+{
+	struct uart_omap_port *up = container_of(work, struct uart_omap_port,
+						qos_work);
+
+	pm_qos_update_request(&up->pm_qos_request, up->latency);
+}
+
 static void
 serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 			struct ktermios *old)
@@ -711,6 +721,12 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/13);
 	quot = serial_omap_get_divisor(port, baud);
 
+	/* calculate wakeup latency constraint */
+	up->calc_latency = (1000000 * up->port.fifosize) /
+				(1000 * baud / 8);
+	up->latency = up->calc_latency;
+	schedule_work(&up->qos_work);
+
 	up->dll = quot & 0xff;
 	up->dlh = quot >> 8;
 	up->mdr1 = UART_OMAP_MDR1_DISABLE;
@@ -1145,8 +1161,11 @@ static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 
-	if (up)
+	if (up) {
 		uart_suspend_port(&serial_omap_reg, &up->port);
+		flush_work_sync(&up->qos_work);
+	}
+
 	return 0;
 }
 
@@ -1383,6 +1402,13 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
 
+	up->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	up->calc_latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	pm_qos_add_request(&up->pm_qos_request,
+		PM_QOS_CPU_DMA_LATENCY, up->latency);
+	serial_omap_uart_wq = create_singlethread_workqueue(up->name);
+	INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 			omap_up_info->autosuspend_timeout);
@@ -1416,6 +1442,8 @@ static int serial_omap_remove(struct platform_device *dev)
 	if (up) {
 		pm_runtime_disable(&up->pdev->dev);
 		uart_remove_one_port(&serial_omap_reg, &up->port);
+		pm_qos_remove_request(&up->pm_qos_request);
+
 		kfree(up);
 	}
 
@@ -1517,6 +1545,9 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	if (up->use_dma && pdata->set_forceidle)
 		pdata->set_forceidle(up->pdev);
 
+	up->latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
+	schedule_work(&up->qos_work);
+
 	return 0;
 }
 
@@ -1536,6 +1567,9 @@ static int serial_omap_runtime_resume(struct device *dev)
 		/* Errata i291 */
 		if (up->use_dma && pdata->set_noidle)
 			pdata->set_noidle(up->pdev);
+
+		up->latency = up->calc_latency;
+		schedule_work(&up->qos_work);
 	}
 
 	return 0;
-- 
1.7.4.1

